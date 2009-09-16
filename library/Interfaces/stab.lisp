(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:stab.h"
; at Sunday July 2,2006 7:31:57 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
;  * @OSF_COPYRIGHT@
;  
; 
;  * HISTORY
;  * 
;  * Revision 1.1.1.1  1998/09/22 21:05:48  wsanchez
;  * Import of Mac OS X kernel (~semeria)
;  *
;  * Revision 1.1.1.1  1998/03/07 02:26:09  wsanchez
;  * Import of OSF Mach kernel (~mburg)
;  *
;  * Revision 1.1.11.2  1995/01/06  19:11:14  devrcs
;  * 	mk6 CR668 - 1.3b26 merge
;  * 	added N_FRAME, an extension to aout symtabs
;  * 	for machines with non-self-describing frame formats
;  * 	[1994/10/14  03:40:05  dwm]
;  *
;  * Revision 1.1.11.1  1994/09/23  01:23:47  ezf
;  * 	change marker to not FREE
;  * 	[1994/09/22  21:11:53  ezf]
;  * 
;  * Revision 1.1.4.3  1993/07/27  18:28:44  elliston
;  * 	Add ANSI prototypes.  CR #9523.
;  * 	[1993/07/27  18:13:49  elliston]
;  * 
;  * Revision 1.1.4.2  1993/06/02  23:13:40  jeffc
;  * 	Added to OSF/1 R1.3 from NMK15.0.
;  * 	[1993/06/02  20:58:12  jeffc]
;  * 
;  * Revision 1.1  1992/09/30  02:24:31  robert
;  * 	Initial revision
;  * 
;  * $EndLog$
;  
;  CMU_HIST 
; 
;  * Revision 2.2  91/10/09  16:05:28  af
;  * 	 Revision 2.1  91/10/05  13:02:42  jeffreyh
;  * 	 Created.
;  * 
;  * Revision 2.1.1.1  91/10/05  13:03:14  jeffreyh
;  * 	Initial MK63 checkin
;  * 
;  * Revision 2.1.1.1  91/07/31  13:14:49  jeffreyh
;  * 	Created from BSD network release #2
;  * 	[91/07/31            jeffreyh]
;  * 
;  *
;  
;  CMU_ENDHIST 
; -
;  * Copyright (c) 1991 The Regents of the University of California.
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
;  *	@(#)stab.h	5.2 (Berkeley) 4/4/91
;  
; 
;  
; #ifndef	_DDB_DB_STAB_H_
; #define	_DDB_DB_STAB_H_
; 
;  * The following are symbols used by various debuggers and by the Pascal
;  * compiler.  Each of them must have one (or more) of the bits defined by
;  * the N_STAB mask set.
;  
(defconstant $N_GSYM 32)
; #define	N_GSYM		0x20	/* global symbol */
(defconstant $N_FNAME 34)
; #define	N_FNAME		0x22	/* F77 function name */
(defconstant $N_FUN 36)
; #define	N_FUN		0x24	/* procedure name */
(defconstant $N_STSYM 38)
; #define	N_STSYM		0x26	/* data segment variable */
(defconstant $N_LCSYM 40)
; #define	N_LCSYM		0x28	/* bss segment variable */
(defconstant $N_MAIN 42)
; #define	N_MAIN		0x2a	/* main function name */
(defconstant $N_PC 48)
; #define	N_PC		0x30	/* global Pascal symbol */
(defconstant $N_FRAME 52)
; #define	N_FRAME		0x34	/* stack frame descriptor */
(defconstant $N_RSYM 64)
; #define	N_RSYM		0x40	/* register variable */
(defconstant $N_SLINE 68)
; #define	N_SLINE		0x44	/* text segment line number */
(defconstant $N_DSLINE 70)
; #define	N_DSLINE	0x46	/* data segment line number */
(defconstant $N_BSLINE 72)
; #define	N_BSLINE	0x48	/* bss segment line number */
(defconstant $N_SSYM 96)
; #define	N_SSYM		0x60	/* structure/union element */
(defconstant $N_SO 100)
; #define	N_SO		0x64	/* main source file name */
(defconstant $N_LSYM 128)
; #define	N_LSYM		0x80	/* stack variable */
(defconstant $N_BINCL 130)
; #define	N_BINCL		0x82	/* include file beginning */
(defconstant $N_SOL 132)
; #define	N_SOL		0x84	/* included source file name */
(defconstant $N_PSYM 160)
; #define	N_PSYM		0xa0	/* parameter variable */
(defconstant $N_EINCL 162)
; #define	N_EINCL		0xa2	/* include file end */
(defconstant $N_ENTRY 164)
; #define	N_ENTRY		0xa4	/* alternate entry point */
(defconstant $N_LBRAC 192)
; #define	N_LBRAC		0xc0	/* left bracket */
(defconstant $N_EXCL 194)
; #define	N_EXCL		0xc2	/* deleted include file */
(defconstant $N_RBRAC 224)
; #define	N_RBRAC		0xe0	/* right bracket */
(defconstant $N_BCOMM 226)
; #define	N_BCOMM		0xe2	/* begin common */
(defconstant $N_ECOMM 228)
; #define	N_ECOMM		0xe4	/* end common */
(defconstant $N_ECOML 232)
; #define	N_ECOML		0xe8	/* end common (local name) */
(defconstant $N_LENG 254)
; #define	N_LENG		0xfe	/* length of preceding entry */

; #endif	/* !_DDB_DB_STAB_H_ */


(provide-interface "stab")