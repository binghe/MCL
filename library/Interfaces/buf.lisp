(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:buf.h"
; at Sunday July 2,2006 7:27:14 pm.
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
;  * Copyright (c) 1982, 1986, 1989, 1993
;  *	The Regents of the University of California.  All rights reserved.
;  * (c) UNIX System Laboratories, Inc.
;  * All or some portions of this file are derived from material licensed
;  * to the University of California by American Telephone and Telegraph
;  * Co. or Unix System Laboratories, Inc. and are reproduced herein with
;  * the permission of UNIX System Laboratories, Inc.
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
;  *	@(#)buf.h	8.9 (Berkeley) 3/30/95
;  
; #ifndef _SYS_BUF_H_
; #define	_SYS_BUF_H_

(require-interface "sys/appleapiopts")
; #ifdef KERNEL
#| #|
#include <sysqueue.h>
#include <syserrno.h>
#include <sysvm.h>
#include <syscdefs.h>

#ifdef__APPLE_API_PRIVATE

#define NOLIST ((struct buf *)0x87654321)


struct buf {
	LIST_ENTRY(buf) b_hash;		
	LIST_ENTRY(buf) b_vnbufs;	
	TAILQ_ENTRY(buf) b_freelist;	
	struct  proc *b_proc;		
	volatile long	b_flags;	
	int	b_error;		
	long	b_bufsize;		
	long	b_bcount;		
	long	b_resid;		
	dev_t	b_dev;			
	struct {
		caddr_t	b_addr;		
	} b_un;
	void	*b_saveaddr;		
	daddr_t	b_lblkno;		
	daddr_t	b_blkno;		
					
	void	(*b_iodone) __P((struct buf *));
	struct	vnode *b_vp;		
	int	b_dirtyoff;		
	int	b_dirtyend;		
	int	b_validoff;		
	int	b_validend;		
	struct	ucred *b_rcred;		
	struct	ucred *b_wcred;		
	int	b_timestamp;		
	long	b_vectorcount;	
	void	*b_vectorlist;	
	void	*b_pagelist;	
	long	b_vects[2];		
	long	b_whichq;		
	TAILQ_ENTRY(buf)	b_act;	
	void	*b_drvdata;		
};


#define b_cylinder b_resid		


#define b_active b_bcount		
#define b_data	 b_un.b_addr		
#define b_errcnt b_resid		
#define iodone	 biodone		
#define iowait	 biowait		


#define b_uploffset  b_bufsize
#define b_trans_head b_freelist.tqe_prev
#define b_trans_next b_freelist.tqe_next
#define b_real_bp    b_saveaddr
#define b_iostate    b_rcred


#define b_transaction b_vectorlist

   


#define B_AGE		0x00000001	
#define B_NEEDCOMMIT	0x00000002	
#define B_ASYNC		0x00000004	
#define B_BAD		0x00000008	
#define B_BUSY		0x00000010	
#define B_CACHE		0x00000020	
#define B_CALL		0x00000040	
#define B_DELWRI	0x00000080	
#define B_DIRTY		0x00000100	
#define B_DONE		0x00000200	
#define B_EINTR		0x00000400	
#define B_ERROR		0x00000800	
#define B_WASDIRTY	0x00001000	
#define B_INVAL		0x00002000	
#define B_LOCKED	0x00004000	
#define B_NOCACHE	0x00008000	
#define B_PAGEOUT	0x00010000	
#define B_PGIN		0x00020000	
#define B_PHYS		0x00040000	
#define B_RAW		0x00080000	
#define B_READ		0x00100000	
#define B_TAPE		0x00200000	
#define B_PAGELIST	0x00400000	
#define B_WANTED	0x00800000	
#define B_WRITE		0x00000000	
#define B_WRITEINPROG	0x01000000	
#define B_HDRALLOC	0x02000000	
#define B_NORELSE	0x04000000	
#define B_NEED_IODONE   0x08000000
								
								
#define B_COMMIT_UPL    0x10000000
								
								
#define B_ZALLOC	0x20000000	
#define B_META		0x40000000	
#define B_VECTORLIST	0x80000000	



#define clrbuf(bp) {							\
	bzero((bp)->b_data, (u_int)(bp)->b_bcount);			\
	(bp)->b_resid = 0;						\
}


#define B_CLRBUF	0x01	
#define B_SYNC		0x02	
#define B_NOBUFF	0x04	


#define BLK_READ	0x01	
#define BLK_WRITE	0x02	
#define BLK_PAGEIN	0x04	
#define BLK_PAGEOUT	0x08	
#define BLK_META	0x10	
#define BLK_CLREAD	0x20	
#define BLK_CLWRITE	0x40	

extern int nbuf;			
extern struct buf *buf;		

#endif


#ifdef__APPLE_API_UNSTABLE

#define SET(t, f)	(t) |= (f)
#define CLR(t, f)	(t) &= ~(f)
#define ISSET(t, f)	((t) & (f))
#endif

#ifdef__APPLE_API_PRIVATE

#define BQUEUES		6		

#define BQ_LOCKED	0		
#define BQ_LRU		1		
#define BQ_AGE		2		
#define BQ_EMPTY	3		
#define BQ_META		4		
#define BQ_LAUNDRY	5		
#endif

__BEGIN_DECLS
#ifdef__APPLE_API_UNSTABLE
int	allocbuf __P((struct buf *, int));
void	bawrite __P((struct buf *));
void	bdwrite __P((struct buf *));
void	biodone __P((struct buf *));
int	biowait __P((struct buf *));
int	bread __P((struct vnode *, daddr_t, int,
	    struct ucred *, struct buf **));
int	meta_bread __P((struct vnode *, daddr_t, int,
	    struct ucred *, struct buf **));
int	breada __P((struct vnode *, daddr_t, int, daddr_t, int,
	    struct ucred *, struct buf **));
int	breadn __P((struct vnode *, daddr_t, int, daddr_t *, int *, int,
	    struct ucred *, struct buf **));
int	meta_breadn __P((struct vnode *, daddr_t, int, daddr_t *, int *, int,
	    struct ucred *, struct buf **));
void	brelse __P((struct buf *));
void	bremfree __P((struct buf *));
void	bufinit __P((void));
void	bwillwrite __P((void));
int	bwrite __P((struct buf *));
struct buf *getblk __P((struct vnode *, daddr_t, int, int, int, int));
struct buf *geteblk __P((int));
struct buf *incore __P((struct vnode *, daddr_t));
u_int	minphys __P((struct buf *bp));
int physio __P((void (*)(struct buf *), struct buf *, dev_t, int ,  u_int (*)(struct buf *), struct uio *, int ));
int count_busy_buffers __P((void));
struct buf *alloc_io_buf __P((struct vnode *, int));
void free_io_buf __P((struct buf *));
void reassignbuf __P((struct buf *, struct vnode *));
#endif
__END_DECLS

#ifdef__APPLE_API_PRIVATE

struct bufstats {
	long	bufs_incore;		
	long	bufs_busyincore;	
	long	bufs_vmhits;		
	long	bufs_miss;			
	long	bufs_sleeps;		
	long	bufs_eblk;			
	long	bufs_iobufmax;		
	long	bufs_iobufinuse;	
	long	bufs_iobufsleeps;	
};
#endif

#endif
|#
 |#
;  KERNEL 

; #endif /* !_SYS_BUF_H_ */


(provide-interface "buf")