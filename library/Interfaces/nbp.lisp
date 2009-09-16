(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:nbp.h"
; at Sunday July 2,2006 7:30:33 pm.
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
;  *
;  *
;  * ORIGINS: 82
;  *
;  * (C) COPYRIGHT Apple Computer, Inc. 1992-1996
;  * All Rights Reserved
;  *
;  
; 
;  *	Copyright (c) 1988, 1989 Apple Computer, Inc. 
;  *
;  *	The information contained herein is subject to change without
;  *	notice and  should not be  construed as a commitment by Apple
;  *	Computer, Inc. Apple Computer, Inc. assumes no responsibility
;  *	for any errors that may appear.
;  *
;  *	Confidential and Proprietary to Apple Computer, Inc.
;  
; 
;  * Title:	nbp.h
;  *
;  * Facility:	Include file for NBP kernel module.
;  *
;  * Author:	Kumar Vora, Creation Date: May-1-1989
;  *
;  * History:
;  * X01-001	Kumar Vora	May-1-1989
;  *	 	Initial Creation.
;  
; #ifndef _NETAT_NBP_H_
; #define _NETAT_NBP_H_

(require-interface "sys/appleapiopts")
;  NBP packet types 
(defconstant $NBP_BRRQ 1)
; #define NBP_BRRQ		0x01  	/* Broadcast request */
(defconstant $NBP_LKUP 2)
; #define NBP_LKUP    		0x02  	/* Lookup */
(defconstant $NBP_LKUP_REPLY 3)
; #define NBP_LKUP_REPLY		0x03  	/* Lookup reply */
(defconstant $NBP_FWDRQ 4)
; #define NBP_FWDRQ		0x04	/* Forward Request (router only) */
;  *** the following may be discontinued in the near future *** 
(defconstant $NBP_CONFIRM 9)
; #define NBP_CONFIRM   		0x09	/* Confirm, not sent on wire */
; #ifdef NOT_USED
#| #|
#define NBP_REGISTER    	0x07	
#define NBP_DELETE      	0x08	
#define NBP_STATUS_REPLY	0x0a	
#define NBP_CLOSE_NOTE		0x0b	
#endif
|#
 |#
;  *** **************************************************** *** 
;  Protocol defaults 
(defconstant $NBP_RETRY_COUNT 8)
; #define NBP_RETRY_COUNT		8	/* Maximum repeats */
(defconstant $NBP_RETRY_INTERVAL 1)
; #define NBP_RETRY_INTERVAL	1	/* Retry timeout */
;  Special (partial) wildcard character 
(defconstant $NBP_SPL_WILDCARD 197)
; #define	NBP_SPL_WILDCARD	0xC5
(defconstant $NBP_ORD_WILDCARD "=")
; #define	NBP_ORD_WILDCARD	'='
;  Packet definitions 
(defconstant $NBP_TUPLE_MAX 15)
; #define NBP_TUPLE_MAX	15	/* Maximum number of tuples in one DDP packet */
(defconstant $NBP_HDR_SIZE 2)
; #define	NBP_HDR_SIZE	2
(defrecord at_nbp
   (control :UInt32)                            ;(: 4)
                                                ;(tuple_count : 4)
   (at_nbp_id :UInt8)
   (tuple (:array :AT_NBPTUPLE 15))
)
(%define-record :at_nbp_t (find-record-descriptor :AT_NBP))
; #define DEFAULT_ZONE(zone) (!(zone)->len || ((zone)->len == 1 && (zone)->str[0] == '*'))
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE


typedef struct _nve_ {
	TAILQ_ENTRY(_nve_) nve_link; 
	gbuf_t		*tag;		
					
	at_nvestr_t	zone;
	u_int		zone_hash;
	at_nvestr_t	object;
	u_int		object_hash;
	at_nvestr_t	type;
	u_int		type_hash;
	at_inet_t	address;
	u_char		ddptype;
	u_char		enumerator;
	int		pid;
	long		unique_nbp_id;	
} nve_entry_t;

#define NBP_WILD_OBJECT	0x01
#define NBP_WILD_TYPE	0x02
#define NBP_WILD_MASK	0x03

typedef	struct	nbp_req	{
	int		(*func)();
	gbuf_t		*response;	
	int		space_unused;	
					
	gbuf_t		*request;	
					
	nve_entry_t	nve;
	u_char		flags;		
					
					
} nbp_req_t;

extern int	nbp_insert_entry(nve_entry_t *);
extern u_int	nbp_strhash (at_nvestr_t *);
extern nve_entry_t *nbp_find_nve(nve_entry_t *);
extern int	nbp_fillin_nve();

extern at_nvestr_t *getSPLocalZone(int);
extern at_nvestr_t *getLocalZone(int);

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_NBP_H_ */


(provide-interface "nbp")