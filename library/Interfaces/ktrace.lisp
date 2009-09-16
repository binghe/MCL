(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ktrace.h"
; at Sunday July 2,2006 7:30:16 pm.
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
;  *	@(#)ktrace.h	8.1 (Berkeley) 6/2/93
;  * $FreeBSD: src/sys/sys/ktrace.h,v 1.19.2.3 2001/01/06 09:58:23 alfred Exp $
;  
; #ifndef _SYS_KTRACE_H_
; #define	_SYS_KTRACE_H_

(require-interface "sys/appleapiopts")

; #if defined(MACH_KERNEL_PRIVATE)
#| ; #ifdef __APPLE_API_PRIVATE
#|
void ktrsyscall(void *, int, int, void *, int);
void ktrsysret(void *, int, int, int, int);
#endif
|#
;  __APPLE_API_PRIVATE 
 |#

; #else
; #ifdef __APPLE_API_UNSTABLE
#| #|

#define KTROP_SET		0	
#define KTROP_CLEAR		1	
#define KTROP_CLEARFILE		2	
#define KTROP(o)		((o)&3)	

#define KTRFLAG_DESCEND		4	


struct ktr_header {
	int	ktr_len;		
	short	ktr_type;		
	pid_t	ktr_pid;		
	char	ktr_comm[MAXCOMLEN+1];	
	struct	timeval ktr_time;	
	caddr_t	ktr_buf;
};


#define KTRPOINT(p, type)	\
	(((p)->p_traceflag & ((1<<(type))|KTRFAC_ACTIVE)) == (1<<(type)))




#define KTR_SYSCALL	1
struct ktr_syscall {
	short	ktr_code;		
	short	ktr_narg;		
	
	register_t	ktr_args[1];
};


#define KTR_SYSRET	2
struct ktr_sysret {
	short	ktr_code;
	short	ktr_eosys;
	int	ktr_error;
	register_t	ktr_retval;
};


#define KTR_NAMEI	3
	


#define KTR_GENIO	4
struct ktr_genio {
	int	ktr_fd;
	enum	uio_rw ktr_rw;
	
};


#define KTR_PSIG	5
struct ktr_psig {
	int	signo;
	sig_t	action;
	int	code;
	sigset_t mask;
};


#define KTR_CSW		6
struct ktr_csw {
	int	out;	
	int	user;	
};


#define KTR_USER_MAXLEN	2048	
#define KTR_USER	7


#define KTRFAC_MASK	0x00ffffff
#define KTRFAC_SYSCALL	(1<<KTR_SYSCALL)
#define KTRFAC_SYSRET	(1<<KTR_SYSRET)
#define KTRFAC_NAMEI	(1<<KTR_NAMEI)
#define KTRFAC_GENIO	(1<<KTR_GENIO)
#define KTRFAC_PSIG	(1<<KTR_PSIG)
#define KTRFAC_CSW	(1<<KTR_CSW)
#define KTRFAC_USER	(1<<KTR_USER)

#define KTRFAC_ROOT	0x80000000	
#define KTRFAC_INHERIT	0x40000000	
#define KTRFAC_ACTIVE	0x20000000	


#ifdefKERNEL
#ifdef__APPLE_API_PRIVATE
void	ktrnamei __P((struct vnode *,char *));
void	ktrcsw __P((struct vnode *, int, int, int));
void	ktrpsig __P((struct vnode *, int, sig_t, sigset_t *, int, int));
void	ktrgenio __P((struct vnode *, int, enum uio_rw,
	    struct uio *, int, int));
void	ktrsyscall __P((struct proc *, int, int, register_t args[], int));
void	ktrsysret __P((struct proc *, int, int, register_t, int));
#endif
#else
#include <syscdefs.h>

__BEGIN_DECLS
int	ktrace __P((const char *, int, int, pid_t));
int	utrace __P((const void *, size_t));
__END_DECLS

#endif

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !MACH_KERNEL_PRIVATE */


; #endif /* !_SYS_KTRACE_H_ */


(provide-interface "ktrace")