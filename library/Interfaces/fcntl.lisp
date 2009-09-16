(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:fcntl.h"
; at Sunday July 2,2006 7:27:51 pm.
; 
;  * Copyright (c) 2000-2001 Apple Computer, Inc. All rights reserved.
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
;  * Copyright (c) 1983, 1990, 1993
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
;  *	@(#)fcntl.h	8.3 (Berkeley) 1/21/94
;  
; #ifndef _SYS_FCNTL_H_
; #define	_SYS_FCNTL_H_
; 
;  * This file includes the definitions for open and fcntl
;  * described by POSIX for <fcntl.h>; it also includes
;  * related kernel definitions.
;  
; #ifndef KERNEL

(require-interface "sys/types")

; #endif

; 
;  * File status flags: these are used by open(2), fcntl(2).
;  * They are also used (indirectly) in the kernel file structure f_flags,
;  * which is a superset of the open/fcntl flags.  Open flags and f_flags
;  * are inter-convertible using OFLAGS(fflags) and FFLAGS(oflags).
;  * Open/fcntl flags begin with O_; kernel-internal flags begin with F.
;  
;  open-only flags 
(defconstant $O_RDONLY 0)
; #define	O_RDONLY	0x0000		/* open for reading only */
(defconstant $O_WRONLY 1)
; #define	O_WRONLY	0x0001		/* open for writing only */
(defconstant $O_RDWR 2)
; #define	O_RDWR		0x0002		/* open for reading and writing */
(defconstant $O_ACCMODE 3)
; #define	O_ACCMODE	0x0003		/* mask for above modes */
; 
;  * Kernel encoding of open mode; separate read and write bits that are
;  * independently testable: 1 greater than the above.
;  *
;  * XXX
;  * FREAD and FWRITE are excluded from the #ifdef KERNEL so that TIOCFLUSH,
;  * which was documented to use FREAD/FWRITE, continues to work.
;  
; #ifndef _POSIX_SOURCE
(defconstant $FREAD 1)
; #define	FREAD		0x0001
(defconstant $FWRITE 2)
; #define	FWRITE		0x0002

; #endif

(defconstant $O_NONBLOCK 4)
; #define	O_NONBLOCK	0x0004		/* no delay */
(defconstant $O_APPEND 8)
; #define	O_APPEND	0x0008		/* set append mode */
; #ifndef _POSIX_SOURCE
(defconstant $O_SHLOCK 16)
; #define	O_SHLOCK	0x0010		/* open with shared file lock */
(defconstant $O_EXLOCK 32)
; #define	O_EXLOCK	0x0020		/* open with exclusive file lock */
(defconstant $O_ASYNC 64)
; #define	O_ASYNC		0x0040		/* signal pgrp when data ready */
(defconstant $O_FSYNC 128)
; #define	O_FSYNC		0x0080		/* synchronous writes */
(defconstant $O_NOFOLLOW 256)
; #define O_NOFOLLOW  0x0100      /* don't follow symlinks */

; #endif

(defconstant $O_CREAT 512)
; #define	O_CREAT		0x0200		/* create if nonexistant */
(defconstant $O_TRUNC 1024)
; #define	O_TRUNC		0x0400		/* truncate to zero length */
(defconstant $O_EXCL 2048)
; #define	O_EXCL		0x0800		/* error if already exists */
; #ifdef KERNEL
#| #|
#define FMARK		0x1000		
#define FDEFER		0x2000		
#define FHASLOCK	0x4000		
#endif
|#
 |#
; #ifndef _POSIX_SOURCE
(defconstant $O_EVTONLY 32768)
; #define	O_EVTONLY	0x8000		/* descriptor requested for event notifications only */

; #endif

;  defined by POSIX 1003.1; BSD default, so no bit required 
(defconstant $O_NOCTTY 0)
; #define	O_NOCTTY	0		/* don't assign controlling terminal */
; #ifdef KERNEL
#| #|

#define FFLAGS(oflags)	((oflags) + 1)
#define OFLAGS(fflags)	((fflags) - 1)


#define FMASK		(FREAD|FWRITE|FAPPEND|FASYNC|FFSYNC|FNONBLOCK)

#define FCNTLFLAGS	(FAPPEND|FASYNC|FFSYNC|FNONBLOCK)
#endif
|#
 |#
; 
;  * The O_* flags used to have only F* names, which were used in the kernel
;  * and by fcntl.  We retain the F* names for the kernel f_flags field
;  * and for backward compatibility for fcntl.
;  
; #ifndef _POSIX_SOURCE
; #define	FAPPEND		O_APPEND	/* kernel/compat */
; #define	FASYNC		O_ASYNC		/* kernel/compat */
; #define	FFSYNC		O_FSYNC		/* kernel */
; #define	FNONBLOCK	O_NONBLOCK	/* kernel */
; #define	FNDELAY		O_NONBLOCK	/* compat */
; #define	O_NDELAY	O_NONBLOCK	/* compat */

; #endif

; 
;  * Flags used for copyfile(2)
;  
; #ifndef _POSIX_SOURCE
(defconstant $CPF_OVERWRITE 1)
; #define CPF_OVERWRITE 1
(defconstant $CPF_IGNORE_MODE 2)
; #define CPF_IGNORE_MODE 2
(defconstant $CPF_MASK 3)
; #define CPF_MASK (CPF_OVERWRITE|CPF_IGNORE_MODE)

; #endif

; 
;  * Constants used for fcntl(2)
;  
;  command values 
(defconstant $F_DUPFD 0)
; #define	F_DUPFD		0		/* duplicate file descriptor */
(defconstant $F_GETFD 1)
; #define	F_GETFD		1		/* get file descriptor flags */
(defconstant $F_SETFD 2)
; #define	F_SETFD		2		/* set file descriptor flags */
(defconstant $F_GETFL 3)
; #define	F_GETFL		3		/* get file status flags */
(defconstant $F_SETFL 4)
; #define	F_SETFL		4		/* set file status flags */
; #ifndef _POSIX_SOURCE
(defconstant $F_GETOWN 5)
; #define	F_GETOWN	5		/* get SIGIO/SIGURG proc/pgrp */
(defconstant $F_SETOWN 6)
; #define F_SETOWN	6		/* set SIGIO/SIGURG proc/pgrp */

; #endif

(defconstant $F_GETLK 7)
; #define	F_GETLK		7		/* get record locking information */
(defconstant $F_SETLK 8)
; #define	F_SETLK		8		/* set record locking information */
(defconstant $F_SETLKW 9)
; #define	F_SETLKW	9		/* F_SETLK; wait if blocked */
(defconstant $F_CHKCLEAN 41)
; #define F_CHKCLEAN      41              /* Used for regression test */
(defconstant $F_PREALLOCATE 42)
; #define F_PREALLOCATE   42		/* Preallocate storage */
(defconstant $F_SETSIZE 43)
; #define F_SETSIZE       43		/* Truncate a file without zeroing space */	
(defconstant $F_RDADVISE 44)
; #define F_RDADVISE      44              /* Issue an advisory read async with no copy to user */
(defconstant $F_RDAHEAD 45)
; #define F_RDAHEAD       45              /* turn read ahead off/on */
(defconstant $F_READBOOTSTRAP 46)
; #define F_READBOOTSTRAP 46              /* Read bootstrap from disk */
(defconstant $F_WRITEBOOTSTRAP 47)
; #define F_WRITEBOOTSTRAP 47             /* Write bootstrap on disk */
(defconstant $F_NOCACHE 48)
; #define F_NOCACHE       48              /* turning data caching off/on */
(defconstant $F_LOG2PHYS 49)
; #define F_LOG2PHYS	49		/* file offset to device offset */
(defconstant $F_GETPATH 50)
; #define F_GETPATH       50              /* return the full path of the fd */
(defconstant $F_FULLFSYNC 51)
; #define F_FULLFSYNC     51		/* fsync + ask the drive to flush to the media */
;  file descriptor flags (F_GETFD, F_SETFD) 
(defconstant $FD_CLOEXEC 1)
; #define	FD_CLOEXEC	1		/* close-on-exec flag */
;  record locking flags (F_GETLK, F_SETLK, F_SETLKW) 
(defconstant $F_RDLCK 1)
; #define	F_RDLCK		1		/* shared or read lock */
(defconstant $F_UNLCK 2)
; #define	F_UNLCK		2		/* unlock */
(defconstant $F_WRLCK 3)
; #define	F_WRLCK		3		/* exclusive or write lock */
; #ifdef KERNEL
#| #|
#define F_WAIT		0x010		
#define F_FLOCK		0x020	 	
#define F_POSIX		0x040	 	
#endif
|#
 |#
;  allocate flags (F_PREALLOCATE) 
(defconstant $F_ALLOCATECONTIG 2)
; #define F_ALLOCATECONTIG  0x00000002    /* allocate contigious space */
(defconstant $F_ALLOCATEALL 4)
; #define F_ALLOCATEALL     0x00000004	/* allocate all requested space or no space at all */
;  Position Modes (fst_posmode) for F_PREALLOCATE 
(defconstant $F_PEOFPOSMODE 3)
; #define F_PEOFPOSMODE 3			/* Make it past all of the SEEK pos modes so that */
;  we can keep them in sync should we desire 
(defconstant $F_VOLPOSMODE 4)
; #define F_VOLPOSMODE	4		/* specify volume starting postion */
; 
;  * Advisory file segment locking data type -
;  * information passed to system by user
;  
(defrecord flock
   (l_start :OFF_T)
                                                ;  starting offset 
   (l_len :OFF_T)
                                                ;  len = 0 means until end of file 
   (l_pid :SInt32)
                                                ;  lock owner 
   (l_type :SInt16)
                                                ;  lock type: read/write, etc. 
   (l_whence :SInt16)
                                                ;  type of l_start 
)
; 
;  * advisory file read data type -
;  * information passed by user to system
;  
(defrecord radvisory
   (ra_offset :OFF_T)
   (ra_count :signed-long)
)
; #ifndef _POSIX_SOURCE
;  lock operations for flock(2) 
(defconstant $LOCK_SH 1)
; #define	LOCK_SH		0x01		/* shared file lock */
(defconstant $LOCK_EX 2)
; #define	LOCK_EX		0x02		/* exclusive file lock */
(defconstant $LOCK_NB 4)
; #define	LOCK_NB		0x04		/* don't block when locking */
(defconstant $LOCK_UN 8)
; #define	LOCK_UN		0x08		/* unlock file */

; #endif

;   fstore_t type used by F_DEALLOCATE and F_PREALLOCATE commands 
(defrecord fstore
   (fst_flags :UInt32)
                                                ;  IN: flags word 
   (fst_posmode :signed-long)
                                                ;  IN: indicates use of offset field 
   (fst_offset :OFF_T)
                                                ;  IN: start of the region 
   (fst_length :OFF_T)
                                                ;  IN: size of the region 
   (fst_bytesalloc :OFF_T)
                                                ;  OUT: number of bytes allocated 
)
(%define-record :fstore_t (find-record-descriptor :FSTORE))
;  fbootstraptransfer_t used by F_READBOOTSTRAP and F_WRITEBOOTSTRAP commands 
(defrecord fbootstraptransfer
   (fbt_offset :OFF_T)                          ;  IN: offset to start read/write 
   (fbt_length :unsigned-long)                  ;  IN: number of bytes to transfer 
   (fbt_buffer :pointer)                        ;  IN: buffer to be read/written 
)
(%define-record :fbootstraptransfer_t (find-record-descriptor :FBOOTSTRAPTRANSFER))
; 
;  * For F_LOG2PHYS this information is passed back to user
;  * Currently only devoffset is returned - that is the VOP_BMAP
;  * result - the disk device address corresponding to the
;  * current file offset (likely set with an lseek).
;  *
;  * The flags could hold an indication of whether the # of 
;  * contiguous bytes reflects the true extent length on disk,
;  * or is an advisory value that indicates there is at least that
;  * many bytes contiguous.  For some filesystems it might be too
;  * inefficient to provide anything beyond the advisory value.
;  * Flags and contiguous bytes return values are not yet implemented.
;  * For them the fcntl will nedd to switch from using BMAP to CMAP
;  * and a per filesystem type flag will be needed to interpret the
;  * contiguous bytes count result from CMAP.
;  
(defrecord log2phys
   (l2p_flags :UInt32)
                                                ;  unused so far 
   (l2p_contigbytes :OFF_T)
                                                ;  unused so far 
   (l2p_devoffset :OFF_T)
                                                ;  bytes into device 
)
; #ifndef _POSIX_SOURCE
(defconstant $O_POPUP 2147483648)
; #define	O_POPUP	   0x80000000   /* force window to popup on open */
(defconstant $O_ALERT 536870912)
; #define	O_ALERT	   0x20000000	/* small, clean popup window */

; #endif

; #ifndef KERNEL

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( const char * #\, int #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, mode_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, \... #\) #\)
|#
; #ifndef _POSIX_SOURCE
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#

; #endif /* !_POSIX_SOURCE */


; #endif


; #endif /* !_SYS_FCNTL_H_ */


(provide-interface "fcntl")