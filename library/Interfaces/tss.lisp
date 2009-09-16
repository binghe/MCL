(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:tss.h"
; at Sunday July 2,2006 7:32:03 pm.
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
;  * Intel386 Family:	Task State Segment.
;  *
;  * HISTORY
;  *
;  * 29 March 1992 ? at NeXT
;  *	Created.
;  

(require-interface "architecture/i386/sel")
; 
;  * Task State segment.
;  
(defrecord tss
   (oldtss :SEL)
   (colon4 :UInt32)
   (esp0 :UInt32)
   (ss0 :SEL)
   (colon2 :UInt32)
   (esp1 :UInt32)
   (ss1 :SEL)
   (colon8 :UInt32)
   (esp2 :UInt32)
   (ss2 :SEL)
   (colon14 :UInt32)
   (cr3 :UInt32)
   (eip :UInt32)
   (eflags :UInt32)
   (eax :UInt32)
   (ecx :UInt32)
   (edx :UInt32)
   (ebx :UInt32)
   (esp :UInt32)
   (ebp :UInt32)
   (esi :UInt32)
   (edi :UInt32)
   (es :SEL)
   (colon8 :UInt32)
   (cs :SEL)
   (colon11 :UInt32)
   (ss :SEL)
   (colon7 :UInt32)
   (ds :SEL)
   (colon11 :UInt32)
   (fs :SEL)
   (colon2 :UInt32)
   (gs :SEL)
   (colon13 :UInt32)
   (ldt :SEL)
   (colon15 :UInt32)
   (t :UInt32)                                  ;(: 1)
                                                ;(: 15)
                                                ;(io_bmap : 16)
)
(%define-record :tss_t (find-record-descriptor :TSS))
; #define TSS_SIZE(n)	(sizeof (struct tss) + (n))
; 
;  * Task State segment descriptor.
;  
(defrecord tss_desc
   (limit00 :UInt16)
   (base00 :UInt16)
   (base16 :UInt8)
   (type :UInt8)                                ;(: 5)
(defconstant $DESC_TSS 9)
; #define DESC_TSS	0x09
                                                ;(dpl : 2)
                                                ;(present : 1)
   (limit16 :UInt8)                             ;(: 4)
                                                ;(: 3)
                                                ;(granular : 1)
   (base24 :UInt8)
)
(%define-record :tss_desc_t (find-record-descriptor :TSS_DESC))
; 
;  * Task gate descriptor.
;  
(defrecord task_gate
   (colon4 :UInt16)
   (tss :SEL)
#|
   (NIL :UInt32)|#                              ;(: 8)
                                                ;(type : 5)
(defconstant $DESC_TASK_GATE 5)
; #define DESC_TASK_GATE	0x05
                                                ;(dpl : 2)
                                                ;(present : 1)
                                                ;(: 0)
)
(%define-record :task_gate_t (find-record-descriptor :TASK_GATE))

(provide-interface "tss")