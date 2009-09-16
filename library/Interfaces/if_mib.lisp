(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:if_mib.h"
; at Sunday July 2,2006 7:27:59 pm.
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
;  * Copyright 1996 Massachusetts Institute of Technology
;  *
;  * Permission to use, copy, modify, and distribute this software and
;  * its documentation for any purpose and without fee is hereby
;  * granted, provided that both the above copyright notice and this
;  * permission notice appear in all copies, that both the above
;  * copyright notice and this permission notice appear in all
;  * supporting documentation, and that the name of M.I.T. not be used
;  * in advertising or publicity pertaining to distribution of the
;  * software without specific, written prior permission.  M.I.T. makes
;  * no representations about the suitability of this software for any
;  * purpose.  It is provided "as is" without express or implied
;  * warranty.
;  * 
;  * THIS SOFTWARE IS PROVIDED BY M.I.T. ``AS IS''.  M.I.T. DISCLAIMS
;  * ALL EXPRESS OR IMPLIED WARRANTIES WITH REGARD TO THIS SOFTWARE,
;  * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
;  * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT
;  * SHALL M.I.T. BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;  * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
;  * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;  * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
;  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
;  * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;  * SUCH DAMAGE.
;  *
;  * $FreeBSD: src/sys/net/if_mib.h,v 1.6 1999/08/28 00:48:19 peter Exp $
;  
; #ifndef _NET_IF_MIB_H
(defconstant $_NET_IF_MIB_H 1)
; #define	_NET_IF_MIB_H	1

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|
struct ifmibdata {
	char	ifmd_name[IFNAMSIZ]; 
	int	ifmd_pcount;	
	int	ifmd_flags;	
	int	ifmd_snd_len;	
	int	ifmd_snd_maxlen; 
	int	ifmd_snd_drops;	
	int	ifmd_filler[4];	
	struct	if_data ifmd_data; 
};


#define IFMIB_SYSTEM	1	
#define IFMIB_IFDATA	2	


#define IFDATA_GENERAL	1	
#define IFDATA_LINKSPECIFIC	2 


#define IFMIB_IFCOUNT	1	


#define NETLINK_GENERIC	0	






struct ifmib_iso_8802_3 {
	u_int32_t	dot3StatsAlignmentErrors;
	u_int32_t	dot3StatsFCSErrors;
	u_int32_t	dot3StatsSingleCollisionFrames;
	u_int32_t	dot3StatsMultipleCollisionFrames;
	u_int32_t	dot3StatsSQETestErrors;
	u_int32_t	dot3StatsDeferredTransmissions;
	u_int32_t	dot3StatsLateCollisions;
	u_int32_t	dot3StatsExcessiveCollisions;
	u_int32_t	dot3StatsInternalMacTransmitErrors;
	u_int32_t	dot3StatsCarrierSenseErrors;
	u_int32_t	dot3StatsFrameTooLongs;
	u_int32_t	dot3StatsInternalMacReceiveErrors;
	u_int32_t	dot3StatsEtherChipSet;
	
	u_int32_t	dot3StatsMissedFrames;

	u_int32_t	dot3StatsCollFrequencies[16]; 

	u_int32_t	dot3Compliance;
#define DOT3COMPLIANCE_STATS	1
#define DOT3COMPLIANCE_COLLS	2
};


#define DOT3CHIPSET_VENDOR(x)	((x) >> 16)
#define DOT3CHIPSET_PART(x)	((x) & 0xffff)
#define DOT3CHIPSET(v,p)	(((v) << 16) + ((p) & 0xffff))


enum dot3Vendors {
	dot3VendorAMD = 1,
	dot3VendorIntel = 2,
	dot3VendorNational = 4,
	dot3VendorFujitsu = 5,
	dot3VendorDigital = 6,
	dot3VendorWesternDigital = 7
};


enum {
	dot3ChipSetAMD7990 = 1,
	dot3ChipSetAMD79900 = 2,
	dot3ChipSetAMD79C940 = 3
};

enum {
	dot3ChipSetIntel82586 = 1,
	dot3ChipSetIntel82596 = 2,
	dot3ChipSetIntel82557 = 3
};

enum {
	dot3ChipSetNational8390 = 1,
	dot3ChipSetNationalSonic = 2
};

enum {
	dot3ChipSetFujitsu86950 = 1
};

enum {
	dot3ChipSetDigitalDC21040 = 1,
	dot3ChipSetDigitalDC21140 = 2,
	dot3ChipSetDigitalDC21041 = 3,
	dot3ChipSetDigitalDC21140A = 4,
	dot3ChipSetDigitalDC21142 = 5
};

enum {
	dot3ChipSetWesternDigital83C690 = 1,
	dot3ChipSetWesternDigital83C790 = 2
};



#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* _NET_IF_MIB_H */


(provide-interface "if_mib")