(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mtio.h"
; at Sunday July 2,2006 7:30:32 pm.
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
;  *	@(#)mtio.h	8.1 (Berkeley) 6/2/93
;  
; #ifndef	_SYS_MTIO_H_
; #define	_SYS_MTIO_H_

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_OBSOLETE
#| #|




struct mtop {
	short	mt_op;		
	daddr_t	mt_count;	
};


#define MTWEOF		0	
#define MTFSF		1	
#define MTBSF		2	
#define MTFSR		3	
#define MTBSR		4	
#define MTREW		5	
#define MTOFFL		6	
#define MTNOP		7	
#define MTRETEN		8	
#define MTERASE		9	
#define MTEOM		10	
#define MTNBSF		11	
#define MTCACHE		12	
#define MTNOCACHE	13	
#define MTSETBSIZ	14	
#define MTSETDNSTY	15	



struct mtget {
	short	mt_type;	

	u_short	mt_dsreg;	
	u_short	mt_erreg;	
	u_short mt_ext_err0;	
	u_short mt_ext_err1;	

	short	mt_resid;	

	daddr_t	mt_fileno;	
	daddr_t	mt_blkno;	

	daddr_t	mt_blksiz;	
	daddr_t	mt_density;	
	daddr_t	mt_mblksiz[4];	
	daddr_t mt_mdensity[4];	
};


#define MT_ISTS		0x01		
#define MT_ISHT		0x02		
#define MT_ISTM		0x03		
#define MT_ISMT		0x04		
#define MT_ISUT		0x05		
#define MT_ISCPC	0x06		
#define MT_ISAR		0x07		
#define MT_ISTMSCP	0x08		
#define MT_ISCY		0x09		
#define MT_ISCT		0x0a		
#define MT_ISFHP	0x0b		
#define MT_ISEXABYTE	0x0c		
#define MT_ISEXA8200	0x0c		
#define MT_ISEXA8500	0x0d		
#define MT_ISVIPER1	0x0e		
#define MT_ISPYTHON	0x0f		
#define MT_ISHPDAT	0x10		
#define MT_ISWANGTEK	0x11		
#define MT_ISCALIPER	0x12		
#define MT_ISWTEK5099	0x13		
#define MT_ISVIPER2525	0x14		
#define MT_ISMFOUR	0x11		
#define MT_ISTK50	0x12		
#define MT_ISMT02	0x13		
#define MT_ISGS		0x14		


#define MTIOCTOP	_IOW('m', 1, struct mtop)	
#define MTIOCGET	_IOR('m', 2, struct mtget)	
#define MTIOCIEOT	_IO('m', 3)			
#define MTIOCEEOT	_IO('m', 4)			

#ifndefKERNEL
#define DEFTAPE	"devrst0"
#endif
#ifdefKERNEL


#define T_UNIT		003		
#define T_NOREWIND	004		
#define T_DENSEL	030		
#define T_800BPI	000		
#define T_1600BPI	010		
#define T_6250BPI	020		
#define T_BADBPI	030		
#endif
#endif
|#
 |#
;  __APPLE_API_OBSOLETE 

; #endif	/* !_SYS_MTIO_H_ */


(provide-interface "mtio")