(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:resource.h"
; at Sunday July 2,2006 7:31:26 pm.
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
;  * Copyright (c) 1982, 1986, 1993
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
;  *	@(#)resource.h	8.2 (Berkeley) 1/4/94
;  
; #ifndef _SYS_RESOURCE_H_
; #define	_SYS_RESOURCE_H_

(require-interface "sys/appleapiopts")
; 
;  * Process priority specifications to get/setpriority.
;  
; #define	PRIO_MIN	-20
(defconstant $PRIO_MAX 20)
; #define	PRIO_MAX	20
(defconstant $PRIO_PROCESS 0)
; #define	PRIO_PROCESS	0
(defconstant $PRIO_PGRP 1)
; #define	PRIO_PGRP	1
(defconstant $PRIO_USER 2)
; #define	PRIO_USER	2
; 
;  * Resource utilization information.
;  
(defconstant $RUSAGE_SELF 0)
; #define	RUSAGE_SELF	0
; #define	RUSAGE_CHILDREN	-1
(defrecord rusage
   (ru_utime :TIMEVAL)
                                                ;  user time used 
   (ru_stime :TIMEVAL)
                                                ;  system time used 
   (ru_maxrss :signed-long)
                                                ;  max resident set size 
; #define	ru_first	ru_ixrss
   (ru_ixrss :signed-long)
                                                ;  integral shared memory size 
   (ru_idrss :signed-long)
                                                ;  integral unshared data " 
   (ru_isrss :signed-long)
                                                ;  integral unshared stack " 
   (ru_minflt :signed-long)
                                                ;  page reclaims 
   (ru_majflt :signed-long)
                                                ;  page faults 
   (ru_nswap :signed-long)
                                                ;  swaps 
   (ru_inblock :signed-long)
                                                ;  block input operations 
   (ru_oublock :signed-long)
                                                ;  block output operations 
   (ru_msgsnd :signed-long)
                                                ;  messages sent 
   (ru_msgrcv :signed-long)
                                                ;  messages received 
   (ru_nsignals :signed-long)
                                                ;  signals received 
   (ru_nvcsw :signed-long)
                                                ;  voluntary context switches 
   (ru_nivcsw :signed-long)
                                                ;  involuntary " 
; #define	ru_last		ru_nivcsw
)
; 
;  * Resource limits
;  
(defconstant $RLIMIT_CPU 0)
; #define	RLIMIT_CPU	0		/* cpu time in milliseconds */
(defconstant $RLIMIT_FSIZE 1)
; #define	RLIMIT_FSIZE	1		/* maximum file size */
(defconstant $RLIMIT_DATA 2)
; #define	RLIMIT_DATA	2		/* data size */
(defconstant $RLIMIT_STACK 3)
; #define	RLIMIT_STACK	3		/* stack size */
(defconstant $RLIMIT_CORE 4)
; #define	RLIMIT_CORE	4		/* core file size */
(defconstant $RLIMIT_RSS 5)
; #define	RLIMIT_RSS	5		/* resident set size */
(defconstant $RLIMIT_MEMLOCK 6)
; #define	RLIMIT_MEMLOCK	6		/* locked-in-memory address space */
(defconstant $RLIMIT_NPROC 7)
; #define	RLIMIT_NPROC	7		/* number of processes */
(defconstant $RLIMIT_NOFILE 8)
; #define	RLIMIT_NOFILE	8		/* number of open files */
(defconstant $RLIM_NLIMITS 9)
; #define	RLIM_NLIMITS	9		/* number of resource limits */
; #define	RLIM_INFINITY	(((u_quad_t)1 << 63) - 1)
(defrecord orlimit
   (rlim_cur :SInt32)
                                                ;  current (soft) limit 
   (rlim_max :SInt32)
                                                ;  maximum value for rlim_cur 
)
(defrecord rlimit
   (rlim_cur :RLIM_T)
                                                ;  current (soft) limit 
   (rlim_max :RLIM_T)
                                                ;  maximum value for rlim_cur 
)
;  Load average structure. 
(defrecord loadavg
   (ldavg (:array :UInt32 3))
   (fscale :signed-long)
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
extern struct loadavg averunnable;
#define LSCALE	1000		
#endif
|#
 |#

; #else

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct rlimit * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct rusage * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const struct rlimit * #\) #\)
|#

; #endif	/* KERNEL */


; #endif	/* !_SYS_RESOURCE_H_ */


(provide-interface "resource")