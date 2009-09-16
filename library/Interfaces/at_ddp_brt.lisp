(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:at_ddp_brt.h"
; at Sunday July 2,2006 7:26:40 pm.
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
;  *	Copyright (c) 1988, 1989 Apple Computer, Inc. 
;  
; #ifndef _NETAT_AT_DDP_BRT_H_
; #define _NETAT_AT_DDP_BRT_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

typedef struct {
	int 				age_flag;
	at_ifaddr_t			*ifID;
	struct	etalk_addr		et_addr;
	at_net_al			net;
} ddp_brt_t;

#define BRT_SWEEP_INT		(10 * PR_SLOWHZ)
#define BRT_BSIZ		 4	
#define BRT_NB			16	
#define BRTSIZE			(BRT_BSIZ * BRT_NB)


#define BRT_EMPTY		0	
					
#define BRT_VALID		1	
					
#define BRT_GETTING_OLD		2	
					

#define BRT_HASH(a)   ((a) % BRT_NB)

#define BRT_LOOK(brt, dst_net) {				\
	register n; 						\
	brt = &at_ddp_brt[BRT_HASH(dst_net) * BRT_BSIZ];	\
	for (n = 0 ; ; brt++) {		                        \
		if (brt->net == dst_net) 			\
			break; 					\
		if (++n >= BRT_BSIZ) {                          \
		        brt = NULL;                             \
			break;                                  \
		}                                               \
	}                                                       \
	}

#define NEW_BRT(brt, net) {					\
	register n; 						\
	brt = &at_ddp_brt[BRT_HASH(net) * BRT_BSIZ]; 		\
	for (n = 0 ; ; brt++) { 		                \
		if (brt->age_flag == BRT_EMPTY)			\
			break; 					\
		if (++n >= BRT_BSIZ) {				\
		        brt = NULL;				\
			break;                                  \
		}                                               \
        }                                                       \
	}


extern	ddp_brt_t	at_ddp_brt[BRTSIZE];

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _NETAT_AT_DDP_BRT_H_ */


(provide-interface "at_ddp_brt")