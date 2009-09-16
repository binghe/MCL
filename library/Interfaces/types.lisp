(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:types.h"
; at Sunday July 2,2006 7:22:43 pm.
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
;  * Copyright (c) 1982, 1986, 1991, 1993, 1994
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
;  *	@(#)types.h	8.4 (Berkeley) 1/21/94
;  
; #ifndef _SYS_TYPES_H_
; #define	_SYS_TYPES_H_

(require-interface "sys/appleapiopts")
; #ifndef __ASSEMBLER__

(require-interface "sys/cdefs")
;  Machine type dependent parameters. 

(require-interface "machine/types")

(require-interface "machine/ansi")

(require-interface "machine/endian")
; #ifndef _POSIX_SOURCE

(def-mactype :u_char (find-mactype ':UInt8))

(def-mactype :u_short (find-mactype ':UInt16))

(def-mactype :u_int (find-mactype ':UInt32))

(def-mactype :u_long (find-mactype ':UInt32))

(def-mactype :ushort (find-mactype ':UInt16))
;  Sys V compatibility 

(def-mactype :uint (find-mactype ':UInt32))
;  Sys V compatibility 

; #endif


(%define-record :u_quad_t (find-record-descriptor ':u_int64_t))
;  quads 

(%define-record :quad_t (find-record-descriptor ':int64_t))

(def-mactype :qaddr_t (find-mactype '(:pointer :quad_t)))

(def-mactype :caddr_t (find-mactype '(:pointer :character)))
;  core address 

(def-mactype :daddr_t (find-mactype ':SInt32))
;  disk address 

(def-mactype :dev_t (find-mactype ':SInt32))
;  device number 

(def-mactype :fixpt_t (find-mactype ':UInt32))
;  fixed point number 

(def-mactype :gid_t (find-mactype ':UInt32))
;  group id 

(def-mactype :in_addr_t (find-mactype ':UInt32))
;  base type for internet address 

(def-mactype :in_port_t (find-mactype ':UInt16))

(def-mactype :ino_t (find-mactype ':UInt32))
;  inode number 

(def-mactype :key_t (find-mactype ':signed-long))
;  IPC key (for Sys V IPC) 

(def-mactype :mode_t (find-mactype ':UInt16))
;  permissions 

(def-mactype :nlink_t (find-mactype ':UInt16))
;  link count 

(%define-record :off_t (find-record-descriptor ':quad_t))
;  file offset 

(def-mactype :pid_t (find-mactype ':SInt32))
;  process id 

(%define-record :rlim_t (find-record-descriptor ':quad_t))
;  resource limit 

(def-mactype :segsz_t (find-mactype ':SInt32))
;  segment size 

(def-mactype :swblk_t (find-mactype ':SInt32))
;  swap offset 

(def-mactype :uid_t (find-mactype ':UInt32))
;  user id 

(def-mactype :useconds_t (find-mactype ':UInt32))
;  microseconds (unsigned) 
; #ifndef _POSIX_SOURCE
;  Major, minor numbers, dev_t's. 
; #define	major(x)	((int32_t)(((u_int32_t)(x) >> 24) & 0xff))
; #define	minor(x)	((int32_t)((x) & 0xffffff))
; #define	makedev(x,y)	((dev_t)(((x) << 24) | (y)))

; #endif

; #ifndef	_BSD_CLOCK_T_DEFINED_
; #define	_BSD_CLOCK_T_DEFINED_

(def-mactype :clock_t (find-mactype ':unsigned-long))

; #endif

; #ifndef	_BSD_SIZE_T_DEFINED_
; #define	_BSD_SIZE_T_DEFINED_

(def-mactype :size_t (find-mactype ':unsigned-long))

; #endif

; #ifndef	_BSD_SSIZE_T_DEFINED_
; #define	_BSD_SSIZE_T_DEFINED_

(def-mactype :ssize_t (find-mactype ':signed-long))

; #endif

; #ifndef	_BSD_TIME_T_DEFINED_
; #define	_BSD_TIME_T_DEFINED_

(def-mactype :time_t (find-mactype ':signed-long))

; #endif

; #ifndef _POSIX_SOURCE
(defconstant $NBBY 8)
; #define	NBBY	8		/* number of bits in a byte */
; 
;  * Select uses bit masks of file descriptors in longs.  These macros
;  * manipulate such bit fields (the filesystem macros use chars).
;  
; #ifndef	FD_SETSIZE
(defconstant $FD_SETSIZE 1024)
; #define	FD_SETSIZE	1024

; #endif


(def-mactype :fd_mask (find-mactype ':SInt32))
(defconstant $NFDBITS 32)
; #define NFDBITS	(sizeof(fd_mask) * NBBY)	/* bits per mask */
; #ifndef howmany
; #define	howmany(x, y)	(((x) + ((y) - 1)) / (y))

; #endif

(defrecord fd_set
   (fds_bits (:array :SInt32 32))
)
; #define	FD_SET(n, p)	((p)->fds_bits[(n)/NFDBITS] |= (1 << ((n) % NFDBITS)))
; #define	FD_CLR(n, p)	((p)->fds_bits[(n)/NFDBITS] &= ~(1 << ((n) % NFDBITS)))
; #define	FD_ISSET(n, p)	((p)->fds_bits[(n)/NFDBITS] & (1 << ((n) % NFDBITS)))
; #define	FD_COPY(f, t)	bcopy(f, t, sizeof(*(f)))
; #define	FD_ZERO(p)	bzero(p, sizeof(*(p)))

; #if defined(__STDC__) && defined(KERNEL)
#| 
; 
;  * Forward structure declarations for function prototypes.  We include the
;  * common structures that cross subsystem boundaries here; others are mostly
;  * used in the same place that the structure is defined.
;  
 |#

; #endif


; #endif /* !_POSIX_SOURCE */


; #endif /* __ASSEMBLER__ */

(defrecord _pthread_handler_rec
   (routine (:pointer :callback))               ;(void (void *))
                                                ;  Routine to call 
   (arg :pointer)                               ;  Argument to pass 
   (next (:pointer :_pthread_handler_rec))
)
; #ifndef __POSIX_LIB__
(defconstant $__PTHREAD_SIZE__ 596)
; #define __PTHREAD_SIZE__           596 
(defconstant $__PTHREAD_ATTR_SIZE__ 36)
; #define __PTHREAD_ATTR_SIZE__      36
(defconstant $__PTHREAD_MUTEXATTR_SIZE__ 8)
; #define __PTHREAD_MUTEXATTR_SIZE__ 8
(defconstant $__PTHREAD_MUTEX_SIZE__ 40)
; #define __PTHREAD_MUTEX_SIZE__     40
(defconstant $__PTHREAD_CONDATTR_SIZE__ 4)
; #define __PTHREAD_CONDATTR_SIZE__  4
(defconstant $__PTHREAD_COND_SIZE__ 24)
; #define __PTHREAD_COND_SIZE__      24
(defconstant $__PTHREAD_ONCE_SIZE__ 4)
; #define __PTHREAD_ONCE_SIZE__      4
(defconstant $__PTHREAD_RWLOCK_SIZE__ 124)
; #define __PTHREAD_RWLOCK_SIZE__    124
(defconstant $__PTHREAD_RWLOCKATTR_SIZE__ 12)
; #define __PTHREAD_RWLOCKATTR_SIZE__ 12
(defrecord _opaque_pthread_t
   (sig :signed-long)
   (cleanup_stack (:pointer :_PTHREAD_HANDLER_REC))
   (opaque (:array :character 596))
)
(def-mactype :pthread_t (find-mactype '(:POINTER :_OPAQUE_PTHREAD_T)))
(defrecord _opaque_pthread_attr_t
   (sig :signed-long)
   (opaque (:array :character 36))
)
(%define-record :pthread_attr_t (find-record-descriptor :_OPAQUE_PTHREAD_ATTR_T))
(defrecord _opaque_pthread_mutexattr_t
   (sig :signed-long)
   (opaque (:array :character 8))
)
(%define-record :pthread_mutexattr_t (find-record-descriptor :_OPAQUE_PTHREAD_MUTEXATTR_T))
(defrecord _opaque_pthread_mutex_t
   (sig :signed-long)
   (opaque (:array :character 40))
)
(%define-record :pthread_mutex_t (find-record-descriptor :_OPAQUE_PTHREAD_MUTEX_T))
(defrecord _opaque_pthread_condattr_t
   (sig :signed-long)
   (opaque (:array :character 4))
)
(%define-record :pthread_condattr_t (find-record-descriptor :_OPAQUE_PTHREAD_CONDATTR_T))
(defrecord _opaque_pthread_cond_t
   (sig :signed-long)
   (opaque (:array :character 24))
)
(%define-record :pthread_cond_t (find-record-descriptor :_OPAQUE_PTHREAD_COND_T))
(defrecord _opaque_pthread_rwlockattr_t
   (sig :signed-long)
   (opaque (:array :character 12))
)
(%define-record :pthread_rwlockattr_t (find-record-descriptor :_OPAQUE_PTHREAD_RWLOCKATTR_T))
(defrecord _opaque_pthread_rwlock_t
   (sig :signed-long)
   (opaque (:array :character 124))
)
(%define-record :pthread_rwlock_t (find-record-descriptor :_OPAQUE_PTHREAD_RWLOCK_T))
(defrecord pthread_once_t
   (sig :signed-long)
   (opaque (:array :character 4))
)

; #endif /* __POSIX_LIB__ */


(def-mactype :pthread_key_t (find-mactype ':UInt32))
;  Opaque 'pointer' 

; #endif /* !_SYS_TYPES_H_ */


(provide-interface "types")