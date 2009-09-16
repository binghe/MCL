(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:pfkeyv2.h"
; at Sunday July 2,2006 7:28:12 pm.
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
; 	$KAME: pfkeyv2.h,v 1.10 2000/03/22 07:04:20 sakane Exp $	
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
;  * This file has been derived rfc 2367,
;  * And added some flags of SADB_KEY_FLAGS_ as SADB_X_EXT_.
;  *	sakane@ydc.co.jp
;  
; #ifndef _NET_PFKEYV2_H_
; #define _NET_PFKEYV2_H_

(require-interface "sys/appleapiopts")
; 
; This file defines structures and symbols for the PF_KEY Version 2
; key management interface. It was written at the U.S. Naval Research
; Laboratory. This file is in the public domain. The authors ask that
; you leave this credit intact on any copies of this file.
; 
; #ifndef __PFKEY_V2_H
(defconstant $__PFKEY_V2_H 1)
; #define __PFKEY_V2_H 1
(defconstant $PF_KEY_V2 2)
; #define PF_KEY_V2 2
(defconstant $PFKEYV2_REVISION 199806)
; #define PFKEYV2_REVISION        199806L
(defconstant $SADB_RESERVED 0)
; #define SADB_RESERVED    0
(defconstant $SADB_GETSPI 1)
; #define SADB_GETSPI      1
(defconstant $SADB_UPDATE 2)
; #define SADB_UPDATE      2
(defconstant $SADB_ADD 3)
; #define SADB_ADD         3
(defconstant $SADB_DELETE 4)
; #define SADB_DELETE      4
(defconstant $SADB_GET 5)
; #define SADB_GET         5
(defconstant $SADB_ACQUIRE 6)
; #define SADB_ACQUIRE     6
(defconstant $SADB_REGISTER 7)
; #define SADB_REGISTER    7
(defconstant $SADB_EXPIRE 8)
; #define SADB_EXPIRE      8
(defconstant $SADB_FLUSH 9)
; #define SADB_FLUSH       9
(defconstant $SADB_DUMP 10)
; #define SADB_DUMP        10
(defconstant $SADB_X_PROMISC 11)
; #define SADB_X_PROMISC   11
(defconstant $SADB_X_PCHANGE 12)
; #define SADB_X_PCHANGE   12
(defconstant $SADB_X_SPDUPDATE 13)
; #define SADB_X_SPDUPDATE  13
(defconstant $SADB_X_SPDADD 14)
; #define SADB_X_SPDADD     14
(defconstant $SADB_X_SPDDELETE 15)
; #define SADB_X_SPDDELETE  15	/* by policy index */
(defconstant $SADB_X_SPDGET 16)
; #define SADB_X_SPDGET     16
(defconstant $SADB_X_SPDACQUIRE 17)
; #define SADB_X_SPDACQUIRE 17
(defconstant $SADB_X_SPDDUMP 18)
; #define SADB_X_SPDDUMP    18
(defconstant $SADB_X_SPDFLUSH 19)
; #define SADB_X_SPDFLUSH   19
(defconstant $SADB_X_SPDSETIDX 20)
; #define SADB_X_SPDSETIDX  20
(defconstant $SADB_X_SPDEXPIRE 21)
; #define SADB_X_SPDEXPIRE  21
(defconstant $SADB_X_SPDDELETE2 22)
; #define SADB_X_SPDDELETE2 22	/* by policy id */
(defconstant $SADB_MAX 22)
; #define SADB_MAX          22
(defrecord sadb_msg
   (sadb_msg_version :UInt8)
   (sadb_msg_type :UInt8)
   (sadb_msg_errno :UInt8)
   (sadb_msg_satype :UInt8)
   (sadb_msg_len :UInt16)
   (sadb_msg_reserved :UInt16)
   (sadb_msg_seq :UInt32)
   (sadb_msg_pid :UInt32)
)
(defrecord sadb_ext
   (sadb_ext_len :UInt16)
   (sadb_ext_type :UInt16)
)
(defrecord sadb_sa
   (sadb_sa_len :UInt16)
   (sadb_sa_exttype :UInt16)
   (sadb_sa_spi :UInt32)
   (sadb_sa_replay :UInt8)
   (sadb_sa_state :UInt8)
   (sadb_sa_auth :UInt8)
   (sadb_sa_encrypt :UInt8)
   (sadb_sa_flags :UInt32)
)
; #ifdef __APPLE_API_PRIVATE
#| #|
struct sadb_sa_2 {
	struct sadb_sa	sa;
	u_int16_t		sadb_sa_natt_port;
	u_int16_t		sadb_reserved0;
	u_int32_t		sadb_reserved1;
};
#endif
|#
 |#
(defrecord sadb_lifetime
   (sadb_lifetime_len :UInt16)
   (sadb_lifetime_exttype :UInt16)
   (sadb_lifetime_allocations :UInt32)
   (sadb_lifetime_bytes :u_int64_t)
   (sadb_lifetime_addtime :u_int64_t)
   (sadb_lifetime_usetime :u_int64_t)
)
(defrecord sadb_address
   (sadb_address_len :UInt16)
   (sadb_address_exttype :UInt16)
   (sadb_address_proto :UInt8)
   (sadb_address_prefixlen :UInt8)
   (sadb_address_reserved :UInt16)
)
(defrecord sadb_key
   (sadb_key_len :UInt16)
   (sadb_key_exttype :UInt16)
   (sadb_key_bits :UInt16)
   (sadb_key_reserved :UInt16)
)
(defrecord sadb_ident
   (sadb_ident_len :UInt16)
   (sadb_ident_exttype :UInt16)
   (sadb_ident_type :UInt16)
   (sadb_ident_reserved :UInt16)
   (sadb_ident_id :u_int64_t)
)
(defrecord sadb_sens
   (sadb_sens_len :UInt16)
   (sadb_sens_exttype :UInt16)
   (sadb_sens_dpd :UInt32)
   (sadb_sens_sens_level :UInt8)
   (sadb_sens_sens_len :UInt8)
   (sadb_sens_integ_level :UInt8)
   (sadb_sens_integ_len :UInt8)
   (sadb_sens_reserved :UInt32)
)
(defrecord sadb_prop
   (sadb_prop_len :UInt16)
   (sadb_prop_exttype :UInt16)
   (sadb_prop_replay :UInt8)
   (sadb_prop_reserved (:array :UInt8 3))
)
(defrecord sadb_comb
   (sadb_comb_auth :UInt8)
   (sadb_comb_encrypt :UInt8)
   (sadb_comb_flags :UInt16)
   (sadb_comb_auth_minbits :UInt16)
   (sadb_comb_auth_maxbits :UInt16)
   (sadb_comb_encrypt_minbits :UInt16)
   (sadb_comb_encrypt_maxbits :UInt16)
   (sadb_comb_reserved :UInt32)
   (sadb_comb_soft_allocations :UInt32)
   (sadb_comb_hard_allocations :UInt32)
   (sadb_comb_soft_bytes :u_int64_t)
   (sadb_comb_hard_bytes :u_int64_t)
   (sadb_comb_soft_addtime :u_int64_t)
   (sadb_comb_hard_addtime :u_int64_t)
   (sadb_comb_soft_usetime :u_int64_t)
   (sadb_comb_hard_usetime :u_int64_t)
)
(defrecord sadb_supported
   (sadb_supported_len :UInt16)
   (sadb_supported_exttype :UInt16)
   (sadb_supported_reserved :UInt32)
)
(defrecord sadb_alg
   (sadb_alg_id :UInt8)
   (sadb_alg_ivlen :UInt8)
   (sadb_alg_minbits :UInt16)
   (sadb_alg_maxbits :UInt16)
   (sadb_alg_reserved :UInt16)
)
(defrecord sadb_spirange
   (sadb_spirange_len :UInt16)
   (sadb_spirange_exttype :UInt16)
   (sadb_spirange_min :UInt32)
   (sadb_spirange_max :UInt32)
   (sadb_spirange_reserved :UInt32)
)
(defrecord sadb_x_kmprivate
   (sadb_x_kmprivate_len :UInt16)
   (sadb_x_kmprivate_exttype :UInt16)
   (sadb_x_kmprivate_reserved :UInt32)
)
; 
;  * XXX Additional SA Extension.
;  * mode: tunnel or transport
;  * reqid: to make SA unique nevertheless the address pair of SA are same.
;  *        Mainly it's for VPN.
;  
(defrecord sadb_x_sa2
   (sadb_x_sa2_len :UInt16)
   (sadb_x_sa2_exttype :UInt16)
   (sadb_x_sa2_mode :UInt8)
   (sadb_x_sa2_reserved1 :UInt8)
   (sadb_x_sa2_reserved2 :UInt16)
   (sadb_x_sa2_sequence :UInt32)
   (sadb_x_sa2_reqid :UInt32)
)
;  XXX Policy Extension 
;  sizeof(struct sadb_x_policy) == 16 
(defrecord sadb_x_policy
   (sadb_x_policy_len :UInt16)
   (sadb_x_policy_exttype :UInt16)
   (sadb_x_policy_type :UInt16)
                                                ;  See policy type of ipsec.h 
   (sadb_x_policy_dir :UInt8)
                                                ;  direction, see ipsec.h 
   (sadb_x_policy_reserved :UInt8)
   (sadb_x_policy_id :UInt32)
   (sadb_x_policy_reserved2 :UInt32)
)
; 
;  * When policy_type == IPSEC, it is followed by some of
;  * the ipsec policy request.
;  * [total length of ipsec policy requests]
;  *	= (sadb_x_policy_len * sizeof(uint64_t) - sizeof(struct sadb_x_policy))
;  
;  XXX IPsec Policy Request Extension 
; 
;  * This structure is aligned 8 bytes.
;  
(defrecord sadb_x_ipsecrequest
   (sadb_x_ipsecrequest_len :UInt16)
                                                ;  structure length aligned to 8 bytes.
; 					 * This value is true length of bytes.
; 					 * Not in units of 64 bits. 
   (sadb_x_ipsecrequest_proto :UInt16)
                                                ;  See ipsec.h 
   (sadb_x_ipsecrequest_mode :UInt8)
                                                ;  See IPSEC_MODE_XX in ipsec.h. 
   (sadb_x_ipsecrequest_level :UInt8)
                                                ;  See IPSEC_LEVEL_XX in ipsec.h 
   (sadb_x_ipsecrequest_reqid :UInt16)
                                                ;  See ipsec.h 
                                                ; 
;    * followed by source IP address of SA, and immediately followed by
;    * destination IP address of SA.  These encoded into two of sockaddr
;    * structure without any padding.  Must set each sa_len exactly.
;    * Each of length of the sockaddr structure are not aligned to 64bits,
;    * but sum of x_request and addresses is aligned to 64bits.
;    
)
(defconstant $SADB_EXT_RESERVED 0)
; #define SADB_EXT_RESERVED             0
(defconstant $SADB_EXT_SA 1)
; #define SADB_EXT_SA                   1
(defconstant $SADB_EXT_LIFETIME_CURRENT 2)
; #define SADB_EXT_LIFETIME_CURRENT     2
(defconstant $SADB_EXT_LIFETIME_HARD 3)
; #define SADB_EXT_LIFETIME_HARD        3
(defconstant $SADB_EXT_LIFETIME_SOFT 4)
; #define SADB_EXT_LIFETIME_SOFT        4
(defconstant $SADB_EXT_ADDRESS_SRC 5)
; #define SADB_EXT_ADDRESS_SRC          5
(defconstant $SADB_EXT_ADDRESS_DST 6)
; #define SADB_EXT_ADDRESS_DST          6
(defconstant $SADB_EXT_ADDRESS_PROXY 7)
; #define SADB_EXT_ADDRESS_PROXY        7
(defconstant $SADB_EXT_KEY_AUTH 8)
; #define SADB_EXT_KEY_AUTH             8
(defconstant $SADB_EXT_KEY_ENCRYPT 9)
; #define SADB_EXT_KEY_ENCRYPT          9
(defconstant $SADB_EXT_IDENTITY_SRC 10)
; #define SADB_EXT_IDENTITY_SRC         10
(defconstant $SADB_EXT_IDENTITY_DST 11)
; #define SADB_EXT_IDENTITY_DST         11
(defconstant $SADB_EXT_SENSITIVITY 12)
; #define SADB_EXT_SENSITIVITY          12
(defconstant $SADB_EXT_PROPOSAL 13)
; #define SADB_EXT_PROPOSAL             13
(defconstant $SADB_EXT_SUPPORTED_AUTH 14)
; #define SADB_EXT_SUPPORTED_AUTH       14
(defconstant $SADB_EXT_SUPPORTED_ENCRYPT 15)
; #define SADB_EXT_SUPPORTED_ENCRYPT    15
(defconstant $SADB_EXT_SPIRANGE 16)
; #define SADB_EXT_SPIRANGE             16
(defconstant $SADB_X_EXT_KMPRIVATE 17)
; #define SADB_X_EXT_KMPRIVATE          17
(defconstant $SADB_X_EXT_POLICY 18)
; #define SADB_X_EXT_POLICY             18
(defconstant $SADB_X_EXT_SA2 19)
; #define SADB_X_EXT_SA2                19
(defconstant $SADB_EXT_MAX 19)
; #define SADB_EXT_MAX                  19
(defconstant $SADB_SATYPE_UNSPEC 0)
; #define SADB_SATYPE_UNSPEC	0
(defconstant $SADB_SATYPE_AH 2)
; #define SADB_SATYPE_AH		2
(defconstant $SADB_SATYPE_ESP 3)
; #define SADB_SATYPE_ESP		3
(defconstant $SADB_SATYPE_RSVP 5)
; #define SADB_SATYPE_RSVP	5
(defconstant $SADB_SATYPE_OSPFV2 6)
; #define SADB_SATYPE_OSPFV2	6
(defconstant $SADB_SATYPE_RIPV2 7)
; #define SADB_SATYPE_RIPV2	7
(defconstant $SADB_SATYPE_MIP 8)
; #define SADB_SATYPE_MIP		8
(defconstant $SADB_X_SATYPE_IPCOMP 9)
; #define SADB_X_SATYPE_IPCOMP	9
(defconstant $SADB_X_SATYPE_POLICY 10)
; #define SADB_X_SATYPE_POLICY	10
(defconstant $SADB_SATYPE_MAX 11)
; #define SADB_SATYPE_MAX		11
(defconstant $SADB_SASTATE_LARVAL 0)
; #define SADB_SASTATE_LARVAL   0
(defconstant $SADB_SASTATE_MATURE 1)
; #define SADB_SASTATE_MATURE   1
(defconstant $SADB_SASTATE_DYING 2)
; #define SADB_SASTATE_DYING    2
(defconstant $SADB_SASTATE_DEAD 3)
; #define SADB_SASTATE_DEAD     3
(defconstant $SADB_SASTATE_MAX 3)
; #define SADB_SASTATE_MAX      3
(defconstant $SADB_SAFLAGS_PFS 1)
; #define SADB_SAFLAGS_PFS      1
;  RFC2367 numbers - meets RFC2407 
(defconstant $SADB_AALG_NONE 0)
; #define SADB_AALG_NONE		0
(defconstant $SADB_AALG_MD5HMAC 1)
; #define SADB_AALG_MD5HMAC	1	/*2*/
(defconstant $SADB_AALG_SHA1HMAC 2)
; #define SADB_AALG_SHA1HMAC	2	/*3*/
(defconstant $SADB_AALG_MAX 8)
; #define SADB_AALG_MAX		8
;  private allocations - based on RFC2407/IANA assignment 
(defconstant $SADB_X_AALG_SHA2_256 6)
; #define SADB_X_AALG_SHA2_256	6	/*5*/
(defconstant $SADB_X_AALG_SHA2_384 7)
; #define SADB_X_AALG_SHA2_384	7	/*6*/
(defconstant $SADB_X_AALG_SHA2_512 8)
; #define SADB_X_AALG_SHA2_512	8	/*7*/
;  private allocations should use 249-255 (RFC2407) 
(defconstant $SADB_X_AALG_MD5 3)
; #define SADB_X_AALG_MD5		3	/*249*/	/* Keyed MD5 */
(defconstant $SADB_X_AALG_SHA 4)
; #define SADB_X_AALG_SHA		4	/*250*/	/* Keyed SHA */
(defconstant $SADB_X_AALG_NULL 5)
; #define SADB_X_AALG_NULL	5	/*251*/	/* null authentication */
;  RFC2367 numbers - meets RFC2407 
(defconstant $SADB_EALG_NONE 0)
; #define SADB_EALG_NONE		0
(defconstant $SADB_EALG_DESCBC 1)
; #define SADB_EALG_DESCBC	1	/*2*/
(defconstant $SADB_EALG_3DESCBC 2)
; #define SADB_EALG_3DESCBC	2	/*3*/
(defconstant $SADB_EALG_NULL 3)
; #define SADB_EALG_NULL		3	/*11*/
(defconstant $SADB_EALG_MAX 12)
; #define SADB_EALG_MAX		12
;  private allocations - based on RFC2407/IANA assignment 
(defconstant $SADB_X_EALG_CAST128CBC 5)
; #define SADB_X_EALG_CAST128CBC	5	/*6*/
(defconstant $SADB_X_EALG_BLOWFISHCBC 4)
; #define SADB_X_EALG_BLOWFISHCBC	4	/*7*/
(defconstant $SADB_X_EALG_RIJNDAELCBC 12)
; #define SADB_X_EALG_RIJNDAELCBC	12
(defconstant $SADB_X_EALG_AES 12)
; #define SADB_X_EALG_AES		12
;  private allocations should use 249-255 (RFC2407) 

; #if 1	/*nonstandard */
; nonstandard 
(defconstant $SADB_X_CALG_NONE 0)
; #define SADB_X_CALG_NONE	0
(defconstant $SADB_X_CALG_OUI 1)
; #define SADB_X_CALG_OUI		1
(defconstant $SADB_X_CALG_DEFLATE 2)
; #define SADB_X_CALG_DEFLATE	2
(defconstant $SADB_X_CALG_LZS 3)
; #define SADB_X_CALG_LZS		3
(defconstant $SADB_X_CALG_MAX 4)
; #define SADB_X_CALG_MAX		4

; #endif

(defconstant $SADB_IDENTTYPE_RESERVED 0)
; #define SADB_IDENTTYPE_RESERVED   0
(defconstant $SADB_IDENTTYPE_PREFIX 1)
; #define SADB_IDENTTYPE_PREFIX     1
(defconstant $SADB_IDENTTYPE_FQDN 2)
; #define SADB_IDENTTYPE_FQDN       2
(defconstant $SADB_IDENTTYPE_USERFQDN 3)
; #define SADB_IDENTTYPE_USERFQDN   3
(defconstant $SADB_X_IDENTTYPE_ADDR 4)
; #define SADB_X_IDENTTYPE_ADDR     4
(defconstant $SADB_IDENTTYPE_MAX 4)
; #define SADB_IDENTTYPE_MAX        4
;  `flags' in sadb_sa structure holds followings 
(defconstant $SADB_X_EXT_NONE 0)
; #define SADB_X_EXT_NONE		0x0000	/* i.e. new format. */
(defconstant $SADB_X_EXT_OLD 1)
; #define SADB_X_EXT_OLD		0x0001	/* old format. */
; #ifdef __APPLE_API_PRIVATE
#| #|
#define SADB_X_EXT_NATT				0x0002	
#define SADB_X_EXT_NATT_KEEPALIVE	0x0004	
											
#endif
|#
 |#
(defconstant $SADB_X_EXT_IV4B 16)
; #define SADB_X_EXT_IV4B		0x0010	/* IV length of 4 bytes in use */
(defconstant $SADB_X_EXT_DERIV 32)
; #define SADB_X_EXT_DERIV	0x0020	/* DES derived */
(defconstant $SADB_X_EXT_CYCSEQ 64)
; #define SADB_X_EXT_CYCSEQ	0x0040	/* allowing to cyclic sequence. */
;  three of followings are exclusive flags each them 
(defconstant $SADB_X_EXT_PSEQ 0)
; #define SADB_X_EXT_PSEQ		0x0000	/* sequencial padding for ESP */
(defconstant $SADB_X_EXT_PRAND 256)
; #define SADB_X_EXT_PRAND	0x0100	/* random padding for ESP */
(defconstant $SADB_X_EXT_PZERO 512)
; #define SADB_X_EXT_PZERO	0x0200	/* zero padding for ESP */
(defconstant $SADB_X_EXT_PMASK 768)
; #define SADB_X_EXT_PMASK	0x0300	/* mask for padding flag */

; #if 1
(defconstant $SADB_X_EXT_RAWCPI 128)
; #define SADB_X_EXT_RAWCPI	0x0080	/* use well known CPI (IPComp) */

; #endif

(defconstant $SADB_KEY_FLAGS_MAX 4095)
; #define SADB_KEY_FLAGS_MAX	0x0fff
;  SPI size for PF_KEYv2 
; #define PFKEY_SPI_SIZE	sizeof(u_int32_t)
;  Identifier for menber of lifetime structure 
(defconstant $SADB_X_LIFETIME_ALLOCATIONS 0)
; #define SADB_X_LIFETIME_ALLOCATIONS	0
(defconstant $SADB_X_LIFETIME_BYTES 1)
; #define SADB_X_LIFETIME_BYTES		1
(defconstant $SADB_X_LIFETIME_ADDTIME 2)
; #define SADB_X_LIFETIME_ADDTIME		2
(defconstant $SADB_X_LIFETIME_USETIME 3)
; #define SADB_X_LIFETIME_USETIME		3
;  The rate for SOFT lifetime against HARD one. 
(defconstant $PFKEY_SOFT_LIFETIME_RATE 80)
; #define PFKEY_SOFT_LIFETIME_RATE	80
;  Utilities 
; #define PFKEY_ALIGN8(a) (1 + (((a) - 1) | (8 - 1)))
; #define	PFKEY_EXTLEN(msg) 	PFKEY_UNUNIT64(((struct sadb_ext *)(msg))->sadb_ext_len)
; #define PFKEY_ADDR_PREFIX(ext) 	(((struct sadb_address *)(ext))->sadb_address_prefixlen)
; #define PFKEY_ADDR_PROTO(ext) 	(((struct sadb_address *)(ext))->sadb_address_proto)
; #define PFKEY_ADDR_SADDR(ext) 	((struct sockaddr *)((caddr_t)(ext) + sizeof(struct sadb_address)))
;  in 64bits 
; #define	PFKEY_UNUNIT64(a)	((a) << 3)
; #define	PFKEY_UNIT64(a)		((a) >> 3)

; #endif /* __PFKEY_V2_H */


; #endif /* _NET_PFKEYV2_H_ */


(provide-interface "pfkeyv2")