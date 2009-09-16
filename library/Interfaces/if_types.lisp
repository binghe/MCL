(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:if_types.h"
; at Sunday July 2,2006 7:28:00 pm.
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
;  * Copyright (c) 1989, 1993, 1994
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
;  *	@(#)if_types.h	8.2 (Berkeley) 4/20/94
;  * $FreeBSD: src/sys/net/if_types.h,v 1.8.2.3 2001/07/03 11:01:41 ume Exp $
;  
; #ifndef _NET_IF_TYPES_H_
; #define _NET_IF_TYPES_H_

(require-interface "sys/appleapiopts")
; 
;  * Interface types for benefit of parsing media address headers.
;  * This list is derived from the SNMP list of ifTypes, currently
;  * documented in RFC1573.
;  
(defconstant $IFT_OTHER 1)
; #define	IFT_OTHER	0x1		/* none of the following */
(defconstant $IFT_1822 2)
; #define	IFT_1822	0x2		/* old-style arpanet imp */
(defconstant $IFT_HDH1822 3)
; #define	IFT_HDH1822	0x3		/* HDH arpanet imp */
(defconstant $IFT_X25DDN 4)
; #define	IFT_X25DDN	0x4		/* x25 to imp */
(defconstant $IFT_X25 5)
; #define	IFT_X25		0x5		/* PDN X25 interface (RFC877) */
(defconstant $IFT_ETHER 6)
; #define	IFT_ETHER	0x6		/* Ethernet CSMACD */
(defconstant $IFT_ISO88023 7)
; #define	IFT_ISO88023	0x7		/* CMSA CD */
(defconstant $IFT_ISO88024 8)
; #define	IFT_ISO88024	0x8		/* Token Bus */
(defconstant $IFT_ISO88025 9)
; #define	IFT_ISO88025	0x9		/* Token Ring */
(defconstant $IFT_ISO88026 10)
; #define	IFT_ISO88026	0xa		/* MAN */
(defconstant $IFT_STARLAN 11)
; #define	IFT_STARLAN	0xb
(defconstant $IFT_P10 12)
; #define	IFT_P10		0xc		/* Proteon 10MBit ring */
(defconstant $IFT_P80 13)
; #define	IFT_P80		0xd		/* Proteon 80MBit ring */
(defconstant $IFT_HY 14)
; #define	IFT_HY		0xe		/* Hyperchannel */
(defconstant $IFT_FDDI 15)
; #define	IFT_FDDI	0xf
(defconstant $IFT_LAPB 16)
; #define	IFT_LAPB	0x10
(defconstant $IFT_SDLC 17)
; #define	IFT_SDLC	0x11
(defconstant $IFT_T1 18)
; #define	IFT_T1		0x12
(defconstant $IFT_CEPT 19)
; #define	IFT_CEPT	0x13		/* E1 - european T1 */
(defconstant $IFT_ISDNBASIC 20)
; #define	IFT_ISDNBASIC	0x14
(defconstant $IFT_ISDNPRIMARY 21)
; #define	IFT_ISDNPRIMARY	0x15
(defconstant $IFT_PTPSERIAL 22)
; #define	IFT_PTPSERIAL	0x16		/* Proprietary PTP serial */
(defconstant $IFT_PPP 23)
; #define	IFT_PPP		0x17		/* RFC 1331 */
(defconstant $IFT_LOOP 24)
; #define	IFT_LOOP	0x18		/* loopback */
(defconstant $IFT_EON 25)
; #define	IFT_EON		0x19		/* ISO over IP */
(defconstant $IFT_XETHER 26)
; #define	IFT_XETHER	0x1a		/* obsolete 3MB experimental ethernet */
(defconstant $IFT_NSIP 27)
; #define	IFT_NSIP	0x1b		/* XNS over IP */
(defconstant $IFT_SLIP 28)
; #define	IFT_SLIP	0x1c		/* IP over generic TTY */
(defconstant $IFT_ULTRA 29)
; #define	IFT_ULTRA	0x1d		/* Ultra Technologies */
(defconstant $IFT_DS3 30)
; #define	IFT_DS3		0x1e		/* Generic T3 */
(defconstant $IFT_SIP 31)
; #define	IFT_SIP		0x1f		/* SMDS */
(defconstant $IFT_FRELAY 32)
; #define	IFT_FRELAY	0x20		/* Frame Relay DTE only */
(defconstant $IFT_RS232 33)
; #define	IFT_RS232	0x21
(defconstant $IFT_PARA 34)
; #define	IFT_PARA	0x22		/* parallel-port */
(defconstant $IFT_ARCNET 35)
; #define	IFT_ARCNET	0x23
(defconstant $IFT_ARCNETPLUS 36)
; #define	IFT_ARCNETPLUS	0x24
(defconstant $IFT_ATM 37)
; #define	IFT_ATM		0x25		/* ATM cells */
(defconstant $IFT_MIOX25 38)
; #define	IFT_MIOX25	0x26
(defconstant $IFT_SONET 39)
; #define	IFT_SONET	0x27		/* SONET or SDH */
(defconstant $IFT_X25PLE 40)
; #define	IFT_X25PLE	0x28
(defconstant $IFT_ISO88022LLC 41)
; #define	IFT_ISO88022LLC	0x29
(defconstant $IFT_LOCALTALK 42)
; #define	IFT_LOCALTALK	0x2a
(defconstant $IFT_SMDSDXI 43)
; #define	IFT_SMDSDXI	0x2b
(defconstant $IFT_FRELAYDCE 44)
; #define	IFT_FRELAYDCE	0x2c		/* Frame Relay DCE */
(defconstant $IFT_V35 45)
; #define	IFT_V35		0x2d
(defconstant $IFT_HSSI 46)
; #define	IFT_HSSI	0x2e
(defconstant $IFT_HIPPI 47)
; #define	IFT_HIPPI	0x2f
(defconstant $IFT_MODEM 48)
; #define	IFT_MODEM	0x30		/* Generic Modem */
(defconstant $IFT_AAL5 49)
; #define	IFT_AAL5	0x31		/* AAL5 over ATM */
(defconstant $IFT_SONETPATH 50)
; #define	IFT_SONETPATH	0x32
(defconstant $IFT_SONETVT 51)
; #define	IFT_SONETVT	0x33
(defconstant $IFT_SMDSICIP 52)
; #define	IFT_SMDSICIP	0x34		/* SMDS InterCarrier Interface */
(defconstant $IFT_PROPVIRTUAL 53)
; #define	IFT_PROPVIRTUAL	0x35		/* Proprietary Virtual/internal */
(defconstant $IFT_PROPMUX 54)
; #define	IFT_PROPMUX	0x36		/* Proprietary Multiplexing */
(defconstant $IFT_GIF 55)
; #define	IFT_GIF		0x37		/*0xf0*/
(defconstant $IFT_FAITH 56)
; #define	IFT_FAITH	0x38		/*0xf2*/
(defconstant $IFT_STF 57)
; #define	IFT_STF		0x39		/*0xf3*/
(defconstant $IFT_L2VLAN 135)
; #define	IFT_L2VLAN	0x87		/* Layer 2 Virtual LAN using 802.1Q */
(defconstant $IFT_IEEE1394 144)
; #define	IFT_IEEE1394	0x90		/* IEEE1394 High Performance SerialBus*/

; #endif


(provide-interface "if_types")