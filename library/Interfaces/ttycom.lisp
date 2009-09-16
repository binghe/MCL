(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ttycom.h"
; at Sunday July 2,2006 7:28:40 pm.
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
;  Copyright (c) 1997 Apple Computer, Inc. All Rights Reserved 
; -
;  * Copyright (c) 1982, 1986, 1990, 1993, 1994
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
;  *	@(#)ttycom.h	8.1 (Berkeley) 3/28/94
;  
; #ifndef	_SYS_TTYCOM_H_
; #define	_SYS_TTYCOM_H_

(require-interface "sys/ioccom")
; 
;  * Tty ioctl's except for those supported only for backwards compatibility
;  * with the old tty driver.
;  
; 
;  * Window/terminal size structure.  This information is stored by the kernel
;  * in order to provide a consistent interface, but is not used by the kernel.
;  
(defrecord winsize
   (ws_row :UInt16)
                                                ;  rows, in characters 
   (ws_col :UInt16)
                                                ;  columns, in characters 
   (ws_xpixel :UInt16)
                                                ;  horizontal size, pixels 
   (ws_ypixel :UInt16)
                                                ;  vertical size, pixels 
)
; #define	TIOCMODG	_IOR('t', 3, int)	/* get modem control state */
; #define	TIOCMODS	_IOW('t', 4, int)	/* set modem control state */
(defconstant $TIOCM_LE 1)
; #define		TIOCM_LE	0001		/* line enable */
(defconstant $TIOCM_DTR 2)
; #define		TIOCM_DTR	0002		/* data terminal ready */
(defconstant $TIOCM_RTS 4)
; #define		TIOCM_RTS	0004		/* request to send */
(defconstant $TIOCM_ST 10)
; #define		TIOCM_ST	0010		/* secondary transmit */
(defconstant $TIOCM_SR 20)
; #define		TIOCM_SR	0020		/* secondary receive */
(defconstant $TIOCM_CTS 40)
; #define		TIOCM_CTS	0040		/* clear to send */
(defconstant $TIOCM_CAR 100)
; #define		TIOCM_CAR	0100		/* carrier detect */
; #define		TIOCM_CD	TIOCM_CAR
(defconstant $TIOCM_RNG 200)
; #define		TIOCM_RNG	0200		/* ring */
; #define		TIOCM_RI	TIOCM_RNG
(defconstant $TIOCM_DSR 400)
; #define		TIOCM_DSR	0400		/* data set ready */
;  8-10 compat 
; #define	TIOCEXCL	 _IO('t', 13)		/* set exclusive use of tty */
; #define	TIOCNXCL	 _IO('t', 14)		/* reset exclusive use of tty */
;  15 unused 
; #define	TIOCFLUSH	_IOW('t', 16, int)	/* flush buffers */
;  17-18 compat 
; #define	TIOCGETA	_IOR('t', 19, struct termios) /* get termios struct */
; #define	TIOCSETA	_IOW('t', 20, struct termios) /* set termios struct */
; #define	TIOCSETAW	_IOW('t', 21, struct termios) /* drain output, set */
; #define	TIOCSETAF	_IOW('t', 22, struct termios) /* drn out, fls in, set */
; #define	TIOCGETD	_IOR('t', 26, int)	/* get line discipline */
; #define	TIOCSETD	_IOW('t', 27, int)	/* set line discipline */
;  127-124 compat 
; #define	TIOCSBRK	 _IO('t', 123)		/* set break bit */
; #define	TIOCCBRK	 _IO('t', 122)		/* clear break bit */
; #define	TIOCSDTR	 _IO('t', 121)		/* set data terminal ready */
; #define	TIOCCDTR	 _IO('t', 120)		/* clear data terminal ready */
; #define	TIOCGPGRP	_IOR('t', 119, int)	/* get pgrp of tty */
; #define	TIOCSPGRP	_IOW('t', 118, int)	/* set pgrp of tty */
;  117-116 compat 
; #define	TIOCOUTQ	_IOR('t', 115, int)	/* output queue size */
; #define	TIOCSTI		_IOW('t', 114, char)	/* simulate terminal input */
; #define	TIOCNOTTY	 _IO('t', 113)		/* void tty association */
; #define	TIOCPKT		_IOW('t', 112, int)	/* pty: set/clear packet mode */
(defconstant $TIOCPKT_DATA 0)
; #define		TIOCPKT_DATA		0x00	/* data packet */
(defconstant $TIOCPKT_FLUSHREAD 1)
; #define		TIOCPKT_FLUSHREAD	0x01	/* flush packet */
(defconstant $TIOCPKT_FLUSHWRITE 2)
; #define		TIOCPKT_FLUSHWRITE	0x02	/* flush packet */
(defconstant $TIOCPKT_STOP 4)
; #define		TIOCPKT_STOP		0x04	/* stop output */
(defconstant $TIOCPKT_START 8)
; #define		TIOCPKT_START		0x08	/* start output */
(defconstant $TIOCPKT_NOSTOP 16)
; #define		TIOCPKT_NOSTOP		0x10	/* no more ^S, ^Q */
(defconstant $TIOCPKT_DOSTOP 32)
; #define		TIOCPKT_DOSTOP		0x20	/* now do ^S ^Q */
(defconstant $TIOCPKT_IOCTL 64)
; #define		TIOCPKT_IOCTL		0x40	/* state change of pty driver */
; #define	TIOCSTOP	 _IO('t', 111)		/* stop output, like ^S */
; #define	TIOCSTART	 _IO('t', 110)		/* start output, like ^Q */
; #define	TIOCMSET	_IOW('t', 109, int)	/* set all modem bits */
; #define	TIOCMBIS	_IOW('t', 108, int)	/* bis modem bits */
; #define	TIOCMBIC	_IOW('t', 107, int)	/* bic modem bits */
; #define	TIOCMGET	_IOR('t', 106, int)	/* get all modem bits */
; #define	TIOCREMOTE	_IOW('t', 105, int)	/* remote input editing */
; #define	TIOCGWINSZ	_IOR('t', 104, struct winsize)	/* get window size */
; #define	TIOCSWINSZ	_IOW('t', 103, struct winsize)	/* set window size */
; #define	TIOCUCNTL	_IOW('t', 102, int)	/* pty: set/clr usr cntl mode */
; #define	TIOCSTAT	 _IO('t', 101)		/* simulate ^T status message */
; #define		UIOCCMD(n)	_IO('u', n)	/* usr cntl op "n" */
; #define	TIOCSCONS	_IO('t', 99)		/* 4.2 compatibility */
; #define	TIOCCONS	_IOW('t', 98, int)	/* become virtual console */
; #define	TIOCSCTTY	 _IO('t', 97)		/* become controlling tty */
; #define	TIOCEXT		_IOW('t', 96, int)	/* pty: external processing */
; #define	TIOCSIG		 _IO('t', 95)		/* pty: generate signal */
; #define	TIOCDRAIN	 _IO('t', 94)		/* wait till output drained */
; #define	TIOCMSDTRWAIT	_IOW('t', 91, int)	/* modem: set wait on close */
; #define	TIOCMGDTRWAIT	_IOR('t', 90, int)	/* modem: get wait on close */
; #define	TIOCTIMESTAMP	_IOR('t', 89, struct timeval)	/* enable/get timestamp
; #define	TIOCDCDTIMESTAMP _IOR('t', 88, struct timeval)	/* enable/get timestamp
; #define	TIOCSDRAINWAIT	_IOW('t', 87, int)	/* set ttywait timeout */
; #define	TIOCGDRAINWAIT	_IOR('t', 86, int)	/* get ttywait timeout */
; #define	TIOCDSIMICROCODE _IO('t', 85)		/* download microcode to
(defconstant $TTYDISC 0)
; #define	TTYDISC		0		/* termios tty line discipline */
(defconstant $TABLDISC 3)
; #define	TABLDISC	3		/* tablet discipline */
(defconstant $SLIPDISC 4)
; #define	SLIPDISC	4		/* serial IP discipline */
(defconstant $PPPDISC 5)
; #define	PPPDISC		5		/* PPP discipline */

; #endif /* !_SYS_TTYCOM_H_ */


(provide-interface "ttycom")