(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:pim6.h"
; at Sunday July 2,2006 7:31:10 pm.
; 	$FreeBSD: src/sys/netinet6/pim6.h,v 1.1.2.1 2000/07/15 07:14:36 kris Exp $	
; 	$KAME: pim6.h,v 1.3 2000/03/25 07:23:58 sumikawa Exp $	
; 
;  * Copyright (C) 1998 WIDE Project.
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
;  * 3. Neither the name of the project nor the names of its contributors
;  *    may be used to endorse or promote products derived from this software
;  *    without specific prior written permission.
;  *
;  * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
;  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
;  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;  * SUCH DAMAGE.
;  
; 
;  * Protocol Independent Multicast (PIM) definitions
;  *
;  * Written by Ahmed Helmy, SGI, July 1996
;  *
;  * MULTICAST
;  

(require-interface "sys/appleapiopts")
; 
;  * PIM packet header
;  
(defconstant $PIM_VERSION 2)
; #define PIM_VERSION	2
(defrecord pim

; #if defined(BYTE_ORDER) && (BYTE_ORDER == LITTLE_ENDIAN)
#| 
   (pim_type :UInt8)                            ;(: 4)
                                                ;  the PIM message type, currently they are:
; 			     * Hello, Register, Register-Stop, Join/Prune,
; 			     * Bootstrap, Assert, Graft (PIM-DM only),
; 			     * Graft-Ack (PIM-DM only), C-RP-Adv
; 			     
                                                ;(pim_ver : 4)
                                                ;  PIM version number; 2 for PIMv2 
 |#

; #else
   (pim_ver :UInt8)                             ;(: 4)
                                                ;  PIM version 
                                                ;(pim_type : 4)
                                                ;  PIM type    

; #endif

   (pim_rsv :UInt8)
                                                ;  Reserved 
   (pim_cksum :UInt16)
                                                ;  IP style check sum 
)
(defconstant $PIM_MINLEN 8)
; #define PIM_MINLEN	8		/* The header min. length is 8    */
(defconstant $PIM6_REG_MINLEN 48)
; #define PIM6_REG_MINLEN	(PIM_MINLEN+40)	/* Register message + inner IP6 header */
; 
;  * Message types
;  
(defconstant $PIM_REGISTER 1)
; #define PIM_REGISTER	1	/* PIM Register type is 1 */
;  second bit in reg_head is the null bit 
(defconstant $PIM_NULL_REGISTER 1073741824)
; #define PIM_NULL_REGISTER 0x40000000

(provide-interface "pim6")