(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:nd6.h"
; at Sunday July 2,2006 7:30:33 pm.
; 	$FreeBSD: src/sys/netinet6/nd6.h,v 1.2.2.3 2001/08/13 01:10:49 simokawa Exp $	
; 	$KAME: nd6.h,v 1.55 2001/04/27 15:09:49 itojun Exp $	
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
; #ifndef _NETINET6_ND6_H_
; #define _NETINET6_ND6_H_

(require-interface "sys/appleapiopts")
;  see net/route.h, or net/if_inarp.h 
; #ifndef RTF_ANNOUNCE
#| #|
#define RTF_ANNOUNCE	RTF_PROTO2
#endif
|#
 |#

(require-interface "sys/queue")
(defrecord llinfo_nd6
   (ln_next (:pointer :llinfo_nd6))
   (ln_prev (:pointer :llinfo_nd6))
   (ln_rt (:pointer :rtentry))
   (ln_hold (:pointer :mbuf))
                                                ;  last packet until resolved/timeout 
   (ln_asked :signed-long)
                                                ;  number of queries already sent for this addr 
   (ln_expire :UInt32)
                                                ;  lifetime for NDP state transition 
   (ln_state :SInt16)
                                                ;  reachability state 
   (ln_router :SInt16)
                                                ;  2^0: ND6 router bit 
   (ln_byhint :signed-long)
                                                ;  # of times we made it reachable by UL hint 
)
; #define ND6_LLINFO_NOSTATE	-2
; 
;  * We don't need the WAITDELETE state any more, but we keep the definition
;  * in a comment line instead of removing it. This is necessary to avoid
;  * unintentionally reusing the value for another purpose, which might
;  * affect backward compatibility with old applications.
;  * (20000711 jinmei@kame.net)
;  
;  #define ND6_LLINFO_WAITDELETE	-1 
(defconstant $ND6_LLINFO_INCOMPLETE 0)
; #define ND6_LLINFO_INCOMPLETE	0
(defconstant $ND6_LLINFO_REACHABLE 1)
; #define ND6_LLINFO_REACHABLE	1
(defconstant $ND6_LLINFO_STALE 2)
; #define ND6_LLINFO_STALE	2
(defconstant $ND6_LLINFO_DELAY 3)
; #define ND6_LLINFO_DELAY	3
(defconstant $ND6_LLINFO_PROBE 4)
; #define ND6_LLINFO_PROBE	4
; #define ND6_IS_LLINFO_PROBREACH(n) ((n)->ln_state > ND6_LLINFO_INCOMPLETE)
(defrecord nd_ifinfo
   (linkmtu :UInt32)
                                                ;  LinkMTU 
   (maxmtu :UInt32)
                                                ;  Upper bound of LinkMTU 
   (basereachable :UInt32)
                                                ;  BaseReachableTime 
   (reachable :UInt32)
                                                ;  Reachable Time 
   (retrans :UInt32)
                                                ;  Retrans Timer 
   (flags :UInt32)
                                                ;  Flags 
   (recalctm :signed-long)
                                                ;  BaseReacable re-calculation timer 
   (chlim :UInt8)
                                                ;  CurHopLimit 
   (receivedra :UInt8)
                                                ;  the following 3 members are for privacy extension for addrconf 
   (randomseed0 (:array :UInt8 8))              ;  upper 64 bits of MD5 digest 
   (randomseed1 (:array :UInt8 8))              ;  lower 64 bits (usually the EUI64 IFID) 
   (randomid (:array :UInt8 8))
                                                ;  current random ID 
)
(defconstant $ND6_IFF_PERFORMNUD 1)
; #define ND6_IFF_PERFORMNUD	0x1
(defrecord in6_nbrinfo
   (ifname (:array :character 16))
                                                ;  if name, e.g. "en0" 
   (addr :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
                                                ;  IPv6 address of the neighbor 
   (asked :signed-long)
                                                ;  number of queries already sent for this addr 
   (isrouter :signed-long)
                                                ;  if it acts as a router 
   (state :signed-long)
                                                ;  reachability state 
   (expire :signed-long)
                                                ;  lifetime for NDP state transition 
)
(defconstant $DRLSTSIZ 10)
; #define DRLSTSIZ 10
(defconstant $PRLSTSIZ 10)
; #define PRLSTSIZ 10
(defrecord in6_drlist
   (ifname (:array :character 16))
   (rtaddr :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
   (flags :UInt8)
   (rtlifetime :UInt16)
   (expire :UInt32)
   (if_index :UInt16)
)
(defrecord in6_defrouter
   (rtaddr :sockaddr_in6)
#|
; Warning: type-size: unknown type SOCKADDR_IN6
|#
   (flags :UInt8)
   (rtlifetime :UInt16)
   (expire :UInt32)
   (if_index :UInt16)
)
(defrecord in6_prlist
   (ifname (:array :character 16))
   (prefix :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
   (raflags :prf_ra)
#|
; Warning: type-size: unknown type PRF_RA
|#
   (prefixlen :UInt8)
   (origin :UInt8)
   (vltime :UInt32)
   (pltime :UInt32)
   (expire :UInt32)
   (if_index :UInt16)
   (advrtrs :UInt16)                            ;  number of advertisement routers 
   (advrtr (:array :in6_addr 10))
#|
; Warning: type-size: unknown type in6_addr
|#                                              ;  XXX: explicit limit 
)
(defrecord in6_prefix
   (prefix :sockaddr_in6)
#|
; Warning: type-size: unknown type SOCKADDR_IN6
|#
   (raflags :prf_ra)
#|
; Warning: type-size: unknown type PRF_RA
|#
   (prefixlen :UInt8)
   (origin :UInt8)
   (vltime :UInt32)
   (pltime :UInt32)
   (expire :UInt32)
   (flags :UInt32)
   (refcnt :signed-long)
   (if_index :UInt16)
   (advrtrs :UInt16)                            ;  number of advertisement routers 
                                                ;  struct sockaddr_in6 advrtr[] 
)
(defrecord in6_ondireq
   (ifname (:array :character 16))
   (linkmtu :UInt32)
                                                ;  LinkMTU 
   (maxmtu :UInt32)
                                                ;  Upper bound of LinkMTU 
   (basereachable :UInt32)                      ;  BaseReachableTime 
   (reachable :UInt32)
                                                ;  Reachable Time 
   (retrans :UInt32)
                                                ;  Retrans Timer 
   (flags :UInt32)
                                                ;  Flags 
   (recalctm :signed-long)
                                                ;  BaseReacable re-calculation timer 
   (chlim :UInt8)
                                                ;  CurHopLimit 
   (receivedra :UInt8)
)
(defrecord in6_ndireq
   (ifname (:array :character 16))
   (ndi :ND_IFINFO)
)
(defrecord in6_ndifreq
   (ifname (:array :character 16))
   (ifindex :UInt32)
)
;  Prefix status 
(defconstant $NDPRF_ONLINK 1)
; #define NDPRF_ONLINK		0x1
(defconstant $NDPRF_DETACHED 2)
; #define NDPRF_DETACHED		0x2
;  protocol constants 
(defconstant $MAX_RTR_SOLICITATION_DELAY 1)
; #define MAX_RTR_SOLICITATION_DELAY	1	/*1sec*/
(defconstant $RTR_SOLICITATION_INTERVAL 4)
; #define RTR_SOLICITATION_INTERVAL	4	/*4sec*/
(defconstant $MAX_RTR_SOLICITATIONS 3)
; #define MAX_RTR_SOLICITATIONS		3
(defconstant $ND6_INFINITE_LIFETIME 4294967295)
; #define ND6_INFINITE_LIFETIME		0xffffffff
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

#define MAX_REACHABLE_TIME		3600000	
#define REACHABLE_TIME			30000	
#define RETRANS_TIMER			1000	
#define MIN_RANDOM_FACTOR		512	
#define MAX_RANDOM_FACTOR		1536	
#define DEF_TEMP_VALID_LIFETIME		604800	
#define DEF_TEMP_PREFERRED_LIFETIME	86400	
#define TEMPADDR_REGEN_ADVANCE		5	
#define MAX_TEMP_DESYNC_FACTOR		600	
#define ND_COMPUTE_RTIME(x) \
		(((MIN_RANDOM_FACTOR * (x >> 10)) + (random() & \
		((MAX_RANDOM_FACTOR - MIN_RANDOM_FACTOR) * (x >> 10)))) 1000)

TAILQ_HEAD(nd_drhead, nd_defrouter);
struct	nd_defrouter {
	TAILQ_ENTRY(nd_defrouter) dr_entry;
	struct	in6_addr rtaddr;
	u_char	flags;		
	u_short	rtlifetime;
	u_long	expire;
	u_long	advint;		
	u_long	advint_expire;	
	int	advints_lost;	
	struct  ifnet *ifp;
};

struct nd_prefix {
	struct ifnet *ndpr_ifp;
	LIST_ENTRY(nd_prefix) ndpr_entry;
	struct sockaddr_in6 ndpr_prefix;	
	struct in6_addr ndpr_mask; 
	struct in6_addr ndpr_addr; 
	u_int32_t ndpr_vltime;	
	u_int32_t ndpr_pltime;	
	time_t ndpr_expire;	
	time_t ndpr_preferred;	
	struct prf_ra ndpr_flags;
	u_int32_t ndpr_stateflags; 
	
	LIST_HEAD(pr_rtrhead, nd_pfxrouter) ndpr_advrtrs;
	u_char	ndpr_plen;
	int	ndpr_refcnt;	
};

#define ndpr_next		ndpr_entry.le_next

#define ndpr_raf		ndpr_flags
#define ndpr_raf_onlink		ndpr_flags.onlink
#define ndpr_raf_auto		ndpr_flags.autonomous


#define NDPR_KEEP_EXPIRED	(1800 * 2)


struct inet6_ndpr_msghdr {
	u_short	inpm_msglen;	
	u_char	inpm_version;	
	u_char	inpm_type;	
	struct in6_addr inpm_prefix;
	u_long	prm_vltim;
	u_long	prm_pltime;
	u_long	prm_expire;
	u_long	prm_preferred;
	struct in6_prflags prm_flags;
	u_short	prm_index;	
	u_char	prm_plen;	
};

#define prm_raf_onlink		prm_flags.prf_ra.onlink
#define prm_raf_auto		prm_flags.prf_ra.autonomous

#define prm_statef_onlink	prm_flags.prf_state.onlink

#define prm_rrf_decrvalid	prm_flags.prf_rr.decrvalid
#define prm_rrf_decrprefd	prm_flags.prf_rr.decrprefd

#define ifpr2ndpr(ifpr)	((struct nd_prefix *)(ifpr))
#define ndpr2ifpr(ndpr)	((struct ifprefix *)(ndpr))

struct nd_pfxrouter {
	LIST_ENTRY(nd_pfxrouter) pfr_entry;
#define pfr_next pfr_entry.le_next
	struct nd_defrouter *router;
};

LIST_HEAD(nd_prhead, nd_prefix);


extern int nd6_prune;
extern int nd6_delay;
extern int nd6_umaxtries;
extern int nd6_mmaxtries;
extern int nd6_useloopback;
extern int nd6_maxnudhint;
extern int nd6_gctimer;
extern struct llinfo_nd6 llinfo_nd6;
extern struct nd_ifinfo *nd_ifinfo;
extern struct nd_drhead nd_defrouter;
extern struct nd_prhead nd_prefix;
extern int nd6_debug;

#define nd6log(x)	do { if (nd6_debug) log x; } while (0)

extern struct callout nd6_timer_ch;


extern int nd6_defifindex;
extern int ip6_desync_factor;	
extern u_int32_t ip6_temp_preferred_lifetime; 
extern u_int32_t ip6_temp_valid_lifetime; 
extern int ip6_temp_regen_advance; 

union nd_opts {
	struct nd_opt_hdr *nd_opt_array[9];	
	struct {
		struct nd_opt_hdr *zero;
		struct nd_opt_hdr *src_lladdr;
		struct nd_opt_hdr *tgt_lladdr;
		struct nd_opt_prefix_info *pi_beg; 
		struct nd_opt_rd_hdr *rh;
		struct nd_opt_mtu *mtu;
		struct nd_opt_hdr *six;
		struct nd_opt_advint *adv;
		struct nd_opt_hai *hai;
		struct nd_opt_hdr *search;	
		struct nd_opt_hdr *last;	
		int done;
		struct nd_opt_prefix_info *pi_end;
	} nd_opt_each;
};
#define nd_opts_src_lladdr	nd_opt_each.src_lladdr
#define nd_opts_tgt_lladdr	nd_opt_each.tgt_lladdr
#define nd_opts_pi		nd_opt_each.pi_beg
#define nd_opts_pi_end		nd_opt_each.pi_end
#define nd_opts_rh		nd_opt_each.rh
#define nd_opts_mtu		nd_opt_each.mtu
#define nd_opts_adv		nd_opt_each.adv
#define nd_opts_hai		nd_opt_each.hai
#define nd_opts_search		nd_opt_each.search
#define nd_opts_last		nd_opt_each.last
#define nd_opts_done		nd_opt_each.done



void nd6_init __P((void));
void nd6_ifattach __P((struct ifnet *));
int nd6_is_addr_neighbor __P((struct sockaddr_in6 *, struct ifnet *));
void nd6_option_init __P((void *, int, union nd_opts *));
struct nd_opt_hdr *nd6_option __P((union nd_opts *));
int nd6_options __P((union nd_opts *));
struct	rtentry *nd6_lookup __P((struct in6_addr *, int, struct ifnet *));
void nd6_setmtu __P((struct ifnet *));
void nd6_timer __P((void *));
void nd6_purge __P((struct ifnet *));
struct llinfo_nd6 *nd6_free __P((struct rtentry *));
void nd6_nud_hint __P((struct rtentry *, struct in6_addr *, int));
int nd6_resolve __P((struct ifnet *, struct rtentry *,
		     struct mbuf *, struct sockaddr *, u_char *));
void nd6_rtrequest __P((int, struct rtentry *, struct sockaddr *));
int nd6_ioctl __P((u_long, caddr_t, struct ifnet *));
struct rtentry *nd6_cache_lladdr __P((struct ifnet *, struct in6_addr *,
	char *, int, int, int));
int nd6_output __P((struct ifnet *, struct ifnet *, struct mbuf *,
		    struct sockaddr_in6 *, struct rtentry *));
int nd6_storelladdr __P((struct ifnet *, struct rtentry *, struct mbuf *,
			 struct sockaddr *, u_char *));
int nd6_need_cache __P((struct ifnet *));


void nd6_na_input __P((struct mbuf *, int, int));
void nd6_na_output __P((struct ifnet *, const struct in6_addr *,
	const struct in6_addr *, u_long, int, struct sockaddr *));
void nd6_ns_input __P((struct mbuf *, int, int));
void nd6_ns_output __P((struct ifnet *, const struct in6_addr *,
	const struct in6_addr *, struct llinfo_nd6 *, int));
caddr_t nd6_ifptomac __P((struct ifnet *));
void nd6_dad_start __P((struct ifaddr *, int *));
void nd6_dad_stop __P((struct ifaddr *));
void nd6_dad_duplicated __P((struct ifaddr *));


void nd6_rs_input __P((struct mbuf *, int, int));
void nd6_ra_input __P((struct mbuf *, int, int));
void prelist_del __P((struct nd_prefix *));
void defrouter_addreq __P((struct nd_defrouter *));
void defrouter_delreq __P((struct nd_defrouter *, int));
void defrouter_select __P((void));
void defrtrlist_del __P((struct nd_defrouter *));
void prelist_remove __P((struct nd_prefix *));
int prelist_update __P((struct nd_prefix *, struct nd_defrouter *,
			struct mbuf *));
int nd6_prelist_add __P((struct nd_prefix *, struct nd_defrouter *,
			 struct nd_prefix **));
int nd6_prefix_onlink __P((struct nd_prefix *));
int nd6_prefix_offlink __P((struct nd_prefix *));
void pfxlist_onlink_check __P((void));
struct nd_defrouter *defrouter_lookup __P((struct in6_addr *,
					   struct ifnet *));
struct nd_prefix *nd6_prefix_lookup __P((struct nd_prefix *));
int in6_init_prefix_ltimes __P((struct nd_prefix *ndpr));
void rt6_flush __P((struct in6_addr *, struct ifnet *));
int nd6_setdefaultiface __P((int));
int in6_tmpifadd __P((const struct in6_ifaddr *, int));

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETINET6_ND6_H_ */


(provide-interface "nd6")