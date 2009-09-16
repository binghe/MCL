(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vnode.h"
; at Sunday July 2,2006 7:27:11 pm.
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
;  * Copyright (c) 1989, 1993
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
;  *	@(#)vnode.h	8.17 (Berkeley) 5/20/95
;  
; #ifndef _VNODE_H_
; #define _VNODE_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/cdefs")

(require-interface "sys/queue")

(require-interface "sys/lock")

(require-interface "sys/time")

(require-interface "sys/uio")

(require-interface "sys/vm")
; #ifdef KERNEL
#| #|
#include <syssystm.h>
#include <vmvm_pageout.h>
#endif
|#
 |#
;  KERNEL 
; #ifdef __APPLE_API_PRIVATE
#| #|



enum vtype	{ VNON, VREG, VDIR, VBLK, VCHR, VLNK, VSOCK, VFIFO, VBAD, VSTR,
			  VCPLX };


enum vtagtype	{
	VT_NON, VT_UFS, VT_NFS, VT_MFS, VT_MSDOSFS, VT_LFS, VT_LOFS, VT_FDESC,
	VT_PORTAL, VT_NULL, VT_UMAP, VT_KERNFS, VT_PROCFS, VT_AFS, VT_ISOFS,
	VT_UNION, VT_HFS, VT_VOLFS, VT_DEVFS, VT_WEBDAV, VT_UDF, VT_AFP,
	VT_CDDA, VT_CIFS,VT_OTHER};


LIST_HEAD(buflists, buf);

#define MAX_CLUSTERS 4	

struct v_cluster {
	unsigned int	start_pg;
	unsigned int	last_pg;
};

struct v_padded_clusters {
	long	v_pad;
	struct v_cluster	v_c[MAX_CLUSTERS];
};


struct vnode {
	u_long	v_flag;				
	long	v_usecount;			
	long	v_holdcnt;			
	daddr_t	v_lastr;			
	u_long	v_id;				
	struct	mount *v_mount;			
	int 	(**v_op)(void *);		
	TAILQ_ENTRY(vnode) v_freelist;		
	LIST_ENTRY(vnode) v_mntvnodes;		
	struct	buflists v_cleanblkhd;		
	struct	buflists v_dirtyblkhd;		
	long	v_numoutput;			
	enum	vtype v_type;			
	union {
		struct mount	*vu_mountedhere;
		struct socket	*vu_socket;	
		struct specinfo	*vu_specinfo;	
		struct fifoinfo	*vu_fifoinfo;	
		char            *vu_name;       
	} v_un;
	struct ubc_info *v_ubcinfo;	
	struct	nqlease *v_lease;		
        void   *v_scmap;			
        int 	v_scdirty;			
	daddr_t	v_ciosiz;			
	int	v_clen;				
	int	v_ralen;			
	daddr_t	v_maxra;			
	union {
		simple_lock_data_t v_ilk;	
		struct v_padded_clusters v_cl;	
	} v_un1;
#define v_clusters v_un1.v_cl.v_c
#define v_interlock v_un1.v_ilk

	struct	lock__bsd__ *v_vnlock;		
	long	v_writecount;			
	enum	vtagtype v_tag;			
	void 	*v_data;			
};
#define v_mountedhere	v_un.vu_mountedhere
#define v_socket	v_un.vu_socket
#define v_specinfo	v_un.vu_specinfo
#define v_fifoinfo	v_un.vu_fifoinfo

#define VNAME(vp)   ((char *)((vp)->v_type == VREG ? (vp)->v_un.vu_name : (vp)->v_scmap))
#define VPARENT(vp) ((struct vnode *)((vp)->v_type == VREG ? (vp)->v_un1.v_cl.v_pad : (vp)->v_scdirty))



#define VROOT		0x000001	
#define VTEXT		0x000002	
#define VSYSTEM		0x000004	
#define VISTTY		0x000008	
#define VWASMAPPED	0x000010	
#define VTERMINATE	0x000020	
#define VTERMWANT	0x000040	
#define VMOUNT		0x000080	
#define VXLOCK		0x000100	
#define VXWANT		0x000200	
#define VBWAIT		0x000400	
#define VALIASED	0x000800	
#define VORECLAIM	0x001000	
#define VNOCACHE_DATA	0x002000	
#define VSTANDARD	0x004000	
#define VAGE		0x008000	
#define VRAOFF		0x010000	
#define VUINIT		0x020000	
#define VUWANT		0x040000	
#define VUINACTIVE	0x080000	
#define VHASDIRTY	0x100000	
		
#define VSWAP		0x200000	
#define VTHROTTLED	0x400000	
		
#define VNOFLUSH	0x800000	
#define VDELETED       0x1000000        
#define VFULLFSYNC     0x2000000	
#define VHASBEENPAGED  0x4000000        


struct vattr {
	enum vtype	va_type;	
	u_short		va_mode;	
	short		va_nlink;	
	uid_t		va_uid;		
	gid_t		va_gid;		
	long		va_fsid;	
	long		va_fileid;	
	u_quad_t	va_size;	
	long		va_blocksize;	
	struct timespec	va_atime;	
	struct timespec	va_mtime;	
	struct timespec	va_ctime;	
	u_long		va_gen;		
	u_long		va_flags;	
	dev_t		va_rdev;	
	u_quad_t	va_bytes;	
	u_quad_t	va_filerev;	
	u_int		va_vaflags;	
	long		va_spare;	
};


#define VA_UTIMES_NULL	0x01		
#define VA_EXCLUSIVE	0x02		


#define IO_UNIT		0x01		
#define IO_APPEND	0x02		
#define IO_SYNC		0x04		
#define IO_NODELOCKED	0x08		
#define IO_NDELAY	0x10		
#define IO_NOZEROFILL	0x20		
#define IO_TAILZEROFILL	0x40		
#define IO_HEADZEROFILL	0x80		
#define IO_NOZEROVALID	0x100		
#define IO_NOZERODIRTY	0x200		


#define VSUID	04000		
#define VSGID	02000		
#define VSVTX	01000		
#define VREAD	00400		
#define VWRITE	00200
#define VEXEC	00100


#define VNOVAL	(-1)

#ifdefKERNEL

extern enum vtype	iftovt_tab[];
extern int		vttoif_tab[];
#define IFTOVT(mode)	(iftovt_tab[((mode) & S_IFMT) >> 12])
#define VTTOIF(indx)	(vttoif_tab[(int)(indx)])
#define MAKEIMODE(indx, mode)	(int)(VTTOIF(indx) | (mode))


#define SKIPSYSTEM	0x0001		
#define FORCECLOSE	0x0002		
#define WRITECLOSE	0x0004		
#define SKIPSWAP	0x0008		

#define DOCLOSE		0x0008		

#define V_SAVE		0x0001		
#define V_SAVEMETA	0x0002		

#define REVOKEALL	0x0001		


#define PREALLOCATE		0x00000001	
#define ALLOCATECONTIG	0x00000002	
#define ALLOCATEALL		0x00000004	
									
#define FREEREMAINDER	0x00000008	
									
#define ALLOCATEFROMPEOF	0x00000010	
#define ALLOCATEFROMVOL		0x00000020	

#ifDIAGNOSTIC
#define VATTR_NULL(vap)	vattr_null(vap)
#define HOLDRELE(vp)	holdrele(vp)
#define VHOLD(vp)	vhold(vp)

void	holdrele __P((struct vnode *));
void	vattr_null __P((struct vattr *));
void	vhold __P((struct vnode *));
#else#define VATTR_NULL(vap)	(*(vap) = va_null)	
#define HOLDRELE(vp)	holdrele(vp)		
extern __inline void holdrele(struct vnode *vp)
{
	simple_lock(&vp->v_interlock);
	vp->v_holdcnt--;
	simple_unlock(&vp->v_interlock);
}
#define VHOLD(vp)	vhold(vp)		
extern __inline void vhold(struct vnode *vp)
{
	simple_lock(&vp->v_interlock);
	if (++vp->v_holdcnt <= 0)
		panic("vhold: v_holdcnt");
	simple_unlock(&vp->v_interlock);
}
#endif

#define VREF(vp)	vref(vp)
void	vref __P((struct vnode *));
#define NULLVP	((struct vnode *)NULL)


extern	struct vnode *rootvnode;	
extern	int desiredvnodes;		
extern	struct vattr va_null;		


#define LEASE_READ	0x1		
#define LEASE_WRITE	0x2		
#endif




#define VDESC_MAX_VPS		16

#define VDESC_VP0_WILLRELE	0x0001
#define VDESC_VP1_WILLRELE	0x0002
#define VDESC_VP2_WILLRELE	0x0004
#define VDESC_VP3_WILLRELE	0x0008
#define VDESC_NOMAP_VPP		0x0100
#define VDESC_VPP_WILLRELE	0x0200


#define VDESC_NO_OFFSET -1


struct vnodeop_desc {
	int	vdesc_offset;		
	char    *vdesc_name;		
	int	vdesc_flags;		

	
	int	*vdesc_vp_offsets;	
	int	vdesc_vpp_offset;	
	int	vdesc_cred_offset;	
	int	vdesc_proc_offset;	
	int	vdesc_componentname_offset; 
	
	caddr_t	*vdesc_transports;
};

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; #ifdef KERNEL
#| #|

#ifdef__APPLE_API_PRIVATE

extern struct vnodeop_desc *vnodeop_descs[];


extern struct slock mntvnode_slock;


#define VOPARG_OFFSET(p_type,field) \
        ((int) (((char *) (&(((p_type)NULL)->field))) - ((char *) NULL)))
#define VOPARG_OFFSETOF(s_type,field) \
	VOPARG_OFFSET(s_type*,field)
#define VOPARG_OFFSETTO(S_TYPE,S_OFFSET,STRUCT_P) \
	((S_TYPE)(((char*)(STRUCT_P))+(S_OFFSET)))



struct vnodeopv_entry_desc {
	struct vnodeop_desc *opve_op;   
	int (*opve_impl)(void *);		
};
struct vnodeopv_desc {
			
	int (***opv_desc_vector_p)(void *);
	struct vnodeopv_entry_desc *opv_desc_ops;   
};


int vn_default_error __P((void));


struct vop_generic_args {
	struct vnodeop_desc *a_desc;
	
};


#define VOCALL(OPSV,OFF,AP) (( *((OPSV)[(OFF)])) (AP))


#define VCALL(VP,OFF,AP) VOCALL((VP)->v_op,(OFF),(AP))
#define VDESC(OP) (& __CONCAT(OP,_desc))
#define VOFFSET(OP) (VDESC(OP)->vdesc_offset)

#endif


#include <sysvnode_if.h>


struct file;
struct mount;
struct nameidata;
struct ostat;
struct proc;
struct stat;
struct ucred;
struct uio;
struct vattr;
struct vnode;
struct vop_bwrite_args;

#ifdef__APPLE_API_EVOLVING
int 	bdevvp __P((dev_t dev, struct vnode **vpp));
void	cvtstat __P((struct stat *st, struct ostat *ost));
int 	getnewvnode __P((enum vtagtype tag,
	    struct mount *mp, int (**vops)(void *), struct vnode **vpp));
void	insmntque __P((struct vnode *vp, struct mount *mp));
void 	vattr_null __P((struct vattr *vap));
int 	vcount __P((struct vnode *vp));
int	vflush __P((struct mount *mp, struct vnode *skipvp, int flags));
int 	vget __P((struct vnode *vp, int lockflag, struct proc *p));
void 	vgone __P((struct vnode *vp));
int	vinvalbuf __P((struct vnode *vp, int save, struct ucred *cred,
	    struct proc *p, int slpflag, int slptimeo));
void	vprint __P((char *label, struct vnode *vp));
int	vrecycle __P((struct vnode *vp, struct slock *inter_lkp,
	    struct proc *p));
int	vn_bwrite __P((struct vop_bwrite_args *ap));
int 	vn_close __P((struct vnode *vp,
	    int flags, struct ucred *cred, struct proc *p));
int	vn_lock __P((struct vnode *vp, int flags, struct proc *p));
int 	vn_open __P((struct nameidata *ndp, int fmode, int cmode));
#ifndef__APPLE_API_PRIVATE
__private_extern__ int
	vn_open_modflags __P((struct nameidata *ndp, int *fmode, int cmode));
#endif
int 	vn_rdwr __P((enum uio_rw rw, struct vnode *vp, caddr_t base,
	    int len, off_t offset, enum uio_seg segflg, int ioflg,
	    struct ucred *cred, int *aresid, struct proc *p));
int	vn_stat __P((struct vnode *vp, struct stat *sb, struct proc *p));
int	vop_noislocked __P((struct vop_islocked_args *));
int	vop_nolock __P((struct vop_lock_args *));
int	vop_nounlock __P((struct vop_unlock_args *));
int	vop_revoke __P((struct vop_revoke_args *));
struct vnode *
	checkalias __P((struct vnode *vp, dev_t nvp_rdev, struct mount *mp));
void 	vput __P((struct vnode *vp));
void 	vrele __P((struct vnode *vp));
int	vaccess __P((mode_t file_mode, uid_t uid, gid_t gid,
	    mode_t acc_mode, struct ucred *cred));
int	getvnode __P((struct proc *p, int fd, struct file **fpp));
#endif

#endif
|#
 |#
;  KERNEL 

; #endif /* !_VNODE_H_ */


(provide-interface "vnode")