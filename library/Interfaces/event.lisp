(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:event.h"
; at Sunday July 2,2006 7:27:46 pm.
; 
;  * Copyright (c) 2003 Apple Computer, Inc. All rights reserved.
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
; -
;  * Copyright (c) 1999,2000,2001 Jonathan Lemon <jlemon@FreeBSD.org>
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
;  *
;  * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
;  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
;  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;  * SUCH DAMAGE.
;  *
;  *	$FreeBSD: src/sys/sys/event.h,v 1.5.2.5 2001/12/14 19:21:22 jlemon Exp $
;  
; #ifndef _SYS_EVENT_H_
; #define _SYS_EVENT_H_
(defconstant $EVFILT_READ -1)
; #define EVFILT_READ		(-1)
(defconstant $EVFILT_WRITE -2)
; #define EVFILT_WRITE		(-2)
(defconstant $EVFILT_AIO -3)
; #define EVFILT_AIO		(-3)	/* attached to aio requests */
(defconstant $EVFILT_VNODE -4)
; #define EVFILT_VNODE		(-4)	/* attached to vnodes */
(defconstant $EVFILT_PROC -5)
; #define EVFILT_PROC		(-5)	/* attached to struct proc */
(defconstant $EVFILT_SIGNAL -6)
; #define EVFILT_SIGNAL		(-6)	/* attached to struct proc */
(defconstant $EVFILT_TIMER -7)
; #define EVFILT_TIMER		(-7)	/* timers */
(defconstant $EVFILT_MACHPORT -8)
; #define EVFILT_MACHPORT		(-8)	/* Mach ports */
(defconstant $EVFILT_FS -9)
; #define EVFILT_FS		(-9)	/* Filesystem events */
(defconstant $EVFILT_SYSCOUNT 9)
; #define EVFILT_SYSCOUNT		9
(defrecord kevent
   (ident :uintptr_t)
#|
; Warning: type-size: unknown type UINTPTR_T
|#
                                                ;  identifier for this event 
   (filter :SInt16)
                                                ;  filter for event 
   (flags :UInt16)
   (fflags :UInt32)
   (data :intptr_t)
#|
; Warning: type-size: unknown type INTPTR_T
|#
   (udata :pointer)
                                                ;  opaque user data identifier 
)
; #define EV_SET(kevp, a, b, c, d, e, f) do {		struct kevent *__kevp__ = (kevp);		__kevp__->ident = (a);				__kevp__->filter = (b);				__kevp__->flags = (c);				__kevp__->fflags = (d);				__kevp__->data = (e);				__kevp__->udata = (f);			} while(0)
;  actions 
(defconstant $EV_ADD 1)
; #define EV_ADD		0x0001		/* add event to kq (implies enable) */
(defconstant $EV_DELETE 2)
; #define EV_DELETE	0x0002		/* delete event from kq */
(defconstant $EV_ENABLE 4)
; #define EV_ENABLE	0x0004		/* enable event */
(defconstant $EV_DISABLE 8)
; #define EV_DISABLE	0x0008		/* disable event (not reported) */
;  flags 
(defconstant $EV_ONESHOT 16)
; #define EV_ONESHOT	0x0010		/* only report one occurrence */
(defconstant $EV_CLEAR 32)
; #define EV_CLEAR	0x0020		/* clear event state after reporting */
(defconstant $EV_SYSFLAGS 61440)
; #define EV_SYSFLAGS	0xF000		/* reserved by system */
(defconstant $EV_FLAG1 8192)
; #define EV_FLAG1	0x2000		/* filter-specific flag */
;  returned values 
(defconstant $EV_EOF 32768)
; #define EV_EOF		0x8000		/* EOF detected */
(defconstant $EV_ERROR 16384)
; #define EV_ERROR	0x4000		/* error, data contains errno */
; 
;  * data/hint flags for EVFILT_{READ|WRITE}, shared with userspace
;  
(defconstant $NOTE_LOWAT 1)
; #define NOTE_LOWAT	0x0001			/* low water mark */
; 
;  * data/hint flags for EVFILT_VNODE, shared with userspace
;  
(defconstant $NOTE_DELETE 1)
; #define	NOTE_DELETE	0x0001			/* vnode was removed */
(defconstant $NOTE_WRITE 2)
; #define	NOTE_WRITE	0x0002			/* data contents changed */
(defconstant $NOTE_EXTEND 4)
; #define	NOTE_EXTEND	0x0004			/* size increased */
(defconstant $NOTE_ATTRIB 8)
; #define	NOTE_ATTRIB	0x0008			/* attributes changed */
(defconstant $NOTE_LINK 16)
; #define	NOTE_LINK	0x0010			/* link count changed */
(defconstant $NOTE_RENAME 32)
; #define	NOTE_RENAME	0x0020			/* vnode was renamed */
(defconstant $NOTE_REVOKE 64)
; #define	NOTE_REVOKE	0x0040			/* vnode access was revoked */
; 
;  * data/hint flags for EVFILT_PROC, shared with userspace
;  
(defconstant $NOTE_EXIT 2147483648)
; #define	NOTE_EXIT	0x80000000		/* process exited */
(defconstant $NOTE_FORK 1073741824)
; #define	NOTE_FORK	0x40000000		/* process forked */
(defconstant $NOTE_EXEC 536870912)
; #define	NOTE_EXEC	0x20000000		/* process exec'd */
(defconstant $NOTE_PCTRLMASK 4026531840)
; #define	NOTE_PCTRLMASK	0xf0000000		/* mask for hint bits */
(defconstant $NOTE_PDATAMASK 1048575)
; #define	NOTE_PDATAMASK	0x000fffff		/* mask for pid */
;  additional flags for EVFILT_PROC 
(defconstant $NOTE_TRACK 1)
; #define	NOTE_TRACK	0x00000001		/* follow across forks */
(defconstant $NOTE_TRACKERR 2)
; #define	NOTE_TRACKERR	0x00000002		/* could not track child */
(defconstant $NOTE_CHILD 4)
; #define	NOTE_CHILD	0x00000004		/* am a child process */
; #ifdef KERNEL_PRIVATE
#| #|

#include <sysqueue.h> 

#ifdefMALLOC_DECLARE
MALLOC_DECLARE(M_KQUEUE);
#endif

#define NOTE_SIGNAL	0x08000000

struct knote {
	
#if0
	struct			wait_queue_link kn_wql;	 
#else	SLIST_ENTRY(knote)	kn_selnext;	
	void		       *kn_type;	
	struct klist	       *kn_list;	
	SLIST_ENTRY(knote)	kn_link;	
	struct			kqueue *kn_kq;	
#endif	TAILQ_ENTRY(knote)	kn_tqe;		
	union {
		struct		file *p_fp;	
		struct		proc *p_proc;	
	} kn_ptr;
	struct			filterops *kn_fop;
	int			kn_status;
	int			kn_sfflags;	
	struct 			kevent kn_kevent;
	intptr_t		kn_sdata;	
	caddr_t			kn_hook;
#define KN_ACTIVE	0x01			
#define KN_QUEUED	0x02			
#define KN_DISABLED	0x04			
#define KN_DETACHED	0x08			

#define kn_id		kn_kevent.ident
#define kn_filter	kn_kevent.filter
#define kn_flags	kn_kevent.flags
#define kn_fflags	kn_kevent.fflags
#define kn_data		kn_kevent.data
#define kn_fp		kn_ptr.p_fp
};

struct filterops {
	int	f_isfd;		
	int	(*f_attach)	__P((struct knote *kn));
	void	(*f_detach)	__P((struct knote *kn));
	int	(*f_event)	__P((struct knote *kn, long hint));
};

struct proc;

SLIST_HEAD(klist, knote);
extern void	klist_init(struct klist *list);

#define KNOTE(list, hint)	knote(list, hint)
#define KNOTE_ATTACH(list, kn)	knote_attach(list, kn)
#define KNOTE_DETACH(list, kn)	knote_detach(list, kn)


extern void	knote(struct klist *list, long hint);
extern int	knote_attach(struct klist *list, struct knote *kn);
extern int	knote_detach(struct klist *list, struct knote *kn);
extern void	knote_remove(struct proc *p, struct klist *list);
extern void	knote_fdclose(struct proc *p, int fd);
extern int 	kqueue_register(struct kqueue *kq,
		    struct kevent *kev, struct proc *p);

|#
 |#

; #else 	/* !KERNEL_PRIVATE */
; 
;  * This is currently visible to userland to work around broken
;  * programs which pull in <sys/proc.h> or <sys/select.h>.
;  

(require-interface "sys/queue")

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( void #\) #\)
|#
#|
 confused about __P #\( #\( int kq #\, const struct kevent * changelist #\, int nchanges #\, struct kevent * eventlist #\, int nevents #\, const struct timespec * timeout #\) #\)
|#

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|
#include <machmach.h>

__BEGIN_DECLS
mach_port_t	kqueue_portset_np __P((int kq));
int	kqueue_from_portset_np __P((mach_port_t portset));
__END_DECLS
#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* !KERNEL_PRIVATE */


; #endif /* !_SYS_EVENT_H_ */


(provide-interface "event")