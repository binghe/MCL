(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:table.h"
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
;  * Intel386 Family:	Descriptor tables.
;  *
;  * HISTORY
;  *
;  * 30 March 1992 ? at NeXT
;  *	Created.
;  

(require-interface "architecture/i386/desc")

(require-interface "architecture/i386/tss")
; 
;  * A totally generic descriptor
;  * table entry.
;  
(defrecord dt_entry
   (:variant
   (
   (code :CODE_DESC)
   )
   (
   (data :DATA_DESC)
   )
   (
   (ldt :LDT_DESC)
   )
   (
   (task_state :TSS_DESC)
   )
   (
   (call_gate :CALL_GATE)
   )
   (
   (trap_gate :TRAP_GATE)
   )
   (
   (intr_gate :INTR_GATE)
   )
   (
   (task_gate :TASK_GATE)
   )
   )
)
(defconstant $DESC_TBL_MAX 8192)
; #define DESC_TBL_MAX	8192
; 
;  * Global descriptor table.
;  
(defrecord gdt_entry
   (:variant
   (
   (code :CODE_DESC)
   )
   (
   (data :DATA_DESC)
   )
   (
   (ldt :LDT_DESC)
   )
   (
   (call_gate :CALL_GATE)
   )
   (
   (task_gate :TASK_GATE)
   )
   (
   (task_state :TSS_DESC)
   )
   )
)

(def-mactype :gdt_t (find-mactype ':gdt_entry_t))
; 
;  * Interrupt descriptor table.
;  
(defrecord idt_entry
   (:variant
   (
   (trap_gate :TRAP_GATE)
   )
   (
   (intr_gate :INTR_GATE)
   )
   (
   (task_gate :TASK_GATE)
   )
   )
)

(def-mactype :idt_t (find-mactype ':idt_entry_t))
; 
;  * Local descriptor table.
;  
(defrecord ldt_entry
   (:variant
   (
   (code :CODE_DESC)
   )
   (
   (data :DATA_DESC)
   )
   (
   (call_gate :CALL_GATE)
   )
   (
   (task_gate :TASK_GATE)
   )
   )
)

(def-mactype :ldt_t (find-mactype ':ldt_entry_t))

(provide-interface "table")