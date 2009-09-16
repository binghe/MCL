(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ipsec.h"
; at Sunday July 2,2006 7:28:11 pm.
; 	$FreeBSD: src/sys/netinet6/ipsec.h,v 1.4.2.2 2001/07/03 11:01:54 ume Exp $	
; 	$KAME: ipsec.h,v 1.44 2001/03/23 08:08:47 itojun Exp $	
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
;  * IPsec controller part.
;  
; #ifndef _NETINET6_IPSEC_H_
; #define _NETINET6_IPSEC_H_

(require-interface "sys/appleapiopts")

(require-interface "net/pfkeyv2")

(require-interface "netkey/keydb")
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

struct secpolicyindex {
	u_int8_t dir;			
	struct sockaddr_storage src;	
	struct sockaddr_storage dst;	
	u_int8_t prefs;			
	u_int8_t prefd;			
	u_int16_t ul_proto;		
#ifdefnotyet
	uid_t uids;
	uid_t uidd;
	gid_t gids;
	gid_t gidd;
#endif};


struct secpolicy {
	LIST_ENTRY(secpolicy) chain;

	int refcnt;			
	struct secpolicyindex spidx;	
	u_int32_t id;			
	u_int state;			
#define IPSEC_SPSTATE_DEAD	0
#define IPSEC_SPSTATE_ALIVE	1

	u_int policy;		
	struct ipsecrequest *req;
				
				

	
	long created;		
	long lastused;		
	long lifetime;		
	long validtime;		
};


struct ipsecrequest {
	struct ipsecrequest *next;
				
				
	struct secasindex saidx;
				
	u_int level;		

	struct secasvar *sav;	
	struct secpolicy *sp;	
};


struct inpcbpolicy {
	struct secpolicy *sp_in;
	struct secpolicy *sp_out;
	int priv;			
};


struct secspacq {
	LIST_ENTRY(secspacq) chain;

	struct secpolicyindex spidx;

	long created;		
	int count;		
	
};
#endif
#endif
|#
 |#
; KERNEL
;  according to IANA assignment, port 0x0000 and proto 0xff are reserved. 
(defconstant $IPSEC_PORT_ANY 0)
; #define IPSEC_PORT_ANY		0
(defconstant $IPSEC_ULPROTO_ANY 255)
; #define IPSEC_ULPROTO_ANY	255
(defconstant $IPSEC_PROTO_ANY 255)
; #define IPSEC_PROTO_ANY		255
;  mode of security protocol 
;  NOTE: DON'T use IPSEC_MODE_ANY at SPD.  It's only use in SAD 
(defconstant $IPSEC_MODE_ANY 0)
; #define	IPSEC_MODE_ANY		0	/* i.e. wildcard. */
(defconstant $IPSEC_MODE_TRANSPORT 1)
; #define	IPSEC_MODE_TRANSPORT	1
(defconstant $IPSEC_MODE_TUNNEL 2)
; #define	IPSEC_MODE_TUNNEL	2
; 
;  * Direction of security policy.
;  * NOTE: Since INVALID is used just as flag.
;  * The other are used for loop counter too.
;  
(defconstant $IPSEC_DIR_ANY 0)
; #define IPSEC_DIR_ANY		0
(defconstant $IPSEC_DIR_INBOUND 1)
; #define IPSEC_DIR_INBOUND	1
(defconstant $IPSEC_DIR_OUTBOUND 2)
; #define IPSEC_DIR_OUTBOUND	2
(defconstant $IPSEC_DIR_MAX 3)
; #define IPSEC_DIR_MAX		3
(defconstant $IPSEC_DIR_INVALID 4)
; #define IPSEC_DIR_INVALID	4
;  Policy level 
; 
;  * IPSEC, ENTRUST and BYPASS are allowed for setsockopt() in PCB,
;  * DISCARD, IPSEC and NONE are allowed for setkey() in SPD.
;  * DISCARD and NONE are allowed for system default.
;  
(defconstant $IPSEC_POLICY_DISCARD 0)
; #define IPSEC_POLICY_DISCARD	0	/* discarding packet */
(defconstant $IPSEC_POLICY_NONE 1)
; #define IPSEC_POLICY_NONE	1	/* through IPsec engine */
(defconstant $IPSEC_POLICY_IPSEC 2)
; #define IPSEC_POLICY_IPSEC	2	/* do IPsec */
(defconstant $IPSEC_POLICY_ENTRUST 3)
; #define IPSEC_POLICY_ENTRUST	3	/* consulting SPD if present. */
(defconstant $IPSEC_POLICY_BYPASS 4)
; #define IPSEC_POLICY_BYPASS	4	/* only for privileged socket. */
;  Security protocol level 
(defconstant $IPSEC_LEVEL_DEFAULT 0)
; #define	IPSEC_LEVEL_DEFAULT	0	/* reference to system default */
(defconstant $IPSEC_LEVEL_USE 1)
; #define	IPSEC_LEVEL_USE		1	/* use SA if present. */
(defconstant $IPSEC_LEVEL_REQUIRE 2)
; #define	IPSEC_LEVEL_REQUIRE	2	/* require SA. */
(defconstant $IPSEC_LEVEL_UNIQUE 3)
; #define	IPSEC_LEVEL_UNIQUE	3	/* unique SA. */
(defconstant $IPSEC_MANUAL_REQID_MAX 16383)
; #define IPSEC_MANUAL_REQID_MAX	0x3fff
; 
; 				 * if security policy level == unique, this id
; 				 * indicate to a relative SA for use, else is
; 				 * zero.
; 				 * 1 - 0x3fff are reserved for manual keying.
; 				 * 0 are reserved for above reason.  Others is
; 				 * for kernel use.
; 				 * Note that this id doesn't identify SA
; 				 * by only itself.
; 				 
(defconstant $IPSEC_REPLAYWSIZE 32)
; #define IPSEC_REPLAYWSIZE  32
; #ifdef __APPLE_API_UNSTABLE
#| #|

struct ipsecstat {
	u_quad_t in_success;  
	u_quad_t in_polvio;
			
	u_quad_t in_nosa;     
	u_quad_t in_inval;    
	u_quad_t in_nomem;    
	u_quad_t in_badspi;   
	u_quad_t in_ahreplay; 
	u_quad_t in_espreplay; 
	u_quad_t in_ahauthsucc; 
	u_quad_t in_ahauthfail; 
	u_quad_t in_espauthsucc; 
	u_quad_t in_espauthfail; 
	u_quad_t in_esphist[256];
	u_quad_t in_ahhist[256];
	u_quad_t in_comphist[256];
	u_quad_t out_success; 
	u_quad_t out_polvio;
			
	u_quad_t out_nosa;    
	u_quad_t out_inval;   
	u_quad_t out_nomem;    
	u_quad_t out_noroute; 
	u_quad_t out_esphist[256];
	u_quad_t out_ahhist[256];
	u_quad_t out_comphist[256];
};
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; 
;  * Definitions for IPsec & Key sysctl operations.
;  
; 
;  * Names for IPsec & Key sysctl objects
;  
(defconstant $IPSECCTL_STATS 1)
; #define IPSECCTL_STATS			1	/* stats */
(defconstant $IPSECCTL_DEF_POLICY 2)
; #define IPSECCTL_DEF_POLICY		2
(defconstant $IPSECCTL_DEF_ESP_TRANSLEV 3)
; #define IPSECCTL_DEF_ESP_TRANSLEV	3	/* int; ESP transport mode */
(defconstant $IPSECCTL_DEF_ESP_NETLEV 4)
; #define IPSECCTL_DEF_ESP_NETLEV		4	/* int; ESP tunnel mode */
(defconstant $IPSECCTL_DEF_AH_TRANSLEV 5)
; #define IPSECCTL_DEF_AH_TRANSLEV	5	/* int; AH transport mode */
(defconstant $IPSECCTL_DEF_AH_NETLEV 6)
; #define IPSECCTL_DEF_AH_NETLEV		6	/* int; AH tunnel mode */

; #if 0	/* obsolete, do not reuse */
;  obsolete, do not reuse 
#| 
; #define IPSECCTL_INBOUND_CALL_IKE	7
 |#

; #endif

(defconstant $IPSECCTL_AH_CLEARTOS 8)
; #define	IPSECCTL_AH_CLEARTOS		8
(defconstant $IPSECCTL_AH_OFFSETMASK 9)
; #define	IPSECCTL_AH_OFFSETMASK		9
(defconstant $IPSECCTL_DFBIT 10)
; #define	IPSECCTL_DFBIT			10
(defconstant $IPSECCTL_ECN 11)
; #define	IPSECCTL_ECN			11
(defconstant $IPSECCTL_DEBUG 12)
; #define	IPSECCTL_DEBUG			12
(defconstant $IPSECCTL_ESP_RANDPAD 13)
; #define	IPSECCTL_ESP_RANDPAD		13
(defconstant $IPSECCTL_MAXID 14)
; #define IPSECCTL_MAXID			14
; #define IPSECCTL_NAMES { 	{ 0, 0 }, 	{ 0, 0 }, 	{ "def_policy", CTLTYPE_INT }, 	{ "esp_trans_deflev", CTLTYPE_INT }, 	{ "esp_net_deflev", CTLTYPE_INT }, 	{ "ah_trans_deflev", CTLTYPE_INT }, 	{ "ah_net_deflev", CTLTYPE_INT }, 	{ 0, 0 }, 	{ "ah_cleartos", CTLTYPE_INT }, 	{ "ah_offsetmask", CTLTYPE_INT }, 	{ "dfbit", CTLTYPE_INT }, 	{ "ecn", CTLTYPE_INT }, 	{ "debug", CTLTYPE_INT }, 	{ "esp_randpad", CTLTYPE_INT }, }
; #define IPSEC6CTL_NAMES { 	{ 0, 0 }, 	{ 0, 0 }, 	{ "def_policy", CTLTYPE_INT }, 	{ "esp_trans_deflev", CTLTYPE_INT }, 	{ "esp_net_deflev", CTLTYPE_INT }, 	{ "ah_trans_deflev", CTLTYPE_INT }, 	{ "ah_net_deflev", CTLTYPE_INT }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ "ecn", CTLTYPE_INT }, 	{ "debug", CTLTYPE_INT }, 	{ "esp_randpad", CTLTYPE_INT }, }
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
struct ipsec_output_state {
	struct mbuf *m;
	struct route *ro;
	struct sockaddr *dst;
};

struct ipsec_history {
	int ih_proto;
	u_int32_t ih_spi;
};

extern int ipsec_debug;

extern struct ipsecstat ipsecstat;
extern struct secpolicy ip4_def_policy;
extern int ip4_esp_trans_deflev;
extern int ip4_esp_net_deflev;
extern int ip4_ah_trans_deflev;
extern int ip4_ah_net_deflev;
extern int ip4_ah_cleartos;
extern int ip4_ah_offsetmask;
extern int ip4_ipsec_dfbit;
extern int ip4_ipsec_ecn;
extern int ip4_esp_randpad;

#define ipseclog(x)	do { if (ipsec_debug) log x; } while (0)

extern struct secpolicy *ipsec4_getpolicybysock
	__P((struct mbuf *, u_int, struct socket *, int *));
extern struct secpolicy *ipsec4_getpolicybyaddr
	__P((struct mbuf *, u_int, int, int *));

struct inpcb;
extern int ipsec_init_policy __P((struct socket *so, struct inpcbpolicy **));
extern int ipsec_copy_policy
	__P((struct inpcbpolicy *, struct inpcbpolicy *));
extern u_int ipsec_get_reqlevel __P((struct ipsecrequest *));

extern int ipsec4_set_policy __P((struct inpcb *inp, int optname,
	caddr_t request, size_t len, int priv));
extern int ipsec4_get_policy __P((struct inpcb *inpcb, caddr_t request,
	size_t len, struct mbuf **mp));
extern int ipsec4_delete_pcbpolicy __P((struct inpcb *));
extern int ipsec4_in_reject_so __P((struct mbuf *, struct socket *));
extern int ipsec4_in_reject __P((struct mbuf *, struct inpcb *));

struct secas;
struct tcpcb;
extern int ipsec_chkreplay __P((u_int32_t, struct secasvar *));
extern int ipsec_updatereplay __P((u_int32_t, struct secasvar *));

extern size_t ipsec4_hdrsiz __P((struct mbuf *, u_int, struct inpcb *));
extern size_t ipsec_hdrsiz_tcp __P((struct tcpcb *));

struct ip;
extern const char *ipsec4_logpacketstr __P((struct ip *, u_int32_t));
extern const char *ipsec_logsastr __P((struct secasvar *));

extern void ipsec_dumpmbuf __P((struct mbuf *));

extern int ipsec4_output __P((struct ipsec_output_state *, struct secpolicy *,
	int));
extern int ipsec4_tunnel_validate __P((struct mbuf *, int, u_int,
	struct secasvar *));
extern struct mbuf *ipsec_copypkt __P((struct mbuf *));
extern void ipsec_delaux __P((struct mbuf *));
extern int ipsec_setsocket __P((struct mbuf *, struct socket *));
extern struct socket *ipsec_getsocket __P((struct mbuf *));
extern int ipsec_addhist __P((struct mbuf *, int, u_int32_t)); 
extern struct ipsec_history *ipsec_gethist __P((struct mbuf *, int *));
extern void ipsec_clearhist __P((struct mbuf *));
#endif
#endif
|#
 |#
; KERNEL
; #ifndef KERNEL
#|
 confused about __P #\( #\( char * #\, int #\) #\)
|#
#|
 confused about __P #\( #\( caddr_t #\) #\)
|#
#|
 confused about __P #\( #\( caddr_t #\, char * #\) #\)
|#
#|
 confused about __P #\( #\( void #\) #\)
|#

; #endif /*!KERNEL*/


; #endif /*_NETINET6_IPSEC_H_*/


(provide-interface "ipsec")