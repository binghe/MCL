(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:syslog.h"
; at Sunday July 2,2006 7:31:28 pm.
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
;  * Copyright (c) 1982, 1986, 1988, 1993
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
;  *	@(#)syslog.h	8.1 (Berkeley) 6/2/93
;  
; #ifndef	_SYS_SYSLOG_H_
; #define _SYS_SYSLOG_H_

(require-interface "sys/appleapiopts")
(defconstant $_PATH_LOG "/var/run/syslog")
; #define	_PATH_LOG	"/var/run/syslog"
; 
;  * priorities/facilities are encoded into a single 32-bit quantity, where the
;  * bottom 3 bits are the priority (0-7) and the top 28 bits are the facility
;  * (0-big number).  Both the priorities and the facilities map roughly
;  * one-to-one to strings in the syslogd(8) source code.  This mapping is
;  * included in this file.
;  *
;  * priorities (these are ordered)
;  
(defconstant $LOG_EMERG 0)
; #define	LOG_EMERG	0	/* system is unusable */
(defconstant $LOG_ALERT 1)
; #define	LOG_ALERT	1	/* action must be taken immediately */
(defconstant $LOG_CRIT 2)
; #define	LOG_CRIT	2	/* critical conditions */
(defconstant $LOG_ERR 3)
; #define	LOG_ERR		3	/* error conditions */
(defconstant $LOG_WARNING 4)
; #define	LOG_WARNING	4	/* warning conditions */
(defconstant $LOG_NOTICE 5)
; #define	LOG_NOTICE	5	/* normal but significant condition */
(defconstant $LOG_INFO 6)
; #define	LOG_INFO	6	/* informational */
(defconstant $LOG_DEBUG 7)
; #define	LOG_DEBUG	7	/* debug-level messages */
(defconstant $LOG_PRIMASK 7)
; #define	LOG_PRIMASK	0x07	/* mask to extract priority part (internal) */
;  extract priority 
; #define	LOG_PRI(p)	((p) & LOG_PRIMASK)
; #define	LOG_MAKEPRI(fac, pri)	(((fac) << 3) | (pri))
; #ifdef SYSLOG_NAMES
#| #|
#define INTERNAL_NOPRI	0x10	
				
#define INTERNAL_MARK	LOG_MAKEPRI(LOG_NFACILITIES, 0)
typedef struct _code {
	char	*c_name;
	int	c_val;
} CODE;

CODE prioritynames[] = {
	"alert",	LOG_ALERT,
	"crit",		LOG_CRIT,
	"debug",	LOG_DEBUG,
	"emerg",	LOG_EMERG,
	"err",		LOG_ERR,
	"error",	LOG_ERR,		
	"info",		LOG_INFO,
	"none",		INTERNAL_NOPRI,		
	"notice",	LOG_NOTICE,
	"panic", 	LOG_EMERG,		
	"warn",		LOG_WARNING,		
	"warning",	LOG_WARNING,
	NULL,		-1,
};
#endif
|#
 |#
;  facility codes 
(defconstant $LOG_KERN 0)
; #define	LOG_KERN	(0<<3)	/* kernel messages */
(defconstant $LOG_USER 8)
; #define	LOG_USER	(1<<3)	/* random user-level messages */
(defconstant $LOG_MAIL 16)
; #define	LOG_MAIL	(2<<3)	/* mail system */
(defconstant $LOG_DAEMON 24)
; #define	LOG_DAEMON	(3<<3)	/* system daemons */
(defconstant $LOG_AUTH 32)
; #define	LOG_AUTH	(4<<3)	/* security/authorization messages */
(defconstant $LOG_SYSLOG 40)
; #define	LOG_SYSLOG	(5<<3)	/* messages generated internally by syslogd */
(defconstant $LOG_LPR 48)
; #define	LOG_LPR		(6<<3)	/* line printer subsystem */
(defconstant $LOG_NEWS 56)
; #define	LOG_NEWS	(7<<3)	/* network news subsystem */
(defconstant $LOG_UUCP 64)
; #define	LOG_UUCP	(8<<3)	/* UUCP subsystem */
(defconstant $LOG_CRON 72)
; #define	LOG_CRON	(9<<3)	/* clock daemon */
(defconstant $LOG_AUTHPRIV 80)
; #define	LOG_AUTHPRIV	(10<<3)	/* security/authorization messages (private) */
(defconstant $LOG_FTP 88)
; #define	LOG_FTP		(11<<3)	/* ftp daemon */
(defconstant $LOG_NETINFO 96)
; #define	LOG_NETINFO	(12<<3)	/* NetInfo */
(defconstant $LOG_REMOTEAUTH 104)
; #define	LOG_REMOTEAUTH	(13<<3)	/* remote authentication/authorization */
(defconstant $LOG_INSTALL 112)
; #define	LOG_INSTALL	(14<<3)	/* installer subsystem */
;  other codes through 15 reserved for system use 
(defconstant $LOG_LOCAL0 128)
; #define	LOG_LOCAL0	(16<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL1 136)
; #define	LOG_LOCAL1	(17<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL2 144)
; #define	LOG_LOCAL2	(18<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL3 152)
; #define	LOG_LOCAL3	(19<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL4 160)
; #define	LOG_LOCAL4	(20<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL5 168)
; #define	LOG_LOCAL5	(21<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL6 176)
; #define	LOG_LOCAL6	(22<<3)	/* reserved for local use */
(defconstant $LOG_LOCAL7 184)
; #define	LOG_LOCAL7	(23<<3)	/* reserved for local use */
(defconstant $LOG_NFACILITIES 24)
; #define	LOG_NFACILITIES	24	/* current number of facilities */
(defconstant $LOG_FACMASK 1016)
; #define	LOG_FACMASK	0x03f8	/* mask to extract facility part */
;  facility of pri 
; #define	LOG_FAC(p)	(((p) & LOG_FACMASK) >> 3)
; #ifdef SYSLOG_NAMES
#| #|
CODE facilitynames[] = {
	"auth",		LOG_AUTH,
	"authpriv",	LOG_AUTHPRIV,
	"cron", 	LOG_CRON,
	"daemon",	LOG_DAEMON,
	"ftp",		LOG_FTP,
	"install",	LOG_INSTALL,
	"kern",		LOG_KERN,
	"lpr",		LOG_LPR,
	"mail",		LOG_MAIL,
	"mark", 	INTERNAL_MARK,		
	"netinfo",	LOG_NETINFO,
	"remoteauth",	LOG_REMOTEAUTH,
	"news",		LOG_NEWS,
	"security",	LOG_AUTH,		
	"syslog",	LOG_SYSLOG,
	"user",		LOG_USER,
	"uucp",		LOG_UUCP,
	"local0",	LOG_LOCAL0,
	"local1",	LOG_LOCAL1,
	"local2",	LOG_LOCAL2,
	"local3",	LOG_LOCAL3,
	"local4",	LOG_LOCAL4,
	"local5",	LOG_LOCAL5,
	"local6",	LOG_LOCAL6,
	"local7",	LOG_LOCAL7,
	NULL,		-1,
};
#endif
|#
 |#
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
#define LOG_PRINTF	-1	
#endif
#endif
|#
 |#
; 
;  * arguments to setlogmask.
;  
; #define	LOG_MASK(pri)	(1 << (pri))		/* mask for one priority */
; #define	LOG_UPTO(pri)	((1 << ((pri)+1)) - 1)	/* all priorities through pri */
; 
;  * Option flags for openlog.
;  *
;  * LOG_ODELAY no longer does anything.
;  * LOG_NDELAY is the inverse of what it used to be.
;  
(defconstant $LOG_PID 1)
; #define	LOG_PID		0x01	/* log the pid with each message */
(defconstant $LOG_CONS 2)
; #define	LOG_CONS	0x02	/* log on the console if errors in sending */
(defconstant $LOG_ODELAY 4)
; #define	LOG_ODELAY	0x04	/* delay open until first syslog() (default) */
(defconstant $LOG_NDELAY 8)
; #define	LOG_NDELAY	0x08	/* don't delay open */
(defconstant $LOG_NOWAIT 16)
; #define	LOG_NOWAIT	0x10	/* don't wait for console forks: DEPRECATED */
(defconstant $LOG_PERROR 32)
; #define	LOG_PERROR	0x20	/* log to stderr as well */

(require-interface "sys/cdefs")
; #ifndef KERNEL
; 
;  * Don't use va_list in the vsyslog() prototype.   Va_list is typedef'd in two
;  * places (<machine/varargs.h> and <machine/stdarg.h>), so if we include one
;  * of them here we may collide with the utility's includes.  It's unreasonable
;  * for utilities to have to include one of them to include syslog.h, so we get
;  * _BSD_VA_LIST_ from <machine/ansi.h> and use it.
;  

(require-interface "machine/ansi")
#|
 confused about __P #\( #\( void #\) #\)
|#
#|
 confused about __P #\( #\( const char * #\, int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const char * #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const char * #\, _BSD_VA_LIST_ #\) #\)
|#
#| 
; #else /* !KERNEL */
; #ifdef __APPLE_API_OBSOLETE
#|





struct reg_values {
	unsigned rv_value;
	char *rv_name;
};


struct reg_desc {
	unsigned rd_mask;	
	int rd_shift;		
	char *rd_name;		
	char *rd_format;	
	struct reg_values *rd_values;	
};

#endif
|#
;  __APPLE_API_OBSOLETE 
 |#

; #endif /* !KERNEL */


; #endif /* !_SYS_SYSLOG_H_ */


(provide-interface "syslog")