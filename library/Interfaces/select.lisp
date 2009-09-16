(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:select.h"
; at Sunday July 2,2006 7:31:54 pm.
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
; 
;  * Copyright (c) 1992, 1993
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
;  *	@(#)select.h	8.2 (Berkeley) 1/4/94
;  
; #ifndef _SYS_SELECT_H_
; #define	_SYS_SELECT_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/cdefs")
; #ifdef __APPLE_API_UNSTABLE
#| #|

__BEGIN_DECLS

#ifdefKERNEL
#include <kernwait_queue.h>
#endif
#include <sysevent.h>


struct selinfo {
#ifdefKERNEL
	union {
		struct  wait_queue wait_queue;	
		struct klist note;		
	} si_u;
#define si_wait_queue si_u.wait_queue
#define si_note si_u.note
#else	char  si_wait_queue[16];
#endif	u_int	si_flags;		
};

#define SI_COLL		0x0001		
#define SI_RECORDED	0x0004		 
#define SI_INITED	0x0008		 
#define SI_CLEAR	0x0010		 

#ifdefKERNEL
struct proc;

void	selrecord __P((struct proc *selector, struct selinfo *, void *));
void	selwakeup __P((struct selinfo *));
void	selthreadclear __P((struct selinfo *));
#endif

__END_DECLS

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #ifndef KERNEL

(require-interface "sys/types")
; #ifndef  __MWERKS__

(require-interface "signal")

; #endif /* __MWERKS__ */


(require-interface "sys/time")
; #ifndef  __MWERKS__

(deftrap-inline "_pselect" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :FD_SET))
    (ARGH (:pointer :FD_SET))
    (ARGH (:pointer :FD_SET))
    (ARGH (:pointer :TIMESPEC))
    (ARGH (:pointer :sigset_t))
   )
   :signed-long
() )

; #endif /* __MWERKS__ */


(deftrap-inline "_select" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :FD_SET))
    (ARGH (:pointer :FD_SET))
    (ARGH (:pointer :FD_SET))
    (* (:pointer :struct))
   )
   :signed-long
() )

; #endif /* ! KERNEL */


; #endif /* !_SYS_SELECT_H_ */


(provide-interface "select")