(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:systm.h"
; at Sunday July 2,2006 7:32:00 pm.
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
; -
;  * Copyright (c) 1982, 1988, 1991, 1993
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
;  *	@(#)systm.h	8.7 (Berkeley) 3/29/95
;  
; 
;  * The `securelevel' variable controls the security level of the system.
;  * It can only be decreased by process 1 (/sbin/init).
;  *
;  * Security levels are as follows:
;  *   -1	permannently insecure mode - always run system in level 0 mode.
;  *    0	insecure mode - immutable and append-only flags make be turned off.
;  *	All devices may be read or written subject to permission modes.
;  *    1	secure mode - immutable and append-only flags may not be changed;
;  *	raw disks of mounted filesystems, /dev/mem, and /dev/kmem are
;  *	read-only.
;  *    2	highly secure mode - same as (1) plus raw disks are always
;  *	read-only whether mounted or not. This level precludes tampering 
;  *	with filesystems by unmounting them, but also inhibits running
;  *	newfs while the system is secured.
;  *
;  * In normal operation, the system runs in level 0 mode while single user
;  * and in level 1 mode while multiuser. If level 2 mode is desired while
;  * running multiuser, it can be set in the multiuser startup script
;  * (/etc/rc.local) using sysctl(1). If it is desired to run the system
;  * in level 0 mode while multiuser, initialize the variable securelevel
;  * in /sys/kern/kern_sysctl.c to -1. Note that it is NOT initialized to
;  * zero as that would allow the vmunix binary to be patched to -1.
;  * Without initialization, securelevel loads in the BSS area which only
;  * comes into existence when the kernel is loaded and hence cannot be
;  * patched by a stalking hacker.
;  
; #ifndef _SYS_SYSTM_H_
; #define	_SYS_SYSTM_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/cdefs")

(require-interface "sys/types")

(require-interface "sys/time")

(require-interface "sys/tty")

(require-interface "sys/vm")

(require-interface "sys/proc")

(require-interface "sys/linker_set")

(require-interface "kern/thread")
; #ifdef __APPLE_API_PRIVATE
#| #|
extern int securelevel;		
extern const char *panicstr;	
extern char version[];		
extern char copyright[];	


extern struct sysent {		
	int16_t		sy_narg;	
	int8_t		sy_parallel;
        int8_t		sy_funnel;	
	int32_t		(*sy_call)();	
} sysent[];
extern int nsysent;

extern int	boothowto;	
extern int	show_space;

extern int nblkdev;		
extern int nchrdev;		
extern dev_t rootdev;		
extern struct vnode *rootvp;	
#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; #ifdef __APPLE_API_UNSTABLE
#| #|
#define NO_FUNNEL 0
#define KERNEL_FUNNEL 1
#define NETWORK_FUNNEL 2

extern funnel_t * kernel_flock;
extern funnel_t * network_flock;
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #define SYSINIT(a,b,c,d,e)
; #define MALLOC_DEFINE(a,b,c)
; #define getenv_int(a,b) (*b = 0)
; #define	KASSERT(exp,msg)
; 
;  * General function declarations.
;  
#|
 confused about __P #\( #\( void #\) #\)
|#

(deftrap-inline "_enodev" 
   ((ARG2 (:NIL :NIL))
   )
   :signed-long
() )
;  avoid actual prototype for multiple use 

(deftrap-inline "_enodev_strat" 
   ((ARG2 (:NIL :NIL))
   )
   :void
() )

(deftrap-inline "_nulldev" 
   ((ARG2 (:NIL :NIL))
   )
   :signed-long
() )
#|
 confused about __P #\( #\( void #\) #\)
|#
#|
 confused about __P #\( #\( void #\) #\)
|#
#|
 confused about __P #\( #\( void #\) #\)
|#
#|
 confused about __P #\( #\( void #\) #\)
|#
; #ifdef __APPLE_API_UNSTABLE
#| #|
int	seltrue __P((dev_t dev, int which, struct proc *p));
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
#|
 confused about __P #\( #\( int count #\, int type #\, u_long * hashmask #\) #\)
|#
#|
 confused about __P #\( #\( struct proc * #\, void * #\, register_t * #\) #\)
|#
; #ifdef __GNUC__
#| #|
volatile void	panic __P((const char *, ...));
|#
 |#

; #else
#|
 confused about __P #\( #\( const char * #\, \... #\) #\)
|#

; #endif

#|
 confused about __P #\( #\( const char * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( struct tty * #\, const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( char const * #\, void #\( * #\) #\( int #\, void * #\) #\, void * #\, int #\, _BSD_VA_LIST_ #\) #\)
|#
#|
 confused about __P #\( #\( char * #\, size_t #\, const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( char * buf #\, const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, _BSD_VA_LIST_ #\) #\)
|#
#|
 confused about __P #\( #\( char * #\, size_t #\, const char * #\, _BSD_VA_LIST_ #\) #\)
|#
#|
 confused about __P #\( #\( char * buf #\, const char * #\, _BSD_VA_LIST_ #\) #\)
|#
#|
 confused about __P #\( #\( const void * from #\, void * to #\, size_t len #\) #\)
|#
#|
 confused about __P #\( #\( const void * from #\, void * to #\, size_t len #\) #\)
|#
#|
 confused about __P #\( #\( void * buf #\, size_t len #\) #\)
|#
#|
 confused about __P #\( #\( void * kfaddr #\, void * kdaddr #\, size_t len #\, size_t * done #\) #\)
|#
#|
 confused about __P #\( #\( void * udaddr #\, void * kaddr #\, size_t len #\, size_t * done #\) #\)
|#
#|
 confused about __P #\( #\( void * kaddr #\, void * udaddr #\, size_t len #\, size_t * done #\) #\)
|#
#|
 confused about __P #\( #\( void * udaddr #\, void * kaddr #\, size_t len #\) #\)
|#
#|
 confused about __P #\( #\( void * kaddr #\, void * udaddr #\, size_t len #\) #\)
|#
#|
 confused about __P #\( #\( void * saddr #\, void * daddr #\, size_t len #\) #\)
|#
#|
 confused about __P #\( #\( void * base #\) #\)
|#
; #ifdef notdef
#| #|
int	fuibyte __P((void *base));
#endif
|#
 |#
#|
 confused about __P #\( #\( void * base #\, int byte #\) #\)
|#
#|
 confused about __P #\( #\( void * base #\, int byte #\) #\)
|#
#|
 confused about __P #\( #\( void * base #\) #\)
|#
#|
 confused about __P #\( #\( void * base #\) #\)
|#
#|
 confused about __P #\( #\( void * base #\, long word #\) #\)
|#
#|
 confused about __P #\( #\( void * base #\, long word #\) #\)
|#
; #ifdef __APPLE_API_UNSTABLE
#| #|
int	hzto __P((struct timeval *tv));
typedef void (*timeout_fcn_t)(void *);
void	timeout __P((void (*)(void *), void *arg, int ticks));
void	untimeout __P((void (*)(void *), void *arg));
void	realitexpire __P((void *));
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #ifdef __APPLE_API_PRIVATE
#| #|
void	bsd_hardclock __P((boolean_t usermode, caddr_t pc, int numticks));
void	gatherstats __P((boolean_t usermode, caddr_t pc));

void	initclocks __P((void));

void	startprofclock __P((struct proc *));
void	stopprofclock __P((struct proc *));
void	setstatclockrate __P((int hzrate));
#ifdefDDB

int	Debugger __P((void));	
#endif
void	set_fsblocksize __P((struct vnode *));
#endif
|#
 |#
;  __APPLE_API_PRIVATE 
#|
 confused about __P #\( #\( const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, \... #\) #\)
|#

(deftrap-inline "_thread_funnel_switch" 
   ((oldfnl :signed-long)
    (newfnl :signed-long)
   )
   :signed-long
() )

(require-interface "libkern/libkern")

; #endif /* !_SYS_SYSTM_H_ */


(provide-interface "systm")