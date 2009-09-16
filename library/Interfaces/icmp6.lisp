(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:icmp6.h"
; at Sunday July 2,2006 7:27:57 pm.
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
; 	$KAME: icmp6.h,v 1.46 2001/04/27 15:09:48 itojun Exp $	
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
;  
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
;  *	@(#)ip_icmp.h	8.1 (Berkeley) 6/10/93
;  
; #ifndef _NETINET_ICMP6_H_
; #define _NETINET_ICMP6_H_

(require-interface "sys/appleapiopts")
(defconstant $ICMPV6_PLD_MAXLEN 1232)
; #define ICMPV6_PLD_MAXLEN	1232	/* IPV6_MMTU - sizeof(struct ip6_hdr)
(defrecord icmp6_hdr
   (icmp6_type :UInt8)
                                                ;  type field 
   (icmp6_code :UInt8)
                                                ;  code field 
   (icmp6_cksum :UInt16)
                                                ;  checksum field 
   (:variant
   (
   (icmp6_un_data32 (:array :UInt32 1))
   )
                                                ;  type-specific field 
   (
   (icmp6_un_data16 (:array :UInt16 2))
   )
                                                ;  type-specific field 
   (
   (icmp6_un_data8 (:array :UInt8 4))
   )
                                                ;  type-specific field 
   )
)
; #define icmp6_data32	icmp6_dataun.icmp6_un_data32
; #define icmp6_data16	icmp6_dataun.icmp6_un_data16
; #define icmp6_data8	icmp6_dataun.icmp6_un_data8
; #define icmp6_pptr	icmp6_data32[0]		/* parameter prob */
; #define icmp6_mtu	icmp6_data32[0]		/* packet too big */
; #define icmp6_id	icmp6_data16[0]		/* echo request/reply */
; #define icmp6_seq	icmp6_data16[1]		/* echo request/reply */
; #define icmp6_maxdelay	icmp6_data16[0]		/* mcast group membership */
(defconstant $ICMP6_DST_UNREACH 1)
; #define ICMP6_DST_UNREACH		1	/* dest unreachable, codes: */
(defconstant $ICMP6_PACKET_TOO_BIG 2)
; #define ICMP6_PACKET_TOO_BIG		2	/* packet too big */
(defconstant $ICMP6_TIME_EXCEEDED 3)
; #define ICMP6_TIME_EXCEEDED		3	/* time exceeded, code: */
(defconstant $ICMP6_PARAM_PROB 4)
; #define ICMP6_PARAM_PROB		4	/* ip6 header bad */
(defconstant $ICMP6_ECHO_REQUEST 128)
; #define ICMP6_ECHO_REQUEST		128	/* echo service */
(defconstant $ICMP6_ECHO_REPLY 129)
; #define ICMP6_ECHO_REPLY		129	/* echo reply */
(defconstant $ICMP6_MEMBERSHIP_QUERY 130)
; #define ICMP6_MEMBERSHIP_QUERY		130	/* group membership query */
(defconstant $MLD6_LISTENER_QUERY 130)
; #define MLD6_LISTENER_QUERY		130 	/* multicast listener query */
(defconstant $ICMP6_MEMBERSHIP_REPORT 131)
; #define ICMP6_MEMBERSHIP_REPORT		131	/* group membership report */
(defconstant $MLD6_LISTENER_REPORT 131)
; #define MLD6_LISTENER_REPORT		131	/* multicast listener report */
(defconstant $ICMP6_MEMBERSHIP_REDUCTION 132)
; #define ICMP6_MEMBERSHIP_REDUCTION	132	/* group membership termination */
(defconstant $MLD6_LISTENER_DONE 132)
; #define MLD6_LISTENER_DONE		132	/* multicast listener done */
(defconstant $ND_ROUTER_SOLICIT 133)
; #define ND_ROUTER_SOLICIT		133	/* router solicitation */
(defconstant $ND_ROUTER_ADVERT 134)
; #define ND_ROUTER_ADVERT		134	/* router advertisment */
(defconstant $ND_NEIGHBOR_SOLICIT 135)
; #define ND_NEIGHBOR_SOLICIT		135	/* neighbor solicitation */
(defconstant $ND_NEIGHBOR_ADVERT 136)
; #define ND_NEIGHBOR_ADVERT		136	/* neighbor advertisment */
(defconstant $ND_REDIRECT 137)
; #define ND_REDIRECT			137	/* redirect */
(defconstant $ICMP6_ROUTER_RENUMBERING 138)
; #define ICMP6_ROUTER_RENUMBERING	138	/* router renumbering */
(defconstant $ICMP6_WRUREQUEST 139)
; #define ICMP6_WRUREQUEST		139	/* who are you request */
(defconstant $ICMP6_WRUREPLY 140)
; #define ICMP6_WRUREPLY			140	/* who are you reply */
(defconstant $ICMP6_FQDN_QUERY 139)
; #define ICMP6_FQDN_QUERY		139	/* FQDN query */
(defconstant $ICMP6_FQDN_REPLY 140)
; #define ICMP6_FQDN_REPLY		140	/* FQDN reply */
(defconstant $ICMP6_NI_QUERY 139)
; #define ICMP6_NI_QUERY			139	/* node information request */
(defconstant $ICMP6_NI_REPLY 140)
; #define ICMP6_NI_REPLY			140	/* node information reply */
;  The definitions below are experimental. TBA 
(defconstant $MLD6_MTRACE_RESP 200)
; #define MLD6_MTRACE_RESP		200	/* mtrace response(to sender) */
(defconstant $MLD6_MTRACE 201)
; #define MLD6_MTRACE			201	/* mtrace messages */
(defconstant $ICMP6_HADISCOV_REQUEST 202)
; #define ICMP6_HADISCOV_REQUEST		202	/* XXX To be defined */
(defconstant $ICMP6_HADISCOV_REPLY 203)
; #define ICMP6_HADISCOV_REPLY		203	/* XXX To be defined */
(defconstant $ICMP6_MAXTYPE 203)
; #define ICMP6_MAXTYPE			203
(defconstant $ICMP6_DST_UNREACH_NOROUTE 0)
; #define ICMP6_DST_UNREACH_NOROUTE	0	/* no route to destination */
(defconstant $ICMP6_DST_UNREACH_ADMIN 1)
; #define ICMP6_DST_UNREACH_ADMIN	 	1	/* administratively prohibited */
(defconstant $ICMP6_DST_UNREACH_NOTNEIGHBOR 2)
; #define ICMP6_DST_UNREACH_NOTNEIGHBOR	2	/* not a neighbor(obsolete) */
(defconstant $ICMP6_DST_UNREACH_BEYONDSCOPE 2)
; #define ICMP6_DST_UNREACH_BEYONDSCOPE	2	/* beyond scope of source address */
(defconstant $ICMP6_DST_UNREACH_ADDR 3)
; #define ICMP6_DST_UNREACH_ADDR		3	/* address unreachable */
(defconstant $ICMP6_DST_UNREACH_NOPORT 4)
; #define ICMP6_DST_UNREACH_NOPORT	4	/* port unreachable */
(defconstant $ICMP6_TIME_EXCEED_TRANSIT 0)
; #define ICMP6_TIME_EXCEED_TRANSIT 	0	/* ttl==0 in transit */
(defconstant $ICMP6_TIME_EXCEED_REASSEMBLY 1)
; #define ICMP6_TIME_EXCEED_REASSEMBLY	1	/* ttl==0 in reass */
(defconstant $ICMP6_PARAMPROB_HEADER 0)
; #define ICMP6_PARAMPROB_HEADER 	 	0	/* erroneous header field */
(defconstant $ICMP6_PARAMPROB_NEXTHEADER 1)
; #define ICMP6_PARAMPROB_NEXTHEADER	1	/* unrecognized next header */
(defconstant $ICMP6_PARAMPROB_OPTION 2)
; #define ICMP6_PARAMPROB_OPTION		2	/* unrecognized option */
(defconstant $ICMP6_INFOMSG_MASK 128)
; #define ICMP6_INFOMSG_MASK		0x80	/* all informational messages */
(defconstant $ICMP6_NI_SUBJ_IPV6 0)
; #define ICMP6_NI_SUBJ_IPV6	0	/* Query Subject is an IPv6 address */
(defconstant $ICMP6_NI_SUBJ_FQDN 1)
; #define ICMP6_NI_SUBJ_FQDN	1	/* Query Subject is a Domain name */
(defconstant $ICMP6_NI_SUBJ_IPV4 2)
; #define ICMP6_NI_SUBJ_IPV4	2	/* Query Subject is an IPv4 address */
(defconstant $ICMP6_NI_SUCCESS 0)
; #define ICMP6_NI_SUCCESS	0	/* node information successful reply */
(defconstant $ICMP6_NI_REFUSED 1)
; #define ICMP6_NI_REFUSED	1	/* node information request is refused */
(defconstant $ICMP6_NI_UNKNOWN 2)
; #define ICMP6_NI_UNKNOWN	2	/* unknown Qtype */
(defconstant $ICMP6_ROUTER_RENUMBERING_COMMAND 0)
; #define ICMP6_ROUTER_RENUMBERING_COMMAND  0	/* rr command */
(defconstant $ICMP6_ROUTER_RENUMBERING_RESULT 1)
; #define ICMP6_ROUTER_RENUMBERING_RESULT   1	/* rr result */
(defconstant $ICMP6_ROUTER_RENUMBERING_SEQNUM_RESET 255)
; #define ICMP6_ROUTER_RENUMBERING_SEQNUM_RESET   255	/* rr seq num reset */
;  Used in kernel only 
(defconstant $ND_REDIRECT_ONLINK 0)
; #define ND_REDIRECT_ONLINK	0	/* redirect to an on-link node */
(defconstant $ND_REDIRECT_ROUTER 1)
; #define ND_REDIRECT_ROUTER	1	/* redirect to a better router */
; 
;  * Multicast Listener Discovery
;  
(defrecord mld6_hdr
   (mld6_hdr :ICMP6_HDR)
   (mld6_addr :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#                                              ;  multicast address 
)
; #define mld6_type	mld6_hdr.icmp6_type
; #define mld6_code	mld6_hdr.icmp6_code
; #define mld6_cksum	mld6_hdr.icmp6_cksum
; #define mld6_maxdelay	mld6_hdr.icmp6_data16[0]
; #define mld6_reserved	mld6_hdr.icmp6_data16[1]
; 
;  * Neighbor Discovery
;  
(defrecord nd_router_solicit
                                                ;  router solicitation 
   (nd_rs_hdr :ICMP6_HDR)
                                                ;  could be followed by options 
)
; #define nd_rs_type	nd_rs_hdr.icmp6_type
; #define nd_rs_code	nd_rs_hdr.icmp6_code
; #define nd_rs_cksum	nd_rs_hdr.icmp6_cksum
; #define nd_rs_reserved	nd_rs_hdr.icmp6_data32[0]
(defrecord nd_router_advert
                                                ;  router advertisement 
   (nd_ra_hdr :ICMP6_HDR)
   (nd_ra_reachable :UInt32)
                                                ;  reachable time 
   (nd_ra_retransmit :UInt32)
                                                ;  retransmit timer 
                                                ;  could be followed by options 
)
; #define nd_ra_type		nd_ra_hdr.icmp6_type
; #define nd_ra_code		nd_ra_hdr.icmp6_code
; #define nd_ra_cksum		nd_ra_hdr.icmp6_cksum
; #define nd_ra_curhoplimit	nd_ra_hdr.icmp6_data8[0]
; #define nd_ra_flags_reserved	nd_ra_hdr.icmp6_data8[1]
(defconstant $ND_RA_FLAG_MANAGED 128)
; #define ND_RA_FLAG_MANAGED	0x80
(defconstant $ND_RA_FLAG_OTHER 64)
; #define ND_RA_FLAG_OTHER	0x40
(defconstant $ND_RA_FLAG_HA 32)
; #define ND_RA_FLAG_HA		0x20
; 
;  * Router preference values based on draft-draves-ipngwg-router-selection-01.
;  * These are non-standard definitions.
;  
(defconstant $ND_RA_FLAG_RTPREF_MASK 24)
; #define ND_RA_FLAG_RTPREF_MASK	0x18 /* 00011000 */
(defconstant $ND_RA_FLAG_RTPREF_HIGH 8)
; #define ND_RA_FLAG_RTPREF_HIGH	0x08 /* 00001000 */
(defconstant $ND_RA_FLAG_RTPREF_MEDIUM 0)
; #define ND_RA_FLAG_RTPREF_MEDIUM	0x00 /* 00000000 */
(defconstant $ND_RA_FLAG_RTPREF_LOW 24)
; #define ND_RA_FLAG_RTPREF_LOW	0x18 /* 00011000 */
(defconstant $ND_RA_FLAG_RTPREF_RSV 16)
; #define ND_RA_FLAG_RTPREF_RSV	0x10 /* 00010000 */
; #define nd_ra_router_lifetime	nd_ra_hdr.icmp6_data16[1]
(defrecord nd_neighbor_solicit
                                                ;  neighbor solicitation 
   (nd_ns_hdr :ICMP6_HDR)
   (nd_ns_target :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
                                                ; target address 
                                                ;  could be followed by options 
)
; #define nd_ns_type		nd_ns_hdr.icmp6_type
; #define nd_ns_code		nd_ns_hdr.icmp6_code
; #define nd_ns_cksum		nd_ns_hdr.icmp6_cksum
; #define nd_ns_reserved		nd_ns_hdr.icmp6_data32[0]
(defrecord nd_neighbor_advert
                                                ;  neighbor advertisement 
   (nd_na_hdr :ICMP6_HDR)
   (nd_na_target :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
                                                ;  target address 
                                                ;  could be followed by options 
)
; #define nd_na_type		nd_na_hdr.icmp6_type
; #define nd_na_code		nd_na_hdr.icmp6_code
; #define nd_na_cksum		nd_na_hdr.icmp6_cksum
; #define nd_na_flags_reserved	nd_na_hdr.icmp6_data32[0]

; #if BYTE_ORDER == BIG_ENDIAN
(defconstant $ND_NA_FLAG_ROUTER 2147483648)
; #define ND_NA_FLAG_ROUTER		0x80000000
(defconstant $ND_NA_FLAG_SOLICITED 1073741824)
; #define ND_NA_FLAG_SOLICITED		0x40000000
(defconstant $ND_NA_FLAG_OVERRIDE 536870912)
; #define ND_NA_FLAG_OVERRIDE		0x20000000
#| 
; #else

; #if BYTE_ORDER == LITTLE_ENDIAN
; #define ND_NA_FLAG_ROUTER		0x80
; #define ND_NA_FLAG_SOLICITED		0x40
; #define ND_NA_FLAG_OVERRIDE		0x20

; #endif

 |#

; #endif

(defrecord nd_redirect
                                                ;  redirect 
   (nd_rd_hdr :ICMP6_HDR)
   (nd_rd_target :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
                                                ;  target address 
   (nd_rd_dst :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
                                                ;  destination address 
                                                ;  could be followed by options 
)
; #define nd_rd_type		nd_rd_hdr.icmp6_type
; #define nd_rd_code		nd_rd_hdr.icmp6_code
; #define nd_rd_cksum		nd_rd_hdr.icmp6_cksum
; #define nd_rd_reserved		nd_rd_hdr.icmp6_data32[0]
(defrecord nd_opt_hdr
                                                ;  Neighbor discovery option header 
   (nd_opt_type :UInt8)
   (nd_opt_len :UInt8)
                                                ;  followed by option specific data
)
(defconstant $ND_OPT_SOURCE_LINKADDR 1)
; #define ND_OPT_SOURCE_LINKADDR		1
(defconstant $ND_OPT_TARGET_LINKADDR 2)
; #define ND_OPT_TARGET_LINKADDR		2
(defconstant $ND_OPT_PREFIX_INFORMATION 3)
; #define ND_OPT_PREFIX_INFORMATION	3
(defconstant $ND_OPT_REDIRECTED_HEADER 4)
; #define ND_OPT_REDIRECTED_HEADER	4
(defconstant $ND_OPT_MTU 5)
; #define ND_OPT_MTU			5
(defconstant $ND_OPT_ROUTE_INFO 200)
; #define ND_OPT_ROUTE_INFO		200	/* draft-ietf-ipngwg-router-preference, not officially assigned yet */
(defrecord nd_opt_prefix_info
                                                ;  prefix information 
   (nd_opt_pi_type :UInt8)
   (nd_opt_pi_len :UInt8)
   (nd_opt_pi_prefix_len :UInt8)
   (nd_opt_pi_flags_reserved :UInt8)
   (nd_opt_pi_valid_time :UInt32)
   (nd_opt_pi_preferred_time :UInt32)
   (nd_opt_pi_reserved2 :UInt32)
   (nd_opt_pi_prefix :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
)
(defconstant $ND_OPT_PI_FLAG_ONLINK 128)
; #define ND_OPT_PI_FLAG_ONLINK		0x80
(defconstant $ND_OPT_PI_FLAG_AUTO 64)
; #define ND_OPT_PI_FLAG_AUTO		0x40
(defrecord nd_opt_rd_hdr
                                                ;  redirected header 
   (nd_opt_rh_type :UInt8)
   (nd_opt_rh_len :UInt8)
   (nd_opt_rh_reserved1 :UInt16)
   (nd_opt_rh_reserved2 :UInt32)
                                                ;  followed by IP header and data 
)
(defrecord nd_opt_mtu
                                                ;  MTU option 
   (nd_opt_mtu_type :UInt8)
   (nd_opt_mtu_len :UInt8)
   (nd_opt_mtu_reserved :UInt16)
   (nd_opt_mtu_mtu :UInt32)
)
(defrecord nd_opt_route_info
                                                ;  route info 
   (nd_opt_rti_type :UInt8)
   (nd_opt_rti_len :UInt8)
   (nd_opt_rti_prefixlen :UInt8)
   (nd_opt_rti_flags :UInt8)
   (nd_opt_rti_lifetime :UInt32)
                                                ;  followed by prefix 
)
; 
;  * icmp6 namelookup
;  
(defrecord icmp6_namelookup
   (icmp6_nl_hdr :ICMP6_HDR)
   (icmp6_nl_nonce (:array :UInt8 8))
   (icmp6_nl_ttl :SInt32)

; #if 0
#| 
   (icmp6_nl_len :UInt8)
   (icmp6_nl_name (:array :UInt8 3))
 |#

; #endif

                                                ;  could be followed by options 
)
; 
;  * icmp6 node information
;  
(defrecord icmp6_nodeinfo
   (icmp6_ni_hdr :ICMP6_HDR)
   (icmp6_ni_nonce (:array :UInt8 8))
                                                ;  could be followed by reply data 
)
; #define ni_type		icmp6_ni_hdr.icmp6_type
; #define ni_code		icmp6_ni_hdr.icmp6_code
; #define ni_cksum	icmp6_ni_hdr.icmp6_cksum
; #define ni_qtype	icmp6_ni_hdr.icmp6_data16[0]
; #define ni_flags	icmp6_ni_hdr.icmp6_data16[1]
(defconstant $NI_QTYPE_NOOP 0)
; #define NI_QTYPE_NOOP		0 /* NOOP  */
(defconstant $NI_QTYPE_SUPTYPES 1)
; #define NI_QTYPE_SUPTYPES	1 /* Supported Qtypes */
(defconstant $NI_QTYPE_FQDN 2)
; #define NI_QTYPE_FQDN		2 /* FQDN (draft 04) */
(defconstant $NI_QTYPE_DNSNAME 2)
; #define NI_QTYPE_DNSNAME	2 /* DNS Name */
(defconstant $NI_QTYPE_NODEADDR 3)
; #define NI_QTYPE_NODEADDR	3 /* Node Addresses */
(defconstant $NI_QTYPE_IPV4ADDR 4)
; #define NI_QTYPE_IPV4ADDR	4 /* IPv4 Addresses */

; #if BYTE_ORDER == BIG_ENDIAN
(defconstant $NI_SUPTYPE_FLAG_COMPRESS 1)
; #define NI_SUPTYPE_FLAG_COMPRESS	0x1
(defconstant $NI_FQDN_FLAG_VALIDTTL 1)
; #define NI_FQDN_FLAG_VALIDTTL		0x1
#| 
; #elif BYTE_ORDER == LITTLE_ENDIAN
; #define NI_SUPTYPE_FLAG_COMPRESS	0x0100
; #define NI_FQDN_FLAG_VALIDTTL		0x0100
 |#

; #endif

; #ifdef NAME_LOOKUPS_04
#| #|
#ifBYTE_ORDER == BIG_ENDIAN
#define NI_NODEADDR_FLAG_LINKLOCAL	0x1
#define NI_NODEADDR_FLAG_SITELOCAL	0x2
#define NI_NODEADDR_FLAG_GLOBAL		0x4
#define NI_NODEADDR_FLAG_ALL		0x8
#define NI_NODEADDR_FLAG_TRUNCATE	0x10
#define NI_NODEADDR_FLAG_ANYCAST	0x20 
#elifBYTE_ORDER == LITTLE_ENDIAN
#define NI_NODEADDR_FLAG_LINKLOCAL	0x0100
#define NI_NODEADDR_FLAG_SITELOCAL	0x0200
#define NI_NODEADDR_FLAG_GLOBAL		0x0400
#define NI_NODEADDR_FLAG_ALL		0x0800
#define NI_NODEADDR_FLAG_TRUNCATE	0x1000
#define NI_NODEADDR_FLAG_ANYCAST	0x2000 
#endif
|#
 |#

; #else  /* draft-ietf-ipngwg-icmp-name-lookups-05 (and later?) */

; #if BYTE_ORDER == BIG_ENDIAN
(defconstant $NI_NODEADDR_FLAG_TRUNCATE 1)
; #define NI_NODEADDR_FLAG_TRUNCATE	0x1
(defconstant $NI_NODEADDR_FLAG_ALL 2)
; #define NI_NODEADDR_FLAG_ALL		0x2
(defconstant $NI_NODEADDR_FLAG_COMPAT 4)
; #define NI_NODEADDR_FLAG_COMPAT		0x4
(defconstant $NI_NODEADDR_FLAG_LINKLOCAL 8)
; #define NI_NODEADDR_FLAG_LINKLOCAL	0x8
(defconstant $NI_NODEADDR_FLAG_SITELOCAL 16)
; #define NI_NODEADDR_FLAG_SITELOCAL	0x10
(defconstant $NI_NODEADDR_FLAG_GLOBAL 32)
; #define NI_NODEADDR_FLAG_GLOBAL		0x20
(defconstant $NI_NODEADDR_FLAG_ANYCAST 64)
; #define NI_NODEADDR_FLAG_ANYCAST	0x40 /* just experimental. not in spec */
#| 
; #elif BYTE_ORDER == LITTLE_ENDIAN
; #define NI_NODEADDR_FLAG_TRUNCATE	0x0100
; #define NI_NODEADDR_FLAG_ALL		0x0200
; #define NI_NODEADDR_FLAG_COMPAT		0x0400
; #define NI_NODEADDR_FLAG_LINKLOCAL	0x0800
; #define NI_NODEADDR_FLAG_SITELOCAL	0x1000
; #define NI_NODEADDR_FLAG_GLOBAL		0x2000
; #define NI_NODEADDR_FLAG_ANYCAST	0x4000 /* just experimental. not in spec */
 |#

; #endif


; #endif

(defrecord ni_reply_fqdn
   (ni_fqdn_ttl :UInt32)
                                                ;  TTL 
   (ni_fqdn_namelen :UInt8)                     ;  length in octets of the FQDN 
   (ni_fqdn_name (:array :UInt8 3))             ;  XXX: alignment 
)
; 
;  * Router Renumbering. as router-renum-08.txt
;  
(defrecord icmp6_router_renum
                                                ;  router renumbering header 
   (rr_hdr :ICMP6_HDR)
   (rr_segnum :UInt8)
   (rr_flags :UInt8)
   (rr_maxdelay :UInt16)
   (rr_reserved :UInt32)
)
(defconstant $ICMP6_RR_FLAGS_TEST 128)
; #define ICMP6_RR_FLAGS_TEST		0x80
(defconstant $ICMP6_RR_FLAGS_REQRESULT 64)
; #define ICMP6_RR_FLAGS_REQRESULT	0x40
(defconstant $ICMP6_RR_FLAGS_FORCEAPPLY 32)
; #define ICMP6_RR_FLAGS_FORCEAPPLY	0x20
(defconstant $ICMP6_RR_FLAGS_SPECSITE 16)
; #define ICMP6_RR_FLAGS_SPECSITE		0x10
(defconstant $ICMP6_RR_FLAGS_PREVDONE 8)
; #define ICMP6_RR_FLAGS_PREVDONE		0x08
; #define rr_type		rr_hdr.icmp6_type
; #define rr_code		rr_hdr.icmp6_code
; #define rr_cksum	rr_hdr.icmp6_cksum
; #define rr_seqnum 	rr_hdr.icmp6_data32[0]
(defrecord rr_pco_match
                                                ;  match prefix part 
   (rpm_code :UInt8)
   (rpm_len :UInt8)
   (rpm_ordinal :UInt8)
   (rpm_matchlen :UInt8)
   (rpm_minlen :UInt8)
   (rpm_maxlen :UInt8)
   (rpm_reserved :UInt16)
   (rpm_prefix :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
)
(defconstant $RPM_PCO_ADD 1)
; #define RPM_PCO_ADD		1
(defconstant $RPM_PCO_CHANGE 2)
; #define RPM_PCO_CHANGE		2
(defconstant $RPM_PCO_SETGLOBAL 3)
; #define RPM_PCO_SETGLOBAL	3
(defconstant $RPM_PCO_MAX 4)
; #define RPM_PCO_MAX		4
(defrecord rr_pco_use
                                                ;  use prefix part 
   (rpu_uselen :UInt8)
   (rpu_keeplen :UInt8)
   (rpu_ramask :UInt8)
   (rpu_raflags :UInt8)
   (rpu_vltime :UInt32)
   (rpu_pltime :UInt32)
   (rpu_flags :UInt32)
   (rpu_prefix :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
)
(defconstant $ICMP6_RR_PCOUSE_RAFLAGS_ONLINK 128)
; #define ICMP6_RR_PCOUSE_RAFLAGS_ONLINK	0x80
(defconstant $ICMP6_RR_PCOUSE_RAFLAGS_AUTO 64)
; #define ICMP6_RR_PCOUSE_RAFLAGS_AUTO	0x40

; #if BYTE_ORDER == BIG_ENDIAN
(defconstant $ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME 2147483648)
; #define ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME     0x80000000
(defconstant $ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME 1073741824)
; #define ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME     0x40000000
#| 
; #elif BYTE_ORDER == LITTLE_ENDIAN
; #define ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME     0x80
; #define ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME     0x40
 |#

; #endif

(defrecord rr_result
                                                ;  router renumbering result message 
   (rrr_flags :UInt16)
   (rrr_ordinal :UInt8)
   (rrr_matchedlen :UInt8)
   (rrr_ifid :UInt32)
   (rrr_prefix :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
)

; #if BYTE_ORDER == BIG_ENDIAN
(defconstant $ICMP6_RR_RESULT_FLAGS_OOB 2)
; #define ICMP6_RR_RESULT_FLAGS_OOB		0x0002
(defconstant $ICMP6_RR_RESULT_FLAGS_FORBIDDEN 1)
; #define ICMP6_RR_RESULT_FLAGS_FORBIDDEN		0x0001
#| 
; #elif BYTE_ORDER == LITTLE_ENDIAN
; #define ICMP6_RR_RESULT_FLAGS_OOB		0x0200
; #define ICMP6_RR_RESULT_FLAGS_FORBIDDEN		0x0100
 |#

; #endif

; 
;  * icmp6 filter structures.
;  
(defrecord icmp6_filter
   (icmp6_filt (:array :UInt32 8))
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE
#define ICMP6_FILTER_SETPASSALL(filterp) \
do {								\
	int i; u_char *p;					\
	p = (u_char *)filterp;					\
	for (i = 0; i < sizeof(struct icmp6_filter); i++)	\
		p[i] = 0xff;					\
} while (0)
#define ICMP6_FILTER_SETBLOCKALL(filterp) \
	bzero(filterp, sizeof(struct icmp6_filter))
#endif
|#
 |#

; #else /* KERNEL */
; #define	ICMP6_FILTER_SETPASSALL(filterp) 	memset(filterp, 0xff, sizeof(struct icmp6_filter))
; #define	ICMP6_FILTER_SETBLOCKALL(filterp) 	memset(filterp, 0x00, sizeof(struct icmp6_filter))

; #endif /* KERNEL */

; #define	ICMP6_FILTER_SETPASS(type, filterp) 	(((filterp)->icmp6_filt[(type) >> 5]) |= (1 << ((type) & 31)))
; #define	ICMP6_FILTER_SETBLOCK(type, filterp) 	(((filterp)->icmp6_filt[(type) >> 5]) &= ~(1 << ((type) & 31)))
; #define	ICMP6_FILTER_WILLPASS(type, filterp) 	((((filterp)->icmp6_filt[(type) >> 5]) & (1 << ((type) & 31))) != 0)
; #define	ICMP6_FILTER_WILLBLOCK(type, filterp) 	((((filterp)->icmp6_filt[(type) >> 5]) & (1 << ((type) & 31))) == 0)
; #ifdef __APPLE_API_UNSTABLE
#| #|

struct icmp6errstat {
	u_quad_t icp6errs_dst_unreach_noroute;
	u_quad_t icp6errs_dst_unreach_admin;
	u_quad_t icp6errs_dst_unreach_beyondscope;
	u_quad_t icp6errs_dst_unreach_addr;
	u_quad_t icp6errs_dst_unreach_noport;
	u_quad_t icp6errs_packet_too_big;
	u_quad_t icp6errs_time_exceed_transit;
	u_quad_t icp6errs_time_exceed_reassembly;
	u_quad_t icp6errs_paramprob_header;
	u_quad_t icp6errs_paramprob_nextheader;
	u_quad_t icp6errs_paramprob_option;
	u_quad_t icp6errs_redirect; 
	u_quad_t icp6errs_unknown;
};

struct icmp6stat {

	u_quad_t icp6s_error;		
	u_quad_t icp6s_canterror;	
	u_quad_t icp6s_toofreq;		
	u_quad_t icp6s_outhist[256];

	u_quad_t icp6s_badcode;		
	u_quad_t icp6s_tooshort;	
	u_quad_t icp6s_checksum;	
	u_quad_t icp6s_badlen;		
	u_quad_t icp6s_reflect;		
	u_quad_t icp6s_inhist[256];	
	u_quad_t icp6s_nd_toomanyopt;	
	struct icmp6errstat icp6s_outerrhist;
#define icp6s_odst_unreach_noroute \
	icp6s_outerrhist.icp6errs_dst_unreach_noroute
#define icp6s_odst_unreach_admin icp6s_outerrhist.icp6errs_dst_unreach_admin
#define icp6s_odst_unreach_beyondscope \
	icp6s_outerrhist.icp6errs_dst_unreach_beyondscope
#define icp6s_odst_unreach_addr icp6s_outerrhist.icp6errs_dst_unreach_addr
#define icp6s_odst_unreach_noport icp6s_outerrhist.icp6errs_dst_unreach_noport
#define icp6s_opacket_too_big icp6s_outerrhist.icp6errs_packet_too_big
#define icp6s_otime_exceed_transit \
	icp6s_outerrhist.icp6errs_time_exceed_transit
#define icp6s_otime_exceed_reassembly \
	icp6s_outerrhist.icp6errs_time_exceed_reassembly
#define icp6s_oparamprob_header icp6s_outerrhist.icp6errs_paramprob_header
#define icp6s_oparamprob_nextheader \
	icp6s_outerrhist.icp6errs_paramprob_nextheader
#define icp6s_oparamprob_option icp6s_outerrhist.icp6errs_paramprob_option
#define icp6s_oredirect icp6s_outerrhist.icp6errs_redirect
#define icp6s_ounknown icp6s_outerrhist.icp6errs_unknown
	u_quad_t icp6s_pmtuchg;		
	u_quad_t icp6s_nd_badopt;	
	u_quad_t icp6s_badns;		
	u_quad_t icp6s_badna;		
	u_quad_t icp6s_badrs;		
	u_quad_t icp6s_badra;		
	u_quad_t icp6s_badredirect;	
};


#define ICMPV6CTL_STATS		1
#define ICMPV6CTL_REDIRACCEPT	2	
#define ICMPV6CTL_REDIRTIMEOUT	3	
#define ICMPV6CTL_ND6_PRUNE	6
#define ICMPV6CTL_ND6_DELAY	8
#define ICMPV6CTL_ND6_UMAXTRIES	9
#define ICMPV6CTL_ND6_MMAXTRIES		10
#define ICMPV6CTL_ND6_USELOOPBACK	11

#define ICMPV6CTL_NODEINFO	13
#define ICMPV6CTL_ERRPPSLIMIT	14	
#define ICMPV6CTL_ND6_MAXNUDHINT	15
#define ICMPV6CTL_MTUDISC_HIWAT	16
#define ICMPV6CTL_MTUDISC_LOWAT	17
#define ICMPV6CTL_ND6_DEBUG	18
#define ICMPV6CTL_ND6_DRLIST	19
#define ICMPV6CTL_ND6_PRLIST	20
#define ICMPV6CTL_MAXID		21

#define ICMPV6CTL_NAMES { \
	{ 0, 0 }, \
	{ 0, 0 }, \
	{ "rediraccept", CTLTYPE_INT }, \
	{ "redirtimeout", CTLTYPE_INT }, \
	{ 0, 0 }, \
	{ 0, 0 }, \
	{ "nd6_prune", CTLTYPE_INT }, \
	{ 0, 0 }, \
	{ "nd6_delay", CTLTYPE_INT }, \
	{ "nd6_umaxtries", CTLTYPE_INT }, \
	{ "nd6_mmaxtries", CTLTYPE_INT }, \
	{ "nd6_useloopback", CTLTYPE_INT }, \
	{ 0, 0 }, \
	{ "nodeinfo", CTLTYPE_INT }, \
	{ "errppslimit", CTLTYPE_INT }, \
	{ "nd6_maxnudhint", CTLTYPE_INT }, \
	{ "mtudisc_hiwat", CTLTYPE_INT }, \
	{ "mtudisc_lowat", CTLTYPE_INT }, \
	{ "nd6_debug", CTLTYPE_INT }, \
	{ 0, 0 }, \
	{ 0, 0 }, \
}
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #define RTF_PROBEMTU	RTF_PROTO1
; #ifdef KERNEL
#| #|
#ifdef__STDC__
struct	rtentry;
struct	rttimer;
struct	in6_multi;
#endif#ifdef__APPLE_API_PRIVATE
void	icmp6_init __P((void));
void	icmp6_paramerror __P((struct mbuf *, int));
void	icmp6_error __P((struct mbuf *, int, int, int));
int	icmp6_input __P((struct mbuf **, int *));
void	icmp6_fasttimo __P((void));
void	icmp6_reflect __P((struct mbuf *, size_t));
void	icmp6_prepare __P((struct mbuf *));
void	icmp6_redirect_input __P((struct mbuf *, int));
void	icmp6_redirect_output __P((struct mbuf *, struct rtentry *));

struct	ip6ctlparam;
void	icmp6_mtudisc_update __P((struct ip6ctlparam *, int));


#define icmp6_ifstat_inc(ifp, tag) \
do {								\
	if ((ifp) && (ifp)->if_index <= if_index			\
	 && (ifp)->if_index < icmp6_ifstatmax			\
	 && icmp6_ifstat && icmp6_ifstat[(ifp)->if_index]) {	\
		icmp6_ifstat[(ifp)->if_index]->tag++;		\
	}							\
} while (0)

#define icmp6_ifoutstat_inc(ifp, type, code) \
do { \
		icmp6_ifstat_inc(ifp, ifs6_out_msg); \
 		if (type < ICMP6_INFOMSG_MASK) \
 			icmp6_ifstat_inc(ifp, ifs6_out_error); \
		switch(type) { \
		 case ICMP6_DST_UNREACH: \
			 icmp6_ifstat_inc(ifp, ifs6_out_dstunreach); \
			 if (code == ICMP6_DST_UNREACH_ADMIN) \
				 icmp6_ifstat_inc(ifp, ifs6_out_adminprohib); \
			 break; \
		 case ICMP6_PACKET_TOO_BIG: \
			 icmp6_ifstat_inc(ifp, ifs6_out_pkttoobig); \
			 break; \
		 case ICMP6_TIME_EXCEEDED: \
			 icmp6_ifstat_inc(ifp, ifs6_out_timeexceed); \
			 break; \
		 case ICMP6_PARAM_PROB: \
			 icmp6_ifstat_inc(ifp, ifs6_out_paramprob); \
			 break; \
		 case ICMP6_ECHO_REQUEST: \
			 icmp6_ifstat_inc(ifp, ifs6_out_echo); \
			 break; \
		 case ICMP6_ECHO_REPLY: \
			 icmp6_ifstat_inc(ifp, ifs6_out_echoreply); \
			 break; \
		 case MLD6_LISTENER_QUERY: \
			 icmp6_ifstat_inc(ifp, ifs6_out_mldquery); \
			 break; \
		 case MLD6_LISTENER_REPORT: \
			 icmp6_ifstat_inc(ifp, ifs6_out_mldreport); \
			 break; \
		 case MLD6_LISTENER_DONE: \
			 icmp6_ifstat_inc(ifp, ifs6_out_mlddone); \
			 break; \
		 case ND_ROUTER_SOLICIT: \
			 icmp6_ifstat_inc(ifp, ifs6_out_routersolicit); \
			 break; \
		 case ND_ROUTER_ADVERT: \
			 icmp6_ifstat_inc(ifp, ifs6_out_routeradvert); \
			 break; \
		 case ND_NEIGHBOR_SOLICIT: \
			 icmp6_ifstat_inc(ifp, ifs6_out_neighborsolicit); \
			 break; \
		 case ND_NEIGHBOR_ADVERT: \
			 icmp6_ifstat_inc(ifp, ifs6_out_neighboradvert); \
			 break; \
		 case ND_REDIRECT: \
			 icmp6_ifstat_inc(ifp, ifs6_out_redirect); \
			 break; \
		} \
} while (0)

extern int	icmp6_rediraccept;	
extern int	icmp6_redirtimeout;	
#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* !_NETINET_ICMP6_H_ */


(provide-interface "icmp6")