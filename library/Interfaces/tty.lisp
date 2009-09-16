(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:tty.h"
; at Sunday July 2,2006 7:32:01 pm.
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
;  * Copyright (c) 1982, 1986, 1993
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
;  *	@(#)tty.h	8.6 (Berkeley) 1/21/94
;  
; #ifndef _SYS_TTY_H_
; #define	_SYS_TTY_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/cdefs")

(require-interface "sys/termios")

(require-interface "sys/select")
; #ifdef __APPLE_API_UNSTABLE
#| #|

#ifndef__APPLE__

struct clist {
	int	c_cc;		
	int	c_cbcount;	
	int	c_cbmax;	
	int	c_cbreserved;	
	char	*c_cf;		
	char	*c_cl;		
};
#else

struct clist {
	int	c_cc;		
	int	c_cn;		
	u_char	*c_cf;		
	u_char	*c_cl;		
	u_char	*c_cs;		
	u_char	*c_ce;		
	u_char	*c_cq;		
};

#ifndefTTYCLSIZE
#define TTYCLSIZE 1024
#endif
#endif


struct tty {
	struct	clist t_rawq;		
	long	t_rawcc;		
	struct	clist t_canq;		
	long	t_cancc;		
	struct	clist t_outq;		
	long	t_outcc;		
	int	t_line;			
	dev_t	t_dev;			
	int	t_state;		
	int	t_flags;		
	int     t_timeout;              
	struct	pgrp *t_pgrp;		
	struct	session *t_session;	
	struct	selinfo t_rsel;		
	struct	selinfo t_wsel;		
	struct	termios t_termios;	
	struct	winsize t_winsize;	
					
	void	(*t_oproc) __P((struct tty *));
					
	void	(*t_stop) __P((struct tty *, int));
					
	int	(*t_param) __P((struct tty *, struct termios *));
	void	*t_sc;			
	int	t_column;		
	int	t_rocount, t_rocol;	
	int	t_hiwat;		
	int	t_lowat;		
	int	t_gen;			
};

#define t_cc		t_termios.c_cc
#define t_cflag		t_termios.c_cflag
#define t_iflag		t_termios.c_iflag
#define t_ispeed	t_termios.c_ispeed
#define t_lflag		t_termios.c_lflag
#define t_min		t_termios.c_min
#define t_oflag		t_termios.c_oflag
#define t_ospeed	t_termios.c_ospeed
#define t_time		t_termios.c_time


#define TTIPRI	25			
#define TTOPRI	26			


#define IBUFSIZ	384			
#define OBUFSIZ	100

#ifndefTTYHOG
#define TTYHOG	1024
#endif
#ifdefKERNEL
#define TTMAXHIWAT	roundup(2048, CBSIZE)
#define TTMINHIWAT	roundup(100, CBSIZE)
#define TTMAXLOWAT	256
#define TTMINLOWAT	32
#endif


#define TS_SO_OLOWAT	0x00001		
#define TS_ASYNC	0x00002		
#define TS_BUSY		0x00004		
#define TS_CARR_ON	0x00008		
#define TS_FLUSH	0x00010		
#define TS_ISOPEN	0x00020		
#define TS_TBLOCK	0x00040		
#define TS_TIMEOUT	0x00080		
#define TS_TTSTOP	0x00100		
#ifdefnotyet
#define TS_WOPEN	0x00200		
#endif#define TS_XCLUDE	0x00400		


#define TS_BKSL		0x00800		
#define TS_CNTTB	0x01000		
#define TS_ERASE	0x02000		
#define TS_LNCH		0x04000		
#define TS_TYPEN	0x08000		
#define TS_LOCAL	(TS_BKSL | TS_CNTTB | TS_ERASE | TS_LNCH | TS_TYPEN)


#define TS_CAN_BYPASS_L_RINT 0x010000	
#define TS_CONNECTED	0x020000	
#define TS_SNOOP	0x040000	
#define TS_SO_OCOMPLETE	0x080000	
#define TS_ZOMBIE	0x100000	


#define TS_CAR_OFLOW	0x200000	
#ifdefnotyet
#define TS_CTS_OFLOW	0x400000	
#define TS_DSR_OFLOW	0x800000	
#endif


#define ORDINARY	0
#define CONTROL		1
#define BACKSPACE	2
#define NEWLINE		3
#define TAB		4
#define VTAB		5
#define RETURN		6

struct speedtab {
	int sp_speed;			
	int sp_code;			
};


#define DMSET		0
#define DMBIS		1
#define DMBIC		2
#define DMGET		3


#define TTY_CHARMASK	0x000000ff	
#define TTY_QUOTE	0x00000100	
#define TTY_ERRORMASK	0xff000000	
#define TTY_FE		0x01000000	
#define TTY_PE		0x02000000	
#define TTY_OE		0x04000000	
#define TTY_BI		0x08000000	


#define isctty(p, tp)							\
	((p)->p_session == (tp)->t_session && (p)->p_flag & P_CONTROLT)


#define isbackground(p, tp)						\
	(isctty((p), (tp)) && (p)->p_pgrp != (tp)->t_pgrp)


#define TSA_CARR_ON(tp)		((void *)&(tp)->t_rawq)
#define TSA_HUP_OR_INPUT(tp)	((void *)&(tp)->t_rawq.c_cf)
#define TSA_OCOMPLETE(tp)	((void *)&(tp)->t_outq.c_cl)
#define TSA_OLOWAT(tp)		((void *)&(tp)->t_outq)
#define TSA_PTC_READ(tp)	((void *)&(tp)->t_outq.c_cf)
#define TSA_PTC_WRITE(tp)	((void *)&(tp)->t_rawq.c_cl)
#define TSA_PTS_READ(tp)	((void *)&(tp)->t_canq)


#ifdefKERNEL
__BEGIN_DECLS

#ifndef__APPLE__
extern	struct tty *constty;	

int	 b_to_q __P((char *cp, int cc, struct clist *q));
void	 catq __P((struct clist *from, struct clist *to));
void	 clist_alloc_cblocks __P((struct clist *q, int ccmax, int ccres));
void	 clist_free_cblocks __P((struct clist *q));
 
int	 getc __P((struct clist *q));
void	 ndflush __P((struct clist *q, int cc));
int	 ndqb __P((struct clist *q, int flag));
char	*nextc __P((struct clist *q, char *cp, int *c));
int	 putc __P((int c, struct clist *q));
int	 q_to_b __P((struct clist *q, char *cp, int cc));
int	 unputc __P((struct clist *q));

int	ttcompat __P((struct tty *tp, int com, caddr_t data, int flag));
int     ttsetcompat __P((struct tty *tp, int *com, caddr_t data, struct termios *term));
#else
int	 b_to_q __P((u_char *cp, int cc, struct clist *q));
void	 catq __P((struct clist *from, struct clist *to));
void	 clist_init __P((void));
int	 getc __P((struct clist *q));
void	 ndflush __P((struct clist *q, int cc));
int	 ndqb __P((struct clist *q, int flag));
u_char	*firstc           __P((struct clist *clp, int *c));
u_char	*nextc __P((struct clist *q, u_char *cp, int *c));
int	 putc __P((int c, struct clist *q));
int	 q_to_b __P((struct clist *q, u_char *cp, int cc));
int	 unputc __P((struct clist *q));
int	 clalloc __P((struct clist *clp, int size, int quot));
void	 clfree __P((struct clist *clp));

#ifdefKERNEL_PRIVATE
int	ttcompat __P((struct tty *tp, u_long com, caddr_t data, int flag,
	    struct proc *p));
int	ttsetcompat __P((struct tty *tp, u_long *com, caddr_t data, struct termios *term));
#endif
#endif

void	 termioschars __P((struct termios *t));
int	 tputchar __P((int c, struct tty *tp));
#ifndef__APPLE__
int	 ttioctl __P((struct tty *tp, int com, void *data, int flag));
#elseint	 ttioctl __P((struct tty *tp, u_long com, caddr_t data, int flag,
	    struct proc *p));
#endifint	 ttread __P((struct tty *tp, struct uio *uio, int flag));
void	 ttrstrt __P((void *tp));
int	 ttyselect __P((struct tty *tp, int rw, void * wql, struct proc *p));
int	 ttselect __P((dev_t dev, int rw, void * wql, struct proc *p));
void	 ttsetwater __P((struct tty *tp));
int	 ttspeedtab __P((int speed, struct speedtab *table));
int	 ttstart __P((struct tty *tp));
void	 ttwakeup __P((struct tty *tp));
int	 ttwrite __P((struct tty *tp, struct uio *uio, int flag));
void	 ttwwakeup __P((struct tty *tp));
void	 ttyblock __P((struct tty *tp));
void	 ttychars __P((struct tty *tp));
int	 ttycheckoutq __P((struct tty *tp, int wait));
int	 ttyclose __P((struct tty *tp));
void	 ttyflush __P((struct tty *tp, int rw));
void	 ttyinfo __P((struct tty *tp));
int	 ttyinput __P((int c, struct tty *tp));
int	 ttylclose __P((struct tty *tp, int flag));
int	 ttymodem __P((struct tty *tp, int flag));
int	 ttyopen __P((dev_t device, struct tty *tp));
int	 ttysleep __P((struct tty *tp,
	    void *chan, int pri, char *wmesg, int timeout));
int	 ttywait __P((struct tty *tp));
struct tty *ttymalloc __P((void));
void     ttyfree __P((struct tty *));

__END_DECLS

#endif

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !_SYS_TTY_H_ */


(provide-interface "tty")