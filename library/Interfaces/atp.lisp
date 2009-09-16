(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:atp.h"
; at Sunday July 2,2006 7:26:51 pm.
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
;  *
;  * ORIGINS: 82
;  *
;  * (C) COPYRIGHT Apple Computer, Inc. 1992-1996
;  * All Rights Reserved
;  *
;  
;  Definitions for ATP protocol and streams module, per 
;  * AppleTalk Transaction Protocol documentation from
;  * `Inside AppleTalk', July 14, 1986.
;  
; 
;  *	Copyright (c) 1988, 1989 Apple Computer, Inc. 
;  *
;  *	The information contained herein is subject to change without
;  *	notice and  should not be  construed as a commitment by Apple
;  *	Computer, Inc. Apple Computer, Inc. assumes no responsibility
;  *	for any errors that may appear.
;  *
;  *	Confidential and Proprietary to Apple Computer, Inc.
;  
; #ifndef _NETAT_ATP_H_
; #define _NETAT_ATP_H_

(require-interface "sys/appleapiopts")
;  ATP function codes 
(defconstant $ATP_CMD_TREQ 1)
; #define ATP_CMD_TREQ		0x01	/* TRequest packet  */
(defconstant $ATP_CMD_TRESP 2)
; #define ATP_CMD_TRESP		0x02	/* TResponse packet */
(defconstant $ATP_CMD_TREL 3)
; #define ATP_CMD_TREL		0x03	/* TRelease packet  */
;  Miscellaneous definitions 
(defconstant $ATP_DEF_RETRIES 8)
; #define	ATP_DEF_RETRIES     8	/* Default for maximum retry count */
(defconstant $ATP_DEF_INTERVAL 2)
; #define	ATP_DEF_INTERVAL    2	/* Default for retry interval in seconds */
(defconstant $ATP_TRESP_MAX 8)
; #define ATP_TRESP_MAX       8	/* Maximum number of Tresp pkts */
(defconstant $ATP_HDR_SIZE 8)
; #define ATP_HDR_SIZE        8  	/* Size of the ATP header */
(defconstant $ATP_DATA_SIZE 578)
; #define ATP_DATA_SIZE       578  	/* Maximum size of the ATP data area */
;  Consts for asynch support 
(defconstant $ATP_ASYNCH_REQ 1)
; #define	ATP_ASYNCH_REQ	1
(defconstant $ATP_ASYNCH_RESP 2)
; #define	ATP_ASYNCH_RESP	2
;  Timer values for XO release timers 
(defconstant $ATP_XO_DEF_REL_TIME 0)
; #define	ATP_XO_DEF_REL_TIME	0
(defconstant $ATP_XO_30SEC 0)
; #define	ATP_XO_30SEC		0
(defconstant $ATP_XO_1MIN 1)
; #define	ATP_XO_1MIN		1
(defconstant $ATP_XO_2MIN 2)
; #define	ATP_XO_2MIN		2
(defconstant $ATP_XO_4MIN 3)
; #define	ATP_XO_4MIN		3
(defconstant $ATP_XO_8MIN 4)
; #define	ATP_XO_8MIN		4
(defrecord at_atp_t
   (cmd :UInt32)                                ;(: 2)
                                                ;(xo : 1)
                                                ;(eom : 1)
                                                ;(sts : 1)
                                                ;(xo_relt : 3)
   (bitmap :UInt8)
   (tid :ua_short)
   (user_bytes :UA_LONG)
   (data (:array :UInt8 578))
)
; #define ATP_ATP_HDR(c) ((at_atp_t *)(&((at_ddp_t *)(c))->data[0]))
; #define TOTAL_ATP_HDR_SIZE    (ATP_HDR_SIZE+DDP_X_HDR_SIZE)
; #define ATP_CLEAR_CONTROL(c)  (*(char *)(c) = 0)
;  ATP ioctl interface 
;  Structure for the atp_set_default call 
(defconstant $ATP_INFINITE_RETRIES 4294967295)
; #define	ATP_INFINITE_RETRIES	0xffffffff	/* means retry forever
(defrecord atp_set_default
   (def_retries :UInt32)
                                                ;  number of retries for a request 
   (def_rate :UInt32)
                                                ;  retry rate (in seconds/100) NB: the
; 					 * system may not be able to resolve
; 					 * delays of 100th of a second but will
; 					 * instead make a 'best effort'
; 					 
   (def_bdsp (:pointer :atpbds))                ;   BDS structure associated with this req 
   (def_BDSlen :UInt32)
                                                ;  size of BDS structure 
)
;  Return header from requests 
(defrecord atp_result
   (count :UInt16)
                                                ;  the number of packets 
   (hdr :UInt16)
                                                ;  offset to header in buffer 
   (offset (:array :UInt16 8))
                                                ;  offset to the Nth packet in the buffer 
   (len (:array :UInt16 8))
                                                ;  length of the Nth packet 
)
(defrecord atpBDS
   (bdsBuffSz :ua_short)
   (bdsBuffAddr :UA_LONG)
   (bdsDataSz :ua_short)
   (bdsUserData (:array :UInt8 4))
)
(defrecord at_atpreq
   (at_atpreq_type :UInt16)
   (at_atpreq_to :AT_INET)
   (at_atpreq_treq_user_bytes (:array :UInt8 4))
   (at_atpreq_treq_data (:pointer :u_char))
   (at_atpreq_treq_length :UInt16)
   (at_atpreq_treq_bitmap :UInt8)
   (at_atpreq_xo :UInt8)
   (at_atpreq_xo_relt :UInt8)
   (at_atpreq_retry_timeout :UInt16)
   (at_atpreq_maximum_retries :UInt16)
   (at_atpreq_tresp_user_bytes (:array :UInt8 32))
   (at_atpreq_tresp_data (:array :pointer 8))
   (at_atpreq_tresp_lengths (:array :UInt16 8))
   (at_atpreq_debug (:array :UInt32 4))
   (at_atpreq_tid :UInt16)
   (at_atpreq_tresp_bitmap :UInt8)
   (at_atpreq_tresp_eom_seqno :UInt8)
   (at_atpreq_got_trel :UInt8)
)
;  The ATP module ioctl commands 
; #define AT_ATP_CANCEL_REQUEST		(('|'<<8)|1)
; #define AT_ATP_ISSUE_REQUEST		(('|'<<8)|2) /* ALO */
; #define AT_ATP_ISSUE_REQUEST_DEF	(('|'<<8)|3) /* XO */
; #define AT_ATP_ISSUE_REQUEST_DEF_NOTE	(('|'<<8)|4) /* XO & nowait -- not needed*/
; #define AT_ATP_ISSUE_REQUEST_NOTE	(('|'<<8)|5) /* ALO & nowait */
; #define AT_ATP_GET_POLL			(('|'<<8)|6)
; #define AT_ATP_RELEASE_RESPONSE		(('|'<<8)|7)
; #define AT_ATP_REQUEST_COMPLETE		(('|'<<8)|8)
; #define AT_ATP_SEND_FULL_RESPONSE	(('|'<<8)|9) /* not used */
; #define AT_ATP_BIND_REQ			(('|'<<8)|10)
; #define AT_ATP_GET_CHANID		(('|'<<8)|11)
; #define AT_ATP_PEEK			(('|'<<8)|12)
; #define AT_ATP_ISSUE_REQUEST_TICKLE 	(('|'<<8)|13) /* ALO & nowait */
;  These macros don't really depend here, but since they're used only by the
;  * old ATP and old PAP, they're put here.  Unisoft PAP includes this file.
;  
; #define	R16(x)		UAS_VALUE(x)
; #define	W16(x,v)	UAS_ASSIGN(x, v)
; #define	C16(x,v)	UAS_UAS(x, v)
; 
;  * these are the dispatch codes for
;  * the new atp_control system call
;  
(defconstant $ATP_SENDREQUEST 0)
; #define ATP_SENDREQUEST  0
(defconstant $ATP_GETRESPONSE 1)
; #define ATP_GETRESPONSE  1
(defconstant $ATP_SENDRESPONSE 2)
; #define ATP_SENDRESPONSE 2
(defconstant $ATP_GETREQUEST 3)
; #define ATP_GETREQUEST   3
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE



#define AT_DDP_HDR(m) ((at_ddp_t *)(gbuf_rptr(m)))
#define AT_ATP_HDR(m) ((at_atp_t *)(&((at_ddp_t *)(gbuf_rptr(m)))->data[0]))



#ifdefATP_DECLARE
unsigned char atp_mask [] = {
	0x01, 0x02, 0x04, 0x08, 
	0x10, 0x20, 0x40, 0x80, 
};

unsigned char atp_lomask [] = {
	0x00, 0x01, 0x03, 0x07, 
	0x0f, 0x1f, 0x3f, 0x7f, 
	0xff
};
#elseextern unsigned char atp_mask [];
extern unsigned char atp_lomask [];
#endif



#define ATP_Q_ENTER(hdr, object, entry) {					\
		if ((hdr).head) {						\
			(hdr).head->entry.prev = (object);			\
			(object)->entry.next = (hdr).head;			\
		} else {							\
			(hdr).tail = (object);					\
			(object)->entry.next = NULL;				\
		}								\
		(object)->entry.prev = NULL;					\
		(hdr).head = (object);						\
	}

#define ATP_Q_APPEND(hdr, object, entry) {					\
		if ((hdr).head) {						\
			(hdr).tail->entry.next = (object);			\
			(object)->entry.prev = (hdr).tail;			\
		} else {							\
			(hdr).head = (object);					\
			(object)->entry.prev = NULL;				\
		}								\
		(object)->entry.next = NULL;					\
		(hdr).tail = (object);						\
	}

#define ATP_Q_REMOVE(hdr, object, entry) {					\
		if ((object)->entry.prev) {					\
			(object)->entry.prev->entry.next = (object)->entry.next;\
		} else {							\
			(hdr).head = (object)->entry.next;			\
		}								\
		if ((object)->entry.next) {					\
			(object)->entry.next->entry.prev = (object)->entry.prev;\
		} else {							\
			(hdr).tail = (object)->entry.prev;			\
		}								\
	}

struct atp_rcb_qhead {
	struct atp_rcb 	*head;
	struct atp_rcb 	*tail;
};

struct atp_rcb_q {
	struct atp_rcb *prev;
	struct atp_rcb *next;
};

struct atp_trans_qhead {
	struct atp_trans *head;
	struct atp_trans *tail;
};

struct atp_trans_q {
	struct atp_trans *prev;
	struct atp_trans *next;
};



struct atp_socket {
	u_short		net;
	at_node		node;
	at_socket	socket;
};



struct atp_trans {
	struct atp_trans_q	tr_list;		
	struct atp_state	*tr_queue;		
	gbuf_t			*tr_xmt;		
	gbuf_t			*tr_rcv[8];		
	unsigned int		tr_retry;		
	unsigned int		tr_timeout;		
	char			tr_state;		
	char			tr_rsp_wait;		
	char 			filler[2];
	unsigned char		tr_xo;			
	unsigned char		tr_bitmap;		
	unsigned short		tr_tid;			
	struct atp_socket	tr_socket;		
	struct atp_trans_q	tr_snd_wait;		
	at_socket		tr_local_socket;
	at_node			tr_local_node;
	at_net			tr_local_net;
	gbuf_t                  *tr_bdsp;               
	unsigned int		tr_tmo_delta;
	void 				(*tr_tmo_func)();
	struct atp_trans	*tr_tmo_next;
	struct atp_trans	*tr_tmo_prev;
	atlock_t tr_lock;
	atevent_t tr_event;
};

#define TRANS_TIMEOUT		0	
#define TRANS_REQUEST		1	
#define TRANS_RELEASE		2	
#define TRANS_DONE			3	
#define TRANS_FAILED		4	
#define TRANS_ABORTING		5	



struct atp_rcb {
	struct atp_rcb_q	rc_list;		
	struct atp_rcb_q        rc_tlist;
	struct atp_state	*rc_queue;		
	gbuf_t			*rc_xmt;		
	gbuf_t			*rc_ioctl;		
	char			rc_snd[8];		
	int                     rc_pktcnt;              
	short			rc_state;		
	unsigned char		rc_xo;			
	at_node			rc_local_node;
	at_net			rc_local_net;
	short			rc_rep_waiting;		
	int			rc_timestamp;		
	unsigned char		rc_bitmap;		
	unsigned char		rc_not_sent_bitmap;	
	unsigned short		rc_tid;			
	struct atp_socket	rc_socket;		
};

#define RCB_UNQUEUED		0 	
#define RCB_RESPONDING		2	
#define RCB_RESPONSE_FULL	3	
#define RCB_RELEASED		4	
#define RCB_PENDING		5	
#define RCB_NOTIFIED		6
#define RCB_SENDING		7	



struct atp_state {
	gref_t		*atp_gref;	
	int		atp_pid; 	
	gbuf_t 		*atp_msgq;	
	unsigned char	dflag; 		
	unsigned char	filler;
	short	atp_socket_no;
	short	atp_flags;	        
	struct atp_trans_qhead	atp_trans_wait;		
	struct atp_state	*atp_trans_waiting;	
	unsigned int		atp_retry;		
	unsigned int		atp_timeout;		
	struct atp_state	*atp_rcb_waiting;
	struct atp_rcb_qhead	atp_rcb;		
	struct atp_rcb_qhead	atp_attached;		
	atlock_t atp_lock;
	atevent_t atp_event;
	atlock_t atp_delay_lock;
	atevent_t atp_delay_event;
};



#define ATP_CLOSING  0x08        





#define NATP_RCB	512	
#define NATP_STATE	192	
				

#ifdefATP_DECLARE
struct atp_trans *atp_trans_free_list = NULL;	
struct atp_rcb *atp_rcb_free_list = NULL;		
struct atp_state *atp_free_list = NULL;         	
struct atp_trans_qhead	atp_trans_abort;		
struct atp_rcb* atp_rcb_data = NULL;
struct atp_state* atp_state_data=NULL;


#elseextern struct atp_trans *atp_trans_free_list;		
extern struct atp_rcb *atp_rcb_free_list;			
extern struct atp_state *atp_free_list;				
extern struct atp_rcb* atp_rcb_data;
extern struct atp_state* atp_state_data;
extern struct atp_trans_qhead atp_trans_abort;		

extern void atp_req_timeout();
extern void atp_rcb_timer();
extern void atp_x_done();
extern struct atp_rcb *atp_rcb_alloc();
extern struct atp_trans *atp_trans_alloc();
#endif


void atp_send_req(gref_t *, gbuf_t *);
void atp_drop_req(gref_t *, gbuf_t *);
void atp_send_rsp(gref_t *, gbuf_t *, int);
void atp_wput(gref_t *, gbuf_t *);
void atp_rput(gref_t *, gbuf_t *);
void atp_retry_req(void *);
void atp_stop(gbuf_t *, int);
void atp_cancel_req(gref_t *, unsigned short);
int atp_open(gref_t *, int);
int atp_bind(gref_t *, unsigned int, unsigned char *);
int atp_close(gref_t *, int);
gbuf_t *atp_build_release(struct atp_trans *);
void atp_req_timeout(struct atp_trans *);
void atp_free(struct atp_trans *);
void atp_x_done(struct atp_trans *);
void atp_send(struct atp_trans *);
void atp_rsp_ind(struct atp_trans *, gbuf_t *);
void atp_trans_free(struct atp_trans *);
void atp_reply(struct atp_rcb *);
void atp_rcb_free(struct atp_rcb *);
void atp_send_replies(struct atp_state *, struct atp_rcb *);
void atp_dequeue_atp(struct atp_state *);
int atp_iocack(struct atp_state *, gbuf_t *);
void atp_req_ind(struct atp_state *, gbuf_t *);
int atp_iocnak(struct atp_state *, gbuf_t *, int);
void atp_trp_timer(void *, int);
void atp_timout(void (*func)(), struct atp_trans *, int);
void atp_untimout(void (*func)(), struct atp_trans *);
int atp_tid(struct atp_state *);

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_ATP_H_ */


(provide-interface "atp")