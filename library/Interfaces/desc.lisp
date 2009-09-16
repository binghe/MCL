(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:desc.h"
; at Sunday July 2,2006 7:27:30 pm.
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
;  * Copyright (c) 1992 NeXT Computer, Inc.
;  *
;  * Intel386 Family:	Segment descriptors.
;  *
;  * HISTORY
;  *
;  * 29 March 1992 ? at NeXT
;  *	Created.
;  
; 
;  * Code segment descriptor.
;  
(defrecord code_desc
   (limit00 :UInt16)
   (base00 :UInt16)
   (base16 :UInt8)
   (type :UInt8)                                ;(: 5)
; #define DESC_CODE_EXEC	0x18
; #define DESC_CODE_READ	0x1a
                                                ;(dpl : 2)
                                                ;(present : 1)
   (limit16 :UInt8)                             ;(: 4)
                                                ;(: 2)
                                                ;(opsz : 1)
; #define DESC_CODE_16B	0
; #define DESC_CODE_32B	1
                                                ;(granular : 1)
; #define DESC_GRAN_BYTE	0
; #define DESC_GRAN_PAGE	1
   (base24 :UInt8)
)
(%define-record :code_desc_t (find-record-descriptor :CODE_DESC))
; 
;  * Data segment descriptor.
;  
(defrecord data_desc
   (limit00 :UInt16)
   (base00 :UInt16)
   (base16 :UInt8)
   (type :UInt8)                                ;(: 5)
; #define DESC_DATA_RONLY	0x10
; #define DESC_DATA_WRITE	0x12
                                                ;(dpl : 2)
                                                ;(present : 1)
   (limit16 :UInt8)                             ;(: 4)
                                                ;(: 2)
                                                ;(stksz : 1)
; #define DESC_DATA_16B	0
; #define DESC_DATA_32B	1
                                                ;(granular : 1)
   (base24 :UInt8)
)
(%define-record :data_desc_t (find-record-descriptor :DATA_DESC))
; 
;  * LDT segment descriptor.
;  
(defrecord ldt_desc
   (limit00 :UInt16)
   (base00 :UInt16)
   (base16 :UInt8)
   (type :UInt8)                                ;(: 5)
; #define DESC_LDT	0x02
                                                ;(: 2)
                                                ;(present : 1)
   (limit16 :UInt8)                             ;(: 4)
                                                ;(: 3)
                                                ;(granular : 1)
   (base24 :UInt8)
)
(%define-record :ldt_desc_t (find-record-descriptor :LDT_DESC))

(require-interface "architecture/i386/sel")
; 
;  * Call gate descriptor.
;  
(defrecord call_gate
   (offset00 :UInt16)
   (seg :SEL)
   (argcnt :uint32)                             ;(: 5)
                                                ;(: 3)
                                                ;(type : 5)
; #define DESC_CALL_GATE	0x0c
                                                ;(dpl : 2)
                                                ;(present : 1)
                                                ;(offset16 : 16)
)
(%define-record :call_gate_t (find-record-descriptor :CALL_GATE))
; 
;  * Trap gate descriptor.
;  
(defrecord trap_gate
   (offset00 :UInt16)
   (seg :SEL)
#|
   (NIL :uint32)|#                              ;(: 8)
                                                ;(type : 5)
; #define DESC_TRAP_GATE	0x0f
                                                ;(dpl : 2)
                                                ;(present : 1)
                                                ;(offset16 : 16)
)
(%define-record :trap_gate_t (find-record-descriptor :TRAP_GATE))
; 
;  * Interrupt gate descriptor.
;  
(defrecord intr_gate
   (offset00 :UInt16)
   (seg :SEL)
#|
   (NIL :uint32)|#                              ;(: 8)
                                                ;(type : 5)
; #define DESC_INTR_GATE	0x0e
                                                ;(dpl : 2)
                                                ;(present : 1)
                                                ;(offset16 : 16)
)
(%define-record :intr_gate_t (find-record-descriptor :INTR_GATE))

(provide-interface "desc")