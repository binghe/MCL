(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ipc.h"
; at Sunday July 2,2006 7:27:05 pm.
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
; 
;  * Copyright (c) 1988 University of Utah.
;  * Copyright (c) 1990, 1993
;  *	The Regents of the University of California.  All rights reserved.
;  * (c) UNIX System Laboratories, Inc.
;  * All or some portions of this file are derived from material licensed
;  * to the University of California by American Telephone and Telegraph
;  * Co. or Unix System Laboratories, Inc. and are reproduced herein with
;  * the permission of UNIX System Laboratories, Inc.
;  *
;  * This code is derived from software contributed to Berkeley by
;  * the Systems Programming Group of the University of Utah Computer
;  * Science Department.
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
;  *	@(#)ipc.h	8.4 (Berkeley) 2/19/95
;  

(require-interface "sys/appleapiopts")
; 
;  * SVID compatible ipc.h file
;  
; #ifndef _SYS_IPC_H_
; #define _SYS_IPC_H_
(defrecord ipc_perm
   (cuid :UInt16)
                                                ;  creator user id 
   (cgid :UInt16)
                                                ;  creator group id 
   (uid :UInt16)
                                                ;  user id 
   (gid :UInt16)
                                                ;  group id 
   (mode :UInt16)
                                                ;  r/w permission 
   (seq :UInt16)
                                                ;  sequence # (to generate unique msg/sem/shm id) 
   (key :signed-long)
                                                ;  user specified msg/sem/shm key 
)
;  common mode bits 
(defconstant $IPC_R 400)
; #define	IPC_R		000400	/* read permission */
(defconstant $IPC_W 200)
; #define	IPC_W		000200	/* write/alter permission */
(defconstant $IPC_M 10000)
; #define	IPC_M		010000	/* permission to change control info */
;  SVID required constants (same values as system 5) 
(defconstant $IPC_CREAT 1000)
; #define	IPC_CREAT	001000	/* create entry if key does not exist */
(defconstant $IPC_EXCL 2000)
; #define	IPC_EXCL	002000	/* fail if key exists */
(defconstant $IPC_NOWAIT 4000)
; #define	IPC_NOWAIT	004000	/* error if request must wait */
; #define	IPC_PRIVATE	(key_t)0 /* private key */
(defconstant $IPC_RMID 0)
; #define	IPC_RMID	0	/* remove identifier */
(defconstant $IPC_SET 1)
; #define	IPC_SET		1	/* set options */
(defconstant $IPC_STAT 2)
; #define	IPC_STAT	2	/* get options */
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE


#define IPCID_TO_IX(id)		((id) & 0xffff)
#define IPCID_TO_SEQ(id)	(((id) >> 16) & 0xffff)
#define IXSEQ_TO_IPCID(ix,perm)	(((perm.seq) << 16) | (ix & 0xffff))

struct ucred;

int	ipcperm __P((struct ucred *, struct ipc_perm *, int));
#endif
|#
 |#

; #else /* ! KERNEL */
;  XXX doesn't really belong here, but has been historical practice in SysV. 

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( const char * #\, int #\) #\)
|#

; #endif /* KERNEL */


; #endif /* !_SYS_IPC_H_ */


(provide-interface "ipc")