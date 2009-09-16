(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sysglue.h"
; at Sunday July 2,2006 7:32:00 pm.
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
;  * Title:	sysglue.h - AppleTalk protocol to Unix System V/streams interface
;  *
;  * Facility:	AppleTalk Protocol Execution Environment
;  *
;  * Author:	Gregory Burns, Creation Date: Jun-3-1988
;  *
;  * History:
;  * X01-001	Gregory Burns	3-Jun-1988
;  *	 	Initial Creation.
;  *
;  
; #ifndef _NETAT_SYSGLUE_H_
; #define _NETAT_SYSGLUE_H_

(require-interface "sys/appleapiopts")
;  
;    The following is originally from netat/h/localglue.h, which was 
;    included in netat/h/sysglue.h:
; 
(defrecord ioccmd_t
   (ic_cmd :signed-long)
   (ic_timout :signed-long)
   (ic_len :signed-long)
   (ic_dp (:pointer :char))
)
(defrecord ioc_t
   (ioc_cmd :signed-long)
   (ioc_cr :pointer)
   (ioc_id :signed-long)
   (ioc_count :signed-long)
   (ioc_error :signed-long)
   (ioc_rval :signed-long)
   (ioc_private :pointer)
   (ioc_filler (:array :signed-long 4))
)
; 
;  * Want these definitions outside the KERNEL define for admin
;  * program access.
;  
; #ifdef _AIX
#| #|
#define MSG_DATA	0x00
#define MSG_PROTO	0x01
#define MSG_IOCTL	0x0e
#define MSG_ERROR	0x8a
#define MSG_HANGUP	0x89
#define MSG_IOCACK	0x81
#define MSG_IOCNAK	0x82
#define MSG_CTL		0x0d
|#
 |#

; #else
;  ### LD 5/3/97 MacOSX porting note:
;  * Cannot use MSG_DATA = 0, because MT_FREE is defined as 0
;  * and the sanity check in m_free cause a panic.
;  
; #define MSG_DATA	(MT_MAX - 1)
; #define MSG_PROTO	(MT_MAX - 2)
; #define MSG_IOCTL	(MT_MAX - 3)
; #define MSG_ERROR	(MT_MAX - 4)
; #define MSG_HANGUP	(MT_MAX - 5)
; #define MSG_IOCACK	(MT_MAX - 6)
; #define MSG_IOCNAK	(MT_MAX - 7)
; #define MSG_CTL		(MT_MAX - 8)

; #endif

; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

#define SYS_HZ HZ 	
#define HZ hz		


#define ENOTREADY 	ESHUTDOWN
#define EPROTO 		EPROTOTYPE


#define T_MPSAFE	0

#define INTERRUPTIBLE   1
#define POLLIN 		0x0001
#define POLLOUT 	0x0002
#define POLLPRI 	0x0004
#define POLLMSG 	0x0080
#define POLLSYNC 	0x8000
#define POLLMSG 	0x0080



#define DTYPE_ATALK -1

#define AT_WR_OFFSET 38
#ifndefEVENT_NULL
#define EVENT_NULL   -1
#define LOCK_HANDLER  2
#endiftypedef int atevent_t;

typedef simple_lock_t atlock_t;
typedef int *atomic_p; 
#define ATLOCKINIT(a)  (a = (atlock_t) EVENT_NULL)
#define ATDISABLE(l, a) (l = splimp())
#define ATENABLE(l, a)  splx(l)
#define ATEVENTINIT(a)  (a = (atevent_t) EVENT_NULL)
#define DDP_OUTPUT(m) ddp_putmsg(0,m)
#define StaticProc static

#define PRI_LO	1
#define PRI_MED	2
#define PRI_HI	3

typedef struct mbuf gbuf_t;



struct mbuf *m_lgbuf_alloc(int size, int wait);
gbuf_t *gbuf_alloc_wait(int size, int wait);
gbuf_t *gbuf_copym(gbuf_t *mlist);
gbuf_t *gbuf_strip(gbuf_t *m);
int gbuf_freel(gbuf_t *m);
void gbuf_linkb(gbuf_t *m1, gbuf_t *m2);
void gbuf_linkpkt(gbuf_t *m1, gbuf_t *m2);
int gbuf_msgsize(gbuf_t *m);

#define gbuf_cont(m)	m->m_next
#define gbuf_next(m)	m->m_nextpkt
#define gbuf_rptr(m)	m->m_data
#define gbuf_rinc(m,len)	{m->m_data += len; m->m_len -= len;}
#define gbuf_rdec(m,len)	{m->m_data -= len; m->m_len += len;}
#define gbuf_wptr(m)	(m->m_data + m->m_len)
#define gbuf_winc(m,len)	(m->m_len += len)
#define gbuf_wdec(m,len)	(m->m_len -= len)
#define gbuf_wset(m,len)	(m->m_len = len)
#define gbuf_type(m)	m->m_type
#define gbuf_len(m)	m->m_len

#define gbuf_alloc(size, pri) (gbuf_alloc_wait(size, FALSE))
#define gbuf_copym(mlist) ((gbuf_t *)copy_pkt(mlist, -1))

#define gbuf_prepend(m,len) M_PREPEND(m,len,M_DONTWAIT)
#define gbuf_freem(mlist) m_freem((struct mbuf *)mlist)
#define gbuf_freeb(m) (void)m_free((struct mbuf *)m)
#define gbuf_set_type(m, mtype) MCHTYPE(m, mtype)


#define gbuf_dupb_wait(m, wait) ((gbuf_t *)m_copym(m, 0, gbuf_len(m), (wait)? M_WAIT: M_DONTWAIT))
#define gbuf_dupb(m) (gbuf_dupb_wait(m, FALSE))

#define gbuf_dupm(mlist) ((gbuf_t *)copy_pkt(mlist, -1))
  

#undef timeoutcf
#undef timeout
#undef untimeout

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_SYSGLUE_H_ */


(provide-interface "sysglue")