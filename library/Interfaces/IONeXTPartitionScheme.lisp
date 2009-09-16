(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IONeXTPartitionScheme.h"
; at Sunday July 2,2006 7:29:33 pm.
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
;  * This header contains the IONeXTPartitionScheme class definition.
;  
; #ifndef _IONEXTPARTITIONSCHEME_H
; #define _IONEXTPARTITIONSCHEME_H

(require-interface "IOKit/IOTypes")
; 
;  * kIONeXTPartitionSchemeClass is the name of the IONeXTPartitionScheme class.
;  
(defconstant $kIONeXTPartitionSchemeClass "IONeXTPartitionScheme")
; #define kIONeXTPartitionSchemeClass "IONeXTPartitionScheme"
; 
;  * NeXT Partition Map Definitions
;  
; #pragma pack(2) /* (enable 16-bit struct packing for dl_un, disk[tab,_label]) */

(require-interface "sys/disktab")
;  Structure constants. 
(defconstant $MAXLBLLEN 24)
; #define	MAXLBLLEN 24                    /* (length of disk name)              */
(defconstant $NBAD 1670)
; #define	NBAD      1670                  /* (size of bad sector table in map)  */
(defconstant $NLABELS 4)
; #define	NLABELS   4                     /* (number of partition maps on disk) */
;  Structure aliases, for disktab and dl_un fields. 
; #define dl_name          dl_dt.d_name
; #define dl_type          dl_dt.d_type
; #define dl_part          dl_dt.d_partitions
; #define dl_front         dl_dt.d_front
; #define dl_back          dl_dt.d_back
; #define dl_ngroups       dl_dt.d_ngroups
; #define dl_ag_size       dl_dt.d_ag_size
; #define dl_ag_alts       dl_dt.d_ag_alts
; #define dl_ag_off        dl_dt.d_ag_off
; #define dl_secsize       dl_dt.d_secsize
; #define dl_ncyl          dl_dt.d_ncylinders
; #define dl_nsect         dl_dt.d_nsectors
; #define dl_ntrack        dl_dt.d_ntracks
; #define dl_rpm           dl_dt.d_rpm
; #define dl_bootfile      dl_dt.d_bootfile
; #define dl_boot0_blkno   dl_dt.d_boot0_blkno
; #define dl_hostname      dl_dt.d_hostname
; #define dl_rootpartition dl_dt.d_rootpartition
; #define dl_rwpartition   dl_dt.d_rwpartition
; #define dl_v3_checksum   dl_un.DL_v3_checksum
; #define dl_bad           dl_un.DL_bad
;  Partition map, as found in block zero (or a redundant block) of the disk. 
(defrecord dl_un_t
   (:variant
   (
   (DL_v3_checksum :UInt16)
   )
;  (V3: ones complement checksum)    
   (
   (DL_bad (:array :SInt32 1670))
   )
;  (V1-V2: bad sector table)         
   )
)
(defrecord disk_label
   (dl_version :SInt32)                         ;  (unique signature for map)        
   (dl_label_blkno :SInt32)                     ;  (block on which this map resides) 
   (dl_size :SInt32)                            ;  (device block count)              
   (dl_label (:array :character 24))            ;  (device name)                     
   (dl_flags :UInt32)                           ;  (device flags)                    
   (dl_tag :UInt32)                             ;  (device tag)                      
   (dl_dt :disktab)
#|
; Warning: type-size: unknown type DISKTAB
|#                                              ;  (device info, partition entries)  
   (dl_un :DL_UN_T)
   (dl_checksum :UInt16)                        ;  (V1-V2: ones complement checksum) 
                                                ;  (add things here so dl_checksum stays in a fixed place) 
)
(%define-record :disk_label_t (find-record-descriptor :DISK_LABEL))
;  Partition map signature (dl_version). 
(defconstant $DL_V1 1315264596)
; #define DL_V1           0x4e655854                     /* (version 1: "NeXT") */
(defconstant $DL_V2 1684821554)
; #define DL_V2           0x646c5632                     /* (version 2: "dlV2") */
(defconstant $DL_V3 1684821555)
; #define DL_V3           0x646c5633                     /* (version 3: "dlV3") */
; #define DL_VERSION      DL_V3                          /* (default version)   */
;  Partition map flags (dl_flags). 
(defconstant $DL_UNINIT 2147483648)
; #define DL_UNINIT       0x80000000                     /* (is uninitialized?) */
; #pragma options align=reset              /* (reset to default struct packing) */

; #endif /* !_IONEXTPARTITIONSCHEME_H */


(provide-interface "IONeXTPartitionScheme")