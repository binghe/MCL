(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:time.h"
; at Sunday July 2,2006 7:22:59 pm.
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
;  *	@(#)time.h	8.2 (Berkeley) 7/10/94
;  
; #ifndef _SYS_TIME_H_
; #define _SYS_TIME_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/types")
; 
;  * Structure returned by gettimeofday(2) system call,
;  * and used in other calls.
;  
(defrecord timeval
   (tv_sec :SInt32)
                                                ;  seconds 
   (tv_usec :SInt32)
                                                ;  and microseconds 
)
; 
;  * Structure defined by POSIX.4 to be like a timeval.
;  
; #ifndef _TIMESPEC_DECLARED
; #define _TIMESPEC_DECLARED
(defrecord timespec
   (tv_sec :signed-long)
                                                ;  seconds 
   (tv_nsec :SInt32)
                                                ;  and nanoseconds 
)

; #endif

; #define	TIMEVAL_TO_TIMESPEC(tv, ts) {						(ts)->tv_sec = (tv)->tv_sec;						(ts)->tv_nsec = (tv)->tv_usec * 1000;				}
; #define	TIMESPEC_TO_TIMEVAL(tv, ts) {						(tv)->tv_sec = (ts)->tv_sec;						(tv)->tv_usec = (ts)->tv_nsec / 1000;				}
(defrecord timezone
   (tz_minuteswest :signed-long)
                                                ;  minutes west of Greenwich 
   (tz_dsttime :signed-long)
                                                ;  type of dst correction 
)
(defconstant $DST_NONE 0)
; #define	DST_NONE	0	/* not on dst */
(defconstant $DST_USA 1)
; #define	DST_USA		1	/* USA style dst */
(defconstant $DST_AUST 2)
; #define	DST_AUST	2	/* Australian style dst */
(defconstant $DST_WET 3)
; #define	DST_WET		3	/* Western European dst */
(defconstant $DST_MET 4)
; #define	DST_MET		4	/* Middle European dst */
(defconstant $DST_EET 5)
; #define	DST_EET		5	/* Eastern European dst */
(defconstant $DST_CAN 6)
; #define	DST_CAN		6	/* Canada */
; #define time_second time.tv_sec
;  Operations on timevals. 
; #define	timerclear(tvp)		(tvp)->tv_sec = (tvp)->tv_usec = 0
; #define	timerisset(tvp)		((tvp)->tv_sec || (tvp)->tv_usec)
; #define	timercmp(tvp, uvp, cmp)							(((tvp)->tv_sec == (uvp)->tv_sec) ?					    ((tvp)->tv_usec cmp (uvp)->tv_usec) :				    ((tvp)->tv_sec cmp (uvp)->tv_sec))
; #define	timeradd(tvp, uvp, vvp)							do {										(vvp)->tv_sec = (tvp)->tv_sec + (uvp)->tv_sec;				(vvp)->tv_usec = (tvp)->tv_usec + (uvp)->tv_usec;			if ((vvp)->tv_usec >= 1000000) {						(vvp)->tv_sec++;							(vvp)->tv_usec -= 1000000;					}								} while (0)
; #define	timersub(tvp, uvp, vvp)							do {										(vvp)->tv_sec = (tvp)->tv_sec - (uvp)->tv_sec;				(vvp)->tv_usec = (tvp)->tv_usec - (uvp)->tv_usec;			if ((vvp)->tv_usec < 0) {							(vvp)->tv_sec--;							(vvp)->tv_usec += 1000000;					}								} while (0)
; #define timevalcmp(l, r, cmp)   timercmp(l, r, cmp) /* freebsd */
; 
;  * Names of the interval timers, and structure
;  * defining a timer setting.
;  
(defconstant $ITIMER_REAL 0)
; #define	ITIMER_REAL	0
(defconstant $ITIMER_VIRTUAL 1)
; #define	ITIMER_VIRTUAL	1
(defconstant $ITIMER_PROF 2)
; #define	ITIMER_PROF	2
(defrecord itimerval
   (it_interval :TIMEVAL)
                                                ;  timer interval 
   (it_value :TIMEVAL)
                                                ;  current value 
)
; 
;  * Getkerninfo clock information structure
;  
(defrecord clockinfo
   (hz :signed-long)
                                                ;  clock frequency 
   (tick :signed-long)
                                                ;  micro-seconds per hz tick 
   (tickadj :signed-long)
                                                ;  clock skew rate for adjtime() 
   (stathz :signed-long)
                                                ;  statistics clock frequency 
   (profhz :signed-long)
                                                ;  profiling clock frequency 
)

(require-interface "sys/cdefs")
; #ifdef KERNEL
#| #|
void	microtime __P((struct timeval *tv));
void	microuptime __P((struct timeval *tv));
#define getmicrotime(a)		microtime(a)
#define getmicrouptime(a)	microuptime(a)
void	nanotime __P((struct timespec *ts));
void	nanouptime __P((struct timespec *ts));
#define getnanotime(a)		nanotime(a)
#define getnanouptime(a)	nanouptime(a)
#ifdef__APPLE_API_PRIVATE
int	itimerfix __P((struct timeval *tv));
int	itimerdecr __P((struct itimerval *itp, int usec));
#endif

|#
 |#

; #else /* !KERNEL */

(require-interface "time")
; #ifndef _POSIX_SOURCE

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( const struct timeval * #\, struct timeval * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const struct timeval * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct itimerval * #\) #\)
|#
#|
 confused about __P #\( #\( struct timeval * #\, struct timezone * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const struct itimerval * #\, struct itimerval * #\) #\)
|#
#|
 confused about __P #\( #\( const struct timeval * #\, const struct timezone * #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, const struct timeval * #\) #\)
|#

; #endif /* !POSIX */


; #endif /* !KERNEL */


; #endif /* !_SYS_TIME_H_ */


(provide-interface "time")