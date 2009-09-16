(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ethernet.h"
; at Sunday July 2,2006 7:27:45 pm.
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
;  * Fundamental constants relating to ethernet.
;  *
;  
; #ifndef _NET_ETHERNET_H_
; #define _NET_ETHERNET_H_

(require-interface "sys/appleapiopts")
; 
;  * The number of bytes in an ethernet (MAC) address.
;  
(defconstant $ETHER_ADDR_LEN 6)
; #define	ETHER_ADDR_LEN		6
; 
;  * The number of bytes in the type field.
;  
(defconstant $ETHER_TYPE_LEN 2)
; #define	ETHER_TYPE_LEN		2
; 
;  * The number of bytes in the trailing CRC field.
;  
(defconstant $ETHER_CRC_LEN 4)
; #define	ETHER_CRC_LEN		4
; 
;  * The length of the combined header.
;  
(defconstant $ETHER_HDR_LEN 14)
; #define	ETHER_HDR_LEN		(ETHER_ADDR_LEN*2+ETHER_TYPE_LEN)
; 
;  * The minimum packet length.
;  
(defconstant $ETHER_MIN_LEN 64)
; #define	ETHER_MIN_LEN		64
; 
;  * The maximum packet length.
;  
(defconstant $ETHER_MAX_LEN 1518)
; #define	ETHER_MAX_LEN		1518
; 
;  * A macro to validate a length with
;  
; #define	ETHER_IS_VALID_LEN(foo)		((foo) >= ETHER_MIN_LEN && (foo) <= ETHER_MAX_LEN)
; 
;  * Structure of a 10Mb/s Ethernet header.
;  
(defrecord ether_header
   (ether_dhost (:array :UInt8 6))
   (ether_shost (:array :UInt8 6))
   (ether_type :UInt16)
)
; 
;  * Structure of a 48-bit Ethernet address.
;  
(defrecord ether_addr
   (octet (:array :UInt8 6))
)
; #define ether_addr_octet octet
(defconstant $ETHERTYPE_PUP 512)
; #define	ETHERTYPE_PUP		0x0200	/* PUP protocol */
(defconstant $ETHERTYPE_IP 2048)
; #define	ETHERTYPE_IP		0x0800	/* IP protocol */
(defconstant $ETHERTYPE_ARP 2054)
; #define ETHERTYPE_ARP		0x0806	/* Addr. resolution protocol */
(defconstant $ETHERTYPE_REVARP 32821)
; #define ETHERTYPE_REVARP	0x8035	/* reverse Addr. resolution protocol */
(defconstant $ETHERTYPE_VLAN 33024)
; #define	ETHERTYPE_VLAN		0x8100	/* IEEE 802.1Q VLAN tagging */
(defconstant $ETHERTYPE_IPV6 34525)
; #define ETHERTYPE_IPV6		0x86dd	/* IPv6 */
(defconstant $ETHERTYPE_LOOPBACK 36864)
; #define	ETHERTYPE_LOOPBACK	0x9000	/* used to test interfaces */
;  XXX - add more useful types here 
; 
;  * The ETHERTYPE_NTRAILER packet types starting at ETHERTYPE_TRAIL have
;  * (type-ETHERTYPE_TRAIL)*512 bytes of data followed
;  * by an ETHER type (as given above) and then the (variable-length) header.
;  
(defconstant $ETHERTYPE_TRAIL 4096)
; #define	ETHERTYPE_TRAIL		0x1000		/* Trailer packet */
(defconstant $ETHERTYPE_NTRAILER 16)
; #define	ETHERTYPE_NTRAILER	16
(defconstant $ETHERMTU 1500)
; #define	ETHERMTU	(ETHER_MAX_LEN-ETHER_HDR_LEN-ETHER_CRC_LEN)
(defconstant $ETHERMIN 46)
; #define	ETHERMIN	(ETHER_MIN_LEN-ETHER_HDR_LEN-ETHER_CRC_LEN)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
struct	ether_addr *ether_aton __P((char *));
#endif
#endif
|#
 |#
; #ifndef KERNEL

(require-interface "sys/cdefs")
; 
;  * Ethernet address conversion/parsing routines.
;  
#|
 confused about __P #\( #\( char * #\, struct ether_addr * #\) #\)
|#
#|
 confused about __P #\( #\( char * #\, struct ether_addr * #\, char * #\) #\)
|#
#|
 confused about __P #\( #\( const struct ether_addr * #\) #\)
|#
#|
 confused about __P #\( #\( char * #\, struct ether_addr * #\) #\)
|#

; #endif /* !KERNEL */


; #endif /* !_NET_ETHERNET_H_ */


(provide-interface "ethernet")