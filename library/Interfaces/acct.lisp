(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:acct.h"
; at Sunday July 2,2006 7:25:30 pm.
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
;  * Copyright (c) 1990, 1993, 1994
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
;  *	@(#)acct.h	8.4 (Berkeley) 1/9/95
;  
; #ifndef _SYS_ACCT_H_
; #define _SYS_ACCT_H_

(require-interface "sys/appleapiopts")
; 
;  * Accounting structures; these use a comp_t type which is a 3 bits base 8
;  * exponent, 13 bit fraction ``floating point'' number.  Units are 1/AHZ
;  * seconds.
;  

(def-mactype :comp_t (find-mactype ':UInt16))
(defrecord acct
   (ac_comm (:array :character 10))
                                                ;  command name 
   (ac_utime :UInt16)
                                                ;  user time 
   (ac_stime :UInt16)
                                                ;  system time 
   (ac_etime :UInt16)
                                                ;  elapsed time 
   (ac_btime :signed-long)
                                                ;  starting time 
   (ac_uid :UInt32)
                                                ;  user id 
   (ac_gid :UInt32)
                                                ;  group id 
   (ac_mem :UInt16)
                                                ;  average memory usage 
   (ac_io :UInt16)
                                                ;  count of IO blocks 
   (ac_tty :SInt32)
                                                ;  controlling tty 
; #define	AFORK	0x01		/* fork'd but not exec'd */
; #define	ASU	0x02		/* used super-user permissions */
; #define	ACOMPAT	0x04		/* used compatibility mode */
; #define	ACORE	0x08		/* dumped core */
; #define	AXSIG	0x10		/* killed by a signal */
   (ac_flag :UInt8)
                                                ;  accounting flags 
)
; 
;  * 1/AHZ is the granularity of the data encoded in the comp_t fields.
;  * This is not necessarily equal to hz.
;  
(defconstant $AHZ 64)
; #define	AHZ	64
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
extern struct vnode	*acctp;
int	acct_process __P((struct proc *p));
#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* ! _SYS_ACCT_H_ */


(provide-interface "acct")