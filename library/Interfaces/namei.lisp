(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:namei.h"
; at Sunday July 2,2006 7:30:33 pm.
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
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
; 
;  * Copyright (c) 1985, 1989, 1991, 1993
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
;  *	@(#)namei.h	8.4 (Berkeley) 8/20/94
;  
; #ifndef _SYS_NAMEI_H_
; #define	_SYS_NAMEI_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|

#include <sysqueue.h>
#include <sysuio.h>


struct componentname {
	
	u_long	cn_nameiop;	
	u_long	cn_flags;	
	struct	proc *cn_proc;	
	struct	ucred *cn_cred;	
	
	char	*cn_pnbuf;	
	long	cn_pnlen;	
	char	*cn_nameptr;	
	long	cn_namelen;	
	u_long	cn_hash;	
	long	cn_consume;	
};


struct nameidata {
	
	caddr_t	ni_dirp;		
	enum	uio_seg ni_segflg;	
     
     
     
	
     
	struct	vnode *ni_startdir;	
	struct	vnode *ni_rootdir;	
	
	struct	vnode *ni_vp;		
	struct	vnode *ni_dvp;		
	
	u_int	ni_pathlen;		
	char	*ni_next;		
	u_long	ni_loopcnt;		
	struct componentname ni_cnd;
};

#ifdefKERNEL

#define LOOKUP		0	
#define CREATE		1	
#define DELETE		2	
#define RENAME		3	
#define OPMASK		3	

#define LOCKLEAF	0x0004	
#define LOCKPARENT	0x0008	
#define WANTPARENT	0x0010	
#define NOCACHE		0x0020	
#define FOLLOW		0x0040	
#define NOFOLLOW	0x0000	
#define SHAREDLEAF	0x0080	
#define MODMASK		0x00fc	

#define NOCROSSMOUNT	0x000100 
#define RDONLY		0x000200 
#define HASBUF		0x000400 
#define SAVENAME	0x000800 
#define SAVESTART	0x001000 
#define ISDOTDOT	0x002000 
#define MAKEENTRY	0x004000 
#define ISLASTCN	0x008000 
#define ISSYMLINK	0x010000 
#define ISWHITEOUT	0x020000 
#define DOWHITEOUT	0x040000 
#define WILLBEDIR	0x080000 
#define AUDITVNPATH1	0x100000 
#define AUDITVNPATH2	0x200000 
#define USEDVP		0x400000 
#define NODELETEBUSY	0x800000 
#define PARAMASK	0x3fff00 

#define NDINIT(ndp, op, flags, segflg, namep, p) { \
	(ndp)->ni_cnd.cn_nameiop = op; \
	(ndp)->ni_cnd.cn_flags = flags; \
	(ndp)->ni_segflg = segflg; \
	(ndp)->ni_dirp = namep; \
	(ndp)->ni_cnd.cn_proc = p; \
}
#endif



#define NCHNAMLEN	31	

struct	namecache {
	LIST_ENTRY(namecache) nc_hash;	
	TAILQ_ENTRY(namecache) nc_lru;	
	struct	vnode *nc_dvp;		
	u_long	nc_dvpid;		
	struct	vnode *nc_vp;		
	u_long	nc_vpid;		
	char	*nc_name;		
};

#ifdefKERNEL
struct mount;
extern u_long	nextvnodeid;
int	namei __P((struct nameidata *ndp));
int	lookup __P((struct nameidata *ndp));
int	relookup __P((struct vnode *dvp, struct vnode **vpp,
		struct componentname *cnp));


int	cache_lookup __P((struct vnode *dvp, struct vnode **vpp,
		struct componentname *cnp));
void	cache_enter __P((struct vnode *dvp, struct vnode *vpp,
		struct componentname *cnp));
void	cache_purge __P((struct vnode *vp));
void    cache_purgevfs __P((struct mount *mp));

char *add_name(const char *name, size_t len, u_int nc_hash, u_int flags);
int   remove_name(const char *name);


#endif


struct	nchstats {
	long	ncs_goodhits;		
	long	ncs_neghits;		
	long	ncs_badhits;		
	long	ncs_falsehits;		
	long	ncs_miss;		
	long	ncs_long;		
	long	ncs_pass2;		
	long	ncs_2passes;		
};
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !_SYS_NAMEI_H_ */


(provide-interface "namei")