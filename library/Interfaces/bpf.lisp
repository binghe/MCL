(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:bpf.h"
; at Sunday July 2,2006 7:27:10 pm.
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
;  * Copyright (c) 1990, 1991, 1993
;  *	The Regents of the University of California.  All rights reserved.
;  *
;  * This code is derived from the Stanford/CMU enet packet filter,
;  * (net/enet.c) distributed as part of 4.3BSD, and code contributed
;  * to Berkeley by Steven McCanne and Van Jacobson both of Lawrence
;  * Berkeley Laboratory.
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
;  *      @(#)bpf.h	8.1 (Berkeley) 6/10/93
;  *	@(#)bpf.h	1.34 (LBL)     6/16/96
;  *
;  * $FreeBSD: src/sys/net/bpf.h,v 1.21.2.3 2001/08/01 00:23:13 fenner Exp $
;  
; #ifndef _NET_BPF_H_
; #define _NET_BPF_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/types")

(require-interface "sys/time")
;  BSD style release date 
(defconstant $BPF_RELEASE 199606)
; #define	BPF_RELEASE 199606

(def-mactype :bpf_int32 (find-mactype ':SInt32))

(def-mactype :bpf_u_int32 (find-mactype ':UInt32))
; 
;  * Alignment macros.  BPF_WORDALIGN rounds up to the next
;  * even multiple of BPF_ALIGNMENT.
;  
; #define BPF_ALIGNMENT sizeof(long)
; #define BPF_WORDALIGN(x) (((x)+(BPF_ALIGNMENT-1))&~(BPF_ALIGNMENT-1))
(defconstant $BPF_MAXINSNS 512)
; #define BPF_MAXINSNS 512
(defconstant $BPF_MAXBUFSIZE 32768)
; #define BPF_MAXBUFSIZE 0x8000
(defconstant $BPF_MINBUFSIZE 32)
; #define BPF_MINBUFSIZE 32
; 
;  *  Structure for BIOCSETF.
;  
(defrecord bpf_program
   (bf_len :UInt32)
   (bf_insns (:pointer :bpf_insn))
)
; 
;  * Struct returned by BIOCGSTATS.
;  
(defrecord bpf_stat
   (bs_recv :UInt32)
                                                ;  number of packets received 
   (bs_drop :UInt32)
                                                ;  number of packets dropped 
)
; 
;  * Struct return by BIOCVERSION.  This represents the version number of
;  * the filter language described by the instruction encodings below.
;  * bpf understands a program iff kernel_major == filter_major &&
;  * kernel_minor >= filter_minor, that is, if the value returned by the
;  * running kernel has the same major number and a minor number equal
;  * equal to or less than the filter being downloaded.  Otherwise, the
;  * results are undefined, meaning an error may be returned or packets
;  * may be accepted haphazardly.
;  * It has nothing to do with the source code version.
;  
(defrecord bpf_version
   (bv_major :UInt16)
   (bv_minor :UInt16)
)
;  Current version number of filter architecture. 
(defconstant $BPF_MAJOR_VERSION 1)
; #define BPF_MAJOR_VERSION 1
(defconstant $BPF_MINOR_VERSION 1)
; #define BPF_MINOR_VERSION 1
; #define	BIOCGBLEN	_IOR('B',102, u_int)
; #define	BIOCSBLEN	_IOWR('B',102, u_int)
; #define	BIOCSETF	_IOW('B',103, struct bpf_program)
; #define	BIOCFLUSH	_IO('B',104)
; #define BIOCPROMISC	_IO('B',105)
; #define	BIOCGDLT	_IOR('B',106, u_int)
; #define BIOCGETIF	_IOR('B',107, struct ifreq)
; #define BIOCSETIF	_IOW('B',108, struct ifreq)
; #define BIOCSRTIMEOUT	_IOW('B',109, struct timeval)
; #define BIOCGRTIMEOUT	_IOR('B',110, struct timeval)
; #define BIOCGSTATS	_IOR('B',111, struct bpf_stat)
; #define BIOCIMMEDIATE	_IOW('B',112, u_int)
; #define BIOCVERSION	_IOR('B',113, struct bpf_version)
; #define BIOCGRSIG	_IOR('B',114, u_int)
; #define BIOCSRSIG	_IOW('B',115, u_int)
; #define BIOCGHDRCMPLT	_IOR('B',116, u_int)
; #define BIOCSHDRCMPLT	_IOW('B',117, u_int)
; #define BIOCGSEESENT	_IOR('B',118, u_int)
; #define BIOCSSEESENT	_IOW('B',119, u_int)
; 
;  * Structure prepended to each packet.
;  
(defrecord bpf_hdr
   (bh_tstamp :TIMEVAL)
                                                ;  time stamp 
   (bh_caplen :UInt32)
                                                ;  length of captured portion 
   (bh_datalen :UInt32)
                                                ;  original length of packet 
   (bh_hdrlen :UInt16)
                                                ;  length of bpf header (this struct
; 					   plus alignment padding) 
)
; 
;  * Because the structure above is not a multiple of 4 bytes, some compilers
;  * will insist on inserting padding; hence, sizeof(struct bpf_hdr) won't work.
;  * Only the kernel needs to know about it; applications use bh_hdrlen.
;  
; #ifdef KERNEL
#| #|
#define SIZEOF_BPF_HDR	(sizeof(struct bpf_hdr) <= 20 ? 18 : \
    sizeof(struct bpf_hdr))
#endif
|#
 |#
; 
;  * Data-link level type codes.
;  
(defconstant $DLT_NULL 0)
; #define DLT_NULL	0	/* no link-layer encapsulation */
(defconstant $DLT_EN10MB 1)
; #define DLT_EN10MB	1	/* Ethernet (10Mb) */
(defconstant $DLT_EN3MB 2)
; #define DLT_EN3MB	2	/* Experimental Ethernet (3Mb) */
(defconstant $DLT_AX25 3)
; #define DLT_AX25	3	/* Amateur Radio AX.25 */
(defconstant $DLT_PRONET 4)
; #define DLT_PRONET	4	/* Proteon ProNET Token Ring */
(defconstant $DLT_CHAOS 5)
; #define DLT_CHAOS	5	/* Chaos */
(defconstant $DLT_IEEE802 6)
; #define DLT_IEEE802	6	/* IEEE 802 Networks */
(defconstant $DLT_ARCNET 7)
; #define DLT_ARCNET	7	/* ARCNET */
(defconstant $DLT_SLIP 8)
; #define DLT_SLIP	8	/* Serial Line IP */
(defconstant $DLT_PPP 9)
; #define DLT_PPP		9	/* Point-to-point Protocol */
(defconstant $DLT_FDDI 10)
; #define DLT_FDDI	10	/* FDDI */
(defconstant $DLT_ATM_RFC1483 11)
; #define DLT_ATM_RFC1483	11	/* LLC/SNAP encapsulated atm */
(defconstant $DLT_RAW 12)
; #define DLT_RAW		12	/* raw IP */
(defconstant $DLT_APPLE_IP_OVER_IEEE1394 138)
; #define DLT_APPLE_IP_OVER_IEEE1394      138
; 
;  * These are values from BSD/OS's "bpf.h".
;  * These are not the same as the values from the traditional libpcap
;  * "bpf.h"; however, these values shouldn't be generated by any
;  * OS other than BSD/OS, so the correct values to use here are the
;  * BSD/OS values.
;  *
;  * Platforms that have already assigned these values to other
;  * DLT_ codes, however, should give these codes the values
;  * from that platform, so that programs that use these codes will
;  * continue to compile - even though they won't correctly read
;  * files of these types.
;  
(defconstant $DLT_SLIP_BSDOS 15)
; #define DLT_SLIP_BSDOS	15	/* BSD/OS Serial Line IP */
(defconstant $DLT_PPP_BSDOS 16)
; #define DLT_PPP_BSDOS	16	/* BSD/OS Point-to-point Protocol */
(defconstant $DLT_ATM_CLIP 19)
; #define DLT_ATM_CLIP	19	/* Linux Classical-IP over ATM */
; 
;  * This value is defined by NetBSD; other platforms should refrain from
;  * using it for other purposes, so that NetBSD savefiles with a link
;  * type of 50 can be read as this type on all platforms.
;  
(defconstant $DLT_PPP_SERIAL 50)
; #define DLT_PPP_SERIAL	50	/* PPP over serial with HDLC encapsulation */
; 
;  * This value was defined by libpcap 0.5; platforms that have defined
;  * it with a different value should define it here with that value -
;  * a link type of 104 in a save file will be mapped to DLT_C_HDLC,
;  * whatever value that happens to be, so programs will correctly
;  * handle files with that link type regardless of the value of
;  * DLT_C_HDLC.
;  *
;  * The name DLT_C_HDLC was used by BSD/OS; we use that name for source
;  * compatibility with programs written for BSD/OS.
;  *
;  * libpcap 0.5 defined it as DLT_CHDLC; we define DLT_CHDLC as well,
;  * for source compatibility with programs written for libpcap 0.5.
;  
(defconstant $DLT_C_HDLC 104)
; #define DLT_C_HDLC	104	/* Cisco HDLC */
; #define DLT_CHDLC	DLT_C_HDLC
; 
;  * Reserved for future use.
;  * Do not pick other numerical value for these unless you have also
;  * picked up the tcpdump.org top-of-CVS-tree version of "savefile.c",
;  * which will arrange that capture files for these DLT_ types have
;  * the same "network" value on all platforms, regardless of what
;  * value is chosen for their DLT_ type (thus allowing captures made
;  * on one platform to be read on other platforms, even if the two
;  * platforms don't use the same numerical values for all DLT_ types).
;  
(defconstant $DLT_IEEE802_11 105)
; #define DLT_IEEE802_11	105	/* IEEE 802.11 wireless */
; 
;  * Values between 106 and 107 are used in capture file headers as
;  * link-layer types corresponding to DLT_ types that might differ
;  * between platforms; don't use those values for new DLT_ new types.
;  
; 
;  * OpenBSD DLT_LOOP, for loopback devices; it's like DLT_NULL, except
;  * that the AF_ type in the link-layer header is in network byte order.
;  *
;  * OpenBSD defines it as 12, but that collides with DLT_RAW, so we
;  * define it as 108 here.  If OpenBSD picks up this file, it should
;  * define DLT_LOOP as 12 in its version, as per the comment above -
;  * and should not use 108 for any purpose.
;  
(defconstant $DLT_LOOP 108)
; #define DLT_LOOP	108
; 
;  * Values between 109 and 112 are used in capture file headers as
;  * link-layer types corresponding to DLT_ types that might differ
;  * between platforms; don't use those values for new DLT_ new types.
;  
; 
;  * This is for Linux cooked sockets.
;  
(defconstant $DLT_LINUX_SLL 113)
; #define DLT_LINUX_SLL	113
; 
;  * The instruction encodings.
;  
;  instruction classes 
; #define BPF_CLASS(code) ((code) & 0x07)
(defconstant $BPF_LD 0)
; #define		BPF_LD		0x00
(defconstant $BPF_LDX 1)
; #define		BPF_LDX		0x01
(defconstant $BPF_ST 2)
; #define		BPF_ST		0x02
(defconstant $BPF_STX 3)
; #define		BPF_STX		0x03
(defconstant $BPF_ALU 4)
; #define		BPF_ALU		0x04
(defconstant $BPF_JMP 5)
; #define		BPF_JMP		0x05
(defconstant $BPF_RET 6)
; #define		BPF_RET		0x06
(defconstant $BPF_MISC 7)
; #define		BPF_MISC	0x07
;  ld/ldx fields 
; #define BPF_SIZE(code)	((code) & 0x18)
(defconstant $BPF_W 0)
; #define		BPF_W		0x00
(defconstant $BPF_H 8)
; #define		BPF_H		0x08
(defconstant $BPF_B 16)
; #define		BPF_B		0x10
; #define BPF_MODE(code)	((code) & 0xe0)
(defconstant $BPF_IMM 0)
; #define		BPF_IMM 	0x00
(defconstant $BPF_ABS 32)
; #define		BPF_ABS		0x20
(defconstant $BPF_IND 64)
; #define		BPF_IND		0x40
(defconstant $BPF_MEM 96)
; #define		BPF_MEM		0x60
(defconstant $BPF_LEN 128)
; #define		BPF_LEN		0x80
(defconstant $BPF_MSH 160)
; #define		BPF_MSH		0xa0
;  alu/jmp fields 
; #define BPF_OP(code)	((code) & 0xf0)
(defconstant $BPF_ADD 0)
; #define		BPF_ADD		0x00
(defconstant $BPF_SUB 16)
; #define		BPF_SUB		0x10
(defconstant $BPF_MUL 32)
; #define		BPF_MUL		0x20
(defconstant $BPF_DIV 48)
; #define		BPF_DIV		0x30
(defconstant $BPF_OR 64)
; #define		BPF_OR		0x40
(defconstant $BPF_AND 80)
; #define		BPF_AND		0x50
(defconstant $BPF_LSH 96)
; #define		BPF_LSH		0x60
(defconstant $BPF_RSH 112)
; #define		BPF_RSH		0x70
(defconstant $BPF_NEG 128)
; #define		BPF_NEG		0x80
(defconstant $BPF_JA 0)
; #define		BPF_JA		0x00
(defconstant $BPF_JEQ 16)
; #define		BPF_JEQ		0x10
(defconstant $BPF_JGT 32)
; #define		BPF_JGT		0x20
(defconstant $BPF_JGE 48)
; #define		BPF_JGE		0x30
(defconstant $BPF_JSET 64)
; #define		BPF_JSET	0x40
; #define BPF_SRC(code)	((code) & 0x08)
(defconstant $BPF_K 0)
; #define		BPF_K		0x00
(defconstant $BPF_X 8)
; #define		BPF_X		0x08
;  ret - BPF_K and BPF_X also apply 
; #define BPF_RVAL(code)	((code) & 0x18)
(defconstant $BPF_A 16)
; #define		BPF_A		0x10
;  misc 
; #define BPF_MISCOP(code) ((code) & 0xf8)
(defconstant $BPF_TAX 0)
; #define		BPF_TAX		0x00
(defconstant $BPF_TXA 128)
; #define		BPF_TXA		0x80
; 
;  * The instruction data structure.
;  
(defrecord bpf_insn
   (code :UInt16)
   (jt :UInt8)
   (jf :UInt8)
   (k :UInt32)
)
; 
;  * Macros for insn array initializers.
;  
; #define BPF_STMT(code, k) { (u_short)(code), 0, 0, k }
; #define BPF_JUMP(code, k, jt, jf) { (u_short)(code), jt, jf, k }
;  Forward declerations 
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE
int	 bpf_validate __P((const struct bpf_insn *, int));
void	 bpf_tap __P((struct ifnet *, u_char *, u_int));
void	 bpf_mtap __P((struct ifnet *, struct mbuf *));
void	 bpfattach __P((struct ifnet *, u_int, u_int));
void	 bpfdetach __P((struct ifnet *));

void	 bpfilterattach __P((int));
u_int	 bpf_filter __P((const struct bpf_insn *, u_char *, u_int, u_int));

#ifdef__APPLE__
#define BPF_TAP(x, y, z) bpf_tap(x,y,z) 
#define BPF_MTAP(x, y) bpf_mtap(x, y)
#endif
#endif
#endif
|#
 |#
;  KERNEL 
; 
;  * Number of scratch memory words (for BPF_LD|BPF_MEM and BPF_ST).
;  
(defconstant $BPF_MEMWORDS 16)
; #define BPF_MEMWORDS 16

; #endif


(provide-interface "bpf")