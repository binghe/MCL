(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOApplePartitionScheme.h"
; at Sunday July 2,2006 7:28:19 pm.
; 
;  * Copyright (c) 1998-2003 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; 
;  * This header contains the IOApplePartitionScheme class definition.
;  
; #ifndef _IOAPPLEPARTITIONSCHEME_H
; #define _IOAPPLEPARTITIONSCHEME_H

(require-interface "IOKit/IOTypes")
; 
;  * kIOApplePartitionSchemeClass is the name of the IOApplePartitionScheme class.
;  
(defconstant $kIOApplePartitionSchemeClass "IOApplePartitionScheme")
; #define kIOApplePartitionSchemeClass "IOApplePartitionScheme"
; 
;  * Apple Partition Map Definitions
;  
; #pragma pack(2)     /* (enable 16-bit struct packing for dpme, DDMap, Block0) */
;  Structure constants. 
(defconstant $DPISTRLEN 32)
; #define DPISTRLEN 32
;  Partition map entry, as found in blocks 1 to dpme_map_entries of the disk. 
(defrecord dpme
   (dpme_signature :UInt16)                     ;  (unique value for partition entry, 'PM') 
   (dpme_reserved_1 :UInt16)                    ;  (reserved for future use)                
   (dpme_map_entries :UInt32)                   ;  (number of partition entries)            
   (dpme_pblock_start :UInt32)                  ;  (physical block start of partition)      
   (dpme_pblocks :UInt32)                       ;  (physical block count of partition)      
   (dpme_name (:array :character 32))           ;  (name of partition)                      
   (dpme_type (:array :character 32))           ;  (type of partition, eg. Apple_HFS)       
   (dpme_lblock_start :UInt32)                  ;  (logical block start of partition)       
   (dpme_lblocks :UInt32)                       ;  (logical block count of partition)       
   (dpme_flags :UInt32)                         ;  (partition flags, see defines below)     
   (dpme_boot_block :UInt32)                    ;  (logical block start of boot code)       
   (dpme_boot_bytes :UInt32)                    ;  (byte count of boot code)                
   (dpme_load_addr (:pointer :UInt8))           ;  (load address in memory of boot code)    
   (dpme_load_addr_2 (:pointer :UInt8))         ;  (reserved for future use)                
   (dpme_goto_addr (:pointer :UInt8))           ;  (jump address in memory of boot code)    
   (dpme_goto_addr_2 (:pointer :UInt8))         ;  (reserved for future use)                
   (dpme_checksum :UInt32)                      ;  (checksum of boot code)                  
   (dpme_process_id (:array :UInt8 16))         ;  (processor type)                         
   (dpme_reserved_2 (:array :UInt32 32))        ;  (reserved for future use)                
   (dpme_reserved_3 (:array :UInt32 62))        ;  (reserved for future use)                
)
;  Driver descriptor map entry. 
(defrecord DDMap
   (ddBlock :UInt32)                            ;  (driver's block start, sbBlkSize-blocks) 
   (ddSize :UInt16)                             ;  (driver's block count, 512-blocks)       
   (ddType :UInt16)                             ;  (driver's system type)                   
)
;  Driver descriptor map, as found in block zero of the disk. 
(defrecord Block0
   (sbSig :UInt16)                              ;  (unique value for block zero, 'ER') 
   (sbBlkSize :UInt16)                          ;  (block size for this device)        
   (sbBlkCount :UInt32)                         ;  (block count for this device)       
   (sbDevType :UInt16)                          ;  (device type)                       
   (sbDevId :UInt16)                            ;  (device id)                         
   (sbDrvrData :UInt32)                         ;  (driver data)                       
   (sbDrvrCount :UInt16)                        ;  (driver descriptor count)           
   (sbDrvrMap (:array :DDMAP 8))                ;  (driver descriptor table)           
   (sbReserved (:array :UInt8 430))             ;  (reserved for future use)           
)
;  Partition map signature (sbSig). 
(defconstant $BLOCK0_SIGNATURE 17746)
; #define BLOCK0_SIGNATURE 0x4552
;  Partition map entry signature (dpme_signature). 
(defconstant $DPME_SIGNATURE 20557)
; #define DPME_SIGNATURE 0x504D
;  Partition map entry flags (dpme_flags). 
(defconstant $DPME_FLAGS_VALID 1)
; #define DPME_FLAGS_VALID          0x00000001                   /* (bit 0)     */
(defconstant $DPME_FLAGS_ALLOCATED 2)
; #define DPME_FLAGS_ALLOCATED      0x00000002                   /* (bit 1)     */
(defconstant $DPME_FLAGS_IN_USE 4)
; #define DPME_FLAGS_IN_USE         0x00000004                   /* (bit 2)     */
(defconstant $DPME_FLAGS_BOOTABLE 8)
; #define DPME_FLAGS_BOOTABLE       0x00000008                   /* (bit 3)     */
(defconstant $DPME_FLAGS_READABLE 16)
; #define DPME_FLAGS_READABLE       0x00000010                   /* (bit 4)     */
(defconstant $DPME_FLAGS_WRITABLE 32)
; #define DPME_FLAGS_WRITABLE       0x00000020                   /* (bit 5)     */
(defconstant $DPME_FLAGS_OS_PIC_CODE 64)
; #define DPME_FLAGS_OS_PIC_CODE    0x00000040                   /* (bit 6)     */
(defconstant $DPME_FLAGS_OS_SPECIFIC_2 128)
; #define DPME_FLAGS_OS_SPECIFIC_2  0x00000080                   /* (bit 7)     */
(defconstant $DPME_FLAGS_OS_SPECIFIC_1 256)
; #define DPME_FLAGS_OS_SPECIFIC_1  0x00000100                   /* (bit 8)     */
(defconstant $DPME_FLAGS_RESERVED_2 4294966784)
; #define DPME_FLAGS_RESERVED_2     0xFFFFFE00                   /* (bit 9..31) */
; #pragma options align=reset              /* (reset to default struct packing) */

; #endif /* !_IOAPPLEPARTITIONSCHEME_H */


(provide-interface "IOApplePartitionScheme")