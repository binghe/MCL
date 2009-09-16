(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:shared_memory_server.h"
; at Sunday July 2,2006 7:30:28 pm.
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
;  *	File: mach/shared_memory_server.h
;  *
;  * 	protos and struct definitions for shared library
;  *	server and interface
;  
; #ifndef _MACH_SHARED_MEMORY_SERVER_H_
; #define _MACH_SHARED_MEMORY_SERVER_H_
; #define	SHARED_LIBRARY_SERVER_SUPPORTED
(defconstant $GLOBAL_SHARED_TEXT_SEGMENT 2415919104)
; #define GLOBAL_SHARED_TEXT_SEGMENT 0x90000000
(defconstant $GLOBAL_SHARED_DATA_SEGMENT 2684354560)
; #define GLOBAL_SHARED_DATA_SEGMENT 0xA0000000
(defconstant $GLOBAL_SHARED_SEGMENT_MASK 4026531840)
; #define GLOBAL_SHARED_SEGMENT_MASK 0xF0000000
(defconstant $SHARED_TEXT_REGION_SIZE 268435456)
; #define		SHARED_TEXT_REGION_SIZE 0x10000000
(defconstant $SHARED_DATA_REGION_SIZE 268435456)
; #define		SHARED_DATA_REGION_SIZE 0x10000000
(defconstant $SHARED_ALTERNATE_LOAD_BASE 150994944)
; #define		SHARED_ALTERNATE_LOAD_BASE 0x9000000
;  
;  *  Note: the two masks below are useful because the assumption is 
;  *  made that these shared regions will always be mapped on natural boundaries 
;  *  i.e. if the size is 0x10000000 the object can be mapped at 
;  *  0x20000000, or 0x30000000, but not 0x1000000
;  
(defconstant $SHARED_TEXT_REGION_MASK 268435455)
; #define		SHARED_TEXT_REGION_MASK 0xFFFFFFF
(defconstant $SHARED_DATA_REGION_MASK 268435455)
; #define		SHARED_DATA_REGION_MASK 0xFFFFFFF

(require-interface "mach/vm_prot")

(require-interface "mach/mach_types")
(defconstant $SHARED_LIB_ALIAS 16)
; #define SHARED_LIB_ALIAS  0x10
;  flags field aliases for copyin_shared_file and load_shared_file 
;  IN 
(defconstant $ALTERNATE_LOAD_SITE 1)
; #define ALTERNATE_LOAD_SITE 0x1
(defconstant $NEW_LOCAL_SHARED_REGIONS 2)
; #define NEW_LOCAL_SHARED_REGIONS 0x2
(defconstant $QUERY_IS_SYSTEM_REGION 4)
; #define	QUERY_IS_SYSTEM_REGION 0x4
;  OUT 
(defconstant $SF_PREV_LOADED 1)
; #define SF_PREV_LOADED    0x1
(defconstant $SYSTEM_REGION_BACKED 2)
; #define SYSTEM_REGION_BACKED 0x2
; #define load_file_hash(file_object, size) 		((((natural_t)file_object) & 0xffffff) % size)
(defconstant $VM_PROT_COW 8)
; #define VM_PROT_COW  0x8  /* must not interfere with normal prot assignments */
(defconstant $VM_PROT_ZF 16)
; #define VM_PROT_ZF  0x10  /* must not interfere with normal prot assignments */
(defrecord sf_mapping
   (mapping_offset :UInt32)
   (size :UInt32)
   (file_offset :UInt32)
   (protection :signed-long)                    ;  read/write/execute/COW/ZF 
   (cksum :UInt32)
)

(%define-record :sf_mapping_t (find-record-descriptor ':sf_mapping))

; #endif /* _MACH_SHARED_MEMORY_SERVER_H_ */


(provide-interface "shared_memory_server")