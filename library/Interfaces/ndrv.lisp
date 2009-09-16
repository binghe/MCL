(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ndrv.h"
; at Sunday July 2,2006 7:30:34 pm.
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
;  Copyright (c) 1997, 1998 Apple Computer, Inc. All Rights Reserved 
; 
;  *	@(#)ndrv.h	1.1 (MacOSX) 6/10/43
;  * Justin Walker - 970604
;  

(require-interface "net/dlil")
; #ifndef _NET_NDRV_H
; #define _NET_NDRV_H

(require-interface "sys/appleapiopts")
(defrecord sockaddr_ndrv
   (snd_len :UInt8)
   (snd_family :UInt8)
   (snd_name (:array :UInt8 16))                ;  from if.h 
)
; 
;  * Support for user-mode protocol handlers
;  
; #define NDRV_DEMUXTYPE_ETHERTYPE	DLIL_DESC_ETYPE2
; #define	NDRV_DEMUXTYPE_SAP			DLIL_DESC_SAP
; #define NDRV_DEMUXTYPE_SNAP			DLIL_DESC_SNAP
(defconstant $NDRVPROTO_NDRV 0)
; #define	NDRVPROTO_NDRV				0
; 
;  * Struct: ndrv_demux_desc
;  * Purpose:
;  *   To uniquely identify a packet based on its low-level framing information.
;  *
;  * Fields:
;  *		type		:	type of protocol in data field, must be understood by
;  *						the interface family of the interface the socket is bound to
;  *		length		: 	length of protocol data in "data" field
;  *		data		:	union of framing-specific data, in network byte order
;  *		ether_type	:	ethernet type in network byte order, assuming
;  *						ethernet type II framing
;  *		sap			:	first 3 bytes of sap header, network byte order
;  *		snap		:	first 5 bytes of snap header, network byte order
;  *		other		:	up to 28 bytes of protocol data for different protocol type
;  *
;  * Examples:
;  * 1) 802.1x uses ether_type 0x888e, so the descriptor would be set as:
;  *    struct ndrv_demux_desc desc;
;  *    desc.type = NDRV_DEMUXTYPE_ETHERTYPE
;  *	  desc.length = sizeof(unsigned short);
;  *    desc.ether_type = htons(0x888e);
;  * 2) AppleTalk uses SNAP 0x080007809B
;  *    struct ndrv_demux_desc desc;
;  *    desc.type = NDRV_DEMUXTYPE_SNAP;
;  *    desc.length = 5;
;  *    desc.data.snap[0] = 08;
;  *    desc.data.snap[1] = 00;
;  *    desc.data.snap[2] = 07;
;  *    desc.data.snap[3] = 80;
;  *    desc.data.snap[4] = 9B;
;  
(defrecord ndrv_demux_desc
   (type :UInt16)
   (length :UInt16)
   (:variant
   (
   (ether_type :UInt16)
   )
   (
   (sap (:array :UInt8 3))
   )
   (
   (snap (:array :UInt8 5))
   )
   (
   (other (:array :UInt8 28))
   )
   )
)
(defconstant $NDRV_PROTOCOL_DESC_VERS 1)
; #define NDRV_PROTOCOL_DESC_VERS	1
; 
;  * Struct: ndrv_protocol_desc
;  * Purpose:
;  *   Used to "bind" an NDRV socket so that packets that match
;  *   given protocol demux descriptions can be received:
;  * Field:
;  *		version			:	must be NDRV_PROTOCOL_DESC_VERS
;  *		protocol_family	:	unique identifier for this protocol
;  *		demux_count		:	number of demux_list descriptors in demux_list
;  *		demux_list		:	pointer to array of demux descriptors
;  
(defrecord ndrv_protocol_desc
   (version :UInt32)
   (protocol_family :UInt32)
   (demux_count :UInt32)
   (demux_list (:pointer :NDRV_DEMUX_DESC))
)
; #define SOL_NDRVPROTO		NDRVPROTO_NDRV	/* Use this socket level */
; 		NDRV_DMXSPEC		0x01		   	   Obsolete 
(defconstant $NDRV_DELDMXSPEC 2)
; #define NDRV_DELDMXSPEC		0x02			/* Delete the registered protocol */
; 		NDRV_DMXSPECCNT		0x03			   Obsolete 
(defconstant $NDRV_SETDMXSPEC 4)
; #define NDRV_SETDMXSPEC		0x04			/* Set the protocol spec */
(defconstant $NDRV_ADDMULTICAST 5)
; #define	NDRV_ADDMULTICAST	0x05			/* Add a physical multicast address */
(defconstant $NDRV_DELMULTICAST 6)
; #define NDRV_DELMULTICAST	0x06			/* Delete a phyiscal multicast */
; 
;  * SOL_NDRVPROTO - use this for the socket level when calling setsocketopt
;  * NDRV_DELDMXSPEC - removes the registered protocol and all related demuxes
;  * NDRV_SETDMXSPEC - set the protocol to receive, use struct ndrv_protocol_desc
;  *					 as the parameter.
;  * NDRV_ADDMULTICAST - Enable reception of a phyiscal multicast address, use
;  *                     a sockaddr of the appropriate type for the media in use.
;  * NDRV_DELMULTICAST - Disable reception of a phyiscal multicast address, use
;  *					   a sockaddr of the appropriate type for the media in use.
;  *
;  * When adding multicasts, the multicasts are ref counted. If the multicast is
;  * already registered in the kernel, the count will be bumped. When deleting
;  * the multicast, the count is decremented. If the count reaches zero the
;  * multicast is removed. If your process is killed, PF_NDRV will unregister
;  * the mulitcasts you've added. You can only delete multicasts you've added
;  * on the same socket.
;  *
;  * If the interface goes away while your socket is open, your protocol is
;  * immediately detached and sending/receiving is disabled on the socket.
;  * If you need a chance to do something, please file a bug and we can give
;  * you a second or two.
;  
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE

struct ifnet*	ndrv_get_ifp(caddr_t ndrv_pcb);
#endif
#endif
|#
 |#

; #endif	/* _NET_NDRV_H */


(provide-interface "ndrv")