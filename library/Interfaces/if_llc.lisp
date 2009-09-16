(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:if_llc.h"
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
;  * Copyright (c) 1988, 1993
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
;  *      @(#)if_llc.h	8.1 (Berkeley) 6/10/93
;  
; #ifndef _NET_IF_LLC_H_
; #define _NET_IF_LLC_H_

(require-interface "sys/appleapiopts")
; 
;  * IEEE 802.2 Link Level Control headers, for use in conjunction with
;  * 802.{3,4,5} media access control methods.
;  *
;  * Headers here do not use bit fields due to shortcomings in many
;  * compilers.
;  
(defrecord llc
   (llc_dsap :UInt8)
   (llc_ssap :UInt8)
   (:variant
   (
   (control :UInt8)
   (format_id :UInt8)
   (class_id :UInt8)
   (window_x2 :UInt8)
   )
   (
   (num_snd_x2 :UInt8)
   (num_rcv_x2 :UInt8)
   )
   (
   (control :UInt8)
   (num_rcv_x2 :UInt8)
   )
   (
   (control :UInt8)
   (rej_pdu_0 :UInt8)
   (rej_pdu_1 :UInt8)
   (frmr_control :UInt8)
   (frmr_control_ext :UInt8)
   (frmr_cause :UInt8)
   )
   (
   (control :UInt8)
   (org_code (:array :UInt8 3))
   (ether_type :UInt16)
   )
   (
   (control :UInt8)
   (control_ext :UInt8)
   )
   )
)
; #define llc_control            llc_un.type_u.control
; #define	llc_control_ext        llc_un.type_raw.control_ext
; #define llc_fid                llc_un.type_u.format_id
; #define llc_class              llc_un.type_u.class_id
; #define llc_window             llc_un.type_u.window_x2
; #define llc_frmrinfo           llc_un.type_frmr.frmrinfo
; #define llc_frmr_pdu0          llc_un.type_frmr.frmrinfo.rej_pdu0
; #define llc_frmr_pdu1          llc_un.type_frmr.frmrinfo.rej_pdu1
; #define llc_frmr_control       llc_un.type_frmr.frmrinfo.frmr_control
; #define llc_frmr_control_ext   llc_un.type_frmr.frmrinfo.frmr_control_ext
; #define llc_frmr_cause         llc_un.type_frmr.frmrinfo.frmr_control_ext
; 
;  * Don't use sizeof(struct llc_un) for LLC header sizes
;  
(defconstant $LLC_ISFRAMELEN 4)
; #define LLC_ISFRAMELEN 4
(defconstant $LLC_UFRAMELEN 3)
; #define LLC_UFRAMELEN  3
(defconstant $LLC_FRMRLEN 7)
; #define LLC_FRMRLEN    7
; 
;  * Unnumbered LLC format commands
;  
(defconstant $LLC_UI 3)
; #define LLC_UI		0x3
(defconstant $LLC_UI_P 19)
; #define LLC_UI_P	0x13
(defconstant $LLC_DISC 67)
; #define LLC_DISC	0x43
(defconstant $LLC_DISC_P 83)
; #define	LLC_DISC_P	0x53
(defconstant $LLC_UA 99)
; #define LLC_UA		0x63
(defconstant $LLC_UA_P 115)
; #define LLC_UA_P	0x73
(defconstant $LLC_TEST 227)
; #define LLC_TEST	0xe3
(defconstant $LLC_TEST_P 243)
; #define LLC_TEST_P	0xf3
(defconstant $LLC_FRMR 135)
; #define LLC_FRMR	0x87
(defconstant $LLC_FRMR_P 151)
; #define	LLC_FRMR_P	0x97
(defconstant $LLC_DM 15)
; #define LLC_DM		0x0f
(defconstant $LLC_DM_P 31)
; #define	LLC_DM_P	0x1f
(defconstant $LLC_XID 175)
; #define LLC_XID		0xaf
(defconstant $LLC_XID_P 191)
; #define LLC_XID_P	0xbf
(defconstant $LLC_SABME 111)
; #define LLC_SABME	0x6f
(defconstant $LLC_SABME_P 127)
; #define LLC_SABME_P	0x7f
; 
;  * Supervisory LLC commands
;  
(defconstant $LLC_RR 1)
; #define	LLC_RR		0x01
(defconstant $LLC_RNR 5)
; #define	LLC_RNR		0x05
(defconstant $LLC_REJ 9)
; #define	LLC_REJ		0x09
; 
;  * Info format - dummy only
;  
(defconstant $LLC_INFO 0)
; #define	LLC_INFO	0x00
; 
;  * ISO PDTR 10178 contains among others
;  
(defconstant $LLC_X25_LSAP 126)
; #define LLC_X25_LSAP	0x7e
(defconstant $LLC_SNAP_LSAP 170)
; #define LLC_SNAP_LSAP	0xaa
(defconstant $LLC_ISO_LSAP 254)
; #define LLC_ISO_LSAP	0xfe

; #endif


(provide-interface "if_llc")