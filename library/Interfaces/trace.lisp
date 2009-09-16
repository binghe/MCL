(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:trace.h"
; at Sunday July 2,2006 7:32:07 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
; -
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
;  *	@(#)trace.h	8.1 (Berkeley) 6/2/93
;  
; #ifndef _SYS_TRACE_H_
; #define	_SYS_TRACE_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_OBSOLETE
#| #|

#define TR_BREADHIT	0	
#define TR_BREADMISS	1	
#define TR_BWRITE	2	
#define TR_BREADHITRA	3	
#define TR_BREADMISSRA	4	
#define TR_XFODMISS	5	
#define TR_XFODHIT	6	
#define TR_BRELSE	7	
#define TR_BREALLOC	8	


#define TR_MALL		10	


#define TR_INTRANS	20	
#define TR_EINTRANS	21	
#define TR_FRECLAIM	22	
#define TR_RECLAIM	23	
#define TR_XSFREC	24	
#define TR_XIFREC	25	
#define TR_WAITMEM	26	
#define TR_EWAITMEM	27	
#define TR_ZFOD		28	
#define TR_EXFOD	29	
#define TR_VRFOD	30	
#define TR_CACHEFOD	31	
#define TR_SWAPIN	32	
#define TR_PGINDONE	33	
#define TR_SWAPIO	34	


#define TR_VADVISE	40	


#define TR_STAMP	45	


#define TR_NFLAGS	100	

#define TRCSIZ		4096


#define VTRACE		64+51

#define VTR_DISABLE	0		
#define VTR_ENABLE	1		
#define VTR_VALUE	2		
#define VTR_UALARM	3		
					
#define VTR_STAMP	4		

#ifdefKERNEL
#ifTRACE
extern struct	proc *traceproc;
extern int	tracewhich, tracebuf[TRCSIZ];
extern u_int	tracex;
extern char	traceflags[TR_NFLAGS];
#define pack(v,b)	(((v)->v_mount->mnt_stat.f_fsid.val[0])<<16)|(b)
#define trace(a,b,c) {							\
	if (traceflags[a])						\
		trace1(a,b,c);						\
}
#else#define trace(a,b,c)
#endif#endif

#endif
|#
 |#
;  __APPLE_API_OBSOLETE 

; #endif /* !_SYS_TRACE_H_ */


(provide-interface "trace")