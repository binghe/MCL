(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sysctl.h"
; at Sunday July 2,2006 7:31:58 pm.
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
;  * Copyright (c) 1989, 1993
;  *	The Regents of the University of California.  All rights reserved.
;  *
;  * This code is derived from software contributed to Berkeley by
;  * Mike Karels at Berkeley Software Design, Inc.
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
;  *	@(#)sysctl.h	8.1 (Berkeley) 6/2/93
;  
; #ifndef _SYS_SYSCTL_H_
; #define	_SYS_SYSCTL_H_
; 
;  * These are for the eproc structure defined below.
;  

(require-interface "sys/appleapiopts")
; #ifndef KERNEL

(require-interface "sys/time")

(require-interface "sys/ucred")

; #endif


(require-interface "sys/vm")

(require-interface "sys/proc")

(require-interface "sys/linker_set")
; 
;  * Definitions for sysctl call.  The sysctl call uses a hierarchical name
;  * for objects that can be examined or modified.  The name is expressed as
;  * a sequence of integers.  Like a file path name, the meaning of each
;  * component depends on its place in the hierarchy.  The top-level and kern
;  * identifiers are defined here, and other identifiers are defined in the
;  * respective subsystem header files.
;  
(defconstant $CTL_MAXNAME 12)
; #define CTL_MAXNAME	12	/* largest number of components supported */
; 
;  * Each subsystem defined by sysctl defines a list of variables
;  * for that subsystem. Each name is either a node with further 
;  * levels defined below it, or it is a leaf of some particular
;  * type given below. Each sysctl level defines a set of name/type
;  * pairs to be used by sysctl(1) in manipulating the subsystem.
;  
(defrecord ctlname
   (ctl_name (:pointer :char))
                                                ;  subsystem name 
   (ctl_type :signed-long)
                                                ;  type of name 
)
(defconstant $CTLTYPE 15)
; #define CTLTYPE		0xf	/* Mask for the type */
(defconstant $CTLTYPE_NODE 1)
; #define	CTLTYPE_NODE	1	/* name is a node */
(defconstant $CTLTYPE_INT 2)
; #define	CTLTYPE_INT	2	/* name describes an integer */
(defconstant $CTLTYPE_STRING 3)
; #define	CTLTYPE_STRING	3	/* name describes a string */
(defconstant $CTLTYPE_QUAD 4)
; #define	CTLTYPE_QUAD	4	/* name describes a 64-bit number */
(defconstant $CTLTYPE_OPAQUE 5)
; #define	CTLTYPE_OPAQUE	5	/* name describes a structure */
; #define	CTLTYPE_STRUCT	CTLTYPE_OPAQUE	/* name describes a structure */
(defconstant $CTLFLAG_RD 2147483648)
; #define CTLFLAG_RD	0x80000000	/* Allow reads of variable */
(defconstant $CTLFLAG_WR 1073741824)
; #define CTLFLAG_WR	0x40000000	/* Allow writes to the variable */
(defconstant $CTLFLAG_RW 3221225472)
; #define CTLFLAG_RW	(CTLFLAG_RD|CTLFLAG_WR)
(defconstant $CTLFLAG_NOLOCK 536870912)
; #define CTLFLAG_NOLOCK	0x20000000	/* XXX Don't Lock */
(defconstant $CTLFLAG_ANYBODY 268435456)
; #define CTLFLAG_ANYBODY	0x10000000	/* All users can set this var */
(defconstant $CTLFLAG_SECURE 134217728)
; #define CTLFLAG_SECURE	0x08000000	/* Permit set only if securelevel<=0 */
(defconstant $CTLFLAG_MASKED 67108864)
; #define CTLFLAG_MASKED	0x04000000	/* deprecated variable, do not display */
(defconstant $CTLFLAG_NOAUTO 33554432)
; #define CTLFLAG_NOAUTO	0x02000000	/* do not auto-register */
(defconstant $CTLFLAG_KERN 16777216)
; #define CTLFLAG_KERN	0x01000000	/* valid inside the kernel */
; 
;  * USE THIS instead of a hardwired number from the categories below
;  * to get dynamically assigned sysctl entries using the linker-set
;  * technology. This is the way nearly all new sysctl variables should
;  * be implemented.
;  * e.g. SYSCTL_INT(_parent, OID_AUTO, name, CTLFLAG_RW, &variable, 0, "");
;  
(defconstant $OID_AUTO -1)
; #define OID_AUTO	(-1)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE
#define SYSCTL_HANDLER_ARGS (struct sysctl_oid *oidp, void *arg1, int arg2, \
	struct sysctl_req *req)


struct sysctl_req {
	struct proc	*p;
	int		lock;
	void		*oldptr;
	size_t		oldlen;
	size_t		oldidx;
	int		(*oldfunc)(struct sysctl_req *, const void *, size_t);
	void		*newptr;
	size_t		newlen;
	size_t		newidx;
	int		(*newfunc)(struct sysctl_req *, void *, size_t);
};

SLIST_HEAD(sysctl_oid_list, sysctl_oid);


struct sysctl_oid {
	struct sysctl_oid_list *oid_parent;
	SLIST_ENTRY(sysctl_oid) oid_link;
	int		oid_number;
	int		oid_kind;
	void		*oid_arg1;
	int		oid_arg2;
	const char	*oid_name;
	int 		(*oid_handler) SYSCTL_HANDLER_ARGS;
	const char	*oid_fmt;
};

#define SYSCTL_IN(r, p, l) (r->newfunc)(r, p, l)
#define SYSCTL_OUT(r, p, l) (r->oldfunc)(r, p, l)

int sysctl_handle_int SYSCTL_HANDLER_ARGS;
int sysctl_handle_long SYSCTL_HANDLER_ARGS;
int sysctl_handle_quad SYSCTL_HANDLER_ARGS;
int sysctl_handle_int2quad SYSCTL_HANDLER_ARGS;

int sysctl_handle_string SYSCTL_HANDLER_ARGS;
int sysctl_handle_opaque SYSCTL_HANDLER_ARGS;


void sysctl_register_oid(struct sysctl_oid *oidp);
void sysctl_unregister_oid(struct sysctl_oid *oidp);


#define SYSCTL_DECL(name)					\
	extern struct sysctl_oid_list sysctl_
; #name##_children
#COMPILER-DIRECTIVE 

#define SYSCTL_OID(parent, nbr, name, kind, a1, a2, handler, fmt, descr) \
	struct sysctl_oid sysctl_
; #parent##_##name = {		 		&sysctl_##parent##_children, { 0 },			 		nbr, kind, a1, a2, #name, handler, fmt };
#COMPILER-DIRECTIVE 


#define SYSCTL_NODE(parent, nbr, name, access, handler, descr)		    \
	struct sysctl_oid_list sysctl_
; #parent##_##name##_children;	    	SYSCTL_OID(parent, nbr, name, CTLTYPE_NODE|access,		    		   (void*)&sysctl_##parent##_##name##_children, 0, handler, 		   "N", descr);
#COMPILER-DIRECTIVE 

#define SYSCTL_STRING(parent, nbr, name, access, arg, len, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_STRING|access, \
		arg, len, sysctl_handle_string, "A", descr)


#define SYSCTL_INT(parent, nbr, name, access, ptr, val, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_INT|access, \
		ptr, val, sysctl_handle_int, "I", descr)


#define SYSCTL_UINT(parent, nbr, name, access, ptr, val, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_INT|access, \
		ptr, val, sysctl_handle_int, "IU", descr)


#define SYSCTL_LONG(parent, nbr, name, access, ptr, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_INT|access, \
		ptr, 0, sysctl_handle_long, "L", descr)


#define SYSCTL_QUAD(parent, nbr, name, access, ptr, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_QUAD|access, \
		ptr, 0, sysctl_handle_quad, "Q", descr)


#define SYSCTL_INT2QUAD(parent, nbr, name, access, ptr, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_QUAD|access, \
		ptr, 0, sysctl_handle_int2quad, "Q", descr)


#define SYSCTL_OPAQUE(parent, nbr, name, access, ptr, len, fmt, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_OPAQUE|access, \
		ptr, len, sysctl_handle_opaque, fmt, descr)


#define SYSCTL_STRUCT(parent, nbr, name, access, ptr, type, descr) \
	SYSCTL_OID(parent, nbr, name, CTLTYPE_OPAQUE|access, \
		ptr, sizeof(struct type), sysctl_handle_opaque, \
		"S," #type , descr)


#define SYSCTL_PROC(parent, nbr, name, access, ptr, arg, handler, fmt, descr) \
	SYSCTL_OID(parent, nbr, name, access, \
		ptr, arg, handler, fmt, descr)
#endif
#endif
|#
 |#
;  KERNEL 
; 
;  * Top-level identifiers
;  
(defconstant $CTL_UNSPEC 0)
; #define	CTL_UNSPEC	0		/* unused */
(defconstant $CTL_KERN 1)
; #define	CTL_KERN	1		/* "high kernel": proc, limits */
(defconstant $CTL_VM 2)
; #define	CTL_VM		2		/* virtual memory */
(defconstant $CTL_VFS 3)
; #define	CTL_VFS		3		/* file system, mount type is next */
(defconstant $CTL_NET 4)
; #define	CTL_NET		4		/* network, see socket.h */
(defconstant $CTL_DEBUG 5)
; #define	CTL_DEBUG	5		/* debugging parameters */
(defconstant $CTL_HW 6)
; #define	CTL_HW		6		/* generic cpu/io */
(defconstant $CTL_MACHDEP 7)
; #define	CTL_MACHDEP	7		/* machine dependent */
(defconstant $CTL_USER 8)
; #define	CTL_USER	8		/* user-level */
(defconstant $CTL_MAXID 9)
; #define	CTL_MAXID	9		/* number of valid top-level ids */
; #define CTL_NAMES { 	{ 0, 0 }, 	{ "kern", CTLTYPE_NODE }, 	{ "vm", CTLTYPE_NODE }, 	{ "vfs", CTLTYPE_NODE }, 	{ "net", CTLTYPE_NODE }, 	{ "debug", CTLTYPE_NODE }, 	{ "hw", CTLTYPE_NODE }, 	{ "machdep", CTLTYPE_NODE }, 	{ "user", CTLTYPE_NODE }, }
; 
;  * CTL_KERN identifiers
;  
(defconstant $KERN_OSTYPE 1)
; #define	KERN_OSTYPE	 	 1	/* string: system version */
(defconstant $KERN_OSRELEASE 2)
; #define	KERN_OSRELEASE	 	 2	/* string: system release */
(defconstant $KERN_OSREV 3)
; #define	KERN_OSREV	 	 3	/* int: system revision */
(defconstant $KERN_VERSION 4)
; #define	KERN_VERSION	 	 4	/* string: compile time info */
(defconstant $KERN_MAXVNODES 5)
; #define	KERN_MAXVNODES	 	 5	/* int: max vnodes */
(defconstant $KERN_MAXPROC 6)
; #define	KERN_MAXPROC	 	 6	/* int: max processes */
(defconstant $KERN_MAXFILES 7)
; #define	KERN_MAXFILES	 	 7	/* int: max open files */
(defconstant $KERN_ARGMAX 8)
; #define	KERN_ARGMAX	 	 8	/* int: max arguments to exec */
(defconstant $KERN_SECURELVL 9)
; #define	KERN_SECURELVL	 	 9	/* int: system security level */
(defconstant $KERN_HOSTNAME 10)
; #define	KERN_HOSTNAME		10	/* string: hostname */
(defconstant $KERN_HOSTID 11)
; #define	KERN_HOSTID		11	/* int: host identifier */
(defconstant $KERN_CLOCKRATE 12)
; #define	KERN_CLOCKRATE		12	/* struct: struct clockrate */
(defconstant $KERN_VNODE 13)
; #define	KERN_VNODE		13	/* struct: vnode structures */
(defconstant $KERN_PROC 14)
; #define	KERN_PROC		14	/* struct: process entries */
(defconstant $KERN_FILE 15)
; #define	KERN_FILE		15	/* struct: file entries */
(defconstant $KERN_PROF 16)
; #define	KERN_PROF		16	/* node: kernel profiling info */
(defconstant $KERN_POSIX1 17)
; #define	KERN_POSIX1		17	/* int: POSIX.1 version */
(defconstant $KERN_NGROUPS 18)
; #define	KERN_NGROUPS		18	/* int: # of supplemental group ids */
(defconstant $KERN_JOB_CONTROL 19)
; #define	KERN_JOB_CONTROL	19	/* int: is job control available */
(defconstant $KERN_SAVED_IDS 20)
; #define	KERN_SAVED_IDS		20	/* int: saved set-user/group-ID */
(defconstant $KERN_BOOTTIME 21)
; #define	KERN_BOOTTIME		21	/* struct: time kernel was booted */
(defconstant $KERN_NISDOMAINNAME 22)
; #define KERN_NISDOMAINNAME	22	/* string: YP domain name */
; #define KERN_DOMAINNAME		KERN_NISDOMAINNAME
(defconstant $KERN_MAXPARTITIONS 23)
; #define	KERN_MAXPARTITIONS	23	/* int: number of partitions/disk */
(defconstant $KERN_KDEBUG 24)
; #define	KERN_KDEBUG			24	/* int: kernel trace points */
(defconstant $KERN_UPDATEINTERVAL 25)
; #define KERN_UPDATEINTERVAL	25	/* int: update process sleep time */
(defconstant $KERN_OSRELDATE 26)
; #define KERN_OSRELDATE		26	/* int: OS release date */
(defconstant $KERN_NTP_PLL 27)
; #define KERN_NTP_PLL		27	/* node: NTP PLL control */
(defconstant $KERN_BOOTFILE 28)
; #define	KERN_BOOTFILE		28	/* string: name of booted kernel */
(defconstant $KERN_MAXFILESPERPROC 29)
; #define	KERN_MAXFILESPERPROC	29	/* int: max open files per proc */
(defconstant $KERN_MAXPROCPERUID 30)
; #define	KERN_MAXPROCPERUID 	30	/* int: max processes per uid */
(defconstant $KERN_DUMPDEV 31)
; #define KERN_DUMPDEV		31	/* dev_t: device to dump on */
(defconstant $KERN_IPC 32)
; #define	KERN_IPC			32	/* node: anything related to IPC */
(defconstant $KERN_DUMMY 33)
; #define	KERN_DUMMY			33	/* unused */
(defconstant $KERN_PS_STRINGS 34)
; #define	KERN_PS_STRINGS		34	/* int: address of PS_STRINGS */
(defconstant $KERN_USRSTACK 35)
; #define	KERN_USRSTACK		35	/* int: address of USRSTACK */
(defconstant $KERN_LOGSIGEXIT 36)
; #define	KERN_LOGSIGEXIT		36	/* int: do we log sigexit procs? */
(defconstant $KERN_SYMFILE 37)
; #define KERN_SYMFILE		37	/* string: kernel symbol filename */
(defconstant $KERN_PROCARGS 38)
; #define KERN_PROCARGS		38
(defconstant $KERN_PCSAMPLES 39)
; #define KERN_PCSAMPLES		39	/* node: pc sampling */
(defconstant $KERN_NETBOOT 40)
; #define KERN_NETBOOT		40	/* int: are we netbooted? 1=yes,0=no */
(defconstant $KERN_PANICINFO 41)
; #define	KERN_PANICINFO		41	/* node: panic UI information */
(defconstant $KERN_SYSV 42)
; #define	KERN_SYSV			42	/* node: panic UI information */
(defconstant $KERN_AFFINITY 43)
; #define KERN_AFFINITY		43	/* xxx */
(defconstant $KERN_CLASSIC 44)
; #define KERN_CLASSIC	   	44	/* xxx */
(defconstant $KERN_CLASSICHANDLER 45)
; #define KERN_CLASSICHANDLER	45	/* xxx */
(defconstant $KERN_AIOMAX 46)
; #define	KERN_AIOMAX			46	/* int: max aio requests */
(defconstant $KERN_AIOPROCMAX 47)
; #define	KERN_AIOPROCMAX		47	/* int: max aio requests per process */
(defconstant $KERN_AIOTHREADS 48)
; #define	KERN_AIOTHREADS		48	/* int: max aio worker threads */
; #ifdef __APPLE_API_UNSTABLE
#| #|
#define KERN_PROCARGS2			49	
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
(defconstant $KERN_MAXID 50)
; #define	KERN_MAXID			50	/* number of valid kern ids */
;  KERN_KDEBUG types 
(defconstant $KERN_KDEFLAGS 1)
; #define KERN_KDEFLAGS		1
(defconstant $KERN_KDDFLAGS 2)
; #define KERN_KDDFLAGS		2
(defconstant $KERN_KDENABLE 3)
; #define KERN_KDENABLE		3
(defconstant $KERN_KDSETBUF 4)
; #define KERN_KDSETBUF		4
(defconstant $KERN_KDGETBUF 5)
; #define KERN_KDGETBUF		5
(defconstant $KERN_KDSETUP 6)
; #define KERN_KDSETUP		6
(defconstant $KERN_KDREMOVE 7)
; #define KERN_KDREMOVE		7
(defconstant $KERN_KDSETREG 8)
; #define KERN_KDSETREG		8
(defconstant $KERN_KDGETREG 9)
; #define KERN_KDGETREG		9
(defconstant $KERN_KDREADTR 10)
; #define KERN_KDREADTR		10
(defconstant $KERN_KDPIDTR 11)
; #define KERN_KDPIDTR        11
(defconstant $KERN_KDTHRMAP 12)
; #define KERN_KDTHRMAP           12
;  Don't use 13 as it is overloaded with KERN_VNODE 
(defconstant $KERN_KDPIDEX 14)
; #define KERN_KDPIDEX            14
(defconstant $KERN_KDSETRTCDEC 15)
; #define KERN_KDSETRTCDEC        15
(defconstant $KERN_KDGETENTROPY 16)
; #define KERN_KDGETENTROPY       16
;  KERN_PCSAMPLES types 
(defconstant $KERN_PCDISABLE 1)
; #define KERN_PCDISABLE		1
(defconstant $KERN_PCSETBUF 2)
; #define KERN_PCSETBUF	        2
(defconstant $KERN_PCGETBUF 3)
; #define KERN_PCGETBUF		3
(defconstant $KERN_PCSETUP 4)
; #define KERN_PCSETUP		4
(defconstant $KERN_PCREMOVE 5)
; #define KERN_PCREMOVE		5
(defconstant $KERN_PCREADBUF 6)
; #define KERN_PCREADBUF		6
(defconstant $KERN_PCSETREG 7)
; #define KERN_PCSETREG           7
(defconstant $KERN_PCCOMM 8)
; #define KERN_PCCOMM             8
;  KERN_PANICINFO types 
(defconstant $KERN_PANICINFO_MAXSIZE 1)
; #define	KERN_PANICINFO_MAXSIZE	1	/* quad: panic UI image size limit */
(defconstant $KERN_PANICINFO_IMAGE16 2)
; #define	KERN_PANICINFO_IMAGE16	2	/* string: path to the panic UI (16 bit) */
(defconstant $KERN_PANICINFO_IMAGE32 3)
; #define	KERN_PANICINFO_IMAGE32	3	/* string: path to the panic UI (32 bit) */
; 
;  * KERN_SYSV identifiers
;  
(defconstant $KSYSV_SHMMAX 1)
; #define KSYSV_SHMMAX		1	/* int: max shared memory segment size (bytes) */
(defconstant $KSYSV_SHMMIN 2)
; #define	KSYSV_SHMMIN		2	/* int: min shared memory segment size (bytes) */
(defconstant $KSYSV_SHMMNI 3)
; #define	KSYSV_SHMMNI		3	/* int: max number of shared memory identifiers */
(defconstant $KSYSV_SHMSEG 4)
; #define	KSYSV_SHMSEG		4	/* int: max shared memory segments per process */
(defconstant $KSYSV_SHMALL 5)
; #define	KSYSV_SHMALL		5	/* int: max amount of shared memory (pages) */
(defconstant $KSYSV_SEMMNI 6)
; #define KSYSV_SEMMNI		6	/* int: max num of semaphore identifiers  */
(defconstant $KSYSV_SEMMNS 7)
; #define KSYSV_SEMMNS		7	/* int: max num of semaphores in system */
(defconstant $KSYSV_SEMMNU 8)
; #define KSYSV_SEMMNU		8	/* int: max num of undo structures in system  */
(defconstant $KSYSV_SEMMSL 9)
; #define KSYSV_SEMMSL		9	/* int: max num of semaphores per id  */
(defconstant $KSYSV_SEMUNE 10)
; #define KSYSV_SEMUNE		10	/* int: max num of undo entries per process */
; #define CTL_KERN_NAMES { 	{ 0, 0 }, 	{ "ostype", CTLTYPE_STRING }, 	{ "osrelease", CTLTYPE_STRING }, 	{ "osrevision", CTLTYPE_INT }, 	{ "version", CTLTYPE_STRING }, 	{ "maxvnodes", CTLTYPE_INT }, 	{ "maxproc", CTLTYPE_INT }, 	{ "maxfiles", CTLTYPE_INT }, 	{ "argmax", CTLTYPE_INT }, 	{ "securelevel", CTLTYPE_INT }, 	{ "hostname", CTLTYPE_STRING }, 	{ "hostid", CTLTYPE_INT }, 	{ "clockrate", CTLTYPE_STRUCT }, 	{ "vnode", CTLTYPE_STRUCT }, 	{ "proc", CTLTYPE_STRUCT }, 	{ "file", CTLTYPE_STRUCT }, 	{ "profiling", CTLTYPE_NODE }, 	{ "posix1version", CTLTYPE_INT }, 	{ "ngroups", CTLTYPE_INT }, 	{ "job_control", CTLTYPE_INT }, 	{ "saved_ids", CTLTYPE_INT }, 	{ "boottime", CTLTYPE_STRUCT }, 	{ "nisdomainname", CTLTYPE_STRING }, 	{ "maxpartitions", CTLTYPE_INT }, 	{ "kdebug", CTLTYPE_INT }, 	{ "update", CTLTYPE_INT }, 	{ "osreldate", CTLTYPE_INT }, 	{ "ntp_pll", CTLTYPE_NODE }, 	{ "bootfile", CTLTYPE_STRING }, 	{ "maxfilesperproc", CTLTYPE_INT }, 	{ "maxprocperuid", CTLTYPE_INT }, 	{ "dumpdev", CTLTYPE_STRUCT }, /* we lie; don't print as int */ 	{ "ipc", CTLTYPE_NODE }, 	{ "dummy", CTLTYPE_INT }, 	{ "ps_strings", CTLTYPE_INT }, 	{ "usrstack", CTLTYPE_INT }, 	{ "logsigexit", CTLTYPE_INT }, 	{ "symfile",CTLTYPE_STRING },	{ "procargs",CTLTYPE_STRUCT },	{ "pcsamples",CTLTYPE_STRUCT },	{ "netboot", CTLTYPE_INT }, 	{ "panicinfo", CTLTYPE_NODE }, 	{ "sysv", CTLTYPE_NODE }, 	{ "dummy", CTLTYPE_INT }, 	{ "dummy", CTLTYPE_INT }, 	{ "dummy", CTLTYPE_INT }, 	{ "aiomax", CTLTYPE_INT }, 	{ "aioprocmax", CTLTYPE_INT }, 	{ "aiothreads", CTLTYPE_INT }, 	{ "procargs2",CTLTYPE_STRUCT } }
; 
;  * CTL_VFS identifiers
;  
; #define CTL_VFS_NAMES { 	{ "vfsconf", CTLTYPE_STRUCT } }
;  
;  * KERN_PROC subtypes
;  
(defconstant $KERN_PROC_ALL 0)
; #define KERN_PROC_ALL		0	/* everything */
(defconstant $KERN_PROC_PID 1)
; #define	KERN_PROC_PID		1	/* by process id */
(defconstant $KERN_PROC_PGRP 2)
; #define	KERN_PROC_PGRP		2	/* by process group id */
(defconstant $KERN_PROC_SESSION 3)
; #define	KERN_PROC_SESSION	3	/* by session of pid */
(defconstant $KERN_PROC_TTY 4)
; #define	KERN_PROC_TTY		4	/* by controlling tty */
(defconstant $KERN_PROC_UID 5)
; #define	KERN_PROC_UID		5	/* by effective uid */
(defconstant $KERN_PROC_RUID 6)
; #define	KERN_PROC_RUID		6	/* by real uid */
;  
;  * KERN_PROC subtype ops return arrays of augmented proc structures:
;  
; #ifdef __APPLE_API_UNSTABLE
#| #|
struct kinfo_proc {
	struct	extern_proc kp_proc;			
	struct	eproc {
		struct	proc *e_paddr;		
		struct	session *e_sess;	
		struct	pcred e_pcred;		
		struct	ucred e_ucred;		
		struct	 vmspace e_vm;		
		pid_t	e_ppid;			
		pid_t	e_pgid;			
		short	e_jobc;			
		dev_t	e_tdev;			
		pid_t	e_tpgid;		
		struct	session *e_tsess;	
#define WMESGLEN	7
		char	e_wmesg[WMESGLEN+1];	
		segsz_t e_xsize;		
		short	e_xrssize;		
		short	e_xccount;		
		short	e_xswrss;
		long	e_flag;
#define EPROC_CTTY	0x01	
#define EPROC_SLEADER	0x02	
#define COMAPT_MAXLOGNAME	12
		char	e_login[COMAPT_MAXLOGNAME];	
		long	e_spare[4];
	} kp_eproc;
};
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; 
;  * KERN_IPC identifiers
;  
(defconstant $KIPC_MAXSOCKBUF 1)
; #define KIPC_MAXSOCKBUF		1	/* int: max size of a socket buffer */
(defconstant $KIPC_SOCKBUF_WASTE 2)
; #define	KIPC_SOCKBUF_WASTE	2	/* int: wastage factor in sockbuf */
(defconstant $KIPC_SOMAXCONN 3)
; #define	KIPC_SOMAXCONN		3	/* int: max length of connection q */
(defconstant $KIPC_MAX_LINKHDR 4)
; #define	KIPC_MAX_LINKHDR	4	/* int: max length of link header */
(defconstant $KIPC_MAX_PROTOHDR 5)
; #define	KIPC_MAX_PROTOHDR	5	/* int: max length of network header */
(defconstant $KIPC_MAX_HDR 6)
; #define	KIPC_MAX_HDR		6	/* int: max total length of headers */
(defconstant $KIPC_MAX_DATALEN 7)
; #define	KIPC_MAX_DATALEN	7	/* int: max length of data? */
(defconstant $KIPC_MBSTAT 8)
; #define	KIPC_MBSTAT		8	/* struct: mbuf usage statistics */
(defconstant $KIPC_NMBCLUSTERS 9)
; #define	KIPC_NMBCLUSTERS	9	/* int: maximum mbuf clusters */
; 
;  * CTL_VM identifiers
;  
(defconstant $VM_METER 1)
; #define	VM_METER	1		/* struct vmmeter */
(defconstant $VM_LOADAVG 2)
; #define	VM_LOADAVG	2		/* struct loadavg */
(defconstant $VM_MAXID 3)
; #define	VM_MAXID	3		/* number of valid vm ids */
(defconstant $VM_MACHFACTOR 4)
; #define	VM_MACHFACTOR	4		/* struct loadavg with mach factor*/
; #define	CTL_VM_NAMES { 	{ 0, 0 }, 	{ "vmmeter", CTLTYPE_STRUCT }, 	{ "loadavg", CTLTYPE_STRUCT } }
; 
;  * CTL_HW identifiers
;  
(defconstant $HW_MACHINE 1)
; #define	HW_MACHINE	 1		/* string: machine class */
(defconstant $HW_MODEL 2)
; #define	HW_MODEL	 2		/* string: specific machine model */
(defconstant $HW_NCPU 3)
; #define	HW_NCPU		 3		/* int: number of cpus */
(defconstant $HW_BYTEORDER 4)
; #define	HW_BYTEORDER	 4		/* int: machine byte order */
(defconstant $HW_PHYSMEM 5)
; #define	HW_PHYSMEM	 5		/* int: total memory */
(defconstant $HW_USERMEM 6)
; #define	HW_USERMEM	 6		/* int: non-kernel memory */
(defconstant $HW_PAGESIZE 7)
; #define	HW_PAGESIZE	 7		/* int: software page size */
(defconstant $HW_DISKNAMES 8)
; #define	HW_DISKNAMES	 8		/* strings: disk drive names */
(defconstant $HW_DISKSTATS 9)
; #define	HW_DISKSTATS	 9		/* struct: diskstats[] */
(defconstant $HW_EPOCH 10)
; #define	HW_EPOCH  	10		/* int: 0 for Legacy, else NewWorld */
(defconstant $HW_FLOATINGPT 11)
; #define HW_FLOATINGPT	11		/* int: has HW floating point? */
(defconstant $HW_MACHINE_ARCH 12)
; #define HW_MACHINE_ARCH	12		/* string: machine architecture */
(defconstant $HW_VECTORUNIT 13)
; #define HW_VECTORUNIT	13		/* int: has HW vector unit? */
(defconstant $HW_BUS_FREQ 14)
; #define HW_BUS_FREQ	14		/* int: Bus Frequency */
(defconstant $HW_CPU_FREQ 15)
; #define HW_CPU_FREQ	15		/* int: CPU Frequency */
(defconstant $HW_CACHELINE 16)
; #define HW_CACHELINE	16		/* int: Cache Line Size in Bytes */
(defconstant $HW_L1ICACHESIZE 17)
; #define HW_L1ICACHESIZE	17		/* int: L1 I Cache Size in Bytes */
(defconstant $HW_L1DCACHESIZE 18)
; #define HW_L1DCACHESIZE	18		/* int: L1 D Cache Size in Bytes */
(defconstant $HW_L2SETTINGS 19)
; #define HW_L2SETTINGS	19		/* int: L2 Cache Settings */
(defconstant $HW_L2CACHESIZE 20)
; #define HW_L2CACHESIZE	20		/* int: L2 Cache Size in Bytes */
(defconstant $HW_L3SETTINGS 21)
; #define HW_L3SETTINGS	21		/* int: L3 Cache Settings */
(defconstant $HW_L3CACHESIZE 22)
; #define HW_L3CACHESIZE	22		/* int: L3 Cache Size in Bytes */
(defconstant $HW_TB_FREQ 23)
; #define HW_TB_FREQ	23		/* int: Bus Frequency */
(defconstant $HW_MEMSIZE 24)
; #define HW_MEMSIZE	24		/* uint64_t: physical ram size */
(defconstant $HW_AVAILCPU 25)
; #define HW_AVAILCPU	25		/* int: number of available CPUs */
(defconstant $HW_MAXID 26)
; #define	HW_MAXID	26		/* number of valid hw ids */
; #define CTL_HW_NAMES { 	{ 0, 0 }, 	{ "machine", CTLTYPE_STRING }, 	{ "model", CTLTYPE_STRING }, 	{ "ncpu", CTLTYPE_INT }, 	{ "byteorder", CTLTYPE_INT }, 	{ "physmem", CTLTYPE_INT }, 	{ "usermem", CTLTYPE_INT }, 	{ "pagesize", CTLTYPE_INT }, 	{ "disknames", CTLTYPE_STRUCT }, 	{ "diskstats", CTLTYPE_STRUCT }, 	{ "epoch", CTLTYPE_INT }, 	{ "floatingpoint", CTLTYPE_INT }, 	{ "machinearch", CTLTYPE_STRING }, 	{ "vectorunit", CTLTYPE_INT }, 	{ "busfrequency", CTLTYPE_INT }, 	{ "cpufrequency", CTLTYPE_INT }, 	{ "cachelinesize", CTLTYPE_INT }, 	{ "l1icachesize", CTLTYPE_INT }, 	{ "l1dcachesize", CTLTYPE_INT }, 	{ "l2settings", CTLTYPE_INT }, 	{ "l2cachesize", CTLTYPE_INT }, 	{ "l3settings", CTLTYPE_INT }, 	{ "l3cachesize", CTLTYPE_INT }, 	{ "tbfrequency", CTLTYPE_INT }, 	{ "memsize", CTLTYPE_QUAD }, 	{ "availcpu", CTLTYPE_INT } }
; 
;  * These are the support HW selectors for sysctlbyname.  Parameters that are byte count or frequencies are 64 bit numbers.
;  * All other parameters are 32 bit numbers.
;  *
;  *   hw.memsize                - The number of bytes of physical memory in the system.
;  *
;  *   hw.ncpu                   - The number maximum number of processor that could be available this boot.
;  *                               Use this value for sizing of static per processor arrays; i.e. processor load statistics.
;  *
;  *   hw.activecpu              - The number of cpus currently available for executing threads.
;  *                               Use this number to determine the number threads to create in SMP aware applications.
;  *                               This number can change when power management modes are changed.
;  *   
;  *   hw.tbfrequency            - This gives the time base frequency used by the OS and is the basis of all timing services.
;  *                               In general is is better to use mach's or higher level timing services, but this value
;  *                               is needed to convert the PPC Time Base registers to real time.
;  *
;  *   hw.cpufrequency           - These values provide the current, min and max cpu frequency.  The min and max are for
;  *   hw.cpufrequency_max       - all power management modes.  The current frequency is the max frequency in the current mode.
;  *   hw.cpufrequency_min       - All frequencies are in Hz.
;  *
;  *   hw.busfrequency           - These values provide the current, min and max bus frequency.  The min and max are for
;  *   hw.busfrequency_max       - all power management modes.  The current frequency is the max frequency in the current mode.
;  *   hw.busfrequency_min       - All frequencies are in Hz.
;  *
;  *   hw.cputype                - These values provide the mach-o cpu type and subtype.  A complete list is in <mach/machine.h>
;  *   hw.cpusubtype             - These values should be used to determine what processor family the running cpu is from so that
;  *                               the best binary can be chosen, or the best dynamic code generated.  They should not be used
;  *                               to determine if a given processor feature is available.
;  *
;  *   hw.byteorder              - Gives the byte order of the processor.  4321 for big endian, 1234 for little.
;  *
;  *   hw.pagesize               - Gives the size in bytes of the pages used by the processor and VM system.
;  *
;  *   hw.cachelinesize          - Gives the size in bytes of the processor's cache lines.
;  *                               This value should be use to control the strides of loops that use cache control instructions
;  *                               like dcbz, dcbt or dcbst.
;  *
;  *   hw.l1dcachesize           - These values provide the size in bytes of the L1, L2 and L3 caches.  If a cache is not present
;  *   hw.l1icachesize           - then the selector will return and error.
;  *   hw.l2cachesize            -
;  *   hw.l3cachesize            -
;  *
;  *
;  * These are the selectors for optional processor features.  Selectors that return errors are not support on the system.
;  * Supported features will return 1 if they are recommended or 0 if they are supported but are not expected to help performance.
;  * Future versions of these selectors may return larger values as necessary so it is best to test for non zero.
;  *
;  *   hw.optional.floatingpoint - Floating Point Instructions
;  *   hw.optional.altivec       - AltiVec Instructions
;  *   hw.optional.graphicsops   - Graphics Operations
;  *   hw.optional.64bitops      - 64-bit Instructions
;  *   hw.optional.fsqrt         - HW Floating Point Square Root Instruction
;  *   hw.optional.stfiwx        - Store Floating Point as Integer Word Indexed Instructions
;  *   hw.optional.dcba          - Data Cache Block Allocate Instruction
;  *   hw.optional.datastreams   - Data Streams Instructions
;  *   hw.optional.dcbtstreams   - Data Cache Block Touch Steams Instruction Form
;  *
;  
; 
;  * CTL_USER definitions
;  
(defconstant $USER_CS_PATH 1)
; #define	USER_CS_PATH		 1	/* string: _CS_PATH */
(defconstant $USER_BC_BASE_MAX 2)
; #define	USER_BC_BASE_MAX	 2	/* int: BC_BASE_MAX */
(defconstant $USER_BC_DIM_MAX 3)
; #define	USER_BC_DIM_MAX		 3	/* int: BC_DIM_MAX */
(defconstant $USER_BC_SCALE_MAX 4)
; #define	USER_BC_SCALE_MAX	 4	/* int: BC_SCALE_MAX */
(defconstant $USER_BC_STRING_MAX 5)
; #define	USER_BC_STRING_MAX	 5	/* int: BC_STRING_MAX */
(defconstant $USER_COLL_WEIGHTS_MAX 6)
; #define	USER_COLL_WEIGHTS_MAX	 6	/* int: COLL_WEIGHTS_MAX */
(defconstant $USER_EXPR_NEST_MAX 7)
; #define	USER_EXPR_NEST_MAX	 7	/* int: EXPR_NEST_MAX */
(defconstant $USER_LINE_MAX 8)
; #define	USER_LINE_MAX		 8	/* int: LINE_MAX */
(defconstant $USER_RE_DUP_MAX 9)
; #define	USER_RE_DUP_MAX		 9	/* int: RE_DUP_MAX */
(defconstant $USER_POSIX2_VERSION 10)
; #define	USER_POSIX2_VERSION	10	/* int: POSIX2_VERSION */
(defconstant $USER_POSIX2_C_BIND 11)
; #define	USER_POSIX2_C_BIND	11	/* int: POSIX2_C_BIND */
(defconstant $USER_POSIX2_C_DEV 12)
; #define	USER_POSIX2_C_DEV	12	/* int: POSIX2_C_DEV */
(defconstant $USER_POSIX2_CHAR_TERM 13)
; #define	USER_POSIX2_CHAR_TERM	13	/* int: POSIX2_CHAR_TERM */
(defconstant $USER_POSIX2_FORT_DEV 14)
; #define	USER_POSIX2_FORT_DEV	14	/* int: POSIX2_FORT_DEV */
(defconstant $USER_POSIX2_FORT_RUN 15)
; #define	USER_POSIX2_FORT_RUN	15	/* int: POSIX2_FORT_RUN */
(defconstant $USER_POSIX2_LOCALEDEF 16)
; #define	USER_POSIX2_LOCALEDEF	16	/* int: POSIX2_LOCALEDEF */
(defconstant $USER_POSIX2_SW_DEV 17)
; #define	USER_POSIX2_SW_DEV	17	/* int: POSIX2_SW_DEV */
(defconstant $USER_POSIX2_UPE 18)
; #define	USER_POSIX2_UPE		18	/* int: POSIX2_UPE */
(defconstant $USER_STREAM_MAX 19)
; #define	USER_STREAM_MAX		19	/* int: POSIX2_STREAM_MAX */
(defconstant $USER_TZNAME_MAX 20)
; #define	USER_TZNAME_MAX		20	/* int: POSIX2_TZNAME_MAX */
(defconstant $USER_MAXID 21)
; #define	USER_MAXID		21	/* number of valid user ids */
; #define	CTL_USER_NAMES { 	{ 0, 0 }, 	{ "cs_path", CTLTYPE_STRING }, 	{ "bc_base_max", CTLTYPE_INT }, 	{ "bc_dim_max", CTLTYPE_INT }, 	{ "bc_scale_max", CTLTYPE_INT }, 	{ "bc_string_max", CTLTYPE_INT }, 	{ "coll_weights_max", CTLTYPE_INT }, 	{ "expr_nest_max", CTLTYPE_INT }, 	{ "line_max", CTLTYPE_INT }, 	{ "re_dup_max", CTLTYPE_INT }, 	{ "posix2_version", CTLTYPE_INT }, 	{ "posix2_c_bind", CTLTYPE_INT }, 	{ "posix2_c_dev", CTLTYPE_INT }, 	{ "posix2_char_term", CTLTYPE_INT }, 	{ "posix2_fort_dev", CTLTYPE_INT }, 	{ "posix2_fort_run", CTLTYPE_INT }, 	{ "posix2_localedef", CTLTYPE_INT }, 	{ "posix2_sw_dev", CTLTYPE_INT }, 	{ "posix2_upe", CTLTYPE_INT }, 	{ "stream_max", CTLTYPE_INT }, 	{ "tzname_max", CTLTYPE_INT } }
; 
;  * CTL_DEBUG definitions
;  *
;  * Second level identifier specifies which debug variable.
;  * Third level identifier specifies which stucture component.
;  
(defconstant $CTL_DEBUG_NAME 0)
; #define	CTL_DEBUG_NAME		0	/* string: variable name */
(defconstant $CTL_DEBUG_VALUE 1)
; #define	CTL_DEBUG_VALUE		1	/* int: variable value */
(defconstant $CTL_DEBUG_MAXID 20)
; #define	CTL_DEBUG_MAXID		20
; #ifdef	KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE

extern struct sysctl_oid_list sysctl__children;
SYSCTL_DECL(_kern);
SYSCTL_DECL(_sysctl);
SYSCTL_DECL(_vm);
SYSCTL_DECL(_vfs);
SYSCTL_DECL(_net);
SYSCTL_DECL(_debug);
SYSCTL_DECL(_hw);
SYSCTL_DECL(_machdep);
SYSCTL_DECL(_user);


#ifdefDEBUG

struct ctldebug {
	char	*debugname;	
	int	*debugvar;	
};
extern struct ctldebug debug0, debug1, debug2, debug3, debug4;
extern struct ctldebug debug5, debug6, debug7, debug8, debug9;
extern struct ctldebug debug10, debug11, debug12, debug13, debug14;
extern struct ctldebug debug15, debug16, debug17, debug18, debug19;
#endif

extern char	machine[];
extern char	osrelease[];
extern char	ostype[];

struct linker_set;

void	sysctl_register_set(struct linker_set *lsp);
void	sysctl_unregister_set(struct linker_set *lsp);
void	sysctl_mib_init(void);
int	kernel_sysctl(struct proc *p, int *name, u_int namelen, void *old,
		      size_t *oldlenp, void *newp, size_t newlen);
int	userland_sysctl(struct proc *p, int *name, u_int namelen, void *old,
			size_t *oldlenp, int inkernel, void *newp, size_t newlen,
			size_t *retval);


int	sysctlbyname __P((const char *, void *, size_t *, void *, size_t));


typedef int (sysctlfn)
    __P((int *, u_int, void *, size_t *, void *, size_t, struct proc *));

int sysctl_int __P((void *, size_t *, void *, size_t, int *));
int sysctl_rdint __P((void *, size_t *, void *, int));
int sysctl_quad __P((void *, size_t *, void *, size_t, quad_t *));
int sysctl_rdquad __P((void *, size_t *, void *, quad_t));
int sysctl_string __P((void *, size_t *, void *, size_t, char *, int));
int sysctl_rdstring __P((void *, size_t *, void *, char *));
int sysctl_rdstruct __P((void *, size_t *, void *, void *, int));

#endif
|#
 |#

; #else	/* !KERNEL */

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( int * #\, u_int #\, void * #\, size_t * #\, void * #\, size_t #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, void * #\, size_t * #\, void * #\, size_t #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, int * #\, size_t * #\) #\)
|#

; #endif	/* KERNEL */


; #endif	/* !_SYS_SYSCTL_H_ */


(provide-interface "sysctl")