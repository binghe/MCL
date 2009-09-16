(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:termios.h"
; at Sunday July 2,2006 7:32:01 pm.
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
;  Copyright (c) 1997 Apple Computer, Inc. All Rights Reserved 
; 
;  * Copyright (c) 1988, 1989, 1993, 1994
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
;  *	@(#)termios.h	8.3 (Berkeley) 3/28/94
;  
; #ifndef _SYS_TERMIOS_H_
; #define _SYS_TERMIOS_H_
; 
;  * Special Control Characters
;  *
;  * Index into c_cc[] character array.
;  *
;  *	Name	     Subscript	Enabled by
;  
(defconstant $VEOF 0)
; #define	VEOF		0	/* ICANON */
(defconstant $VEOL 1)
; #define	VEOL		1	/* ICANON */
; #ifndef _POSIX_SOURCE
(defconstant $VEOL2 2)
; #define	VEOL2		2	/* ICANON together with IEXTEN */

; #endif

(defconstant $VERASE 3)
; #define	VERASE		3	/* ICANON */
; #ifndef _POSIX_SOURCE
(defconstant $VWERASE 4)
; #define VWERASE 	4	/* ICANON together with IEXTEN */

; #endif

(defconstant $VKILL 5)
; #define VKILL		5	/* ICANON */
; #ifndef _POSIX_SOURCE
(defconstant $VREPRINT 6)
; #define	VREPRINT 	6	/* ICANON together with IEXTEN */

; #endif

; 			7	   spare 1 
(defconstant $VINTR 8)
; #define VINTR		8	/* ISIG */
(defconstant $VQUIT 9)
; #define VQUIT		9	/* ISIG */
(defconstant $VSUSP 10)
; #define VSUSP		10	/* ISIG */
; #ifndef _POSIX_SOURCE
(defconstant $VDSUSP 11)
; #define VDSUSP		11	/* ISIG together with IEXTEN */

; #endif

(defconstant $VSTART 12)
; #define VSTART		12	/* IXON, IXOFF */
(defconstant $VSTOP 13)
; #define VSTOP		13	/* IXON, IXOFF */
; #ifndef _POSIX_SOURCE
(defconstant $VLNEXT 14)
; #define	VLNEXT		14	/* IEXTEN */
(defconstant $VDISCARD 15)
; #define	VDISCARD	15	/* IEXTEN */

; #endif

(defconstant $VMIN 16)
; #define VMIN		16	/* !ICANON */
(defconstant $VTIME 17)
; #define VTIME		17	/* !ICANON */
; #ifndef _POSIX_SOURCE
(defconstant $VSTATUS 18)
; #define VSTATUS		18	/* ICANON together with IEXTEN */
; 			19	   spare 2 

; #endif

(defconstant $NCCS 20)
; #define	NCCS		20
; #ifndef _POSIX_VDISABLE
(defconstant $_POSIX_VDISABLE 255)
; #define	_POSIX_VDISABLE	0xff

; #endif

; #ifndef _POSIX_SOURCE
; #define	CCEQ(val, c)	((c) == (val) ? (val) != _POSIX_VDISABLE : 0)

; #endif

; 
;  * Input flags - software input processing
;  
(defconstant $IGNBRK 1)
; #define	IGNBRK		0x00000001	/* ignore BREAK condition */
(defconstant $BRKINT 2)
; #define	BRKINT		0x00000002	/* map BREAK to SIGINTR */
(defconstant $IGNPAR 4)
; #define	IGNPAR		0x00000004	/* ignore (discard) parity errors */
(defconstant $PARMRK 8)
; #define	PARMRK		0x00000008	/* mark parity and framing errors */
(defconstant $INPCK 16)
; #define	INPCK		0x00000010	/* enable checking of parity errors */
(defconstant $ISTRIP 32)
; #define	ISTRIP		0x00000020	/* strip 8th bit off chars */
(defconstant $INLCR 64)
; #define	INLCR		0x00000040	/* map NL into CR */
(defconstant $IGNCR 128)
; #define	IGNCR		0x00000080	/* ignore CR */
(defconstant $ICRNL 256)
; #define	ICRNL		0x00000100	/* map CR to NL (ala CRMOD) */
(defconstant $IXON 512)
; #define	IXON		0x00000200	/* enable output flow control */
(defconstant $IXOFF 1024)
; #define	IXOFF		0x00000400	/* enable input flow control */
; #ifndef _POSIX_SOURCE
(defconstant $IXANY 2048)
; #define	IXANY		0x00000800	/* any char will restart after stop */
(defconstant $IMAXBEL 8192)
; #define IMAXBEL		0x00002000	/* ring bell on input queue full */

; #endif  /*_POSIX_SOURCE */

; 
;  * Output flags - software output processing
;  
(defconstant $OPOST 1)
; #define	OPOST		0x00000001	/* enable following output processing */
; #ifndef _POSIX_SOURCE
(defconstant $ONLCR 2)
; #define ONLCR		0x00000002	/* map NL to CR-NL (ala CRMOD) */
(defconstant $OXTABS 4)
; #define OXTABS		0x00000004	/* expand tabs to spaces */
(defconstant $ONOEOT 8)
; #define ONOEOT		0x00000008	/* discard EOT's (^D) on output) */

; #endif  /*_POSIX_SOURCE */

; 
;  * Control flags - hardware control of terminal
;  
; #ifndef _POSIX_SOURCE
(defconstant $CIGNORE 1)
; #define	CIGNORE		0x00000001	/* ignore control flags */

; #endif

(defconstant $CSIZE 768)
; #define CSIZE		0x00000300	/* character size mask */
(defconstant $CS5 0)
; #define     CS5		    0x00000000	    /* 5 bits (pseudo) */
(defconstant $CS6 256)
; #define     CS6		    0x00000100	    /* 6 bits */
(defconstant $CS7 512)
; #define     CS7		    0x00000200	    /* 7 bits */
(defconstant $CS8 768)
; #define     CS8		    0x00000300	    /* 8 bits */
(defconstant $CSTOPB 1024)
; #define CSTOPB		0x00000400	/* send 2 stop bits */
(defconstant $CREAD 2048)
; #define CREAD		0x00000800	/* enable receiver */
(defconstant $PARENB 4096)
; #define PARENB		0x00001000	/* parity enable */
(defconstant $PARODD 8192)
; #define PARODD		0x00002000	/* odd parity, else even */
(defconstant $HUPCL 16384)
; #define HUPCL		0x00004000	/* hang up on last close */
(defconstant $CLOCAL 32768)
; #define CLOCAL		0x00008000	/* ignore modem status lines */
; #ifndef _POSIX_SOURCE
(defconstant $CCTS_OFLOW 65536)
; #define CCTS_OFLOW	0x00010000	/* CTS flow control of output */
; #define CRTSCTS		(CCTS_OFLOW | CRTS_IFLOW)
(defconstant $CRTS_IFLOW 131072)
; #define CRTS_IFLOW	0x00020000	/* RTS flow control of input */
(defconstant $CDTR_IFLOW 262144)
; #define	CDTR_IFLOW	0x00040000	/* DTR flow control of input */
(defconstant $CDSR_OFLOW 524288)
; #define CDSR_OFLOW	0x00080000	/* DSR flow control of output */
(defconstant $CCAR_OFLOW 1048576)
; #define	CCAR_OFLOW	0x00100000	/* DCD flow control of output */
(defconstant $MDMBUF 1048576)
; #define	MDMBUF		0x00100000	/* old name for CCAR_OFLOW */

; #endif

; 
;  * "Local" flags - dumping ground for other state
;  *
;  * Warning: some flags in this structure begin with
;  * the letter "I" and look like they belong in the
;  * input flag.
;  
; #ifndef _POSIX_SOURCE
(defconstant $ECHOKE 1)
; #define	ECHOKE		0x00000001	/* visual erase for line kill */

; #endif  /*_POSIX_SOURCE */

(defconstant $ECHOE 2)
; #define	ECHOE		0x00000002	/* visually erase chars */
(defconstant $ECHOK 4)
; #define	ECHOK		0x00000004	/* echo NL after line kill */
(defconstant $ECHO 8)
; #define ECHO		0x00000008	/* enable echoing */
(defconstant $ECHONL 16)
; #define	ECHONL		0x00000010	/* echo NL even if ECHO is off */
; #ifndef _POSIX_SOURCE
(defconstant $ECHOPRT 32)
; #define	ECHOPRT		0x00000020	/* visual erase mode for hardcopy */
(defconstant $ECHOCTL 64)
; #define ECHOCTL  	0x00000040	/* echo control chars as ^(Char) */

; #endif  /*_POSIX_SOURCE */

(defconstant $ISIG 128)
; #define	ISIG		0x00000080	/* enable signals INTR, QUIT, [D]SUSP */
(defconstant $ICANON 256)
; #define	ICANON		0x00000100	/* canonicalize input lines */
; #ifndef _POSIX_SOURCE
(defconstant $ALTWERASE 512)
; #define ALTWERASE	0x00000200	/* use alternate WERASE algorithm */

; #endif  /*_POSIX_SOURCE */

(defconstant $IEXTEN 1024)
; #define	IEXTEN		0x00000400	/* enable DISCARD and LNEXT */
(defconstant $EXTPROC 2048)
; #define EXTPROC         0x00000800      /* external processing */
(defconstant $TOSTOP 4194304)
; #define TOSTOP		0x00400000	/* stop background jobs from output */
; #ifndef _POSIX_SOURCE
(defconstant $FLUSHO 8388608)
; #define FLUSHO		0x00800000	/* output being flushed (state) */
(defconstant $NOKERNINFO 33554432)
; #define	NOKERNINFO	0x02000000	/* no kernel output from VSTATUS */
(defconstant $PENDIN 536870912)
; #define PENDIN		0x20000000	/* XXX retype pending input (state) */

; #endif  /*_POSIX_SOURCE */

(defconstant $NOFLSH 2147483648)
; #define	NOFLSH		0x80000000	/* don't flush after interrupt */

(def-mactype :tcflag_t (find-mactype ':UInt32))

(def-mactype :cc_t (find-mactype ':UInt8))

(def-mactype :speed_t (find-mactype ':signed-long))
;  XXX should be unsigned long 
(defrecord termios
   (c_iflag :UInt32)
                                                ;  input flags 
   (c_oflag :UInt32)
                                                ;  output flags 
   (c_cflag :UInt32)
                                                ;  control flags 
   (c_lflag :UInt32)
                                                ;  local flags 
   (c_cc (:array :UInt8 20))
                                                ;  control chars 
   (c_ispeed :signed-long)
                                                ;  input speed 
   (c_ospeed :signed-long)
                                                ;  output speed 
)
; 
;  * Commands passed to tcsetattr() for setting the termios structure.
;  
(defconstant $TCSANOW 0)
; #define	TCSANOW		0		/* make change immediate */
(defconstant $TCSADRAIN 1)
; #define	TCSADRAIN	1		/* drain output, then change */
(defconstant $TCSAFLUSH 2)
; #define	TCSAFLUSH	2		/* drain output, flush input */
; #ifndef _POSIX_SOURCE
(defconstant $TCSASOFT 16)
; #define TCSASOFT	0x10		/* flag - don't alter h.w. state */

; #endif

; 
;  * Standard speeds
;  
(defconstant $B0 0)
; #define B0	0
(defconstant $B50 50)
; #define B50	50
(defconstant $B75 75)
; #define B75	75
(defconstant $B110 110)
; #define B110	110
(defconstant $B134 134)
; #define B134	134
(defconstant $B150 150)
; #define B150	150
(defconstant $B200 200)
; #define B200	200
(defconstant $B300 300)
; #define B300	300
(defconstant $B600 600)
; #define B600	600
(defconstant $B1200 1200)
; #define B1200	1200
(defconstant $B1800 1800)
; #define	B1800	1800
(defconstant $B2400 2400)
; #define B2400	2400
(defconstant $B4800 4800)
; #define B4800	4800
(defconstant $B9600 9600)
; #define B9600	9600
(defconstant $B19200 19200)
; #define B19200	19200
(defconstant $B38400 38400)
; #define B38400	38400
; #ifndef _POSIX_SOURCE
(defconstant $B7200 7200)
; #define B7200	7200
(defconstant $B14400 14400)
; #define B14400	14400
(defconstant $B28800 28800)
; #define B28800	28800
(defconstant $B57600 57600)
; #define B57600	57600
(defconstant $B76800 76800)
; #define B76800	76800
(defconstant $B115200 115200)
; #define B115200	115200
(defconstant $B230400 230400)
; #define B230400	230400
(defconstant $EXTA 19200)
; #define EXTA	19200
(defconstant $EXTB 38400)
; #define EXTB	38400

; #endif  /* !_POSIX_SOURCE */

; #ifndef KERNEL
(defconstant $TCIFLUSH 1)
; #define	TCIFLUSH	1
(defconstant $TCOFLUSH 2)
; #define	TCOFLUSH	2
(defconstant $TCIOFLUSH 3)
; #define TCIOFLUSH	3
(defconstant $TCOOFF 1)
; #define	TCOOFF		1
(defconstant $TCOON 2)
; #define	TCOON		2
(defconstant $TCIOFF 3)
; #define TCIOFF		3
(defconstant $TCION 4)
; #define TCION		4

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( const struct termios * #\) #\)
|#
#|
 confused about __P #\( #\( const struct termios * #\) #\)
|#
#|
 confused about __P #\( #\( struct termios * #\, speed_t #\) #\)
|#
#|
 confused about __P #\( #\( struct termios * #\, speed_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct termios * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, const struct termios * #\) #\)
|#
#|
 confused about __P #\( #\( int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#
; #ifndef _POSIX_SOURCE
#|
 confused about __P #\( #\( struct termios * #\) #\)
|#
#|
 confused about __P #\( #\( struct termios * #\, speed_t #\) #\)
|#

; #endif /* !_POSIX_SOURCE */


; #endif /* !KERNEL */

; #ifndef _POSIX_SOURCE
; 
;  * Include tty ioctl's that aren't just for backwards compatibility
;  * with the old tty driver.  These ioctl definitions were previously
;  * in <sys/ioctl.h>.
;  

(require-interface "sys/ttycom")

; #endif

; 
;  * END OF PROTECTED INCLUDE.
;  

; #endif /* !_SYS_TERMIOS_H_ */

; #ifndef _POSIX_SOURCE

(require-interface "sys/ttydefaults")

; #endif


(provide-interface "termios")