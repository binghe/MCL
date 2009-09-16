(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:bootp.h"
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
;  * Bootstrap Protocol (BOOTP).  RFC 951.
;  
; 
;  * HISTORY
;  *
;  * 14 May 1992 ? at NeXT
;  *	Added correct padding to struct nextvend.  This is
;  *	needed for the i386 due to alignment differences wrt
;  *	the m68k.  Also adjusted the size of the array fields
;  *	because the NeXT vendor area was overflowing the bootp
;  *	packet.
;  
; #define iaddr_t struct in_addr
(defrecord bootp
   (bp_op :UInt8)
                                                ;  packet opcode type 
; #define	BOOTREQUEST	1
; #define	BOOTREPLY	2
   (bp_htype :UInt8)
                                                ;  hardware addr type 
   (bp_hlen :UInt8)
                                                ;  hardware addr length 
   (bp_hops :UInt8)
                                                ;  gateway hops 
   (bp_xid :UInt32)
                                                ;  transaction ID 
   (bp_secs :UInt16)
                                                ;  seconds since boot began 
   (bp_unused :UInt16)
   (bp_ciaddr :iaddr_t)
#|
; Warning: type-size: unknown type IADDR_T
|#
                                                ;  client IP address 
   (bp_yiaddr :iaddr_t)
#|
; Warning: type-size: unknown type IADDR_T
|#
                                                ;  'your' IP address 
   (bp_siaddr :iaddr_t)
#|
; Warning: type-size: unknown type IADDR_T
|#
                                                ;  server IP address 
   (bp_giaddr :iaddr_t)
#|
; Warning: type-size: unknown type IADDR_T
|#
                                                ;  gateway IP address 
   (bp_chaddr (:array :UInt8 16))
                                                ;  client hardware address 
   (bp_sname (:array :UInt8 64))
                                                ;  server host name 
   (bp_file (:array :UInt8 128))
                                                ;  boot file name 
   (bp_vend (:array :UInt8 64))
                                                ;  vendor-specific area 
)
; 
;  * UDP port numbers, server and client.
;  
(defconstant $IPPORT_BOOTPS 67)
; #define	IPPORT_BOOTPS		67
(defconstant $IPPORT_BOOTPC 68)
; #define	IPPORT_BOOTPC		68
; 
;  * "vendor" data permitted for Stanford boot clients.
;  
(defrecord vend
   (v_magic (:array :UInt8 4))
                                                ;  magic number 
   (v_flags :UInt32)
                                                ;  flags/opcodes, etc. 
   (v_unused (:array :UInt8 56))
                                                ;  currently unused 
)
(defconstant $VM_STANFORD "STAN")
; #define	VM_STANFORD	"STAN"	/* v_magic for Stanford */
;  v_flags values 
(defconstant $VF_PCBOOT 1)
; #define	VF_PCBOOT	1	/* an IBMPC or Mac wants environment info */
(defconstant $VF_HELP 2)
; #define	VF_HELP		2	/* help me, I'm not registered */
(defconstant $NVMAXTEXT 55)
; #define	NVMAXTEXT	55	/* don't change this, it just fits RFC951 */
(defrecord nextvend
   (nv_magic (:array :UInt8 4))
                                                ;  Magic number for vendor specificity 
   (nv_version :UInt8)
                                                ;  NeXT protocol version 
                                                ; 
; 	 * Round the beginning
; 	 * of the union to a 16
; 	 * bit boundary due to
; 	 * struct/union alignment
; 	 * on the m68k.
; 	 
   (colon7 :UInt16)
   (:variant
   (
   (NV0 (:array :UInt8 58))
   )
   (
   (NV1_opcode :UInt8)
                                                ;  opcode - Version 1 
   (NV1_xid :UInt8)
                                                ;  transcation id 
   (NV1_text (:array :UInt8 55))
                                                ;  text 
   (NV1_null :UInt8)
                                                ;  null terminator 
   )
   )
)
; #define	nv_unused	nv_U.NV0
; #define	nv_opcode	nv_U.NV1.NV1_opcode
; #define	nv_xid		nv_U.NV1.NV1_xid
; #define	nv_text		nv_U.NV1.NV1_text
; #define nv_null		nv_U.NV1.NV1_null
;  Magic number 
(defconstant $VM_NEXT "NeXT")
; #define VM_NEXT		"NeXT"	/* v_magic for NeXT, Inc. */
;  Opcodes 
(defconstant $BPOP_OK 0)
; #define	BPOP_OK		0
(defconstant $BPOP_QUERY 1)
; #define BPOP_QUERY	1
(defconstant $BPOP_QUERY_NE 2)
; #define	BPOP_QUERY_NE	2
(defconstant $BPOP_ERROR 3)
; #define	BPOP_ERROR	3
(defrecord bootp_packet
   (bp_ip :ip)
#|
; Warning: type-size: unknown type IP
|#
   (bp_udp :udphdr)
#|
; Warning: type-size: unknown type UDPHDR
|#
   (bp_bootp :BOOTP)
)
(defconstant $BOOTP_PKTSIZE 308)
; #define	BOOTP_PKTSIZE (sizeof (struct bootp_packet))
;  backoffs must be masks 
(defconstant $BOOTP_MIN_BACKOFF 2047)
; #define	BOOTP_MIN_BACKOFF	0x7ff		/* 2.048 sec */
(defconstant $BOOTP_MAX_BACKOFF 65535)
; #define	BOOTP_MAX_BACKOFF	0xffff		/* 65.535 sec */
(defconstant $BOOTP_RETRY 6)
; #define	BOOTP_RETRY		6		/* # retries */

(provide-interface "bootp")