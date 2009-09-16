(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFDiskPartitionScheme.h"
; at Sunday July 2,2006 7:28:54 pm.
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
;  * This header contains the IOFDiskPartitionScheme class definition.
;  
; #ifndef _IOFDISKPARTITIONSCHEME_H
; #define _IOFDISKPARTITIONSCHEME_H

(require-interface "IOKit/IOTypes")
; 
;  * kIOFDiskPartitionSchemeClass is the name of the IOFDiskPartitionScheme class.
;  
(defconstant $kIOFDiskPartitionSchemeClass "IOFDiskPartitionScheme")
; #define kIOFDiskPartitionSchemeClass "IOFDiskPartitionScheme"
; 
;  * FDisk Partition Map Definitions
;  
; #pragma pack(2)   /* (enable 16-bit struct packing for fdisk_part, disk_blk0) */
;  Structure constants. 
; #define DISK_BLK0SZ sizeof(struct disk_blk0)    /* (size of partition map)    */
(defconstant $DISK_BOOTSZ 446)
; #define DISK_BOOTSZ 446                         /* (size of boot code in map) */
(defconstant $DISK_NPART 4)
; #define DISK_NPART  4                           /* (number of entries in map) */
;  Partition map entry. 
(defrecord fdisk_part
   (bootid :UInt8)                              ;  (is active boot partition?)                         
   (beghead :UInt8)                             ;  (beginning head)                                    
   (begsect :UInt8)                             ;  (beginning sector; beginning cylinder, high 2 bits) 
   (begcyl :UInt8)                              ;  (beginning cylinder, low 8 bits)                    
   (systid :UInt8)                              ;  (type)                                              
   (endhead :UInt8)                             ;  (ending head)                                       
   (endsect :UInt8)                             ;  (ending sector; ending cylinder, high 2 bits)       
   (endcyl :UInt8)                              ;  (ending cylinder, low 8 bits)                       
   (relsect :UInt32)                            ;  (block start)                                       
   (numsect :UInt32)                            ;  (block count)                                       
)
;  Partition map, as found in block zero of the disk (or extended partition). 
(defrecord disk_blk0
   (bootcode (:array :UInt8 446))               ;  (boot code)                
   (parts (:array :FDISK_PART 4))               ;  (partition entries)        
   (signature :UInt16)                          ;  (unique signature for map) 
)
;  Partition map signature (signature). 
(defconstant $DISK_SIGNATURE 43605)
; #define DISK_SIGNATURE 0xAA55
;  Partition map entry types (systid). 
(defconstant $FDISK_PARTITION_TYPE_01 "DOS_FAT_12")
; #define FDISK_PARTITION_TYPE_01 "DOS_FAT_12"
(defconstant $FDISK_PARTITION_TYPE_04 "DOS_FAT_16_S")
; #define FDISK_PARTITION_TYPE_04 "DOS_FAT_16_S"
(defconstant $FDISK_PARTITION_TYPE_05 "DOS_Extended")
; #define FDISK_PARTITION_TYPE_05 "DOS_Extended"
(defconstant $FDISK_PARTITION_TYPE_06 "DOS_FAT_16")
; #define FDISK_PARTITION_TYPE_06 "DOS_FAT_16"
(defconstant $FDISK_PARTITION_TYPE_07 "Windows_NTFS")
; #define FDISK_PARTITION_TYPE_07 "Windows_NTFS"
(defconstant $FDISK_PARTITION_TYPE_0A "Boot_Manager")
; #define FDISK_PARTITION_TYPE_0A "Boot_Manager"
(defconstant $FDISK_PARTITION_TYPE_0B "DOS_FAT_32")
; #define FDISK_PARTITION_TYPE_0B "DOS_FAT_32"
(defconstant $FDISK_PARTITION_TYPE_0C "Windows_FAT_32")
; #define FDISK_PARTITION_TYPE_0C "Windows_FAT_32"
(defconstant $FDISK_PARTITION_TYPE_0E "Windows_FAT_16")
; #define FDISK_PARTITION_TYPE_0E "Windows_FAT_16"
(defconstant $FDISK_PARTITION_TYPE_0F "Windows_Extended")
; #define FDISK_PARTITION_TYPE_0F "Windows_Extended"
(defconstant $FDISK_PARTITION_TYPE_11 "DOS_FAT_12_Hidden")
; #define FDISK_PARTITION_TYPE_11 "DOS_FAT_12_Hidden"
(defconstant $FDISK_PARTITION_TYPE_14 "DOS_FAT_16_S_Hidden")
; #define FDISK_PARTITION_TYPE_14 "DOS_FAT_16_S_Hidden"
(defconstant $FDISK_PARTITION_TYPE_16 "DOS_FAT_16_Hidden")
; #define FDISK_PARTITION_TYPE_16 "DOS_FAT_16_Hidden"
(defconstant $FDISK_PARTITION_TYPE_17 "Windows_NTFS_Hidden")
; #define FDISK_PARTITION_TYPE_17 "Windows_NTFS_Hidden"
(defconstant $FDISK_PARTITION_TYPE_1B "DOS_FAT_32_Hidden")
; #define FDISK_PARTITION_TYPE_1B "DOS_FAT_32_Hidden"
(defconstant $FDISK_PARTITION_TYPE_1C "Windows_FAT_32_Hidden")
; #define FDISK_PARTITION_TYPE_1C "Windows_FAT_32_Hidden"
(defconstant $FDISK_PARTITION_TYPE_1E "Windows_FAT_16_Hidden")
; #define FDISK_PARTITION_TYPE_1E "Windows_FAT_16_Hidden"
(defconstant $FDISK_PARTITION_TYPE_63 "UNIX")
; #define FDISK_PARTITION_TYPE_63 "UNIX"
(defconstant $FDISK_PARTITION_TYPE_82 "Linux_Swap")
; #define FDISK_PARTITION_TYPE_82 "Linux_Swap"
(defconstant $FDISK_PARTITION_TYPE_83 "Linux_Ext2FS")
; #define FDISK_PARTITION_TYPE_83 "Linux_Ext2FS"
(defconstant $FDISK_PARTITION_TYPE_84 "Hibernation")
; #define FDISK_PARTITION_TYPE_84 "Hibernation"
(defconstant $FDISK_PARTITION_TYPE_85 "Linux_Extended")
; #define FDISK_PARTITION_TYPE_85 "Linux_Extended"
(defconstant $FDISK_PARTITION_TYPE_86 "Windows_FAT_16_FT")
; #define FDISK_PARTITION_TYPE_86 "Windows_FAT_16_FT"
(defconstant $FDISK_PARTITION_TYPE_87 "Windows_NTFS_FT")
; #define FDISK_PARTITION_TYPE_87 "Windows_NTFS_FT"
(defconstant $FDISK_PARTITION_TYPE_A5 "FreeBSD")
; #define FDISK_PARTITION_TYPE_A5 "FreeBSD"
(defconstant $FDISK_PARTITION_TYPE_A6 "OpenBSD")
; #define FDISK_PARTITION_TYPE_A6 "OpenBSD"
(defconstant $FDISK_PARTITION_TYPE_A7 "Apple_Rhapsody_UFS")
; #define FDISK_PARTITION_TYPE_A7 "Apple_Rhapsody_UFS"
(defconstant $FDISK_PARTITION_TYPE_A8 "Apple_UFS")
; #define FDISK_PARTITION_TYPE_A8 "Apple_UFS"
(defconstant $FDISK_PARTITION_TYPE_A9 "NetBSD")
; #define FDISK_PARTITION_TYPE_A9 "NetBSD"
(defconstant $FDISK_PARTITION_TYPE_AB "Apple_Boot")
; #define FDISK_PARTITION_TYPE_AB "Apple_Boot"
(defconstant $FDISK_PARTITION_TYPE_AF "Apple_HFS")
; #define FDISK_PARTITION_TYPE_AF "Apple_HFS"
(defconstant $FDISK_PARTITION_TYPE_B7 "BSDI")
; #define FDISK_PARTITION_TYPE_B7 "BSDI"
(defconstant $FDISK_PARTITION_TYPE_B8 "BSDI_Swap")
; #define FDISK_PARTITION_TYPE_B8 "BSDI_Swap"
(defconstant $FDISK_PARTITION_TYPE_C6 "Windows_FAT_16_FT_Corrupt")
; #define FDISK_PARTITION_TYPE_C6 "Windows_FAT_16_FT_Corrupt"
(defconstant $FDISK_PARTITION_TYPE_C7 "Windows_NTFS_FT_Corrupt")
; #define FDISK_PARTITION_TYPE_C7 "Windows_NTFS_FT_Corrupt"
(defconstant $FDISK_PARTITION_TYPE_EB "BeOS")
; #define FDISK_PARTITION_TYPE_EB "BeOS"
(defconstant $FDISK_PARTITION_TYPE_F2 "DOS_Secondary")
; #define FDISK_PARTITION_TYPE_F2 "DOS_Secondary"
(defconstant $FDISK_PARTITION_TYPE_FD "Linux_RAID")
; #define FDISK_PARTITION_TYPE_FD "Linux_RAID"
; #pragma options align=reset              /* (reset to default struct packing) */

; #endif /* !_IOFDISKPARTITIONSCHEME_H */


(provide-interface "IOFDiskPartitionScheme")