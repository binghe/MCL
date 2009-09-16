(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:asp.h"
; at Sunday July 2,2006 7:26:40 pm.
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
; #ifndef _NETAT_ASP_H_
; #define _NETAT_ASP_H_

(require-interface "sys/appleapiopts")
(defconstant $ASP_Version 256)
; #define ASP_Version           0x100
(defconstant $ASPFUNC_CloseSess 1)
; #define ASPFUNC_CloseSess     1
(defconstant $ASPFUNC_Command 2)
; #define ASPFUNC_Command       2
(defconstant $ASPFUNC_GetStatus 3)
; #define ASPFUNC_GetStatus     3
(defconstant $ASPFUNC_OpenSess 4)
; #define ASPFUNC_OpenSess      4
(defconstant $ASPFUNC_Tickle 5)
; #define ASPFUNC_Tickle        5
(defconstant $ASPFUNC_Write 6)
; #define ASPFUNC_Write         6
(defconstant $ASPFUNC_WriteContinue 7)
; #define ASPFUNC_WriteContinue 7
(defconstant $ASPFUNC_Attention 8)
; #define ASPFUNC_Attention     8
(defconstant $ASPFUNC_CmdReply 9)
; #define ASPFUNC_CmdReply      9
(defconstant $ASPIOC 210)
; #define ASPIOC               210 /* AT_MID_ASP */
(defconstant $ASPIOC_ClientBind 53761)
; #define ASPIOC_ClientBind    ((ASPIOC<<8) | 1)
(defconstant $ASPIOC_CloseSession 53762)
; #define ASPIOC_CloseSession  ((ASPIOC<<8) | 2)
(defconstant $ASPIOC_GetLocEntity 53763)
; #define ASPIOC_GetLocEntity  ((ASPIOC<<8) | 3)
(defconstant $ASPIOC_GetRemEntity 53764)
; #define ASPIOC_GetRemEntity  ((ASPIOC<<8) | 4)
(defconstant $ASPIOC_GetSession 53765)
; #define ASPIOC_GetSession    ((ASPIOC<<8) | 5)
(defconstant $ASPIOC_GetStatus 53766)
; #define ASPIOC_GetStatus     ((ASPIOC<<8) | 6)
(defconstant $ASPIOC_ListenerBind 53767)
; #define ASPIOC_ListenerBind  ((ASPIOC<<8) | 7)
(defconstant $ASPIOC_OpenSession 53768)
; #define ASPIOC_OpenSession   ((ASPIOC<<8) | 8)
(defconstant $ASPIOC_StatusBlock 53769)
; #define ASPIOC_StatusBlock   ((ASPIOC<<8) | 9)
(defconstant $ASPIOC_SetPid 53770)
; #define ASPIOC_SetPid        ((ASPIOC<<8) |10)
(defconstant $ASPIOC_GetSessId 53771)
; #define ASPIOC_GetSessId     ((ASPIOC<<8) |11)
(defconstant $ASPIOC_EnableSelect 53772)
; #define ASPIOC_EnableSelect  ((ASPIOC<<8) |12)	/* not needed */
(defconstant $ASPIOC_Look 53773)
; #define ASPIOC_Look          ((ASPIOC<<8) |13)
(defconstant $MOREDATA 1)
; #define MOREDATA 1
;  The following ASP error codes are defined in Inside AppleTalk: 
(defconstant $ASPERR_NoError 0)
; #define ASPERR_NoError         0
; #define ASPERR_BadVersNum      -1066
; #define ASPERR_BufTooSmall     -1067
; #define ASPERR_NoMoreSessions  -1068
; #define ASPERR_NoServers       -1069
; #define ASPERR_ParamErr        -1070
; #define ASPERR_ServerBusy      -1071
; #define ASPERR_SessClosed      -1072
; #define ASPERR_SizeErr         -1073
; #define ASPERR_TooManyClients  -1074
; #define ASPERR_NoAck           -1075
;  These ASP error codes were apparently defined later: 
; #define ASPERR_NoSuchDevice    -1058
; #define ASPERR_BindErr         -1059
; #define ASPERR_CmdReply        -1060
; #define ASPERR_CmdRequest      -1061
; #define ASPERR_SystemErr       -1062
; #define ASPERR_ProtoErr        -1063
; #define ASPERR_NoSuchEntity    -1064
; #define ASPERR_RegisterErr     -1065
(defrecord asp_status_cmd_t
   (SLSEntityIdentifier :AT_INET)
   (Retry :AT_RETRY)
   (StatusBufferSize :signed-long)
)
(defrecord asp_open_cmd_t
   (SLSEntityIdentifier :AT_INET)
   (Retry :AT_RETRY)
   (TickleInterval :UInt16)
   (SessionTimer :UInt16)
)
(defrecord asp_cmdreply_req_t
   (Primitive :signed-long)
   (CmdResult :signed-long)
   (ReqRefNum :UInt16)
   (Filler :UInt16)
)
(defrecord asp_cmdreply_ind_t
   (Primitive :signed-long)
   (CmdResult :signed-long)
)
(defrecord asp_command_ind_t
   (Primitive :signed-long)
   (ReqRefNum :UInt16)
   (ReqType :UInt8)
   (Filler :UInt8)
)
(defrecord asp_primitives
   (:variant
   (
   (Primitive :signed-long)
   )
   (
   (CmdReplyInd :ASP_CMDREPLY_IND_T)
   )
   (
   (CmdReplyReq :ASP_CMDREPLY_REQ_T)
   )
   (
   (CommandInd :ASP_COMMAND_IND_T)
   )
   )
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

#define ASPSTATE_Close                      0
#define ASPSTATE_Idle                       1
#define ASPSTATE_WaitingForGetStatusRsp     2
#define ASPSTATE_WaitingForOpenSessRsp      3
#define ASPSTATE_WaitingForCommandRsp       4
#define ASPSTATE_WaitingForWriteContinue    5
#define ASPSTATE_WaitingForWriteRsp         6
#define ASPSTATE_WaitingForWriteContinueRsp 7
#define ASPSTATE_WaitingForCloseSessRsp     8
#ifdefNOT_USED
#define ASPSTATE_WaitingForCfgAck           9
#endif

typedef struct {
	gref_t *atp_gref; 
	int pid; 
	gbuf_t *atp_msgq; 
	unsigned char dflag; 
	unsigned char filler[3];
} atp_state_t;


typedef struct {
	unsigned char  func;
	unsigned char  param1;
	unsigned short param2;
} asp_word_t;


typedef struct asp_scb {
	gref_t *gref; 
	int pid; 
	atp_state_t *atp_state; 
	unsigned char  dflag; 
	unsigned char  state;
	unsigned char  sess_id;
	unsigned char  tmo_delta;
	unsigned char  tmo_cnt;
	unsigned char  rem_socket;
	unsigned char  rem_node;
	unsigned char  magic_num;
	unsigned short snd_seq_num;
	unsigned short rcv_seq_num;
	unsigned short filler;
	unsigned short tickle_tid;
	unsigned short tickle_interval;
	unsigned short session_timer;
	unsigned short attn_tid;
	unsigned char  attn_flag;
	unsigned char  req_flag;
	gbuf_t *req_msgq;
	unsigned short wrt_seq_num;
	unsigned char get_wait;
	unsigned char ioc_wait;
	at_retry_t cmd_retry;
	at_inet_t loc_addr;
	at_inet_t rem_addr;
	at_inet_t svc_addr;
	gbuf_t *sess_ioc;
	gbuf_t *stat_msg;
	void (*tmo_func)();
	struct asp_scb *next_tmo;
	struct asp_scb *prev_tmo;
	struct asp_scb *sess_scb;
	struct asp_scb *next_scb;
	struct asp_scb *prev_scb;
	unsigned char sel_on;		
	unsigned char user;
	unsigned char rcv_cnt;
	unsigned char snd_stop;
	unsigned char reply_socket;
	unsigned char if_num;
	unsigned char pad[2];
	atlock_t lock;
	atlock_t delay_lock;
	atevent_t event;
	atevent_t delay_event;
} asp_scb_t;

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_ASP_H_ */


(provide-interface "asp")