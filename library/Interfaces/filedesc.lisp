(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:filedesc.h"
; at Sunday July 2,2006 7:27:52 pm.
; 
;  * Copyright (c) 2000-2003 Apple Computer, Inc. All rights reserved.
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
;  * Copyright (c) 1990, 1993
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
;  *	@(#)filedesc.h	8.1 (Berkeley) 6/2/93
;  
; #ifndef _SYS_FILEDESC_H_
; #define	_SYS_FILEDESC_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|

#define NDFILE		25		
#define NDEXTENT	50		 

struct klist;

struct filedesc {
	struct	file **fd_ofiles;	
	char	*fd_ofileflags;		
	struct	vnode *fd_cdir;		
	struct	vnode *fd_rdir;		
	int	fd_nfiles;		
	u_short	fd_lastfile;		
	u_short	fd_freefile;		
	u_short	fd_cmask;		
	u_short	fd_refcnt;		

	int     fd_knlistsize;          
	struct  klist *fd_knlist;       
	u_long  fd_knhashmask;          
	struct  klist *fd_knhash;       
};


#define UF_EXCLOSE 	0x01		
#define UF_MAPPED 	0x02		
#define UF_RESERVED	0x04		


#define OFILESIZE (sizeof(struct file *) + sizeof(char))

#ifdefKERNEL

extern int	dupfdopen __P((struct filedesc *fdp,
				int indx, int dfd, int mode, int error));
extern int	fdalloc __P((struct proc *p, int want, int *result));
extern void	fdrelse __P((struct proc *p, int fd));
extern int	fdavail __P((struct proc *p, int n));
extern int	fdgetf __P((struct proc *p, int fd, struct file **resultfp));
#define 	fdfile(p, fd)					\
			(&(p)->p_fd->fd_ofiles[(fd)])
#define 	fdflags(p, fd)					\
			(&(p)->p_fd->fd_ofileflags[(fd)])
extern int	falloc __P((struct proc *p,
				struct file **resultfp, int *resultfd));
extern void	ffree __P((struct file *fp));

#ifdef__APPLE_API_PRIVATE
extern struct	filedesc *fdcopy __P((struct proc *p));
extern void	fdfree __P((struct proc *p));
extern void	fdexec __P((struct proc *p));
#endif

#endif

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !_SYS_FILEDESC_H_ */


(provide-interface "filedesc")