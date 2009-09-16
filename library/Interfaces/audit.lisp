(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:audit.h"
; at Sunday July 2,2006 7:27:04 pm.
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
; #ifndef _SYS_AUDIT_H
; #define	_SYS_AUDIT_H

(require-interface "sys/queue")

(require-interface "sys/ucred")

(require-interface "sys/param")

(require-interface "sys/ipc")

(require-interface "sys/socket")
(defconstant $AUDIT_RECORD_MAGIC 2190085915)
; #define	AUDIT_RECORD_MAGIC	0x828a0f1b
(defconstant $MAX_AUDIT_RECORDS 20)
; #define MAX_AUDIT_RECORDS	20
(defconstant $MAX_AUDIT_RECORD_SIZE 4096)
; #define MAX_AUDIT_RECORD_SIZE	4096	
; 
;  * Define the masks for the classes of audit events.
;  
(defconstant $AU_NULL 0)
; #define	AU_NULL		0x00000000
(defconstant $AU_FREAD 1)
; #define	AU_FREAD	0x00000001
(defconstant $AU_FWRITE 2)
; #define	AU_FWRITE	0x00000002
(defconstant $AU_FACCESS 4)
; #define	AU_FACCESS	0x00000004
(defconstant $AU_FMODIFY 8)
; #define	AU_FMODIFY	0x00000008
(defconstant $AU_FCREATE 16)
; #define	AU_FCREATE	0x00000010
(defconstant $AU_FDELETE 32)
; #define	AU_FDELETE	0x00000020
(defconstant $AU_CLOSE 64)
; #define	AU_CLOSE	0x00000040
(defconstant $AU_PROCESS 128)
; #define	AU_PROCESS	0x00000080
(defconstant $AU_NET 256)
; #define	AU_NET		0x00000100
(defconstant $AU_IPC 512)
; #define	AU_IPC		0x00000200
(defconstant $AU_NONAT 1024)
; #define	AU_NONAT	0x00000400
(defconstant $AU_ADMIN 2048)
; #define	AU_ADMIN	0x00000800
(defconstant $AU_LOGIN 4096)
; #define	AU_LOGIN	0x00001000
(defconstant $AU_TFM 8192)
; #define	AU_TFM		0x00002000
(defconstant $AU_APPL 16384)
; #define	AU_APPL		0x00004000
(defconstant $AU_SETL 32768)
; #define	AU_SETL		0x00008000
(defconstant $AU_IFLOAT 65536)
; #define	AU_IFLOAT	0x00010000
(defconstant $AU_PRIV 131072)
; #define	AU_PRIV		0x00020000
(defconstant $AU_MAC_RW 262144)
; #define	AU_MAC_RW	0x00040000
(defconstant $AU_XCONN 524288)
; #define	AU_XCONN	0x00080000
(defconstant $AU_XCREATE 1048576)
; #define	AU_XCREATE	0x00100000
(defconstant $AU_XDELETE 2097152)
; #define	AU_XDELETE	0x00200000
(defconstant $AU_XIFLOAT 4194304)
; #define	AU_XIFLOAT	0x00400000
(defconstant $AU_XPRIVS 8388608)
; #define	AU_XPRIVS	0x00800000
(defconstant $AU_XPRIVF 16777216)
; #define	AU_XPRIVF	0x01000000
(defconstant $AU_XMOVE 33554432)
; #define	AU_XMOVE	0x02000000
(defconstant $AU_XDACF 67108864)
; #define	AU_XDACF	0x04000000
(defconstant $AU_XMACF 134217728)
; #define	AU_XMACF	0x08000000
(defconstant $AU_XSECATTR 268435456)
; #define	AU_XSECATTR	0x10000000
(defconstant $AU_IOCTL 536870912)
; #define	AU_IOCTL	0x20000000
(defconstant $AU_EXEC 1073741824)
; #define	AU_EXEC		0x40000000
(defconstant $AU_OTHER 2147483648)
; #define	AU_OTHER	0x80000000
(defconstant $AU_ALL 4294967295)
; #define	AU_ALL		0xffffffff
; 
;  * IPC types
;  
(defconstant $AT_IPC_MSG 1)
; #define AT_IPC_MSG	((u_char)1) /* message IPC id */
(defconstant $AT_IPC_SEM 2)
; #define AT_IPC_SEM	((u_char)2) /* semaphore IPC id */
(defconstant $AT_IPC_SHM 3)
; #define AT_IPC_SHM	((u_char)3) /* shared mem IPC id */
; 
;  * Audit conditions.
;  
(defconstant $AUC_UNSET 0)
; #define AUC_UNSET		0
(defconstant $AUC_AUDITING 1)
; #define AUC_AUDITING		1
(defconstant $AUC_NOAUDIT 2)
; #define AUC_NOAUDIT		2
; #define AUC_DISABLED		-1
; 
;  * auditon(2) commands.
;  
(defconstant $A_GETPOLICY 2)
; #define A_GETPOLICY	2
(defconstant $A_SETPOLICY 3)
; #define A_SETPOLICY	3
(defconstant $A_GETKMASK 4)
; #define A_GETKMASK	4
(defconstant $A_SETKMASK 5)
; #define A_SETKMASK	5
(defconstant $A_GETQCTRL 6)
; #define	A_GETQCTRL	6
(defconstant $A_SETQCTRL 7)
; #define A_SETQCTRL	7
(defconstant $A_GETCWD 8)
; #define A_GETCWD	8
(defconstant $A_GETCAR 9)
; #define A_GETCAR	9
(defconstant $A_GETSTAT 12)
; #define A_GETSTAT	12
(defconstant $A_SETSTAT 13)
; #define A_SETSTAT	13
(defconstant $A_SETUMASK 14)
; #define	A_SETUMASK	14
(defconstant $A_SETSMASK 15)
; #define A_SETSMASK	15
(defconstant $A_GETCOND 20)
; #define A_GETCOND	20
(defconstant $A_SETCOND 21)
; #define A_SETCOND	21
(defconstant $A_GETCLASS 22)
; #define A_GETCLASS	22
(defconstant $A_SETCLASS 23)
; #define A_SETCLASS	23
(defconstant $A_GETPINFO 24)
; #define A_GETPINFO	24
(defconstant $A_SETPMASK 25)
; #define A_SETPMASK	25
(defconstant $A_SETFSIZE 26)
; #define A_SETFSIZE	26
(defconstant $A_GETFSIZE 27)
; #define A_GETFSIZE	27
(defconstant $A_GETPINFO_ADDR 28)
; #define A_GETPINFO_ADDR	28
(defconstant $A_GETKAUDIT 29)
; #define A_GETKAUDIT	29
(defconstant $A_SETKAUDIT 30)
; #define A_SETKAUDIT	30
; 
;  * Audit policy controls.
;  
(defconstant $AUDIT_CNT 1)
; #define AUDIT_CNT	0x0001
(defconstant $AUDIT_AHLT 2)
; #define AUDIT_AHLT	0x0002
(defconstant $AUDIT_ARGV 4)
; #define AUDIT_ARGV	0x0004
(defconstant $AUDIT_ARGE 8)
; #define AUDIT_ARGE	0x0008
(defconstant $AUDIT_PASSWD 16)
; #define AUDIT_PASSWD	0x0010
(defconstant $AUDIT_SEQ 32)
; #define AUDIT_SEQ	0x0020
(defconstant $AUDIT_WINDATA 64)
; #define AUDIT_WINDATA	0x0040
(defconstant $AUDIT_USER 128)
; #define AUDIT_USER	0x0080
(defconstant $AUDIT_GROUP 256)
; #define AUDIT_GROUP	0x0100
(defconstant $AUDIT_TRAIL 512)
; #define AUDIT_TRAIL	0x0200
(defconstant $AUDIT_PATH 1024)
; #define AUDIT_PATH	0x0400

(def-mactype :au_id_t (find-mactype ':UInt32))

(def-mactype :au_asid_t (find-mactype ':SInt32))

(def-mactype :au_event_t (find-mactype ':UInt16))

(def-mactype :au_emod_t (find-mactype ':UInt16))

(def-mactype :au_class_t (find-mactype ':UInt32))
(defrecord au_tid
   (port :SInt32)
   (machine :UInt32)
)

(%define-record :au_tid_t (find-record-descriptor ':au_tid))
(defrecord au_tid_addr
   (at_port :SInt32)
   (at_type :UInt32)
   (at_addr (:array :UInt32 4))
)

(%define-record :au_tid_addr_t (find-record-descriptor ':au_tid_addr))
(defrecord au_mask
   (am_success :UInt32)                         ;  success bits 
   (am_failure :UInt32)                         ;  failure bits 
)

(%define-record :au_mask_t (find-record-descriptor ':au_mask))
(defrecord auditinfo
   (ai_auid :UInt32)
                                                ;  Audit user ID 
   (ai_mask :au_mask)
                                                ;  Audit masks 
   (ai_termid :au_tid)
                                                ;  Terminal ID 
   (ai_asid :SInt32)
                                                ;  Audit session ID 
)

(%define-record :auditinfo_t (find-record-descriptor ':auditinfo))
(defrecord auditinfo_addr
   (ai_auid :UInt32)
                                                ;  Audit user ID 
   (ai_mask :au_mask)
                                                ;  Audit masks 
   (ai_termid :au_tid_addr)
                                                ;  Terminal ID 
   (ai_asid :SInt32)
                                                ;  Audit session ID 
)

(%define-record :auditinfo_addr_t (find-record-descriptor ':auditinfo_addr))
;  Token and record structures 
(defrecord au_token
   (t_data (:pointer :u_char))
   (len :unsigned-long)
#|
   (NIL (:pointer :callback))|#                 ;(TAILQ_ENTRY tokens)
)

(%define-record :token_t (find-record-descriptor ':au_token))
(defrecord au_record
   (used :character)                            ;  Is this record currently being used 
   (desc :signed-long)                          ;  The descriptor associated with this record 
   (au_token (:pointer :callback))              ;(TAILQ_HEAD token_q)
                                                ;  queue of BSM tokens 
   (data (:pointer :u_char))
   (len :unsigned-long)
#|
   (NIL (:pointer :callback))|#                 ;(LIST_ENTRY au_rec_q)
)

(%define-record :au_record_t (find-record-descriptor ':au_record))
; #ifndef KERNEL

(require-interface "sys/cdefs")

(deftrap-inline "_audit" 
   ((ARGH :pointer)
    (ARG2 :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_auditon" 
   ((ARG2 :signed-long)
    (ARGH :pointer)
    (ARG2 :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_auditsvc" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_auditctl" 
   ((ARGH (:pointer :char))
   )
   :signed-long
() )

(deftrap-inline "_getauid" 
   ((ARGH (:pointer :AU_ID_T))
   )
   :signed-long
() )

(deftrap-inline "_setauid" 
   ((ARGH (:pointer :AU_ID_T))
   )
   :signed-long
() )

(deftrap-inline "_getaudit" 
   ((* (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_setaudit" 
   ((ARGH (:pointer :auditinfo))
   )
   :signed-long
() )

(deftrap-inline "_getaudit_addr" 
   ((* (:pointer :struct))
    (ARG2 :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_setaudit_addr" 
   ((ARGH (:pointer :auditinfo_addr))
    (ARG2 :signed-long)
   )
   :signed-long
() )

; #endif /* !KERNEL */


; #endif /* !_SYS_AUDIT_H */


(provide-interface "audit")