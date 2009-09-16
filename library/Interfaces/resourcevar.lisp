(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:resourcevar.h"
; at Sunday July 2,2006 7:31:26 pm.
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
;  Copyright (c) 1995, 1997 Apple Computer, Inc. All Rights Reserved 
; 
;  * Copyright (c) 1991, 1993
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
;  *	@(#)resourcevar.h	8.4 (Berkeley) 1/9/95
;  
; #ifndef	_SYS_RESOURCEVAR_H_
; #define	_SYS_RESOURCEVAR_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

struct pstats {
#define pstat_startzero	p_ru
	struct	rusage p_ru;		
	struct	rusage p_cru;		

	struct uprof {			
		struct uprof *pr_next;  
		caddr_t	pr_base;	
		u_long	pr_size;	
		u_long	pr_off;		
		u_long	pr_scale;	
		u_long	pr_addr;	
		u_long	pr_ticks;	
	} p_prof;
#define pstat_endzero	pstat_startcopy

#define pstat_startcopy	p_timer
	struct	itimerval p_timer[3];	
#define pstat_endcopy	p_start
	struct	timeval p_start;	
};


struct plimit {
	struct	rlimit pl_rlimit[RLIM_NLIMITS];
#define PL_SHAREMOD	0x01		
	int	p_lflags;
	int	p_refcnt;		
};


#define ADDUPROF(p)							\
	addupc_task(p,							\
	    (p)->p_stats->p_prof.pr_addr, (p)->p_stats->p_prof.pr_ticks)

#ifdefKERNEL
void	 addupc_intr __P((struct proc *p, u_long pc, u_int ticks));
void	 addupc_task __P((struct proc *p, u_long pc, u_int ticks));
void	 calcru __P((struct proc *p, struct timeval *up, struct timeval *sp,
	    struct timeval *ip));
void	 ruadd __P((struct rusage *ru, struct rusage *ru2));
struct plimit *limcopy __P((struct plimit *lim));
#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif	/* !_SYS_RESOURCEVAR_H_ */


(provide-interface "resourcevar")