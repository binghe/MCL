(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ioctl_compat.h"
; at Sunday July 2,2006 7:28:45 pm.
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
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
; 
;  * Copyright (c) 1990, 1993
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
;  *	@(#)ioctl_compat.h	8.4 (Berkeley) 1/21/94
;  
; #ifndef _SYS_IOCTL_COMPAT_H_
; #define	_SYS_IOCTL_COMPAT_H_

(require-interface "sys/ttychars")

(require-interface "sys/ttydev")
(defrecord tchars
   (t_intrc :character)
                                                ;  interrupt 
   (t_quitc :character)
                                                ;  quit 
   (t_startc :character)
                                                ;  start output 
   (t_stopc :character)
                                                ;  stop output 
   (t_eofc :character)
                                                ;  end-of-file 
   (t_brkc :character)
                                                ;  input delimiter (like nl) 
)
(defrecord ltchars
   (t_suspc :character)
                                                ;  stop process signal 
   (t_dsuspc :character)
                                                ;  delayed stop process signal 
   (t_rprntc :character)
                                                ;  reprint line 
   (t_flushc :character)
                                                ;  flush output (toggles) 
   (t_werasc :character)
                                                ;  word erase 
   (t_lnextc :character)
                                                ;  literal next character 
)
; 
;  * Structure for TIOCGETP and TIOCSETP ioctls.
;  
; #ifndef _SGTTYB_
; #define	_SGTTYB_
(defrecord sgttyb
   (sg_ispeed :character)
                                                ;  input speed 
   (sg_ospeed :character)
                                                ;  output speed 
   (sg_erase :character)
                                                ;  erase character 
   (sg_kill :character)
                                                ;  kill character 
   (sg_flags :SInt16)
                                                ;  mode flags 
)

; #endif

; #ifdef USE_OLD_TTY
#| #|
#undef  TIOCGETD
#define TIOCGETD	_IOR('t', 0, int)	
#undef  TIOCSETD
#define TIOCSETD	_IOW('t', 1, int)	
|#
 |#

; #else
; # define OTIOCGETD	_IOR('t', 0, int)	/* get line discipline */
; # define OTIOCSETD	_IOW('t', 1, int)	/* set line discipline */

; #endif

; #define	TIOCHPCL	_IO('t', 2)		/* hang up on last close */
; #define	TIOCGETP	_IOR('t', 8,struct sgttyb)/* get parameters -- gtty */
; #define	TIOCSETP	_IOW('t', 9,struct sgttyb)/* set parameters -- stty */
; #define	TIOCSETN	_IOW('t',10,struct sgttyb)/* as above, but no flushtty*/
; #define	TIOCSETC	_IOW('t',17,struct tchars)/* set special characters */
; #define	TIOCGETC	_IOR('t',18,struct tchars)/* get special characters */
(defconstant $TANDEM 1)
; #define		TANDEM		0x00000001	/* send stopc on out q full */
(defconstant $CBREAK 2)
; #define		CBREAK		0x00000002	/* half-cooked mode */
(defconstant $LCASE 4)
; #define		LCASE		0x00000004	/* simulate lower case */
(defconstant $ECHO 8)
; #define		ECHO		0x00000008	/* echo input */
(defconstant $CRMOD 16)
; #define		CRMOD		0x00000010	/* map \r to \r\n on output */
(defconstant $RAW 32)
; #define		RAW		0x00000020	/* no i/o processing */
(defconstant $ODDP 64)
; #define		ODDP		0x00000040	/* get/send odd parity */
(defconstant $EVENP 128)
; #define		EVENP		0x00000080	/* get/send even parity */
(defconstant $ANYP 192)
; #define		ANYP		0x000000c0	/* get any parity/send none */
(defconstant $NLDELAY 768)
; #define		NLDELAY		0x00000300	/* \n delay */
(defconstant $NL0 0)
; #define			NL0	0x00000000
(defconstant $NL1 256)
; #define			NL1	0x00000100	/* tty 37 */
(defconstant $NL2 512)
; #define			NL2	0x00000200	/* vt05 */
(defconstant $NL3 768)
; #define			NL3	0x00000300
(defconstant $TBDELAY 3072)
; #define		TBDELAY		0x00000c00	/* horizontal tab delay */
(defconstant $TAB0 0)
; #define			TAB0	0x00000000
(defconstant $TAB1 1024)
; #define			TAB1	0x00000400	/* tty 37 */
(defconstant $TAB2 2048)
; #define			TAB2	0x00000800
(defconstant $XTABS 3072)
; #define		XTABS		0x00000c00	/* expand tabs on output */
(defconstant $CRDELAY 12288)
; #define		CRDELAY		0x00003000	/* \r delay */
(defconstant $CR0 0)
; #define			CR0	0x00000000
(defconstant $CR1 4096)
; #define			CR1	0x00001000	/* tn 300 */
(defconstant $CR2 8192)
; #define			CR2	0x00002000	/* tty 37 */
(defconstant $CR3 12288)
; #define			CR3	0x00003000	/* concept 100 */
(defconstant $VTDELAY 16384)
; #define		VTDELAY		0x00004000	/* vertical tab delay */
(defconstant $FF0 0)
; #define			FF0	0x00000000
(defconstant $FF1 16384)
; #define			FF1	0x00004000	/* tty 37 */
(defconstant $BSDELAY 32768)
; #define		BSDELAY		0x00008000	/* \b delay */
(defconstant $BS0 0)
; #define			BS0	0x00000000
(defconstant $BS1 32768)
; #define			BS1	0x00008000
(defconstant $ALLDELAY 65280)
; #define		ALLDELAY	(NLDELAY|TBDELAY|CRDELAY|VTDELAY|BSDELAY)
(defconstant $CRTBS 65536)
; #define		CRTBS		0x00010000	/* do backspacing for crt */
(defconstant $PRTERA 131072)
; #define		PRTERA		0x00020000	/* \ ... / erase */
(defconstant $CRTERA 262144)
; #define		CRTERA		0x00040000	/* " \b " to wipe out char */
(defconstant $TILDE 524288)
; #define		TILDE		0x00080000	/* hazeltine tilde kludge */
(defconstant $MDMBUF 1048576)
; #define		MDMBUF		0x00100000	/*start/stop output on carrier*/
(defconstant $LITOUT 2097152)
; #define		LITOUT		0x00200000	/* literal output */
(defconstant $TOSTOP 4194304)
; #define		TOSTOP		0x00400000	/*SIGSTOP on background output*/
(defconstant $FLUSHO 8388608)
; #define		FLUSHO		0x00800000	/* flush output to terminal */
(defconstant $NOHANG 16777216)
; #define		NOHANG		0x01000000	/* (no-op) was no SIGHUP on carrier drop */
(defconstant $L001000 33554432)
; #define		L001000		0x02000000
(defconstant $CRTKIL 67108864)
; #define		CRTKIL		0x04000000	/* kill line with " \b " */
(defconstant $PASS8 134217728)
; #define		PASS8		0x08000000
(defconstant $CTLECH 268435456)
; #define		CTLECH		0x10000000	/* echo control chars as ^X */
(defconstant $PENDIN 536870912)
; #define		PENDIN		0x20000000	/* tp->t_rawq needs reread */
(defconstant $DECCTQ 1073741824)
; #define		DECCTQ		0x40000000	/* only ^Q starts after ^S */
(defconstant $NOFLSH 2147483648)
; #define		NOFLSH		0x80000000	/* no output flush on signal */
; #define	TIOCLBIS	_IOW('t', 127, int)	/* bis local mode bits */
; #define	TIOCLBIC	_IOW('t', 126, int)	/* bic local mode bits */
; #define	TIOCLSET	_IOW('t', 125, int)	/* set entire local mode word */
; #define	TIOCLGET	_IOR('t', 124, int)	/* get local modes */
(defconstant $LCRTBS 1)
; #define		LCRTBS		(CRTBS>>16)
(defconstant $LPRTERA 2)
; #define		LPRTERA		(PRTERA>>16)
(defconstant $LCRTERA 4)
; #define		LCRTERA		(CRTERA>>16)
(defconstant $LTILDE 8)
; #define		LTILDE		(TILDE>>16)
(defconstant $LMDMBUF 16)
; #define		LMDMBUF		(MDMBUF>>16)
(defconstant $LLITOUT 32)
; #define		LLITOUT		(LITOUT>>16)
(defconstant $LTOSTOP 64)
; #define		LTOSTOP		(TOSTOP>>16)
(defconstant $LFLUSHO 128)
; #define		LFLUSHO		(FLUSHO>>16)
(defconstant $LNOHANG 256)
; #define		LNOHANG		(NOHANG>>16)
(defconstant $LCRTKIL 1024)
; #define		LCRTKIL		(CRTKIL>>16)
(defconstant $LPASS8 2048)
; #define		LPASS8		(PASS8>>16)
(defconstant $LCTLECH 4096)
; #define		LCTLECH		(CTLECH>>16)
(defconstant $LPENDIN 8192)
; #define		LPENDIN		(PENDIN>>16)
(defconstant $LDECCTQ 16384)
; #define		LDECCTQ		(DECCTQ>>16)
(defconstant $LNOFLSH 32768)
; #define		LNOFLSH		(NOFLSH>>16)
; #define	TIOCSLTC	_IOW('t',117,struct ltchars)/* set local special chars*/
; #define	TIOCGLTC	_IOR('t',116,struct ltchars)/* get local special chars*/
; #define OTIOCCONS	_IO('t', 98)	/* for hp300 -- sans int arg */
(defconstant $OTTYDISC 0)
; #define	OTTYDISC	0
(defconstant $NETLDISC 1)
; #define	NETLDISC	1
(defconstant $NTTYDISC 2)
; #define	NTTYDISC	2
; #define TIOCGSID	_IOR('t', 99, int)	/* For svr4 -- get session id */

; #endif /* !_SYS_IOCTL_COMPAT_H_ */


(provide-interface "ioctl_compat")