(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mount.h"
; at Sunday July 2,2006 7:30:29 pm.
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
;  * Copyright (c) 1989, 1991, 1993
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
;  *	@(#)mount.h	8.21 (Berkeley) 5/20/95
;  
; #ifndef _SYS_MOUNT_H_
; #define	_SYS_MOUNT_H_

(require-interface "sys/appleapiopts")
; #ifndef KERNEL

(require-interface "sys/ucred")

; #endif


(require-interface "sys/queue")

(require-interface "sys/lock")

(require-interface "net/radix")

(require-interface "sys/socket")
(defrecord fsid
   (val (:array :SInt32 2))
)
(%define-record :fsid_t (find-record-descriptor :FSID))
;  file system id type 
; 
;  * File identifier.
;  * These are unique per filesystem on a single machine.
;  
(defconstant $MAXFIDSZ 16)
; #define	MAXFIDSZ	16
(defrecord fid
   (fid_len :UInt16)
                                                ;  length of data in bytes 
   (fid_reserved :UInt16)
                                                ;  force longword alignment 
   (fid_data (:array :character 16))
                                                ;  data (variable length) 
)
; 
;  * file system statistics
;  
(defconstant $MFSNAMELEN 15)
; #define	MFSNAMELEN	15	/* length of fs type name, not inc. null */
(defconstant $MNAMELEN 90)
; #define	MNAMELEN	90	/* length of buffer for returned name */
(defrecord statfs
   (f_otype :SInt16)
                                                ;  TEMPORARY SHADOW COPY OF f_type 
   (f_oflags :SInt16)
                                                ;  TEMPORARY SHADOW COPY OF f_flags 
   (f_bsize :signed-long)
                                                ;  fundamental file system block size 
   (f_iosize :signed-long)
                                                ;  optimal transfer block size 
   (f_blocks :signed-long)
                                                ;  total data blocks in file system 
   (f_bfree :signed-long)
                                                ;  free blocks in fs 
   (f_bavail :signed-long)
                                                ;  free blocks avail to non-superuser 
   (f_files :signed-long)
                                                ;  total file nodes in file system 
   (f_ffree :signed-long)
                                                ;  free file nodes in fs 
   (f_fsid :FSID)
                                                ;  file system id 
   (f_owner :UInt32)
                                                ;  user that mounted the filesystem 
   (f_reserved1 :SInt16)
                                                ;  spare for later 
   (f_type :SInt16)
                                                ;  type of filesystem 
   (f_flags :signed-long)
                                                ;  copy of mount exported flags 
   (f_reserved2 (:array :signed-long 2))
                                                ;  reserved for future use 
   (f_fstypename (:array :character 15))        ;  fs type name 
   (f_mntonname (:array :character 90))
                                                ;  directory on which mounted 
   (f_mntfromname (:array :character 90))       ;  mounted filesystem 

; #if COMPAT_GETFSSTAT
#|    (f_reserved3 (:array :character 0))
                                                ;  For alignment 
   (f_reserved4 (:array :signed-long 0))
                                                ;  For future use 
 |#

; #else
   (f_reserved3 :character)
                                                ;  For alignment 
   (f_reserved4 (:array :signed-long 4))
                                                ;  For future use 

; #endif

)
; #ifdef __APPLE_API_PRIVATE
#| #|

LIST_HEAD(vnodelst, vnode);

struct mount {
	CIRCLEQ_ENTRY(mount) mnt_list;		
	struct vfsops	*mnt_op;		
	struct vfsconf	*mnt_vfc;		
	struct vnode	*mnt_vnodecovered;	
	struct vnodelst	mnt_vnodelist;		
	struct lock__bsd__ mnt_lock;		
	int		mnt_flag;		
	int		mnt_kern_flag;		
	int		mnt_maxsymlinklen;	
	struct statfs	mnt_stat;		
	qaddr_t		mnt_data;		
	
        union {
	  u_int32_t	mntu_maxreadcnt;	
	  void         *mntu_xinfo_ptr;         
	} mnt_un;                               
#define mnt_maxreadcnt mnt_un.mntu_maxreadcnt
#define mnt_xinfo_ptr  mnt_un.mntu_xinfo_ptr
	u_int32_t	mnt_maxwritecnt;	
	u_int16_t	mnt_segreadcnt;	
	u_int16_t	mnt_segwritecnt;	
};
#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; 
;  * User specifiable flags.
;  *
;  * Unmount uses MNT_FORCE flag.
;  
(defconstant $MNT_RDONLY 1)
; #define	MNT_RDONLY	0x00000001	/* read only filesystem */
(defconstant $MNT_SYNCHRONOUS 2)
; #define	MNT_SYNCHRONOUS	0x00000002	/* file system written synchronously */
(defconstant $MNT_NOEXEC 4)
; #define	MNT_NOEXEC	0x00000004	/* can't exec from filesystem */
(defconstant $MNT_NOSUID 8)
; #define	MNT_NOSUID	0x00000008	/* don't honor setuid bits on fs */
(defconstant $MNT_NODEV 16)
; #define	MNT_NODEV	0x00000010	/* don't interpret special files */
(defconstant $MNT_UNION 32)
; #define	MNT_UNION	0x00000020	/* union with underlying filesystem */
(defconstant $MNT_ASYNC 64)
; #define	MNT_ASYNC	0x00000040	/* file system written asynchronously */
(defconstant $MNT_DONTBROWSE 1048576)
; #define MNT_DONTBROWSE	0x00100000	/* file system is not appropriate path to user data */
(defconstant $MNT_UNKNOWNPERMISSIONS 2097152)
; #define MNT_UNKNOWNPERMISSIONS 0x00200000 /* no known mapping for uid/gid in permissions information on disk */
(defconstant $MNT_AUTOMOUNTED 4194304)
; #define MNT_AUTOMOUNTED 0x00400000	/* filesystem was mounted by automounter */
(defconstant $MNT_JOURNALED 8388608)
; #define MNT_JOURNALED   0x00800000  /* filesystem is journaled */
; 
;  * NFS export related mount flags.
;  
(defconstant $MNT_EXRDONLY 128)
; #define	MNT_EXRDONLY	0x00000080	/* exported read only */
(defconstant $MNT_EXPORTED 256)
; #define	MNT_EXPORTED	0x00000100	/* file system is exported */
(defconstant $MNT_DEFEXPORTED 512)
; #define	MNT_DEFEXPORTED	0x00000200	/* exported to the world */
(defconstant $MNT_EXPORTANON 1024)
; #define	MNT_EXPORTANON	0x00000400	/* use anon uid mapping for everyone */
(defconstant $MNT_EXKERB 2048)
; #define	MNT_EXKERB	0x00000800	/* exported with Kerberos uid mapping */
; 
;  * Flags set by internal operations.
;  
(defconstant $MNT_LOCAL 4096)
; #define	MNT_LOCAL	0x00001000	/* filesystem is stored locally */
(defconstant $MNT_QUOTA 8192)
; #define	MNT_QUOTA	0x00002000	/* quotas are enabled on filesystem */
(defconstant $MNT_ROOTFS 16384)
; #define	MNT_ROOTFS	0x00004000	/* identifies the root filesystem */
(defconstant $MNT_DOVOLFS 32768)
; #define	MNT_DOVOLFS	0x00008000	/* FS supports volfs */
(defconstant $MNT_FIXEDSCRIPTENCODING 268435456)
; #define MNT_FIXEDSCRIPTENCODING	0x10000000	/* FS supports only fixed script encoding [HFS] */
; 
;  * XXX I think that this could now become (~(MNT_CMDFLAGS))
;  * but the 'mount' program may need changing to handle this.
;  
(defconstant $MNT_VISFLAGMASK 284229631)
; #define	MNT_VISFLAGMASK	(MNT_RDONLY	| MNT_SYNCHRONOUS | MNT_NOEXEC	| 			MNT_NOSUID	| MNT_NODEV	| MNT_UNION	| 			MNT_ASYNC	| MNT_EXRDONLY	| MNT_EXPORTED	| 			MNT_DEFEXPORTED	| MNT_EXPORTANON| MNT_EXKERB	| 			MNT_LOCAL	|		MNT_QUOTA	| 			MNT_ROOTFS	| MNT_DOVOLFS	| MNT_DONTBROWSE | 			MNT_UNKNOWNPERMISSIONS | MNT_AUTOMOUNTED | MNT_JOURNALED | MNT_FIXEDSCRIPTENCODING )
; 
;  * External filesystem command modifier flags.
;  * Unmount can use the MNT_FORCE flag.
;  * XXX These are not STATES and really should be somewhere else.
;  * External filesystem control flags.
;  
(defconstant $MNT_UPDATE 65536)
; #define	MNT_UPDATE	0x00010000	/* not a real mount, just an update */
(defconstant $MNT_DELEXPORT 131072)
; #define	MNT_DELEXPORT	0x00020000	/* delete export host lists */
(defconstant $MNT_RELOAD 262144)
; #define	MNT_RELOAD	0x00040000	/* reload filesystem data */
(defconstant $MNT_FORCE 524288)
; #define	MNT_FORCE	0x00080000	/* force unmount or readonly change */
(defconstant $MNT_CMDFLAGS 983040)
; #define MNT_CMDFLAGS	(MNT_UPDATE|MNT_DELEXPORT|MNT_RELOAD|MNT_FORCE)
; 
;  * Internal filesystem control flags stored in mnt_kern_flag.
;  *
;  * MNTK_UNMOUNT locks the mount entry so that name lookup cannot proceed
;  * past the mount point.  This keeps the subtree stable during mounts
;  * and unmounts.
;  
(defconstant $MNTK_VIRTUALDEV 2097152)
; #define MNTK_VIRTUALDEV 0x00200000      /* mounted on a virtual device i.e. a disk image */
(defconstant $MNTK_ROOTDEV 4194304)
; #define MNTK_ROOTDEV    0x00400000      /* this filesystem resides on the same device as the root */
(defconstant $MNTK_IO_XINFO 8388608)
; #define MNTK_IO_XINFO   0x00800000      /* mnt_un.mntu_ioptr has a malloc associated with it */
(defconstant $MNTK_UNMOUNT 16777216)
; #define MNTK_UNMOUNT	0x01000000	/* unmount in progress */
(defconstant $MNTK_MWAIT 33554432)
; #define	MNTK_MWAIT	0x02000000	/* waiting for unmount to finish */
(defconstant $MNTK_WANTRDWR 67108864)
; #define MNTK_WANTRDWR	0x04000000	/* upgrade to read/write requested */

; #if REV_ENDIAN_FS
#| 
; #define MNT_REVEND	0x08000000	/* Reverse endian FS */
 |#

; #endif /* REV_ENDIAN_FS */

(defconstant $MNTK_FRCUNMOUNT 268435456)
; #define MNTK_FRCUNMOUNT	0x10000000	/* Forced unmount wanted. */
; 
;  * Sysctl CTL_VFS definitions.
;  *
;  * Second level identifier specifies which filesystem. Second level
;  * identifier VFS_GENERIC returns information about all filesystems.
;  
(defconstant $VFS_GENERIC 0)
; #define	VFS_GENERIC		0	/* generic filesystem information */
(defconstant $VFS_NUMMNTOPS 1)
; #define VFS_NUMMNTOPS		1	/* int: total num of vfs mount/unmount operations */
; 
;  * Third level identifiers for VFS_GENERIC are given below; third
;  * level identifiers for specific filesystems are given in their
;  * mount specific header files.
;  
(defconstant $VFS_MAXTYPENUM 1)
; #define VFS_MAXTYPENUM	1	/* int: highest defined filesystem type */
(defconstant $VFS_CONF 2)
; #define VFS_CONF	2	/* struct: vfsconf for filesystem given
(defconstant $VFS_FMOD_WATCH 3)
; #define VFS_FMOD_WATCH        3 /* block waiting for the next modified file */
(defconstant $VFS_FMOD_WATCH_ENABLE 4)
; #define VFS_FMOD_WATCH_ENABLE 4 /* 1==enable, 0==disable */
; 
;  * Flags for various system call interfaces.
;  *
;  * waitfor flags to vfs_sync() and getfsstat()
;  
(defconstant $MNT_WAIT 1)
; #define MNT_WAIT	1	/* synchronously wait for I/O to complete */
(defconstant $MNT_NOWAIT 2)
; #define MNT_NOWAIT	2	/* start all I/O, but do not wait for it */
; 
;  * Generic file handle
;  
(defrecord fhandle
   (fh_fsid :FSID)
                                                ;  File system id of mount point 
   (fh_fid :FID)
                                                ;  File sys specific id 
)

(%define-record :fhandle_t (find-record-descriptor ':fhandle))
; 
;  * Export arguments for local filesystem mount calls.
;  
(defrecord export_args
   (ex_flags :signed-long)
                                                ;  export related flags 
   (ex_root :UInt32)
                                                ;  mapping for root uid 
   (ex_anon :ucred)
#|
; Warning: type-size: unknown type UCRED
|#
                                                ;  mapping for anonymous user 
   (ex_addr (:pointer :SOCKADDR))
                                                ;  net address to which exported 
   (ex_addrlen :signed-long)
                                                ;  and the net address length 
   (ex_mask (:pointer :SOCKADDR))
                                                ;  mask of valid bits in saddr 
   (ex_masklen :signed-long)
                                                ;  and the smask length 
)
; #ifdef __APPLE_API_UNSTABLE
#| #|

struct vfsconf {
	struct	vfsops *vfc_vfsops;	
	char	vfc_name[MFSNAMELEN];	
	int	vfc_typenum;		
	int	vfc_refcount;		
	int	vfc_flags;		
	int	(*vfc_mountroot)(void);	
	struct	vfsconf *vfc_next;	
};

#endif
|#
 |#
; __APPLE_API_UNSTABLE 
(defrecord vfsidctl
   (vc_vers :signed-long)
                                                ;  should be VFSIDCTL_VERS1 (below) 
   (vc_fsid :FSID)
                                                ;  fsid to operate on. 
   (vc_ptr :pointer)
                                                ;  pointer to data structure. 
   (vc_len :unsigned-long)
                                                ;  sizeof said structure. 
   (vc_spare (:array :UInt32 12))
                                                ;  spare (must be zero). 
)
;  vfsidctl API version. 
(defconstant $VFS_CTL_VERS1 1)
; #define VFS_CTL_VERS1	0x01
; 
;  * New style VFS sysctls, do not reuse/conflict with the namespace for
;  * private sysctls.
;  
(defconstant $VFS_CTL_STATFS 65537)
; #define VFS_CTL_STATFS	0x00010001	/* statfs */
(defconstant $VFS_CTL_UMOUNT 65538)
; #define VFS_CTL_UMOUNT	0x00010002	/* unmount */
(defconstant $VFS_CTL_QUERY 65539)
; #define VFS_CTL_QUERY	0x00010003	/* anything wrong? (vfsquery) */
(defconstant $VFS_CTL_NEWADDR 65540)
; #define VFS_CTL_NEWADDR	0x00010004	/* reconnect to new address */
(defconstant $VFS_CTL_TIMEO 65541)
; #define VFS_CTL_TIMEO	0x00010005	/* set timeout for vfs notification */
(defrecord vfsquery
   (vq_flags :UInt32)
   (vq_spare (:array :UInt32 31))
)
;  vfsquery flags 
(defconstant $VQ_NOTRESP 1)
; #define VQ_NOTRESP	0x0001	/* server down */
(defconstant $VQ_NEEDAUTH 2)
; #define VQ_NEEDAUTH	0x0002	/* server bad auth */
(defconstant $VQ_LOWDISK 4)
; #define VQ_LOWDISK	0x0004	/* we're low on space */
(defconstant $VQ_MOUNT 8)
; #define VQ_MOUNT	0x0008	/* new filesystem arrived */
(defconstant $VQ_UNMOUNT 16)
; #define VQ_UNMOUNT	0x0010	/* filesystem has left */
(defconstant $VQ_DEAD 32)
; #define VQ_DEAD		0x0020	/* filesystem is dead, needs force unmount */
(defconstant $VQ_ASSIST 64)
; #define VQ_ASSIST	0x0040	/* filesystem needs assistance from external
(defconstant $VQ_FLAG0080 128)
; #define VQ_FLAG0080	0x0080	/* placeholder */
(defconstant $VQ_FLAG0100 256)
; #define VQ_FLAG0100	0x0100	/* placeholder */
(defconstant $VQ_FLAG0200 512)
; #define VQ_FLAG0200	0x0200	/* placeholder */
(defconstant $VQ_FLAG0400 1024)
; #define VQ_FLAG0400	0x0400	/* placeholder */
(defconstant $VQ_FLAG0800 2048)
; #define VQ_FLAG0800	0x0800	/* placeholder */
(defconstant $VQ_FLAG1000 4096)
; #define VQ_FLAG1000	0x1000	/* placeholder */
(defconstant $VQ_FLAG2000 8192)
; #define VQ_FLAG2000	0x2000	/* placeholder */
(defconstant $VQ_FLAG4000 16384)
; #define VQ_FLAG4000	0x4000	/* placeholder */
(defconstant $VQ_FLAG8000 32768)
; #define VQ_FLAG8000	0x8000	/* placeholder */
; #ifdef KERNEL
#| #|

#define VCTLTOREQ(vc, req)						\
	do {								\
		(req)->newptr = (vc)->vc_ptr;				\
		(req)->newlen = (vc)->vc_len;				\
		(req)->newidx = 0;					\
	} while (0)
#endif
|#
 |#
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE
extern int maxvfsconf;		
extern struct vfsconf *vfsconf;	
extern int maxvfsslots;		
extern int numused_vfsslots;	

int	vfsconf_add __P((struct	vfsconf *));
int	vfsconf_del __P((char *));


#ifdef__STDC__
struct nameidata;
struct mbuf;
#endif
struct vfsops {
	int	(*vfs_mount)	__P((struct mount *mp, char *path, caddr_t data,
				    struct nameidata *ndp, struct proc *p));
	int	(*vfs_start)	__P((struct mount *mp, int flags,
				    struct proc *p));
	int	(*vfs_unmount)	__P((struct mount *mp, int mntflags,
				    struct proc *p));
	int	(*vfs_root)	__P((struct mount *mp, struct vnode **vpp));
	int	(*vfs_quotactl)	__P((struct mount *mp, int cmds, uid_t uid,
				    caddr_t arg, struct proc *p));
	int	(*vfs_statfs)	__P((struct mount *mp, struct statfs *sbp,
				    struct proc *p));
	int	(*vfs_sync)	__P((struct mount *mp, int waitfor,
				    struct ucred *cred, struct proc *p));
	int	(*vfs_vget)	__P((struct mount *mp, void *ino,
				    struct vnode **vpp));
	int	(*vfs_fhtovp)	__P((struct mount *mp, struct fid *fhp,
				    struct mbuf *nam, struct vnode **vpp,
				    int *exflagsp, struct ucred **credanonp));
	int	(*vfs_vptofh)	__P((struct vnode *vp, struct fid *fhp));
	int	(*vfs_init)	__P((struct vfsconf *));
	int	(*vfs_sysctl)	__P((int *, u_int, void *, size_t *, void *,
				    size_t, struct proc *));
};

#define VFS_MOUNT(MP, PATH, DATA, NDP, P) \
	(*(MP)->mnt_op->vfs_mount)(MP, PATH, DATA, NDP, P)
#define VFS_START(MP, FLAGS, P)	  (*(MP)->mnt_op->vfs_start)(MP, FLAGS, P)
#define VFS_UNMOUNT(MP, FORCE, P) (*(MP)->mnt_op->vfs_unmount)(MP, FORCE, P)
#define VFS_ROOT(MP, VPP)	  (*(MP)->mnt_op->vfs_root)(MP, VPP)
#define VFS_QUOTACTL(MP,C,U,A,P)  (*(MP)->mnt_op->vfs_quotactl)(MP, C, U, A, P)
#define VFS_STATFS(MP, SBP, P)	  (*(MP)->mnt_op->vfs_statfs)(MP, SBP, P)
#define VFS_SYNC(MP, WAIT, C, P)  (*(MP)->mnt_op->vfs_sync)(MP, WAIT, C, P)
#define VFS_VGET(MP, INO, VPP)	  (*(MP)->mnt_op->vfs_vget)(MP, INO, VPP)
#define VFS_FHTOVP(MP, FIDP, NAM, VPP, EXFLG, CRED) \
	(*(MP)->mnt_op->vfs_fhtovp)(MP, FIDP, NAM, VPP, EXFLG, CRED)
#define VFS_VPTOFH(VP, FIDP)	  (*(VP)->v_mount->mnt_op->vfs_vptofh)(VP, FIDP)


struct netcred {
	struct	radix_node netc_rnodes[2];
	int	netc_exflags;
	struct	ucred netc_anon;
};


struct netexport {
	struct	netcred ne_defexported;		      
	struct	radix_node_head *ne_rtable[AF_MAX+1]; 
};


int	vfs_busy __P((struct mount *, int, struct slock *, struct proc *));
int	vfs_export __P((struct mount *, struct netexport *,
	    struct export_args *));
struct	netcred *vfs_export_lookup __P((struct mount *, struct netexport *,
	    struct mbuf *));
void	vfs_getnewfsid __P((struct mount *));
struct	mount *vfs_getvfs __P((fsid_t *));
int	vfs_mountedon __P((struct vnode *));
void	vfs_unbusy __P((struct mount *, struct proc *));
#ifdef__APPLE_API_PRIVATE
int	vfs_mountroot __P((void));
int	vfs_rootmountalloc __P((char *, char *, struct mount **));
void	vfs_unmountall __P((void));
int	safedounmount(struct mount *, int, struct proc *);
int	dounmount(struct mount *, int, struct proc *);
void	vfs_event_signal(fsid_t *, u_int32_t, intptr_t);
void	vfs_event_init(void);
#endif
extern	CIRCLEQ_HEAD(mntlist, mount) mountlist;
extern	struct slock mountlist_slock;

#endif
|#
 |#

; #else /* !KERNEL */

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( const struct fhandle * #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct statfs * #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, fhandle_t * #\) #\)
|#
#|
 confused about __P #\( #\( struct statfs * #\, long #\, int #\) #\)
|#
#|
 confused about __P #\( #\( struct statfs ** #\, int #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, const char * #\, int #\, void * #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, struct statfs * #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, int #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, struct vfsconf * #\) #\)
|#

; #endif /* KERNEL */


; #endif /* !_SYS_MOUNT_H_ */


(provide-interface "mount")