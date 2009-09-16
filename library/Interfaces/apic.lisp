(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:apic.h"
; at Sunday July 2,2006 7:25:39 pm.
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
;  * @OSF_COPYRIGHT@
;  * 
;  
(defconstant $LAPIC_START 4276092928)
; #define LAPIC_START			0xFEE00000
(defconstant $LAPIC_SIZE 1024)
; #define LAPIC_SIZE			0x00000400
(defconstant $LAPIC_ID 32)
; #define LAPIC_ID			0x00000020
(defconstant $LAPIC_ID_SHIFT 24)
; #define		LAPIC_ID_SHIFT		24
(defconstant $LAPIC_ID_MASK 15)
; #define		LAPIC_ID_MASK		0x0F
(defconstant $LAPIC_VERSION 48)
; #define LAPIC_VERSION			0x00000030
(defconstant $LAPIC_VERSION_MASK 255)
; #define		LAPIC_VERSION_MASK	0xFF
(defconstant $LAPIC_TPR 128)
; #define LAPIC_TPR			0x00000080
(defconstant $LAPIC_TPR_MASK 255)
; #define		LAPIC_TPR_MASK		0xFF
(defconstant $LAPIC_APR 144)
; #define LAPIC_APR			0x00000090
(defconstant $LAPIC_APR_MASK 255)
; #define		LAPIC_APR_MASK		0xFF
(defconstant $LAPIC_PPR 160)
; #define LAPIC_PPR			0x000000A0
(defconstant $LAPIC_PPR_MASK 255)
; #define		LAPIC_PPR_MASK		0xFF
(defconstant $LAPIC_EOI 176)
; #define LAPIC_EOI			0x000000B0
(defconstant $LAPIC_REMOTE_READ 192)
; #define LAPIC_REMOTE_READ		0x000000C0
(defconstant $LAPIC_LDR 208)
; #define LAPIC_LDR			0x000000D0
(defconstant $LAPIC_LDR_SHIFT 24)
; #define		LAPIC_LDR_SHIFT		24
(defconstant $LAPIC_DFR 224)
; #define LAPIC_DFR			0x000000E0
(defconstant $LAPIC_DFR_FLAT 4294967295)
; #define		LAPIC_DFR_FLAT		0xFFFFFFFF
(defconstant $LAPIC_DFR_CLUSTER 268435455)
; #define		LAPIC_DFR_CLUSTER	0x0FFFFFFF
(defconstant $LAPIC_DFR_SHIFT 28)
; #define		LAPIC_DFR_SHIFT         28
(defconstant $LAPIC_SVR 240)
; #define LAPIC_SVR			0x000000F0
(defconstant $LAPIC_SVR_MASK 255)
; #define		LAPIC_SVR_MASK		0x0FF
(defconstant $LAPIC_SVR_ENABLE 256)
; #define		LAPIC_SVR_ENABLE	0x100
(defconstant $LAPIC_SVR_FOCUS_OFF 512)
; #define		LAPIC_SVR_FOCUS_OFF	0x200
(defconstant $LAPIC_ISR_BASE 256)
; #define LAPIC_ISR_BASE			0x00000100
(defconstant $LAPIC_TMR_BASE 384)
; #define LAPIC_TMR_BASE			0x00000180
(defconstant $LAPIC_IRR_BASE 512)
; #define LAPIC_IRR_BASE			0x00000200
(defconstant $LAPIC_ERROR_STATUS 640)
; #define LAPIC_ERROR_STATUS		0x00000280
(defconstant $LAPIC_ICR 768)
; #define LAPIC_ICR			0x00000300
(defconstant $LAPIC_ICR_VECTOR_MASK 255)
; #define		LAPIC_ICR_VECTOR_MASK	0x000FF
(defconstant $LAPIC_ICR_DM_MASK 1792)
; #define		LAPIC_ICR_DM_MASK	0x00700
(defconstant $LAPIC_ICR_DM_FIXED 0)
; #define		LAPIC_ICR_DM_FIXED	0x00000
(defconstant $LAPIC_ICR_DM_LOWEST 256)
; #define		LAPIC_ICR_DM_LOWEST	0x00100
(defconstant $LAPIC_ICR_DM_SMI 512)
; #define		LAPIC_ICR_DM_SMI	0x00200
(defconstant $LAPIC_ICR_DM_REMOTE 768)
; #define		LAPIC_ICR_DM_REMOTE	0x00300
(defconstant $LAPIC_ICR_DM_NMI 1024)
; #define		LAPIC_ICR_DM_NMI	0x00400
(defconstant $LAPIC_ICR_DM_INIT 1280)
; #define		LAPIC_ICR_DM_INIT	0x00500
(defconstant $LAPIC_ICR_DM_STARTUP 1536)
; #define		LAPIC_ICR_DM_STARTUP	0x00600
(defconstant $LAPIC_ICR_DM_LOGICAL 2048)
; #define		LAPIC_ICR_DM_LOGICAL	0x00800
(defconstant $LAPIC_ICR_DS_PENDING 4096)
; #define		LAPIC_ICR_DS_PENDING	0x01000
(defconstant $LAPIC_ICR_LEVEL_ASSERT 16384)
; #define		LAPIC_ICR_LEVEL_ASSERT	0x04000
(defconstant $LAPIC_ICR_TRIGGER_LEVEL 32768)
; #define		LAPIC_ICR_TRIGGER_LEVEL	0x08000
(defconstant $LAPIC_ICR_RR_MASK 196608)
; #define		LAPIC_ICR_RR_MASK	0x30000
(defconstant $LAPIC_ICR_RR_INVALID 0)
; #define		LAPIC_ICR_RR_INVALID	0x00000
(defconstant $LAPIC_ICR_RR_INPROGRESS 65536)
; #define		LAPIC_ICR_RR_INPROGRESS	0x10000
(defconstant $LAPIC_ICR_RR_VALID 131072)
; #define		LAPIC_ICR_RR_VALID	0x20000
(defconstant $LAPIC_ICR_DSS_MASK 786432)
; #define		LAPIC_ICR_DSS_MASK	0xC0000
(defconstant $LAPIC_ICR_DSS_DEST 0)
; #define		LAPIC_ICR_DSS_DEST	0x00000
(defconstant $LAPIC_ICR_DSS_SELF 262144)
; #define		LAPIC_ICR_DSS_SELF	0x40000
(defconstant $LAPIC_ICR_DSS_ALL 524288)
; #define		LAPIC_ICR_DSS_ALL	0x80000
(defconstant $LAPIC_ICR_DSS_OTHERS 786432)
; #define		LAPIC_ICR_DSS_OTHERS	0xC0000
(defconstant $LAPIC_ICRD 784)
; #define LAPIC_ICRD			0x00000310
(defconstant $LAPIC_ICRD_DEST_SHIFT 24)
; #define		LAPIC_ICRD_DEST_SHIFT	24
(defconstant $LAPIC_LVT_TIMER 800)
; #define LAPIC_LVT_TIMER			0x00000320
(defconstant $LAPIC_LVT_THERMAL 816)
; #define LAPIC_LVT_THERMAL		0x00000330
(defconstant $LAPIC_LVT_PERFCNT 832)
; #define LAPIC_LVT_PERFCNT		0x00000340
(defconstant $LAPIC_LVT_LINT0 848)
; #define LAPIC_LVT_LINT0			0x00000350
(defconstant $LAPIC_LVT_LINT1 864)
; #define LAPIC_LVT_LINT1			0x00000360
(defconstant $LAPIC_LVT_ERROR 880)
; #define LAPIC_LVT_ERROR			0x00000370
(defconstant $LAPIC_LVT_VECTOR_MASK 255)
; #define		LAPIC_LVT_VECTOR_MASK	0x000FF
(defconstant $LAPIC_LVT_DM_SHIFT 8)
; #define		LAPIC_LVT_DM_SHIFT	8
(defconstant $LAPIC_LVT_DM_MASK 7)
; #define		LAPIC_LVT_DM_MASK	0x00007
(defconstant $LAPIC_LVT_DM_FIXED 0)
; #define		LAPIC_LVT_DM_FIXED	0x00000
(defconstant $LAPIC_LVT_DM_NMI 1024)
; #define		LAPIC_LVT_DM_NMI	0x00400
(defconstant $LAPIC_LVT_DM_EXTINT 1792)
; #define		LAPIC_LVT_DM_EXTINT	0x00700
(defconstant $LAPIC_LVT_DS_PENDING 4096)
; #define		LAPIC_LVT_DS_PENDING	0x01000
(defconstant $LAPIC_LVT_IP_PLRITY_LOW 8192)
; #define		LAPIC_LVT_IP_PLRITY_LOW	0x02000
(defconstant $LAPIC_LVT_REMOTE_IRR 16384)
; #define		LAPIC_LVT_REMOTE_IRR	0x04000
(defconstant $LAPIC_LVT_TM_LEVEL 32768)
; #define		LAPIC_LVT_TM_LEVEL	0x08000
(defconstant $LAPIC_LVT_MASKED 65536)
; #define		LAPIC_LVT_MASKED	0x10000
(defconstant $LAPIC_LVT_PERIODIC 131072)
; #define		LAPIC_LVT_PERIODIC	0x20000
(defconstant $LAPIC_INITIAL_COUNT_TIMER 896)
; #define LAPIC_INITIAL_COUNT_TIMER	0x00000380
(defconstant $LAPIC_CURRENT_COUNT_TIMER 912)
; #define LAPIC_CURRENT_COUNT_TIMER	0x00000390
(defconstant $LAPIC_TIMER_DIVIDE_CONFIG 992)
; #define LAPIC_TIMER_DIVIDE_CONFIG	0x000003E0
(defconstant $IOAPIC_START 4273995776)
; #define IOAPIC_START			0xFEC00000
(defconstant $IOAPIC_SIZE 32)
; #define	IOAPIC_SIZE			0x00000020
(defconstant $IOAPIC_RSELECT 0)
; #define IOAPIC_RSELECT			0x00000000
(defconstant $IOAPIC_RWINDOW 16)
; #define IOAPIC_RWINDOW			0x00000010
(defconstant $IOA_R_ID 0)
; #define IOA_R_ID			0x00
(defconstant $IOA_R_ID_SHIFT 24)
; #define		IOA_R_ID_SHIFT		24
(defconstant $IOA_R_VERSION 1)
; #define IOA_R_VERSION			0x01
(defconstant $IOA_R_VERSION_MASK 255)
; #define		IOA_R_VERSION_MASK	0xFF
(defconstant $IOA_R_VERSION_ME_SHIFT 16)
; #define		IOA_R_VERSION_ME_SHIFT	16
(defconstant $IOA_R_VERSION_ME_MASK 255)
; #define		IOA_R_VERSION_ME_MASK	0xFF
(defconstant $IOA_R_REDIRECTION 16)
; #define IOA_R_REDIRECTION		0x10
(defconstant $IOA_R_R_VECTOR_MASK 255)
; #define 	IOA_R_R_VECTOR_MASK	0x000FF
(defconstant $IOA_R_R_DM_MASK 1792)
; #define		IOA_R_R_DM_MASK		0x00700
(defconstant $IOA_R_R_DM_FIXED 0)
; #define		IOA_R_R_DM_FIXED	0x00000
(defconstant $IOA_R_R_DM_LOWEST 256)
; #define		IOA_R_R_DM_LOWEST	0x00100
(defconstant $IOA_R_R_DM_NMI 1024)
; #define		IOA_R_R_DM_NMI		0x00400
(defconstant $IOA_R_R_DM_RESET 1280)
; #define		IOA_R_R_DM_RESET	0x00500
(defconstant $IOA_R_R_DM_EXTINT 1792)
; #define		IOA_R_R_DM_EXTINT	0x00700
(defconstant $IOA_R_R_DEST_LOGICAL 2048)
; #define		IOA_R_R_DEST_LOGICAL	0x00800
(defconstant $IOA_R_R_DS_PENDING 4096)
; #define		IOA_R_R_DS_PENDING	0x01000
(defconstant $IOA_R_R_IP_PLRITY_LOW 8192)
; #define		IOA_R_R_IP_PLRITY_LOW	0x02000
(defconstant $IOA_R_R_TM_LEVEL 32768)
; #define		IOA_R_R_TM_LEVEL	0x08000
(defconstant $IOA_R_R_MASKED 65536)
; #define		IOA_R_R_MASKED		0x10000

(provide-interface "apic")