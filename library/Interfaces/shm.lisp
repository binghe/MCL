(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:shm.h"
; at Sunday July 2,2006 7:31:56 pm.
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
; 	$NetBSD: shm.h,v 1.15 1994/06/29 06:45:17 cgd Exp $	
; 
;  * Copyright (c) 1994 Adam Glass
;  * All rights reserved.
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
;  *      This product includes software developed by Adam Glass.
;  * 4. The name of the author may not be used to endorse or promote products
;  *    derived from this software without specific prior written permission
;  *
;  * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
;  * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;  * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
;  * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
;  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;  * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;  * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;  * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
;  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;  
; 
;  * As defined+described in "X/Open System Interfaces and Headers"
;  *                         Issue 4, p. XXX
;  
; #ifndef _SYS_SHM_H_
; #define _SYS_SHM_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/param")

(require-interface "sys/ipc")
(defconstant $SHM_RDONLY 10000)
; #define SHM_RDONLY  010000  /* Attach read-only (else read-write) */
(defconstant $SHM_RND 20000)
; #define SHM_RND     020000  /* Round attach address to SHMLBA */
; #define SHMLBA      NBPG /* Segment low boundary address multiple */
;  "official" access mode definitions; somewhat braindead since you have
;    to specify (SHM_* >> 3) for group and (SHM_* >> 6) for world permissions 
(defconstant $SHM_R 400)
; #define SHM_R       (IPC_R)
(defconstant $SHM_W 200)
; #define SHM_W       (IPC_W)
(defrecord shmid_ds
   (shm_perm :IPC_PERM)
                                                ;  operation permission structure 
   (shm_segsz :signed-long)
                                                ;  size of segment in bytes 
   (shm_lpid :SInt32)                           ;  process ID of last shared memory op 
   (shm_cpid :SInt32)
                                                ;  process ID of creator 
   (shm_nattch :SInt16)
                                                ;  number of current attaches 
   (shm_atime :signed-long)
                                                ;  time of last shmat() 
   (shm_dtime :signed-long)
                                                ;  time of last shmdt() 
   (shm_ctime :signed-long)
                                                ;  time of last change by shmctl() 
   (shm_internal :pointer)                      ;  sysv stupidity 
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

struct shminfo {
	int	shmmax,		
		shmmin,		
		shmmni,		
		shmseg,		
		shmall;		
};
extern struct shminfo	shminfo;
extern struct shmid_ds	*shmsegs;

struct proc;

void	shmexit __P((struct proc *));
void	shmfork __P((struct proc *, struct proc *));
__private_extern__ void	shmexec __P((struct proc *));
#endif
|#
 |#

; #else /* !KERNEL */

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( int #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( int #\, void * #\, int #\) #\)
|#
#|
 confused about __P #\( #\( key_t #\, int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, struct shmid_ds * #\) #\)
|#
#|
 confused about __P #\( #\( void * #\) #\)
|#

; #endif /* !KERNEL */


; #endif /* !_SYS_SHM_H_ */


(provide-interface "shm")