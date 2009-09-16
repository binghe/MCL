(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:at_pcb.h"
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
;  *	Copyright (c) 1997-1999 Apple Computer, Inc.
;  *	All Rights Reserved.
;  
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
; 
;  * Copyright (c) 1982, 1986, 1990, 1993
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
;  *      This product includes software developed by the University of
;  *      California, Berkeley and its contributors.
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
;  
;  at_pcb.h 

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

struct atpcb {
	struct atpcb 	*atpcb_next,	
			*atpcb_prev,
			*atpcb_head;	
	struct socket 	*atpcb_socket;	
	u_char		ddptype,	
			lport,		
			rport;          
	struct at_addr  laddr,		
			raddr;		
	int		ddp_flags;	
	caddr_t		at_ppcb;	

  

	void *info;
	gbuf_t *ichead;
	gbuf_t *ictail;
	gbuf_t *rdhead;
	gbuf_t *rdtail;
	unsigned char	proto;		
	unsigned char  errno;
	unsigned short sevents;
	int pid;
	atlock_t lock;
	atevent_t event;
	atevent_t iocevent;
	int (*writeable)();
	int (*readable)();
	struct selinfo si;	
};

#define sotoatpcb(so)((struct atpcb *)(so)->so_pcb)
#endif
|#
 |#
;  __APPLE_API_PRIVATE 
;  ddp_flags 
(defconstant $DDPFLG_CHKSUM 1)
; #define DDPFLG_CHKSUM	 0x01	/* DDP checksums to be used on this connection */
(defconstant $DDPFLG_SLFSND 2)
; #define DDPFLG_SLFSND	 0x02	/* packets sent to the cable-multicast address
(defconstant $DDPFLG_HDRINCL 8)
; #define DDPFLG_HDRINCL 	 0x08	/* user supplies entire DDP header */
(defconstant $DDPFLG_STRIPHDR 512)
; #define DDPFLG_STRIPHDR	0x200	/* drop DDP header on receive (raw) */
; #ifdef __APPLE_API_PRIVATE
#| #|
#ifdefKERNEL
typedef struct atpcb gref_t;

int	at_pcballoc __P((struct socket *, struct atpcb *));
int	at_pcbdetach __P((struct atpcb *));
int	at_pcbbind __P((struct atpcb *, struct sockaddr *));
#endif
#endif
|#
 |#
;  __APPLE_API_PRIVATE 

(provide-interface "at_pcb")