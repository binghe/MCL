(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:stat.h"
; at Sunday July 2,2006 7:31:57 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
;  *	@(#)stat.h	8.9 (Berkeley) 8/17/94
;  
; #ifndef _SYS_STAT_H_
; #define	_SYS_STAT_H_

(require-interface "sys/time")
; #ifndef _POSIX_SOURCE
(defrecord ostat
   (st_dev :UInt16)
                                                ;  inode's device 
   (st_ino :UInt32)
                                                ;  inode's number 
   (st_mode :UInt16)
                                                ;  inode protection mode 
   (st_nlink :UInt16)
                                                ;  number of hard links 
   (st_uid :UInt16)
                                                ;  user ID of the file's owner 
   (st_gid :UInt16)
                                                ;  group ID of the file's group 
   (st_rdev :UInt16)
                                                ;  device type 
   (st_size :SInt32)
                                                ;  file size, in bytes 
   (st_atimespec :TIMESPEC)
                                                ;  time of last access 
   (st_mtimespec :TIMESPEC)
                                                ;  time of last data modification 
   (st_ctimespec :TIMESPEC)
                                                ;  time of last file status change 
   (st_blksize :SInt32)
                                                ;  optimal blocksize for I/O 
   (st_blocks :SInt32)
                                                ;  blocks allocated for file 
   (st_flags :UInt32)
                                                ;  user defined flags for file 
   (st_gen :UInt32)
                                                ;  file generation number 
)

; #endif /* !_POSIX_SOURCE */

(defrecord stat
   (st_dev :SInt32)
                                                ;  inode's device 
   (st_ino :UInt32)
                                                ;  inode's number 
   (st_mode :UInt16)
                                                ;  inode protection mode 
   (st_nlink :UInt16)
                                                ;  number of hard links 
   (st_uid :UInt32)
                                                ;  user ID of the file's owner 
   (st_gid :UInt32)
                                                ;  group ID of the file's group 
   (st_rdev :SInt32)
                                                ;  device type 
; #ifndef _POSIX_SOURCE
   (st_atimespec :TIMESPEC)
                                                ;  time of last access 
   (st_mtimespec :TIMESPEC)
                                                ;  time of last data modification 
   (st_ctimespec :TIMESPEC)
                                                ;  time of last file status change 
#| 
; #else
   (st_atime :signed-long)
                                                ;  time of last access 
   (st_atimensec :signed-long)
                                                ;  nsec of last access 
   (st_mtime :signed-long)
                                                ;  time of last data modification 
   (st_mtimensec :signed-long)
                                                ;  nsec of last data modification 
   (st_ctime :signed-long)
                                                ;  time of last file status change 
   (st_ctimensec :signed-long)
                                                ;  nsec of last file status change 
 |#

; #endif

   (st_size :OFF_T)
                                                ;  file size, in bytes 
   (st_blocks :int64_t)
                                                ;  blocks allocated for file 
   (st_blksize :UInt32)
                                                ;  optimal blocksize for I/O 
   (st_flags :UInt32)
                                                ;  user defined flags for file 
   (st_gen :UInt32)
                                                ;  file generation number 
   (st_lspare :SInt32)
   (st_qspare (:array :int64_t 2))
)
; #ifndef _POSIX_SOURCE
; #define st_atime st_atimespec.tv_sec
; #define st_mtime st_mtimespec.tv_sec
; #define st_ctime st_ctimespec.tv_sec

; #endif

(defconstant $S_ISUID 4000)
; #define	S_ISUID	0004000			/* set user id on execution */
(defconstant $S_ISGID 2000)
; #define	S_ISGID	0002000			/* set group id on execution */
; #ifndef _POSIX_SOURCE
(defconstant $S_ISTXT 1000)
; #define	S_ISTXT	0001000			/* sticky bit */

; #endif

(defconstant $S_IRWXU 700)
; #define	S_IRWXU	0000700			/* RWX mask for owner */
(defconstant $S_IRUSR 400)
; #define	S_IRUSR	0000400			/* R for owner */
(defconstant $S_IWUSR 200)
; #define	S_IWUSR	0000200			/* W for owner */
(defconstant $S_IXUSR 100)
; #define	S_IXUSR	0000100			/* X for owner */
; #ifndef _POSIX_SOURCE
; #define	S_IREAD		S_IRUSR
; #define	S_IWRITE	S_IWUSR
; #define	S_IEXEC		S_IXUSR

; #endif

(defconstant $S_IRWXG 70)
; #define	S_IRWXG	0000070			/* RWX mask for group */
(defconstant $S_IRGRP 40)
; #define	S_IRGRP	0000040			/* R for group */
(defconstant $S_IWGRP 20)
; #define	S_IWGRP	0000020			/* W for group */
(defconstant $S_IXGRP 10)
; #define	S_IXGRP	0000010			/* X for group */
(defconstant $S_IRWXO 7)
; #define	S_IRWXO	0000007			/* RWX mask for other */
(defconstant $S_IROTH 4)
; #define	S_IROTH	0000004			/* R for other */
(defconstant $S_IWOTH 2)
; #define	S_IWOTH	0000002			/* W for other */
(defconstant $S_IXOTH 1)
; #define	S_IXOTH	0000001			/* X for other */
; #ifndef _POSIX_SOURCE
(defconstant $S_IFMT 170000)
; #define	S_IFMT	 0170000		/* type of file mask */
(defconstant $S_IFIFO 10000)
; #define	S_IFIFO	 0010000		/* named pipe (fifo) */
(defconstant $S_IFCHR 20000)
; #define	S_IFCHR	 0020000		/* character special */
(defconstant $S_IFDIR 40000)
; #define	S_IFDIR	 0040000		/* directory */
(defconstant $S_IFBLK 60000)
; #define	S_IFBLK	 0060000		/* block special */
(defconstant $S_IFREG 100000)
; #define	S_IFREG	 0100000		/* regular */
(defconstant $S_IFLNK 120000)
; #define	S_IFLNK	 0120000		/* symbolic link */
(defconstant $S_IFSOCK 140000)
; #define	S_IFSOCK 0140000		/* socket */
(defconstant $S_IFWHT 160000)
; #define	S_IFWHT  0160000		/* whiteout */
(defconstant $S_ISVTX 1000)
; #define	S_ISVTX	 0001000		/* save swapped text even after use */

; #endif

; #define	S_ISDIR(m)	(((m) & 0170000) == 0040000)	/* directory */
; #define	S_ISCHR(m)	(((m) & 0170000) == 0020000)	/* char special */
; #define	S_ISBLK(m)	(((m) & 0170000) == 0060000)	/* block special */
; #define	S_ISREG(m)	(((m) & 0170000) == 0100000)	/* regular file */
; #define	S_ISFIFO(m)	(((m) & 0170000) == 0010000)	/* fifo or socket */
; #ifndef _POSIX_SOURCE
; #define	S_ISLNK(m)	(((m) & 0170000) == 0120000)	/* symbolic link */
; #define	S_ISSOCK(m)	(((m) & 0170000) == 0140000)	/* socket */
; #define	S_ISWHT(m)	(((m) & 0170000) == 0160000)	/* whiteout */

; #endif

; #ifndef _POSIX_SOURCE
(defconstant $ACCESSPERMS 767)
; #define	ACCESSPERMS	(S_IRWXU|S_IRWXG|S_IRWXO)	/* 0777 */
;  7777 
(defconstant $ALLPERMS 4095)
; #define	ALLPERMS	(S_ISUID|S_ISGID|S_ISTXT|S_IRWXU|S_IRWXG|S_IRWXO)
;  0666 
(defconstant $DEFFILEMODE 510)
; #define	DEFFILEMODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH)
(defconstant $S_BLKSIZE 512)
; #define S_BLKSIZE	512		/* block size used in the stat struct */
; 
;  * Definitions of flags stored in file flags word.
;  *
;  * Super-user and owner changeable flags.
;  
(defconstant $UF_SETTABLE 65535)
; #define	UF_SETTABLE	0x0000ffff	/* mask of owner changeable flags */
(defconstant $UF_NODUMP 1)
; #define	UF_NODUMP	0x00000001	/* do not dump file */
(defconstant $UF_IMMUTABLE 2)
; #define	UF_IMMUTABLE	0x00000002	/* file may not be changed */
(defconstant $UF_APPEND 4)
; #define	UF_APPEND	0x00000004	/* writes to file may only append */
(defconstant $UF_OPAQUE 8)
; #define UF_OPAQUE	0x00000008	/* directory is opaque wrt. union */
; 
;  * Super-user changeable flags.
;  
(defconstant $SF_SETTABLE 4294901760)
; #define	SF_SETTABLE	0xffff0000	/* mask of superuser changeable flags */
(defconstant $SF_ARCHIVED 65536)
; #define	SF_ARCHIVED	0x00010000	/* file is archived */
(defconstant $SF_IMMUTABLE 131072)
; #define	SF_IMMUTABLE	0x00020000	/* file may not be changed */
(defconstant $SF_APPEND 262144)
; #define	SF_APPEND	0x00040000	/* writes to file may only append */
; #ifdef KERNEL
#| #|

#define OPAQUE		(UF_OPAQUE)
#define APPEND		(UF_APPEND | SF_APPEND)
#define IMMUTABLE	(UF_IMMUTABLE | SF_IMMUTABLE)
#endif
|#
 |#

; #endif

; #ifndef KERNEL

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( const char * #\, mode_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct stat * #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, mode_t #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, mode_t #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, struct stat * #\) #\)
|#
#|
 confused about __P #\( #\( mode_t #\) #\)
|#
; #ifndef _POSIX_SOURCE
#|
 confused about __P #\( #\( const char * #\, u_long #\) #\)
|#
#|
 confused about __P #\( #\( int #\, u_long #\) #\)
|#
#|
 confused about __P #\( #\( int #\, mode_t #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, struct stat * #\) #\)
|#

; #endif


; #endif


; #endif /* !_SYS_STAT_H_ */


(provide-interface "stat")