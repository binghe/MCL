(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vm_region.h"
; at Sunday July 2,2006 7:24:11 pm.
; 
;  * Copyright (c) 2002,2000 Apple Computer, Inc. All rights reserved.
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
;  
; 
;  *	File:	mach/vm_region.h
;  *
;  *	Define the attributes of a task's memory region
;  *
;  
; #ifndef	_MACH_VM_REGION_H_
; #define _MACH_VM_REGION_H_

(require-interface "mach/boolean")

(require-interface "mach/vm_prot")

(require-interface "mach/vm_inherit")

(require-interface "mach/vm_behavior")
; 
;  *	Types defined:
;  *
;  *	vm_region_info_t	memory region attributes
;  
(defconstant $VM_REGION_INFO_MAX 1024)
; #define VM_REGION_INFO_MAX      (1024)

(def-mactype :vm_region_info_t (find-mactype '(:pointer :signed-long)))

(def-mactype :vm_region_info_64_t (find-mactype '(:pointer :signed-long)))

(def-mactype :vm_region_recurse_info_t (find-mactype '(:pointer :signed-long)))

(def-mactype :vm_region_recurse_info_64_t (find-mactype '(:pointer :signed-long)))

(def-mactype :vm_region_flavor_t (find-mactype ':signed-long))
(defrecord vm_region_info_data_t
   (contents (:array :signed-long 1024))
)
(defconstant $VM_REGION_BASIC_INFO 10)
; #define VM_REGION_BASIC_INFO	10
(defrecord vm_region_basic_info_64
   (protection :signed-long)
   (max_protection :signed-long)
   (inheritance :UInt32)
   (shared :signed-long)
   (reserved :signed-long)
   (offset :vm_object_offset_t)
#|
; Warning: type-size: unknown type VM_OBJECT_OFFSET_T
|#
   (behavior :signed-long)
   (user_wired_count :UInt16)
)

(def-mactype :vm_region_basic_info_64_t (find-mactype '(:pointer :vm_region_basic_info_64)))

(%define-record :vm_region_basic_info_data_64_t (find-record-descriptor ':vm_region_basic_info_64))
(defconstant $VM_REGION_BASIC_INFO_COUNT_64 1)
; #define VM_REGION_BASIC_INFO_COUNT_64			(sizeof(vm_region_basic_info_data_64_t)/sizeof(int))
(defrecord vm_region_basic_info
   (protection :signed-long)
   (max_protection :signed-long)
   (inheritance :UInt32)
   (shared :signed-long)
   (reserved :signed-long)
; #ifdef soon
#| #|
	vm_object_offset_t	offset;
|#
 |#

; #else
   (offset :UInt32)

; #endif

   (behavior :signed-long)
   (user_wired_count :UInt16)
)

(def-mactype :vm_region_basic_info_t (find-mactype '(:pointer :vm_region_basic_info)))

(%define-record :vm_region_basic_info_data_t (find-record-descriptor ':vm_region_basic_info))
(defconstant $VM_REGION_BASIC_INFO_COUNT 1)
; #define VM_REGION_BASIC_INFO_COUNT			(sizeof(vm_region_basic_info_data_t)/sizeof(int))
(defconstant $VM_REGION_EXTENDED_INFO 11)
; #define VM_REGION_EXTENDED_INFO	11
(defconstant $SM_COW 1)
; #define SM_COW             1
(defconstant $SM_PRIVATE 2)
; #define SM_PRIVATE         2
(defconstant $SM_EMPTY 3)
; #define SM_EMPTY           3
(defconstant $SM_SHARED 4)
; #define SM_SHARED          4
(defconstant $SM_TRUESHARED 5)
; #define SM_TRUESHARED      5
(defconstant $SM_PRIVATE_ALIASED 6)
; #define SM_PRIVATE_ALIASED 6
(defconstant $SM_SHARED_ALIASED 7)
; #define SM_SHARED_ALIASED  7
;  
;  * For submap info,  the SM flags above are overlayed when a submap
;  * is encountered.  The field denotes whether or not machine level mapping
;  * information is being shared.  PTE's etc.  When such sharing is taking
;  * place the value returned is SM_TRUESHARED otherwise SM_PRIVATE is passed
;  * back.
;  
(defrecord vm_region_extended_info
   (protection :signed-long)
   (user_tag :UInt32)
   (pages_resident :UInt32)
   (pages_shared_now_private :UInt32)
   (pages_swapped_out :UInt32)
   (pages_dirtied :UInt32)
   (ref_count :UInt32)
   (shadow_depth :UInt16)
   (external_pager :UInt8)
   (share_mode :UInt8)
)

(def-mactype :vm_region_extended_info_t (find-mactype '(:pointer :vm_region_extended_info)))

(%define-record :vm_region_extended_info_data_t (find-record-descriptor ':vm_region_extended_info))
(defconstant $VM_REGION_EXTENDED_INFO_COUNT 1)
; #define VM_REGION_EXTENDED_INFO_COUNT			(sizeof(vm_region_extended_info_data_t)/sizeof(int))
(defconstant $VM_REGION_TOP_INFO 12)
; #define VM_REGION_TOP_INFO	12
(defrecord vm_region_top_info
   (obj_id :UInt32)
   (ref_count :UInt32)
   (private_pages_resident :UInt32)
   (shared_pages_resident :UInt32)
   (share_mode :UInt8)
)

(def-mactype :vm_region_top_info_t (find-mactype '(:pointer :vm_region_top_info)))

(%define-record :vm_region_top_info_data_t (find-record-descriptor ':vm_region_top_info))
(defconstant $VM_REGION_TOP_INFO_COUNT 1)
; #define VM_REGION_TOP_INFO_COUNT			(sizeof(vm_region_top_info_data_t)/sizeof(int))
;  
;  * vm_region_submap_info will return information on a submap or object.
;  * The user supplies a nesting level on the call.  When a walk of the
;  * user's map is done and a submap is encountered, the nesting count is
;  * checked. If the nesting count is greater than 1 the submap is entered and
;  * the offset relative to the address in the base map is examined.  If the
;  * nesting count is zero, the information on the submap is returned.
;  * The caller may thus learn about a submap and its contents by judicious
;  * choice of the base map address and nesting count.  The nesting count
;  * allows penetration of recursively mapped submaps.  If a submap is
;  * encountered as a mapped entry of another submap, the caller may bump
;  * the nesting count and call vm_region_recurse again on the target address
;  * range.  The "is_submap" field tells the caller whether or not a submap
;  * has been encountered.
;  *
;  * Object only fields are filled in through a walking of the object shadow
;  * chain (where one is present), and a walking of the resident page queue.
;  * 
;  
(defrecord vm_region_submap_info
   (protection :signed-long)                    ;  present access protection 
   (max_protection :signed-long)                ;  max avail through vm_prot 
   (inheritance :UInt32)                        ;  behavior of map/obj on fork 
; #ifdef soon
#| #|
	vm_object_offset_t	offset;		
|#
 |#

; #else
   (offset :UInt32)
                                                ;  offset into object/map 

; #endif

   (user_tag :UInt32)
                                                ;  user tag on map entry 
   (pages_resident :UInt32)
                                                ;  only valid for objects 
   (pages_shared_now_private :UInt32)           ;  only for objects 
   (pages_swapped_out :UInt32)                  ;  only for objects 
   (pages_dirtied :UInt32)                      ;  only for objects 
   (ref_count :UInt32)
                                                ;  obj/map mappers, etc 
   (shadow_depth :UInt16)
                                                ;  only for obj 
   (external_pager :UInt8)                      ;  only for obj 
   (share_mode :UInt8)
                                                ;  see enumeration 
   (is_submap :signed-long)
                                                ;  submap vs obj 
   (behavior :signed-long)
                                                ;  access behavior hint 
   (object_id :UInt32)
                                                ;  obj/map name, not a handle 
   (user_wired_count :UInt16)
)

(def-mactype :vm_region_submap_info_t (find-mactype '(:pointer :vm_region_submap_info)))

(%define-record :vm_region_submap_info_data_t (find-record-descriptor ':vm_region_submap_info))
(defconstant $VM_REGION_SUBMAP_INFO_COUNT 1)
; #define VM_REGION_SUBMAP_INFO_COUNT			(sizeof(vm_region_submap_info_data_t)/sizeof(int))
(defrecord vm_region_submap_info_64
   (protection :signed-long)                    ;  present access protection 
   (max_protection :signed-long)                ;  max avail through vm_prot 
   (inheritance :UInt32)                        ;  behavior of map/obj on fork 
   (offset :vm_object_offset_t)
#|
; Warning: type-size: unknown type VM_OBJECT_OFFSET_T
|#
                                                ;  offset into object/map 
   (user_tag :UInt32)
                                                ;  user tag on map entry 
   (pages_resident :UInt32)
                                                ;  only valid for objects 
   (pages_shared_now_private :UInt32)           ;  only for objects 
   (pages_swapped_out :UInt32)                  ;  only for objects 
   (pages_dirtied :UInt32)                      ;  only for objects 
   (ref_count :UInt32)
                                                ;  obj/map mappers, etc 
   (shadow_depth :UInt16)
                                                ;  only for obj 
   (external_pager :UInt8)                      ;  only for obj 
   (share_mode :UInt8)
                                                ;  see enumeration 
   (is_submap :signed-long)
                                                ;  submap vs obj 
   (behavior :signed-long)
                                                ;  access behavior hint 
   (object_id :UInt32)
                                                ;  obj/map name, not a handle 
   (user_wired_count :UInt16)
)

(def-mactype :vm_region_submap_info_64_t (find-mactype '(:pointer :vm_region_submap_info_64)))

(%define-record :vm_region_submap_info_data_64_t (find-record-descriptor ':vm_region_submap_info_64))
(defconstant $VM_REGION_SUBMAP_INFO_COUNT_64 1)
; #define VM_REGION_SUBMAP_INFO_COUNT_64			(sizeof(vm_region_submap_info_data_64_t)/sizeof(int))
(defrecord vm_read_entry
   (address :vm_address_t)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
   (size :UInt32)
)
(defconstant $VM_MAP_ENTRY_MAX 256)
; #define VM_MAP_ENTRY_MAX  (256)
(defrecord vm_read_entry_t
   (contents (:array :VM_READ_ENTRY 256))
)
; #endif	/*_MACH_VM_REGION_H_*/


(provide-interface "vm_region")