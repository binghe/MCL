(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sem.h"
; at Sunday July 2,2006 7:31:54 pm.
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
; 	$NetBSD: sem.h,v 1.5 1994/06/29 06:45:15 cgd Exp $	
; 
;  * SVID compatible sem.h file
;  *
;  * Author:  Daniel Boulet
;  
; 
;  * John Bellardo modified the implementation for Darwin. 12/2000
;  
; #ifndef _SYS_SEM_H_
; #define _SYS_SEM_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/ipc")
(defrecord sem
   (semval :UInt16)
                                                ;  semaphore value 
   (sempid :SInt32)
                                                ;  pid of last operation 
   (semncnt :UInt16)
                                                ;  # awaiting semval > cval 
   (semzcnt :UInt16)
                                                ;  # awaiting semval = 0 
)
(defrecord semid_ds
   (sem_perm :IPC_PERM)
                                                ;  operation permission struct 
   (sem_base (:pointer :SEM))
                                                ;  pointer to first semaphore in set 
   (sem_nsems :UInt16)
                                                ;  number of sems in set 
   (sem_otime :signed-long)
                                                ;  last operation time 
   (sem_pad1 :signed-long)
                                                ;  SVABI/386 says I need this here 
   (sem_ctime :signed-long)
                                                ;  last change time 
                                                ;  Times measured in secs since 
                                                ;  00:00:00 GMT, Jan. 1, 1970 
   (sem_pad2 :signed-long)
                                                ;  SVABI/386 says I need this here 
   (sem_pad3 (:array :signed-long 4))
                                                ;  SVABI/386 says I need this here 
)
; 
;  * semop's sops parameter structure
;  
(defrecord sembuf
   (sem_num :UInt16)
                                                ;  semaphore # 
   (sem_op :SInt16)
                                                ;  semaphore operation 
   (sem_flg :SInt16)
                                                ;  operation flags 
)
(defconstant $SEM_UNDO 10000)
; #define SEM_UNDO	010000
(defconstant $MAX_SOPS 5)
; #define MAX_SOPS	5	/* maximum # of sembuf's per semop call */
; 
;  * semctl's arg parameter structure
;  
(defrecord semun
   (:variant
   (
   (val :signed-long)
   )
                                                ;  value for SETVAL 
   (
   (buf (:pointer :SEMID_DS))
   )
                                                ;  buffer for IPC_STAT & IPC_SET 
   (
   (array (:pointer :u_short))
   )
                                                ;  array for GETALL & SETALL 
   )
)
; 
;  * commands for semctl
;  
(defconstant $GETNCNT 3)
; #define GETNCNT	3	/* Return the value of semncnt {READ} */
(defconstant $GETPID 4)
; #define GETPID	4	/* Return the value of sempid {READ} */
(defconstant $GETVAL 5)
; #define GETVAL	5	/* Return the value of semval {READ} */
(defconstant $GETALL 6)
; #define GETALL	6	/* Return semvals into arg.array {READ} */
(defconstant $GETZCNT 7)
; #define GETZCNT	7	/* Return the value of semzcnt {READ} */
(defconstant $SETVAL 8)
; #define SETVAL	8	/* Set the value of semval to arg.val {ALTER} */
(defconstant $SETALL 9)
; #define SETALL	9	/* Set semvals from arg.array {ALTER} */
; 
;  * Permissions
;  
(defconstant $SEM_A 200)
; #define SEM_A		0200	/* alter permission */
(defconstant $SEM_R 400)
; #define SEM_R		0400	/* read permission */
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

#define SEMVMX	32767		
#define SEMAEM	16384		



#ifndefSEMMNS			
#define SEMMNS	(1048576sizeof(struct sem))
#endif			
#ifndefSEMMNI			
#define SEMMNI	SEMMNS		
#endif#ifndefSEMUME
#define SEMUME	10		
#endif#ifndefSEMMNU			
#define SEMMNU	SEMMNS		
#endif			


#ifndefSEMMAP
#define SEMMAP	30		
#endif#ifndefSEMMSL
#define SEMMSL	SEMMNS		
#endif#ifndefSEMOPM
#define SEMOPM	100		
#endif


struct sem_undo {
	struct	sem_undo *un_next;	
	struct	proc *un_proc;		
	short	un_cnt;			
	struct undo {
		short	un_adjval;	
		short	un_num;		
		int	un_id;		
	} un_ent[SEMUME];		
};


struct seminfo {
	int	semmap,		
		semmni,		
		semmns,		
		semmnu,		
		semmsl,		
		semopm,		
		semume,		
		semusz,		
		semvmx,		
		semaem;		
};
extern struct seminfo	seminfo;


#define SEM_ALLOC	01000	
#define SEM_DEST	02000	

#define SEMMNI_INC	8	
#define SEMMNS_INC	64	
#define SEMMNU_INC	32	







#define SEMUSZ		sizeof(struct sem_undo)

extern struct semid_ds *sema;	
extern struct sem *sem;		

extern struct sem_undo	*semu;		




#define SEMU(ix)        (&semu[ix])



void	semexit __P((struct proc *p));


typedef enum {
	SEM_CONFIG_FREEZE,	
	SEM_CONFIG_THAW		
} semconfig_ctl_t;

#endif

#endif
|#
 |#
;  KERNEL 
; #ifndef KERNEL

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( int #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, int #\, \... #\) #\)
|#
#|
 confused about __P #\( #\( key_t #\, int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct sembuf * #\, unsigned #\) #\)
|#

; #endif /* !KERNEL */


; #endif /* !_SEM_H_ */


(provide-interface "sem")