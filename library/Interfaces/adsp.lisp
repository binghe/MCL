(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:adsp.h"
; at Sunday July 2,2006 7:25:31 pm.
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
; #ifndef _NETAT_ADSP_H_
; #define _NETAT_ADSP_H_

(require-interface "sys/appleapiopts")
;  ADSP flags for read, write, and close routines 
(defconstant $ADSP_EOM 1)
; #define	ADSP_EOM	0x01	/* Sent or received EOM with data */
(defconstant $ADSP_FLUSH 2)
; #define ADSP_FLUSH	0x02	/* Send all data in send queue */
(defconstant $ADSP_WAIT 4)
; #define	ADSP_WAIT	0x04	/* Graceful close, wait 'til snd queue emptys */
;  ADSP events to be fielded by the user event handler 
(defconstant $ADSP_EV_ATTN 2)
; #define	ADSP_EV_ATTN 	0x02	/* Attention data recvd. */
(defconstant $ADSP_EV_RESET 4)
; #define	ADSP_EV_RESET	0x04	/* Forward reset recvd. */
(defconstant $ADSP_EV_CLOSE 8)
; #define	ADSP_EV_CLOSE	0x08	/* Close advice recvd. */
;  ADSP packet control codes 
(defconstant $ADSP_PROBEACK 0)
; #define ADSP_PROBEACK 0			/* Probe or acknowledgement */
(defconstant $ADSP_OPENCONREQUEST 1)
; #define ADSP_OPENCONREQUEST 1		/* Open connection request */
(defconstant $ADSP_OPENCONACK 2)
; #define ADSP_OPENCONACK 2		/* Open connection acknowledgement */
(defconstant $ADSP_OPENCONREQACK 3)
; #define ADSP_OPENCONREQACK 3		/* Open connection request + ack */
(defconstant $ADSP_OPENCONDENIAL 4)
; #define ADSP_OPENCONDENIAL 4		/* Open connection denial */
(defconstant $ADSP_CLOSEADVICE 5)
; #define ADSP_CLOSEADVICE 5		/* Close connection advice */
(defconstant $ADSP_FORWARDRESET 6)
; #define ADSP_FORWARDRESET 6		/* Forward reset */
(defconstant $ADSP_FORWARDRESETACK 7)
; #define ADSP_FORWARDRESETACK 7		/* Forward reset acknowledgement */
(defconstant $ADSP_RETRANSADVICE 8)
; #define ADSP_RETRANSADVICE 8		/* Retransmit advice */
;  Miscellaneous constants 
(defconstant $ADSP_MAXDATA 572)
; #define ADSP_MAXDATA		572	/* Maximum data bytes in ADSP packet */
(defconstant $ADSP_MAXATTNDATA 570)
; #define ADSP_MAXATTNDATA	570	/* Maximum data bytes in attn msg */
(defconstant $ADSP_DDPTYPE 7)
; #define ADSP_DDPTYPE		7	/* DDP protocol type for ADSP */
(defconstant $ADSP_VERSION 256)
; #define ADSP_VERSION		0x0100	/* ADSP version */
;  Some additional ADSP error codes 
(defconstant $EQUEWASEMP 10001)
; #define	EQUEWASEMP	10001
(defconstant $EONEENTQUE 10002)
; #define EONEENTQUE	10002
(defconstant $EQUEBLOCKED 10003)
; #define	EQUEBLOCKED	10003
(defconstant $EFWDRESET 10004)
; #define	EFWDRESET	10004
(defconstant $EENDOFMSG 10005)
; #define	EENDOFMSG	10005
(defconstant $EADDRNOTINUSE 10006)
; #define	EADDRNOTINUSE	10006
;  Tuning Parameter Block 
(defrecord tpb
   (Valid (:pointer :callback))                 ;(UInt32 colon13)
                                                ;  Tuning parameter block is valid 
   (TransThresh :UInt16)
                                                ;  Transmit threshold 
   (TransTimerIntrvl :UInt32)
                                                ;  Transmit timer interval 
   (SndWdwCloThresh :UInt16)
                                                ;  Send window closing threshold 
   (SndWdwCloIntrvl :UInt32)
                                                ;  Send window closed interval 
   (SndWdwCloBckoff :UInt8)
                                                ;  Send window closed backoff rate 
   (ReTransIntrvl :UInt32)
                                                ;  Retransmit interval 
   (ReTransBckoff :UInt8)
                                                ;  Retransmit backoff rate 
   (RestartIntrvl :UInt32)
                                                ;  Restart sender interval 
   (RestartBckoff :UInt8)
                                                ;  Restart sender backoff rate 
   (SndQBufSize :UInt32)
                                                ;  Send queue buffer size 
   (RcvQMaxSize :UInt16)
                                                ;  Maximum size of the receive queue 
   (RcvQCpyThresh :UInt16)
                                                ;  Receive queue copy threshold 
   (FwdRstIntrvl :UInt32)
                                                ;  Forward reset interval 
   (FwdRstBckoff :UInt8)
                                                ;  Forward reset backoff rate 
   (AttnIntrvl :UInt32)
                                                ;  Retransmit attn msg interval 
   (AttnBckoff :UInt8)
                                                ;  Retransmit attn msg backoff rate 
   (OpenIntrvl :UInt32)
                                                ;  Retransmit open request interval 
   (OpenMaxRetry :UInt8)
                                                ;  Open request maximum retrys 
   (RetransThresh :UInt8)
                                                ;  Retransmit advice threshold 
   (ProbeRetryMax :UInt32)
                                                ;  Maximum number of probes 
   (SndByteCntMax :UInt32)
                                                ;  Maximum number bytes in send queue 
)
;  Tuning Parameter Tags 
(defconstant $ADSP_TRANSTHRESH 1)
; #define	ADSP_TRANSTHRESH	 1	/* Transmit threshold */
(defconstant $ADSP_TRANSTIMERINTRVL 2)
; #define	ADSP_TRANSTIMERINTRVL	 2	/* Transmit timer interval */
(defconstant $ADSP_SNDWDWCLOTHRESH 3)
; #define	ADSP_SNDWDWCLOTHRESH	 3	/* Send window closing threshold */
(defconstant $ADSP_SNDWDWCLOINTRVL 4)
; #define	ADSP_SNDWDWCLOINTRVL	 4	/* Send window closed interval */
(defconstant $ADSP_SNDWDWCLOBCKOFF 5)
; #define	ADSP_SNDWDWCLOBCKOFF	 5	/* Send window closed backoff rate */
(defconstant $ADSP_RETRANSINTRVL 6)
; #define	ADSP_RETRANSINTRVL	 6	/* Retransmit interval */
(defconstant $ADSP_RETRANSBCKOFF 7)
; #define	ADSP_RETRANSBCKOFF	 7	/* Retransmit backoff rate */
(defconstant $ADSP_RESTARTINTRVL 8)
; #define	ADSP_RESTARTINTRVL	 8	/* Restart sender interval */
(defconstant $ADSP_RESTARTBCKOFF 9)
; #define	ADSP_RESTARTBCKOFF	 9	/* Restart sender backoff rate */
(defconstant $ADSP_SNDQBUFSIZE 10)
; #define	ADSP_SNDQBUFSIZE	 10	/* Send queue buffer size */
(defconstant $ADSP_RCVQMAXSIZE 11)
; #define	ADSP_RCVQMAXSIZE	 11	/* Receive queue maximum size */
(defconstant $ADSP_RCVQCPYTHRESH 12)
; #define	ADSP_RCVQCPYTHRESH	 12	/* Receive queue copy threshold */
(defconstant $ADSP_FWDRSTINTRVL 13)
; #define	ADSP_FWDRSTINTRVL	 13	/* Forward reset retransmit interval */
(defconstant $ADSP_FWDRSTBCKOFF 14)
; #define	ADSP_FWDRSTBCKOFF	 14	/* Forward reset backoff rate */
(defconstant $ADSP_ATTNINTRVL 15)
; #define	ADSP_ATTNINTRVL		 15	/* Rexmit attention message interval */
(defconstant $ADSP_ATTNBCKOFF 16)
; #define	ADSP_ATTNBCKOFF		 16	/* Attention message backoff rate */
(defconstant $ADSP_OPENINTRVL 17)
; #define	ADSP_OPENINTRVL		 17	/* Retransmit open request interval */
(defconstant $ADSP_OPENMAXRETRY 18)
; #define	ADSP_OPENMAXRETRY	 18	/* Open request max retrys */
(defconstant $ADSP_RETRANSTHRESH 19)
; #define	ADSP_RETRANSTHRESH	 19	/* Retransmit advice threshold */
(defconstant $ADSP_PROBERETRYMAX 20)
; #define	ADSP_PROBERETRYMAX	 20
(defconstant $ADSP_SNDBYTECNTMAX 21)
; #define	ADSP_SNDBYTECNTMAX	 21
(defconstant $TuneParamCnt 21)
; #define TuneParamCnt 21			/* The number of tuning parameters */
;  Connection Status Tags 
(defconstant $ADSP_STATE 1)
; #define	ADSP_STATE		 1	/* The connection state */
(defconstant $ADSP_SNDSEQ 2)
; #define	ADSP_SNDSEQ		 2	/* Send sequence number */
(defconstant $ADSP_FIRSTRTMTSEQ 3)
; #define	ADSP_FIRSTRTMTSEQ	 3	/* First retransmit sequence number */
(defconstant $ADSP_SNDWDWSEQ 4)
; #define	ADSP_SNDWDWSEQ	  	 4	/* Send window sequence number */
(defconstant $ADSP_RCVSEQ 5)
; #define	ADSP_RCVSEQ		 5	/* Receive sequence number */
(defconstant $ADSP_ATTNSNDSEQ 6)
; #define	ADSP_ATTNSNDSEQ	 	 6	/* Attn msg send sequence number */
(defconstant $ADSP_ATTNRCVSEQ 7)
; #define	ADSP_ATTNRCVSEQ	 	 7	/* Attn msg receive sequence number */
(defconstant $ADSP_RCVWDW 8)
; #define	ADSP_RCVWDW		 8	/* Receive window size */
(defconstant $ADSP_ATTNMSGWAIT 9)
; #define	ADSP_ATTNMSGWAIT	 9	/* Attn msg is in the receive queue */
(defconstant $ConStatTagCnt 9)
; #define ConStatTagCnt 9			/* Number of connection status tags */
(defconstant $ADSP_INVALID 0)
; #define	ADSP_INVALID	 	0       /* Invalid connection control block */
(defconstant $ADSP_LISTEN 1)
; #define	ADSP_LISTEN	 	1       /* Waiting for an open con req */
(defconstant $ADSP_OPENING 2)
; #define	ADSP_OPENING	 	2     	/* No state info, sending open req */
(defconstant $ADSP_MYHALFOPEN 4)
; #define	ADSP_MYHALFOPEN		4   	/* His state info, sending open req */
(defconstant $ADSP_HISHALFOPEN 8)
; #define	ADSP_HISHALFOPEN	8  	/* He has my state info, sndng op req */
(defconstant $ADSP_OPEN 16)
; #define	ADSP_OPEN	 	16     	/* Connection is operational */
(defconstant $ADSP_TORNDOWN 32)
; #define	ADSP_TORNDOWN	 	32     	/* Probe timer has expired 4 times */
(defconstant $ADSP_CLOSING 64)
; #define	ADSP_CLOSING	 	64	/* Client close, emptying send Queues */
(defconstant $ADSP_CLOSED 128)
; #define	ADSP_CLOSED	 	128	/* Close adv rcvd, emptying rcv Queues */
;  Management Counters 
(defconstant $ADSP_ATTNACKRCVD 1)
; #define	ADSP_ATTNACKRCVD	 1	/* Attn msg ack received */
(defconstant $ADSP_ATTNACKACPTD 2)
; #define	ADSP_ATTNACKACPTD	 2	/* Attn msg ack accepted */
(defconstant $ADSP_PROBERCVD 3)
; #define	ADSP_PROBERCVD	 	 3	/* Probe received */
(defconstant $ADSP_ACKRCVD 4)
; #define	ADSP_ACKRCVD		 4	/* Explicit ack msg received */
(defconstant $ADSP_FWDRSTRCVD 5)
; #define	ADSP_FWDRSTRCVD	 	 5	/* Forward reset received */
(defconstant $ADSP_FWDRSTACPTD 6)
; #define	ADSP_FWDRSTACPTD	 6	/* Forward reset accepted */
(defconstant $ADSP_FWDRSTACKRCVD 7)
; #define	ADSP_FWDRSTACKRCVD	 7	/* Forward reset ack received */
(defconstant $ADSP_FWDRSTACKACPTD 8)
; #define	ADSP_FWDRSTACKACPTD	 8	/* Forward reset ack accepted */
(defconstant $ADSP_ATTNRCVD 9)
; #define	ADSP_ATTNRCVD		 9	/* Attn msg received */
(defconstant $ADSP_ATTNACPTD 10)
; #define	ADSP_ATTNACPTD	   	 10	/* Attn msg accepted */
(defconstant $ADSP_DATARCVD 11)
; #define	ADSP_DATARCVD		 11	/* Data msg received */
(defconstant $ADSP_DATAACPTD 12)
; #define	ADSP_DATAACPTD	  	 12	/* Data msg Accepted */
(defconstant $ADSP_ACKFIELDCHKD 13)
; #define	ADSP_ACKFIELDCHKD	 13	/* Ack field checked */
(defconstant $ADSP_ACKNRSFIELDACPTD 14)
; #define	ADSP_ACKNRSFIELDACPTD	 14	/* Next receive seq field accepted */
(defconstant $ADSP_ACKSWSFIELDACPTD 15)
; #define	ADSP_ACKSWSFIELDACPTD	 15	/* Send window seq field accepted */
(defconstant $ADSP_ACKREQSTD 16)
; #define	ADSP_ACKREQSTD	 	 16	/* Ack requested */
(defconstant $ADSP_LOWMEM 17)
; #define	ADSP_LOWMEM		 17	/* Low memory */
(defconstant $ADSP_OPNREQEXP 18)
; #define	ADSP_OPNREQEXP	 	 18	/* Open request timer expired */
(defconstant $ADSP_PROBEEXP 19)
; #define	ADSP_PROBEEXP	  	 19	/* Probe timer expired */
(defconstant $ADSP_FWDRSTEXP 20)
; #define	ADSP_FWDRSTEXP	 	 20	/* Forward reset timer expired */
(defconstant $ADSP_ATTNEXP 21)
; #define	ADSP_ATTNEXP	 	 21	/* Attention timer expired */
(defconstant $ADSP_TRANSEXP 22)
; #define	ADSP_TRANSEXP	         22	/* Transmit timer expired */
(defconstant $ADSP_RETRANSEXP 23)
; #define	ADSP_RETRANSEXP	 	 23	/* Retransmit timer expired */
(defconstant $ADSP_SNDWDWCLOEXP 24)
; #define	ADSP_SNDWDWCLOEXP	 24	/* Send window closed timer expired */
(defconstant $ADSP_RESTARTEXP 25)
; #define	ADSP_RESTARTEXP	 	 25	/* Restart sender timer expired */
(defconstant $ADSP_RESLOWEXP 26)
; #define	ADSP_RESLOWEXP	 	 26	/* Resources are low timer expired */
(defconstant $ADSP_RETRANSRCVD 27)
; #define	ADSP_RETRANSRCVD	 27	/* Retransmit advice received */
(defconstant $InfoTagCnt 27)
; #define	InfoTagCnt		 27
;  Length of the parameter and status lists 
(defconstant $ADSP_DEFLEN 127)
; #define	ADSP_DEFLEN	 (TuneParamCnt * 6 + 1)
(defconstant $ADSP_STALEN 55)
; #define	ADSP_STALEN	 (ConStatTagCnt * 6 + 1)
(defconstant $ADSP_INFOLEN 163)
; #define	ADSP_INFOLEN	 (InfoTagCnt * 6 + 1)
;  from h/ADSP.h 
;  result codes 
; #define controlErr -17          /*I/O System Errors*/
; #define errENOBUFS	-1281
; #define	errRefNum	-1280	/* bad connection refNum */
; #define	errAborted	-1279	/* control call was aborted */
; #define	errState	-1278	/* bad connection state for this operation */
; #define	errOpening	-1277	/* open connection request failed */
; #define	errAttention	-1276	/* attention message too long */
; #define	errFwdReset	-1275	/* read terminated by forward reset */
; #define errDSPQueueSize	-1274	/* DSP Read/Write Queue Too small */
; #define errOpenDenied	-1273	/* open connection request was denied */
;  control codes 
(defconstant $dspInit 255)
; #define	dspInit		255	/* create a new connection end */
(defconstant $dspRemove 254)
; #define	dspRemove	254	/* remove a connection end */
(defconstant $dspOpen 253)
; #define	dspOpen		253	/* open a connection */
(defconstant $dspClose 252)
; #define	dspClose	252	/* close a connection */
(defconstant $dspCLInit 251)
; #define	dspCLInit	251	/* create a connection listener */
(defconstant $dspCLRemove 250)
; #define	dspCLRemove	250	/* remove a connection listener */
(defconstant $dspCLListen 249)
; #define	dspCLListen	249	/* post a listener request */
(defconstant $dspCLDeny 248)
; #define	dspCLDeny	248	/* deny an open connection request */
(defconstant $dspStatus 247)
; #define	dspStatus	247	/* get status of connection end */
(defconstant $dspRead 246)
; #define	dspRead		246	/* read data from the connection */
(defconstant $dspWrite 245)
; #define	dspWrite	245	/* write data on the connection */
(defconstant $dspAttention 244)
; #define	dspAttention	244	/* send an attention message */
(defconstant $dspOptions 243)
; #define	dspOptions	243	/* set connection end options */
(defconstant $dspReset 242)
; #define	dspReset	242	/* forward reset the connection */
(defconstant $dspNewCID 241)
; #define	dspNewCID	241	/* generate a cid for a connection end */
;  connection opening modes 
(defconstant $ocRequest 1)
; #define	ocRequest	1	/* request a connection with remote */
(defconstant $ocPassive 2)
; #define	ocPassive	2	/* wait for a connection request from remote */
(defconstant $ocAccept 3)
; #define	ocAccept	3	/* accept request as delivered by listener */
(defconstant $ocEstablish 4)
; #define	ocEstablish	4	/* consider connection to be open */
;  connection end states 
(defconstant $sListening 1)
; #define	sListening	1	/* for connection listeners */
(defconstant $sPassive 2)
; #define	sPassive	2	/* waiting for a connection request from remote */
(defconstant $sOpening 3)
; #define	sOpening	3	/* requesting a connection with remote */
(defconstant $sOpen 4)
; #define	sOpen		4	/* connection is open */
(defconstant $sClosing 5)
; #define	sClosing	5	/* connection is being torn down */
(defconstant $sClosed 6)
; #define	sClosed		6	/* connection end state is closed */
;  client event flags 
(defconstant $eClosed 128)
; #define	eClosed		0x80	/* received connection closed advice */
(defconstant $eTearDown 64)
; #define	eTearDown	0x40	/* connection closed due to broken connection */
(defconstant $eAttention 32)
; #define	eAttention	0x20	/* received attention message */
(defconstant $eFwdReset 16)
; #define	eFwdReset	0x10	/* received forward reset advice */
;  miscellaneous constants  
(defconstant $attnBufSize 570)
; #define	attnBufSize	570	/* size of client attention buffer */
(defconstant $minDSPQueueSize 100)
; #define	minDSPQueueSize	100	/* Minimum size of receive or send Queue */
(defconstant $defaultDSPQS 16384)
; #define defaultDSPQS	16384	/* random guess */
; #define RecvQSize	defaultDSPQS
; #define SendQSize	defaultDSPQS
;  *** Seems to be a problem in Mac OS X too *** 
;  Solaris defines u as (curproc->p_user) 
; #if defined(u)
; #undef u
; #endif
; 

(def-mactype :ProcPtr (find-mactype ':pointer))

(def-mactype :ProcHandle (find-mactype '(:pointer :pointer)))

;type name? (def-mactype :Ptr (find-mactype '(:pointer :character)))

;type name? (def-mactype :Handle (find-mactype '(:pointer :pointer)))
;  connection control block 
(defrecord TRCCB
   (ccbLink (:pointer :U_CHAR))
                                                ;  link to next ccb 
   (refNum :UInt16)
                                                ;  user reference number 
   (state :UInt16)
                                                ;  state of the connection end 
   (userFlags :UInt8)
                                                ;  flags for unsolicited connection events 
   (localSocket :UInt8)
                                                ;  socket number of this connection end 
   (remoteAddress :at_inet_t)
#|
; Warning: type-size: unknown type AT_INET_T
|#
                                                ;  internet address of remote end 
   (attnCode :UInt16)
                                                ;  attention code received 
   (attnSize :UInt16)
                                                ;  size of received attention data 
   (attnPtr (:pointer :U_CHAR))
                                                ;  ptr to received attention data 
   (reserved (:array :UInt8 220))               ;  for adsp internal use 
)

;type name? (%define-record :TRCCB (find-record-descriptor ':TRCCB))

(def-mactype :TPCCB (find-mactype '(:pointer :TRCCB)))
;  init connection end parameters 
(defrecord TRinitParams
   (ccbPtr (:pointer :TRCCB))
                                                ;  pointer to connection control block 
   (userRoutine :pointer)
                                                ;  client routine to call on event 
   (sendQueue (:pointer :U_CHAR))
                                                ;  client passed send queue buffer 
   (recvQueue (:pointer :U_CHAR))
                                                ;  client passed receive queue buffer 
   (attnPtr (:pointer :U_CHAR))
                                                ;  client passed receive attention buffer 
   (sendQSize :UInt16)
                                                ;  size of send queue (0..64K bytes) 
   (recvQSize :UInt16)
                                                ;  size of receive queue (0..64K bytes) 
   (localSocket :UInt8)
                                                ;  local socket number 
)

;type name? (%define-record :TRinitParams (find-record-descriptor ':TRinitParams))
;  open connection parameters 
(defrecord TRopenParams
   (localCID :UInt16)
                                                ;  local connection id 
   (remoteCID :UInt16)
                                                ;  remote connection id 
   (remoteAddress :at_inet_t)
#|
; Warning: type-size: unknown type AT_INET_T
|#
                                                ;  address of remote end 
   (filterAddress :at_inet_t)
#|
; Warning: type-size: unknown type AT_INET_T
|#
                                                ;  address filter 
   (sendSeq :UInt32)
                                                ;  local send sequence number 
   (recvSeq :UInt32)
                                                ;  receive sequence number 
   (attnSendSeq :UInt32)
                                                ;  attention send sequence number 
   (attnRecvSeq :UInt32)
                                                ;  attention receive sequence number 
   (sendWindow :UInt16)
                                                ;  send window size 
   (ocMode :UInt8)
                                                ;  open connection mode 
   (ocInterval :UInt8)
                                                ;  open connection request retry interval 
   (ocMaximum :UInt8)
                                                ;  open connection request retry maximum 
)

;type name? (%define-record :TRopenParams (find-record-descriptor ':TRopenParams))
;  close connection parameters 
(defrecord TRcloseParams
   (abort :UInt8)
                                                ;  abort connection immediately if non-zero 
)

;type name? (%define-record :TRcloseParams (find-record-descriptor ':TRcloseParams))
;  client status parameter block 
(defrecord TRstatusParams
   (ccbPtr (:pointer :TRCCB))
                                                ;  pointer to ccb 
   (sendQPending :UInt16)
                                                ;  pending bytes in send queue 
   (sendQFree :UInt16)
                                                ;  available buffer space in send queue 
   (recvQPending :UInt16)
                                                ;  pending bytes in receive queue 
   (recvQFree :UInt16)
                                                ;  available buffer space in receive queue 
)

;type name? (%define-record :TRstatusParams (find-record-descriptor ':TRstatusParams))
;  read/write parameter block 
(defrecord TRioParams
   (reqCount :UInt16)
                                                ;  requested number of bytes 
   (actCount :UInt16)
                                                ;  actual number of bytes 
   (dataPtr (:pointer :U_CHAR))
                                                ;  pointer to data buffer 
   (eom :UInt8)
                                                ;  indicates logical end of message 
   (flush :UInt8)
                                                ;  send data now 
   (dummy (:array :UInt8 2))                    ; ### LD 
)

;type name? (%define-record :TRioParams (find-record-descriptor ':TRioParams))
;  attention parameter block 
(defrecord TRattnParams
   (attnCode :UInt16)
                                                ;  client attention code 
   (attnSize :UInt16)
                                                ;  size of attention data 
   (attnData (:pointer :U_CHAR))
                                                ;  pointer to attention data 
   (attnInterval :UInt8)
                                                ;  retransmit timer in 10-tick intervals 
   (dummy (:array :UInt8 3))
                                                ;  ### LD 
)

;type name? (%define-record :TRattnParams (find-record-descriptor ':TRattnParams))
;  client send option parameter block 
(defrecord TRoptionParams
   (sendBlocking :UInt16)
                                                ;  quantum for data packets 
   (sendTimer :UInt8)
                                                ;  send timer in 10-tick intervals 
   (rtmtTimer :UInt8)
                                                ;  retransmit timer in 10-tick intervals 
   (badSeqMax :UInt8)
                                                ;  threshold for sending retransmit advice 
   (useCheckSum :UInt8)
                                                ;  use ddp packet checksum 
   (filler :UInt16)
                                                ;  ### LD 
   (newPID :signed-long)
                                                ;  ### Temp for backward compatibility 02/11/94 
)

;type name? (%define-record :TRoptionParams (find-record-descriptor ':TRoptionParams))
;  new cid parameters 
(defrecord TRnewcidParams
   (newcid :UInt16)
                                                ;  new connection id returned 
)

;type name? (%define-record :TRnewcidParams (find-record-descriptor ':TRnewcidParams))
(defrecord adsp_command
   (:variant
   (
   (initParams :TRinitParams)
   )
                                                ;  dspInit, dspCLInit 
   (
   (openParams :TRopenParams)
   )
                                                ;  dspOpen, dspCLListen, dspCLDeny 
   (
   (closeParams :TRcloseParams)
   )
                                                ;  dspClose, dspRemove 
   (
   (ioParams :TRioParams)
   )
                                                ;  dspRead, dspWrite, dspAttnRead 
   (
   (attnParams :TRattnParams)
   )
                                                ;  dspAttention 
   (
   (statusParams :TRstatusParams)
   )
                                                ;  dspStatus 
   (
   (optionParams :TRoptionParams)
   )
                                                ;  dspOptions 
   (
   (newCIDParams :TRnewcidParams)
   )
                                                ;  dspNewCID 
   )
)
;  ADSP CntrlParam ioQElement 
(defrecord DSPParamBlock
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion :pointer)
   (ioResult :SInt16)
   (ioNamePtr (:pointer :char))
   (ioVRefNum :SInt16)
   (ioCRefNum :SInt16)
                                                ;  adsp driver refNum 
   (csCode :SInt16)
                                                ;  adsp driver control code 
   (qStatus :signed-long)
                                                ;  adsp internal use 
   (ccbRefNum :UInt16)
                                                ;  connection end refNum 
   (:variant
   (
   (u :ADSP_COMMAND)
   )
   )
)

;type name? (%define-record :DSPParamBlock (find-record-descriptor ':DSPParamBlock))

(def-mactype :DSPPBPtr (find-mactype '(:pointer :DSPParamBlock)))
(defrecord adspcmd
   (qLink (:pointer :adspcmd))
   (ccbRefNum :UInt32)
   (ioc (:pointer :character))
; #ifdef KERNEL
#| #|
    gref_t *gref;
    gbuf_t *mp;
|#
 |#

; #else
   (gref :pointer)
   (mp :pointer)

; #endif

   (ioResult :SInt16)
   (ioDirection :UInt16)
   (csCode :SInt16)
   (socket :UInt16)
   (:variant
   (
   (u :ADSP_COMMAND)
   )
   )
)
;  from h/adsp_frames.h 
; #ifdef NOT_USED
#| #|


typedef struct {
  u_char     lap_dest;
  u_char     lap_src;
  u_char     lap_type;
  u_char     lap_data[1];
} LAP_FRAME;

#define LAP_FRAME_LEN     3

#define MAX_FRAME_SIZE    603

#define LAP_DDP           0x01
#define LAP_DDPX          0x02

typedef struct {
  ua_short   ddp_length;             
  u_char     ddp_dest;               
  u_char     ddp_source;             
  u_char     ddp_type;               
  u_char     ddp_data[1];            
} DDP_FRAME;

#define DDPS_FRAME_LEN     5
#endif
|#
 |#
;  NOT_USED 
#|
; Warning: type-size: unknown type UA_SHORT
|#
#|
; Warning: type-size: unknown type UA_SHORT
|#
#|
; Warning: type-size: unknown type AT_NET
|#
#|
; Warning: type-size: unknown type AT_NET
|#
(defrecord DDPX_FRAME
   (ddpx_length :ua_short)                      ;  length and hop count        
   (ddpx_cksm :ua_short)                        ;  checksum                    
   (ddpx_dnet :at_net)                          ;  destination network number  
   (ddpx_snet :at_net)                          ;  source network number       
   (ddpx_dnode :UInt8)                          ;  destination node            
   (ddpx_snode :UInt8)                          ;  source node                 
   (ddpx_dest :UInt8)                           ;  destination socket          
   (ddpx_source :UInt8)                         ;  source socket               
   (ddpx_type :UInt8)                           ;  protocol type               
   (ddpx_data (:array :UInt8 1))                ;  data field                  
)
(defconstant $DDPL_FRAME_LEN 13)
; #define DDPL_FRAME_LEN     13
; #ifdef NOT_USED
#| #|
typedef struct {
  u_char     nbp_ctrl_cnt;           
  u_char     nbp_id;                 
  u_char     nbp_data[1];            
} NBP_FRAME;

#define NBP_TYPE_MASK     0xf0     
#define NBP_CNT_MASK      0x0f     
#define NBP_BROADCAST     0x10     
#define NBP_LOOKUP        0x20     
#define NBP_REPLY         0x30     

typedef struct {
  u_char     atp_control;            
  u_char     atp_map;                
  ua_short   atp_tid;                
  union
  {
      u_char     b[4];               
      ua_long    dw;
  } atp_ub;
  u_char     atp_data[1];            
} ATP_FRAME;

#define ATP_FRAME_LEN      8

#define ATP_TREQ          0x40     
#define ATP_TRESP         0x80     
#define ATP_TREL          0xc0     
#define ATP_XO            0x20     
#define ATP_EOM           0x10     
#define ATP_STS           0x08     

#define ATP_TYPE(x)       ((x)->atp_control & 0xc0)

typedef struct {
  at_net     net1;
  u_char     zonename[33];
} ZIP_1;

typedef struct {
  at_net     net1;
  at_net     net2;
  u_char     zonename[33];
} ZIP_2;

typedef struct {
  u_char     zip_command;             
  u_char     flags;                   
  union
  {
     ZIP_1 o;                       
     ZIP_2 r;                       
  } u;
} ZIP_FRAME;



#define ZIPF_BROADCAST     0x80
#define ZIPF_ZONE_INVALID  0x80
#define ZIPF_USE_BROADCAST 0x40
#define ZIPF_ONE_ZONE      0x20

#define ZIP_QUERY          1        
#define ZIP_REPLY          2
#define ZIP_TAKEDOWN       3
#define ZIP_BRINGUP        4
#define ZIP_GETNETINFO     5
#define ZIP_NETINFOREPLY   6
#define ZIP_NOTIFY         7

#define ZIP_GETMYZONE      7        
#define ZIP_GETZONELIST    8
#define ZIP_GETLOCALZONES  9
#define ZIP_GETYOURZONE    10       


typedef struct
{
   u_char  UserU_Chars[2];
   ua_short  ResponderVersion;
   ua_short  AtalkVersion;
   u_char  ROMVersion;
   u_char  SystemType;
   u_char  SystemClass;
   u_char  HdwrConfig;
   ua_short  ROM85Version;
   u_char  ResponderLevel;
   u_char  ResponderLink;
   u_char  data[1];
} RESPONDER_FRAME;
#endif
|#
 |#
;  NOT_USED 
; 
;  * ADSP Frame
;  
#|
; Warning: type-size: unknown type UA_SHORT
|#
#|
; Warning: type-size: unknown type UA_LONG
|#
#|
; Warning: type-size: unknown type UA_LONG
|#
#|
; Warning: type-size: unknown type UA_SHORT
|#
(defrecord ADSP_FRAME
   (CID :ua_short)
   (pktFirstByteSeq :ua_long)
   (pktNextRecvSeq :ua_long)
   (pktRecvWdw :ua_short)
   (descriptor :UInt8)
                                                ;  Bit-Mapped 
   (data (:array :UInt8 1))
#|
 confused about , * ADSP_FRAMEPtr
|#
)
(defconstant $ADSP_FRAME_LEN 13)
; #define ADSP_FRAME_LEN     13
(defconstant $ADSP_CONTROL_BIT 128)
; #define ADSP_CONTROL_BIT   0x80
(defconstant $ADSP_ACK_REQ_BIT 64)
; #define ADSP_ACK_REQ_BIT   0x40
(defconstant $ADSP_EOM_BIT 32)
; #define ADSP_EOM_BIT       0x20
(defconstant $ADSP_ATTENTION_BIT 16)
; #define ADSP_ATTENTION_BIT 0x10
(defconstant $ADSP_CONTROL_MASK 15)
; #define ADSP_CONTROL_MASK  0x0F
(defconstant $ADSP_CTL_PROBE 0)
; #define ADSP_CTL_PROBE        0x00 /* Probe or acknowledgement */
(defconstant $ADSP_CTL_OREQ 1)
; #define ADSP_CTL_OREQ         0x01 /* Open Connection Request */
(defconstant $ADSP_CTL_OACK 2)
; #define ADSP_CTL_OACK         0x02 /* Open Request acknowledgment */
(defconstant $ADSP_CTL_OREQACK 3)
; #define ADSP_CTL_OREQACK      0x03 /* Open Request and acknowledgement */
(defconstant $ADSP_CTL_ODENY 4)
; #define ADSP_CTL_ODENY        0x04 /* Open Request denial */
(defconstant $ADSP_CTL_CLOSE 5)
; #define ADSP_CTL_CLOSE        0x05 /* Close connection advice */
(defconstant $ADSP_CTL_FRESET 6)
; #define ADSP_CTL_FRESET       0x06 /* Forward Reset */
(defconstant $ADSP_CTL_FRESET_ACK 7)
; #define ADSP_CTL_FRESET_ACK   0x07 /* Forward Reset Acknowledgement */
(defconstant $ADSP_CTL_RETRANSMIT 8)
; #define ADSP_CTL_RETRANSMIT   0x08 /* Retransmit advice	*/
#|
; Warning: type-size: unknown type UA_SHORT
|#
#|
; Warning: type-size: unknown type UA_SHORT
|#
#|
; Warning: type-size: unknown type UA_LONG
|#
(defrecord ADSP_OPEN_DATA
   (version :ua_short)
                                                ;  Must be in network byte order 
   (dstCID :ua_short)
                                                ;  
   (pktAttnRecvSeq :ua_long)
                                                ;  Must be in network byte order 
#|
 confused about , * ADSP_OPEN_DATAPtr
|#
)
(defconstant $ADSP_OPEN_FRAME_LEN 8)
; #define ADSP_OPEN_FRAME_LEN   8
(defconstant $ADSP_MAX_DATA_LEN 572)
; #define ADSP_MAX_DATA_LEN		572
;  from h/adsp_ioctl.h 
; 
;  * Defines that correspond to atlog.h in the N & C Appletalk
;  * sources.
;  
(defconstant $AT_MID_ADSP 212)
; #define AT_MID_ADSP	212
;  Streams ioctl definitions 
; #define ADSP_IOCTL(i)     ((i>>8) == AT_MID_ADSP)
(defconstant $ADSPATTNREAD 54526)
; #define ADSPATTNREAD	((AT_MID_ADSP<<8) | 254) /* read attention data */
(defconstant $ADSPOPEN 54525)
; #define	ADSPOPEN 	((AT_MID_ADSP<<8) | 253) /* open a connection */
(defconstant $ADSPCLOSE 54524)
; #define	ADSPCLOSE 	((AT_MID_ADSP<<8) | 252) /* close a connection */
(defconstant $ADSPCLINIT 54523)
; #define	ADSPCLINIT 	((AT_MID_ADSP<<8) | 251) /* create a conn listener */
(defconstant $ADSPCLREMOVE 54522)
; #define	ADSPCLREMOVE 	((AT_MID_ADSP<<8) | 250) /* remove a conn listener */
(defconstant $ADSPCLLISTEN 54521)
; #define	ADSPCLLISTEN 	((AT_MID_ADSP<<8) | 249) /* post a listener request */
(defconstant $ADSPCLDENY 54520)
; #define	ADSPCLDENY 	((AT_MID_ADSP<<8) | 248) /* deny an open connection request */
(defconstant $ADSPSTATUS 54519)
; #define	ADSPSTATUS 	((AT_MID_ADSP<<8) | 247) /* get status of conn end */
(defconstant $ADSPREAD 54518)
; #define	ADSPREAD 	((AT_MID_ADSP<<8) | 246) /* read data from conn */
(defconstant $ADSPWRITE 54517)
; #define	ADSPWRITE 	((AT_MID_ADSP<<8) | 245) /* write data on the conn */
(defconstant $ADSPATTENTION 54516)
; #define	ADSPATTENTION 	((AT_MID_ADSP<<8) | 244) /* send attention message */
(defconstant $ADSPOPTIONS 54515)
; #define	ADSPOPTIONS 	((AT_MID_ADSP<<8) | 243) /* set conn end options */
(defconstant $ADSPRESET 54514)
; #define	ADSPRESET 	((AT_MID_ADSP<<8) | 242) /* forward reset connection */
(defconstant $ADSPNEWCID 54513)
; #define	ADSPNEWCID 	((AT_MID_ADSP<<8) | 241) /* generate a cid conn end */
(defconstant $ADSPBINDREQ 54512)
; #define ADSPBINDREQ	((AT_MID_ADSP<<8) | 240)
(defconstant $ADSPGETSOCK 54511)
; #define ADSPGETSOCK	((AT_MID_ADSP<<8) | 239)
(defconstant $ADSPGETPEER 54510)
; #define ADSPGETPEER	((AT_MID_ADSP<<8) | 238)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE




#define STR_IGNORE	0
#define STR_PUTNEXT	1
#define STR_PUTBACK	2
#define STR_QTIME	(HZ >> 3)

extern int adspInit();
extern int adspOpen();
extern int adspCLListen();
extern int adspClose();
extern int adspCLDeny();
extern int adspStatus();
extern int adspRead();
extern int adspWrite();
extern int adspAttention();
extern int adspOptions();
extern int adspReset();
extern int adspNewCID();
extern int adspPacket();


struct adsp_debug {
    int ad_time;
    int ad_seq;
    int ad_caller;
    int ad_descriptor;
    int ad_bits;
    short ad_sendCnt;
    short ad_sendMax;
    int ad_maxSendSeq;
    int ad_sendWdwSeq;
};

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_ADSP_H_ */


(provide-interface "adsp")