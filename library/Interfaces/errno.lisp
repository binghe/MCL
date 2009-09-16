(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:errno.h"
; at Sunday July 2,2006 7:22:56 pm.
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
;  *	@(#)errno.h	8.5 (Berkeley) 1/21/94
;  
; #ifndef	_SYS_ERRNO_H_
; #define	_SYS_ERRNO_H_

; #if !defined(KERNEL) && !defined(KERNEL_PRIVATE)

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( void #\) #\)
|#
; #define errno (*__error())

; #endif

; 
;  * Error codes
;  
(defconstant $EPERM 1)
; #define	EPERM		1		/* Operation not permitted */
(defconstant $ENOENT 2)
; #define	ENOENT		2		/* No such file or directory */
(defconstant $ESRCH 3)
; #define	ESRCH		3		/* No such process */
(defconstant $EINTR 4)
; #define	EINTR		4		/* Interrupted system call */
(defconstant $EIO 5)
; #define	EIO		5		/* Input/output error */
(defconstant $ENXIO 6)
; #define	ENXIO		6		/* Device not configured */
(defconstant $E2BIG 7)
; #define	E2BIG		7		/* Argument list too long */
(defconstant $ENOEXEC 8)
; #define	ENOEXEC		8		/* Exec format error */
(defconstant $EBADF 9)
; #define	EBADF		9		/* Bad file descriptor */
(defconstant $ECHILD 10)
; #define	ECHILD		10		/* No child processes */
(defconstant $EDEADLK 11)
; #define	EDEADLK		11		/* Resource deadlock avoided */
;  11 was EAGAIN 
(defconstant $ENOMEM 12)
; #define	ENOMEM		12		/* Cannot allocate memory */
(defconstant $EACCES 13)
; #define	EACCES		13		/* Permission denied */
(defconstant $EFAULT 14)
; #define	EFAULT		14		/* Bad address */
; #ifndef _POSIX_SOURCE
(defconstant $ENOTBLK 15)
; #define	ENOTBLK		15		/* Block device required */

; #endif

(defconstant $EBUSY 16)
; #define	EBUSY		16		/* Device busy */
(defconstant $EEXIST 17)
; #define	EEXIST		17		/* File exists */
(defconstant $EXDEV 18)
; #define	EXDEV		18		/* Cross-device link */
(defconstant $ENODEV 19)
; #define	ENODEV		19		/* Operation not supported by device */
(defconstant $ENOTDIR 20)
; #define	ENOTDIR		20		/* Not a directory */
(defconstant $EISDIR 21)
; #define	EISDIR		21		/* Is a directory */
(defconstant $EINVAL 22)
; #define	EINVAL		22		/* Invalid argument */
(defconstant $ENFILE 23)
; #define	ENFILE		23		/* Too many open files in system */
(defconstant $EMFILE 24)
; #define	EMFILE		24		/* Too many open files */
(defconstant $ENOTTY 25)
; #define	ENOTTY		25		/* Inappropriate ioctl for device */
; #ifndef _POSIX_SOURCE
(defconstant $ETXTBSY 26)
; #define	ETXTBSY		26		/* Text file busy */

; #endif

(defconstant $EFBIG 27)
; #define	EFBIG		27		/* File too large */
(defconstant $ENOSPC 28)
; #define	ENOSPC		28		/* No space left on device */
(defconstant $ESPIPE 29)
; #define	ESPIPE		29		/* Illegal seek */
(defconstant $EROFS 30)
; #define	EROFS		30		/* Read-only file system */
(defconstant $EMLINK 31)
; #define	EMLINK		31		/* Too many links */
(defconstant $EPIPE 32)
; #define	EPIPE		32		/* Broken pipe */
;  math software 
(defconstant $EDOM 33)
; #define	EDOM		33		/* Numerical argument out of domain */
(defconstant $ERANGE 34)
; #define	ERANGE		34		/* Result too large */
;  non-blocking and interrupt i/o 
(defconstant $EAGAIN 35)
; #define	EAGAIN		35		/* Resource temporarily unavailable */
; #ifndef _POSIX_SOURCE
; #define	EWOULDBLOCK	EAGAIN		/* Operation would block */
(defconstant $EINPROGRESS 36)
; #define	EINPROGRESS	36		/* Operation now in progress */
(defconstant $EALREADY 37)
; #define	EALREADY	37		/* Operation already in progress */
;  ipc/network software -- argument errors 
(defconstant $ENOTSOCK 38)
; #define	ENOTSOCK	38		/* Socket operation on non-socket */
(defconstant $EDESTADDRREQ 39)
; #define	EDESTADDRREQ	39		/* Destination address required */
(defconstant $EMSGSIZE 40)
; #define	EMSGSIZE	40		/* Message too long */
(defconstant $EPROTOTYPE 41)
; #define	EPROTOTYPE	41		/* Protocol wrong type for socket */
(defconstant $ENOPROTOOPT 42)
; #define	ENOPROTOOPT	42		/* Protocol not available */
(defconstant $EPROTONOSUPPORT 43)
; #define	EPROTONOSUPPORT	43		/* Protocol not supported */
(defconstant $ESOCKTNOSUPPORT 44)
; #define	ESOCKTNOSUPPORT	44		/* Socket type not supported */

; #endif /* ! _POSIX_SOURCE */

(defconstant $ENOTSUP 45)
; #define ENOTSUP	45		/* Operation not supported */
; #ifndef _POSIX_SOURCE
; #define	EOPNOTSUPP	 ENOTSUP		/* Operation not supported */
(defconstant $EPFNOSUPPORT 46)
; #define	EPFNOSUPPORT	46		/* Protocol family not supported */
(defconstant $EAFNOSUPPORT 47)
; #define	EAFNOSUPPORT	47		/* Address family not supported by protocol family */
(defconstant $EADDRINUSE 48)
; #define	EADDRINUSE	48		/* Address already in use */
(defconstant $EADDRNOTAVAIL 49)
; #define	EADDRNOTAVAIL	49		/* Can't assign requested address */
;  ipc/network software -- operational errors 
(defconstant $ENETDOWN 50)
; #define	ENETDOWN	50		/* Network is down */
(defconstant $ENETUNREACH 51)
; #define	ENETUNREACH	51		/* Network is unreachable */
(defconstant $ENETRESET 52)
; #define	ENETRESET	52		/* Network dropped connection on reset */
(defconstant $ECONNABORTED 53)
; #define	ECONNABORTED	53		/* Software caused connection abort */
(defconstant $ECONNRESET 54)
; #define	ECONNRESET	54		/* Connection reset by peer */
(defconstant $ENOBUFS 55)
; #define	ENOBUFS		55		/* No buffer space available */
(defconstant $EISCONN 56)
; #define	EISCONN		56		/* Socket is already connected */
(defconstant $ENOTCONN 57)
; #define	ENOTCONN	57		/* Socket is not connected */
(defconstant $ESHUTDOWN 58)
; #define	ESHUTDOWN	58		/* Can't send after socket shutdown */
(defconstant $ETOOMANYREFS 59)
; #define	ETOOMANYREFS	59		/* Too many references: can't splice */
(defconstant $ETIMEDOUT 60)
; #define	ETIMEDOUT	60		/* Operation timed out */
(defconstant $ECONNREFUSED 61)
; #define	ECONNREFUSED	61		/* Connection refused */
(defconstant $ELOOP 62)
; #define	ELOOP		62		/* Too many levels of symbolic links */

; #endif /* _POSIX_SOURCE */

(defconstant $ENAMETOOLONG 63)
; #define	ENAMETOOLONG	63		/* File name too long */
;  should be rearranged 
; #ifndef _POSIX_SOURCE
(defconstant $EHOSTDOWN 64)
; #define	EHOSTDOWN	64		/* Host is down */
(defconstant $EHOSTUNREACH 65)
; #define	EHOSTUNREACH	65		/* No route to host */

; #endif /* _POSIX_SOURCE */

(defconstant $ENOTEMPTY 66)
; #define	ENOTEMPTY	66		/* Directory not empty */
;  quotas & mush 
; #ifndef _POSIX_SOURCE
(defconstant $EPROCLIM 67)
; #define	EPROCLIM	67		/* Too many processes */
(defconstant $EUSERS 68)
; #define	EUSERS		68		/* Too many users */
(defconstant $EDQUOT 69)
; #define	EDQUOT		69		/* Disc quota exceeded */
;  Network File System 
(defconstant $ESTALE 70)
; #define	ESTALE		70		/* Stale NFS file handle */
(defconstant $EREMOTE 71)
; #define	EREMOTE		71		/* Too many levels of remote in path */
(defconstant $EBADRPC 72)
; #define	EBADRPC		72		/* RPC struct is bad */
(defconstant $ERPCMISMATCH 73)
; #define	ERPCMISMATCH	73		/* RPC version wrong */
(defconstant $EPROGUNAVAIL 74)
; #define	EPROGUNAVAIL	74		/* RPC prog. not avail */
(defconstant $EPROGMISMATCH 75)
; #define	EPROGMISMATCH	75		/* Program version wrong */
(defconstant $EPROCUNAVAIL 76)
; #define	EPROCUNAVAIL	76		/* Bad procedure for program */

; #endif /* _POSIX_SOURCE */

(defconstant $ENOLCK 77)
; #define	ENOLCK		77		/* No locks available */
(defconstant $ENOSYS 78)
; #define	ENOSYS		78		/* Function not implemented */
; #ifndef _POSIX_SOURCE
(defconstant $EFTYPE 79)
; #define	EFTYPE		79		/* Inappropriate file type or format */
(defconstant $EAUTH 80)
; #define	EAUTH		80		/* Authentication error */
(defconstant $ENEEDAUTH 81)
; #define	ENEEDAUTH	81		/* Need authenticator */

; #endif /* _POSIX_SOURCE */

;  Intelligent device errors 
(defconstant $EPWROFF 82)
; #define	EPWROFF		82	/* Device power is off */
(defconstant $EDEVERR 83)
; #define	EDEVERR		83	/* Device error, e.g. paper out */
; #ifndef _POSIX_SOURCE
(defconstant $EOVERFLOW 84)
; #define	EOVERFLOW	84		/* Value too large to be stored in data type */
;  Program loading errors 
(defconstant $EBADEXEC 85)
; #define EBADEXEC	85	/* Bad executable */
(defconstant $EBADARCH 86)
; #define EBADARCH	86	/* Bad CPU type in executable */
(defconstant $ESHLIBVERS 87)
; #define ESHLIBVERS	87	/* Shared library version mismatch */
(defconstant $EBADMACHO 88)
; #define EBADMACHO	88	/* Malformed Macho file */
(defconstant $ECANCELED 89)
; #define	ECANCELED	89		/* Operation canceled */
(defconstant $EIDRM 90)
; #define EIDRM		90		/* Identifier removed */
(defconstant $ENOMSG 91)
; #define ENOMSG		91		/* No message of desired type */   
(defconstant $EILSEQ 92)
; #define EILSEQ		92		/* Illegal byte sequence */
(defconstant $ENOATTR 93)
; #define ENOATTR		93		/* Attribute not found */
(defconstant $ELAST 93)
; #define	ELAST		93		/* Must be equal largest errno */

; #endif /* _POSIX_SOURCE */

; #ifdef KERNEL
#| #|

#define ERESTART	-1		
#define EJUSTRETURN	-2		
#endif
|#
 |#

; #endif /* _SYS_ERRNO_H_ */


(provide-interface "errno")