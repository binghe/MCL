(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cisreg.h"
; at Sunday July 2,2006 7:27:22 pm.
; 
;  * cisreg.h 1.17 2000/06/12 21:55:41
;  *
;  * The contents of this file are subject to the Mozilla Public License
;  * Version 1.1 (the "License"); you may not use this file except in
;  * compliance with the License. You may obtain a copy of the License
;  * at http://www.mozilla.org/MPL/
;  *
;  * Software distributed under the License is distributed on an "AS IS"
;  * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
;  * the License for the specific language governing rights and
;  * limitations under the License. 
;  *
;  * The initial developer of the original code is David A. Hinds
;  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
;  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
;  *
;  * Contributor:  Apple Computer, Inc.  Portions © 2003 Apple Computer, 
;  * Inc. All rights reserved.
;  *
;  * Alternatively, the contents of this file may be used under the
;  * terms of the GNU Public License version 2 (the "GPL"), in which
;  * case the provisions of the GPL are applicable instead of the
;  * above.  If you wish to allow the use of your version of this file
;  * only under the terms of the GPL and not to allow others to use
;  * your version of this file under the MPL, indicate your decision by
;  * deleting the provisions above and replace them with the notice and
;  * other provisions required by the GPL.  If you do not delete the
;  * provisions above, a recipient may use your version of this file
;  * under either the MPL or the GPL.
;  
; #ifndef _LINUX_CISREG_H
; #define _LINUX_CISREG_H
; 
;  * Offsets from ConfigBase for CIS registers
;  
(defconstant $CISREG_COR 0)
; #define CISREG_COR		0x00
(defconstant $CISREG_CCSR 2)
; #define CISREG_CCSR		0x02
(defconstant $CISREG_PRR 4)
; #define CISREG_PRR		0x04
(defconstant $CISREG_SCR 6)
; #define CISREG_SCR		0x06
(defconstant $CISREG_ESR 8)
; #define CISREG_ESR		0x08
(defconstant $CISREG_IOBASE_0 10)
; #define CISREG_IOBASE_0		0x0a
(defconstant $CISREG_IOBASE_1 12)
; #define CISREG_IOBASE_1		0x0c
(defconstant $CISREG_IOBASE_2 14)
; #define CISREG_IOBASE_2		0x0e
(defconstant $CISREG_IOBASE_3 16)
; #define CISREG_IOBASE_3		0x10
(defconstant $CISREG_IOSIZE 18)
; #define CISREG_IOSIZE		0x12
; 
;  * Configuration Option Register
;  
(defconstant $COR_CONFIG_MASK 63)
; #define COR_CONFIG_MASK		0x3f
(defconstant $COR_MFC_CONFIG_MASK 56)
; #define COR_MFC_CONFIG_MASK	0x38
(defconstant $COR_FUNC_ENA 1)
; #define COR_FUNC_ENA		0x01
(defconstant $COR_ADDR_DECODE 2)
; #define COR_ADDR_DECODE		0x02
(defconstant $COR_IREQ_ENA 4)
; #define COR_IREQ_ENA		0x04
(defconstant $COR_LEVEL_REQ 64)
; #define COR_LEVEL_REQ		0x40
(defconstant $COR_SOFT_RESET 128)
; #define COR_SOFT_RESET		0x80
; 
;  * Card Configuration and Status Register
;  
(defconstant $CCSR_INTR_ACK 1)
; #define CCSR_INTR_ACK		0x01
(defconstant $CCSR_INTR_PENDING 2)
; #define CCSR_INTR_PENDING	0x02
(defconstant $CCSR_POWER_DOWN 4)
; #define CCSR_POWER_DOWN		0x04
(defconstant $CCSR_AUDIO_ENA 8)
; #define CCSR_AUDIO_ENA		0x08
(defconstant $CCSR_IOIS8 32)
; #define CCSR_IOIS8		0x20
(defconstant $CCSR_SIGCHG_ENA 64)
; #define CCSR_SIGCHG_ENA		0x40
(defconstant $CCSR_CHANGED 128)
; #define CCSR_CHANGED		0x80
; 
;  * Pin Replacement Register
;  
(defconstant $PRR_WP_STATUS 1)
; #define PRR_WP_STATUS		0x01
(defconstant $PRR_READY_STATUS 2)
; #define PRR_READY_STATUS	0x02
(defconstant $PRR_BVD2_STATUS 4)
; #define PRR_BVD2_STATUS		0x04
(defconstant $PRR_BVD1_STATUS 8)
; #define PRR_BVD1_STATUS		0x08
(defconstant $PRR_WP_EVENT 16)
; #define PRR_WP_EVENT		0x10
(defconstant $PRR_READY_EVENT 32)
; #define PRR_READY_EVENT		0x20
(defconstant $PRR_BVD2_EVENT 64)
; #define PRR_BVD2_EVENT		0x40
(defconstant $PRR_BVD1_EVENT 128)
; #define PRR_BVD1_EVENT		0x80
; 
;  * Socket and Copy Register
;  
(defconstant $SCR_SOCKET_NUM 15)
; #define SCR_SOCKET_NUM		0x0f
(defconstant $SCR_COPY_NUM 112)
; #define SCR_COPY_NUM		0x70
; 
;  * Extended Status Register
;  
(defconstant $ESR_REQ_ATTN_ENA 1)
; #define ESR_REQ_ATTN_ENA	0x01
(defconstant $ESR_REQ_ATTN 16)
; #define ESR_REQ_ATTN		0x10
; 
;  * CardBus Function Status Registers
;  
(defconstant $CBFN_EVENT 0)
; #define CBFN_EVENT		0x00
(defconstant $CBFN_MASK 4)
; #define CBFN_MASK		0x04
(defconstant $CBFN_STATE 8)
; #define CBFN_STATE		0x08
(defconstant $CBFN_FORCE 12)
; #define CBFN_FORCE		0x0c
; 
;  * These apply to all the CardBus function registers
;  
(defconstant $CBFN_WP 1)
; #define CBFN_WP			0x0001
(defconstant $CBFN_READY 2)
; #define CBFN_READY		0x0002
(defconstant $CBFN_BVD2 4)
; #define CBFN_BVD2		0x0004
(defconstant $CBFN_BVD1 8)
; #define CBFN_BVD1		0x0008
(defconstant $CBFN_GWAKE 16)
; #define CBFN_GWAKE		0x0010
(defconstant $CBFN_INTR 32768)
; #define CBFN_INTR		0x8000
; 
;  * Extra bits in the Function Event Mask Register
;  
(defconstant $FEMR_BAM_ENA 32)
; #define FEMR_BAM_ENA		0x0020
(defconstant $FEMR_PWM_ENA 64)
; #define FEMR_PWM_ENA		0x0040
(defconstant $FEMR_WKUP_MASK 16384)
; #define FEMR_WKUP_MASK		0x4000
; 
;  * Indirect Addressing Registers for Zoomed Video: these are addresses
;  * in common memory space
;  
(defconstant $CISREG_ICTRL0 2)
; #define CISREG_ICTRL0		0x02	/* control registers */
(defconstant $CISREG_ICTRL1 3)
; #define CISREG_ICTRL1		0x03
(defconstant $CISREG_IADDR0 4)
; #define CISREG_IADDR0		0x04	/* address registers */
(defconstant $CISREG_IADDR1 5)
; #define CISREG_IADDR1		0x05
(defconstant $CISREG_IADDR2 6)
; #define CISREG_IADDR2		0x06
(defconstant $CISREG_IADDR3 7)
; #define CISREG_IADDR3		0x07
(defconstant $CISREG_IDATA0 8)
; #define CISREG_IDATA0		0x08	/* data registers */
(defconstant $CISREG_IDATA1 9)
; #define CISREG_IDATA1		0x09
(defconstant $ICTRL0_COMMON 1)
; #define ICTRL0_COMMON		0x01
(defconstant $ICTRL0_AUTOINC 2)
; #define ICTRL0_AUTOINC		0x02
(defconstant $ICTRL0_BYTEGRAN 4)
; #define ICTRL0_BYTEGRAN		0x04

; #endif /* _LINUX_CISREG_H */


(provide-interface "cisreg")