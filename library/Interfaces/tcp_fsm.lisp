(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:tcp_fsm.h"
; at Sunday July 2,2006 7:32:05 pm.
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
;  * Copyright (c) 1982, 1986, 1993
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
;  *	@(#)tcp_fsm.h	8.1 (Berkeley) 6/10/93
;  * $FreeBSD: src/sys/netinet/tcp_fsm.h,v 1.14 1999/11/07 04:18:30 jlemon Exp $
;  
; #ifndef _NETINET_TCP_FSM_H_
; #define _NETINET_TCP_FSM_H_

(require-interface "sys/appleapiopts")
; 
;  * TCP FSM state definitions.
;  * Per RFC793, September, 1981.
;  
(defconstant $TCP_NSTATES 11)
; #define	TCP_NSTATES	11
(defconstant $TCPS_CLOSED 0)
; #define	TCPS_CLOSED		0	/* closed */
(defconstant $TCPS_LISTEN 1)
; #define	TCPS_LISTEN		1	/* listening for connection */
(defconstant $TCPS_SYN_SENT 2)
; #define	TCPS_SYN_SENT		2	/* active, have sent syn */
(defconstant $TCPS_SYN_RECEIVED 3)
; #define	TCPS_SYN_RECEIVED	3	/* have send and received syn */
;  states < TCPS_ESTABLISHED are those where connections not established 
(defconstant $TCPS_ESTABLISHED 4)
; #define	TCPS_ESTABLISHED	4	/* established */
(defconstant $TCPS_CLOSE_WAIT 5)
; #define	TCPS_CLOSE_WAIT		5	/* rcvd fin, waiting for close */
;  states > TCPS_CLOSE_WAIT are those where user has closed 
(defconstant $TCPS_FIN_WAIT_1 6)
; #define	TCPS_FIN_WAIT_1		6	/* have closed, sent fin */
(defconstant $TCPS_CLOSING 7)
; #define	TCPS_CLOSING		7	/* closed xchd FIN; await FIN ACK */
(defconstant $TCPS_LAST_ACK 8)
; #define	TCPS_LAST_ACK		8	/* had fin and close; await FIN ACK */
;  states > TCPS_CLOSE_WAIT && < TCPS_FIN_WAIT_2 await ACK of FIN 
(defconstant $TCPS_FIN_WAIT_2 9)
; #define	TCPS_FIN_WAIT_2		9	/* have closed, fin is acked */
(defconstant $TCPS_TIME_WAIT 10)
; #define	TCPS_TIME_WAIT		10	/* in 2*msl quiet wait after close */
;  for KAME src sync over BSD*'s 
; #define	TCP6_NSTATES		TCP_NSTATES
; #define	TCP6S_CLOSED		TCPS_CLOSED
; #define	TCP6S_LISTEN		TCPS_LISTEN
; #define	TCP6S_SYN_SENT		TCPS_SYN_SENT
; #define	TCP6S_SYN_RECEIVED	TCPS_SYN_RECEIVED
; #define	TCP6S_ESTABLISHED	TCPS_ESTABLISHED
; #define	TCP6S_CLOSE_WAIT	TCPS_CLOSE_WAIT
; #define	TCP6S_FIN_WAIT_1	TCPS_FIN_WAIT_1
; #define	TCP6S_CLOSING		TCPS_CLOSING
; #define	TCP6S_LAST_ACK		TCPS_LAST_ACK
; #define	TCP6S_FIN_WAIT_2	TCPS_FIN_WAIT_2
; #define	TCP6S_TIME_WAIT		TCPS_TIME_WAIT
; #define	TCPS_HAVERCVDSYN(s)	((s) >= TCPS_SYN_RECEIVED)
; #define	TCPS_HAVEESTABLISHED(s)	((s) >= TCPS_ESTABLISHED)
; #define	TCPS_HAVERCVDFIN(s)	((s) >= TCPS_TIME_WAIT)
; #ifdef __APPLE_API_UNSTABLE
#| #|
#ifdefTCPOUTFLAGS

static u_char	tcp_outflags[TCP_NSTATES] = {
	TH_RST|TH_ACK,		
	0,			
	TH_SYN,			
	TH_SYN|TH_ACK,		
	TH_ACK,			
	TH_ACK,			
	TH_FIN|TH_ACK,		
	TH_FIN|TH_ACK,		
	TH_FIN|TH_ACK,		
	TH_ACK,			
	TH_ACK,			
};	
#endif#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #if KPROF
#| ; #ifdef __APPLE_API_PRIVATE
#|
int	tcp_acounts[TCP_NSTATES][PRU_NREQ];
#endif
|#
;  __APPLE_API_PRIVATE 
 |#

; #endif

; #ifdef	TCPSTATES
#| #|
char *tcpstates[] = {
	"CLOSED",	"LISTEN",	"SYN_SENT",	"SYN_RCVD",
	"ESTABLISHED",	"CLOSE_WAIT",	"FIN_WAIT_1",	"CLOSING",
	"LAST_ACK",	"FIN_WAIT_2",	"TIME_WAIT",
};
#endif
|#
 |#

; #endif


(provide-interface "tcp_fsm")