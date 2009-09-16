(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:pap.h"
; at Sunday July 2,2006 7:31:10 pm.
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
; #ifndef _NETAT_PAP_H_
; #define _NETAT_PAP_H_

(require-interface "sys/appleapiopts")
(defconstant $AT_PAP_DATA_SIZE 512)
; #define  AT_PAP_DATA_SIZE	      512    /* Maximum PAP data size */
(defconstant $AT_PAP_STATUS_SIZE 255)
; #define  AT_PAP_STATUS_SIZE	      255    /* Maximum PAP status length */
(defconstant $PAP_TIMEOUT 120)
; #define  PAP_TIMEOUT		      120
;  PAP packet types 
(defconstant $AT_PAP_TYPE_OPEN_CONN 1)
; #define  AT_PAP_TYPE_OPEN_CONN        0x01   /* Open-Connection packet */
(defconstant $AT_PAP_TYPE_OPEN_CONN_REPLY 2)
; #define  AT_PAP_TYPE_OPEN_CONN_REPLY  0x02   /* Open-Connection-Reply packet */
(defconstant $AT_PAP_TYPE_SEND_DATA 3)
; #define  AT_PAP_TYPE_SEND_DATA        0x03   /* Send-Data packet */
(defconstant $AT_PAP_TYPE_DATA 4)
; #define  AT_PAP_TYPE_DATA             0x04   /* Data packet */
(defconstant $AT_PAP_TYPE_TICKLE 5)
; #define  AT_PAP_TYPE_TICKLE           0x05   /* Tickle packet */
(defconstant $AT_PAP_TYPE_CLOSE_CONN 6)
; #define  AT_PAP_TYPE_CLOSE_CONN       0x06   /* Close-Connection packet */
(defconstant $AT_PAP_TYPE_CLOSE_CONN_REPLY 7)
; #define  AT_PAP_TYPE_CLOSE_CONN_REPLY 0x07   /* Close-Connection-Reply pkt */
(defconstant $AT_PAP_TYPE_SEND_STATUS 8)
; #define  AT_PAP_TYPE_SEND_STATUS      0x08   /* Send-Status packet */
(defconstant $AT_PAP_TYPE_SEND_STS_REPLY 9)
; #define  AT_PAP_TYPE_SEND_STS_REPLY   0x09   /* Send-Status-Reply packet */
(defconstant $AT_PAP_TYPE_READ_LW 10)
; #define  AT_PAP_TYPE_READ_LW	      0x0A   /* Read LaserWriter Message */
;  PAP packet structure 
(defrecord at_pap
   (at_pap_connection_id :UInt8)
   (at_pap_type :UInt8)
   (at_pap_sequence_number (:array :UInt8 2))
   (at_pap_responding_socket :UInt8)
   (at_pap_flow_quantum :UInt8)
   (at_pap_wait_time_or_result (:array :UInt8 2))
   (at_pap_buffer (:array :UInt8 512))
)
;  ioctl definitions 
; #define	AT_PAP_SETHDR		(('~'<<8)|0)
; #define	AT_PAP_READ		(('~'<<8)|1)
; #define	AT_PAP_WRITE		(('~'<<8)|2)
; #define	AT_PAP_WRITE_EOF	(('~'<<8)|3)
; #define	AT_PAP_WRITE_FLUSH	(('~'<<8)|4)
; #define	AT_PAP_READ_IGNORE	(('~'<<8)|5)
; #define	AT_PAPD_SET_STATUS	(('~'<<8)|40)
; #define	AT_PAPD_GET_NEXT_JOB	(('~'<<8)|41)
(def-mactype :at_pap_status (find-mactype '(:pointer :char)))

(deftrap-inline "_pap_status" 
   ((ARG2 (:NIL :NIL))
   )
   (:pointer :character)
() )
(defconstant $NPAPSERVERS 10)
; #define	NPAPSERVERS	10	/* the number of active PAP servers/node */
(defconstant $NPAPSESSIONS 40)
; #define	NPAPSESSIONS	40	/* the number of active PAP sockets/node */
(defconstant $AT_PAP_HDR_SIZE 21)
; #define AT_PAP_HDR_SIZE	(DDP_X_HDR_SIZE + ATP_HDR_SIZE)
; #define	 ATP_DDP_HDR(c)	((at_ddp_t *)(c))
(defconstant $PAP_SOCKERR "Unable to open PAP socket")
; #define PAP_SOCKERR 	"Unable to open PAP socket"
(defconstant $P_NOEXIST "Printer not found")
; #define P_NOEXIST 	"Printer not found"
(defconstant $P_UNREACH "Unable to establish PAP session")
; #define P_UNREACH	"Unable to establish PAP session"
(defrecord pap_state
   (pap_inuse :UInt8)
                                                ;  true if this one is allocated 
   (pap_tickle :UInt8)
                                                ;  true if we are tickling the other end 
   (pap_request :UInt8)
                                                ;  bitmap from a received request 
   (pap_eof :UInt8)
                                                ;  true if we have received an EOF 
   (pap_eof_sent :UInt8)
                                                ;  true if we have sent an EOF 
   (pap_sent :UInt8)
                                                ;  true if we have sent anything (and
; 				   therefore may have to send an eof
; 				   on close) 
   (pap_error :UInt8)
                                                ;  error message from read request 
   (pap_timer :UInt8)
                                                ;  a timeout is pending 
   (pap_closing :UInt8)
                                                ;  the link is closing and/or closed 
   (pap_request_count :UInt8)                   ;  number of outstanding requests 
   (pap_req_timer :UInt8)
                                                ;  the request timer is running 
   (pap_ending :UInt8)
                                                ;  we are waiting for atp to flush 
   (pap_read_ignore :UInt8)                     ;  we are in 'read with ignore' mode 
   (pap_req_socket :UInt8)
   (pap_to :AT_INET)
   (pap_flow :signed-long)
   (pap_send_count :UInt16)                     ;  the sequence number to send on the
; 				   next send data request 
   (pap_rcv_count :UInt16)
                                                ;  the sequence number expected to
; 				   receive on the next request 
   (pap_tid :UInt16)
                                                ;  ATP transaction ID for responses 
   (pap_connID :UInt8)
                                                ;  our connection ID 
   (pap_ignore_id :signed-long)
                                                ;  the transaction ID for read ignore 
   (pap_tickle_id :signed-long)
                                                ;  the transaction ID for tickles 
)

; #endif /* _NETAT_PAP_H_ */


(provide-interface "pap")