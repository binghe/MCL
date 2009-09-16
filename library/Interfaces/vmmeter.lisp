(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vmmeter.h"
; at Sunday July 2,2006 7:32:15 pm.
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
;  *      This product includes software developed by the University of
;  *      California, Berkeley and its contributors.
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
;  *	@(#)vmmeter.h	8.2 (Berkeley) 7/10/94
;  
; #ifndef _SYS_VMMETER_H_
; #define	_SYS_VMMETER_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_OBSOLETE
#| #|

struct vmmeter {
	
	u_int v_swtch;		
	u_int v_trap;		
	u_int v_syscall;	
	u_int v_intr;		
	u_int v_soft;		
	u_int v_faults;		
	
	u_int v_lookups;	
	u_int v_hits;		
	u_int v_vm_faults;	
	u_int v_cow_faults;	
	u_int v_swpin;		
	u_int v_swpout;		
	u_int v_pswpin;		
	u_int v_pswpout;	
	u_int v_pageins;	
	u_int v_pageouts;	
	u_int v_pgpgin;		
	u_int v_pgpgout;	
	u_int v_intrans;	
	u_int v_reactivated;	
	u_int v_rev;		
	u_int v_scan;		
	u_int v_dfree;		
	u_int v_pfree;		
	u_int v_zfod;		
	u_int v_nzfod;		
	
	u_int v_page_size;	
	u_int v_kernel_pages;	
	u_int v_free_target;	
	u_int v_free_min;	
	u_int v_free_count;	
	u_int v_wire_count;	
	u_int v_active_count;	
	u_int v_inactive_target; 
	u_int v_inactive_count;  
};
#ifdefKERNEL
extern struct	vmmeter cnt;
#endif

struct vmtotal
{
	int16_t	t_rq;		
	int16_t	t_dw;		
	int16_t	t_pw;		
	int16_t	t_sl;		
	int16_t	t_sw;		
	int32_t	t_vm;		
	int32_t	t_avm;		
	int32_t	t_rm;		
	int32_t	t_arm;		
	int32_t	t_vmshr;	
	int32_t	t_avmshr;	
	int32_t	t_rmshr;	
	int32_t	t_armshr;	
	int32_t	t_free;		
};
#ifdefKERNEL
extern struct	vmtotal total;
#endif
#endif
|#
 |#
; __APPLE_API_OBSOLETE 

; #endif /* !_SYS_VMMETER_H_ */


(provide-interface "vmmeter")