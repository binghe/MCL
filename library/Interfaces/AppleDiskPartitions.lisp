(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AppleDiskPartitions.h"
; at Sunday July 2,2006 7:23:31 pm.
; 
;      File:       OSServices/AppleDiskPartitions.h
;  
;      Contains:   The Apple disk partition scheme as defined in Inside Macintosh: Volume V.
;  
;      Version:    OSServices-62.7~16
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __APPLEDISKPARTITIONS__
; #define __APPLEDISKPARTITIONS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  Block 0 Definitions 

(defconstant $sbSIGWord #x4552)                 ;  signature word for Block 0 ('ER') 

(defconstant $sbMac 1)                          ;  system type for Mac 

;  Partition Map Signatures 

(defconstant $pMapSIG #x504D)                   ;  partition map signature ('PM') 

(defconstant $pdSigWord #x5453)                 ;  partition map signature ('TS') 

(defconstant $oldPMSigWord #x5453)
(defconstant $newPMSigWord #x504D)
;  Driver Descriptor Map 
(defrecord Block0
   (sbSig :UInt16)                              ;  unique value for SCSI block 0 
   (sbBlkSize :UInt16)                          ;  block size of device 
   (sbBlkCount :UInt32)                         ;  number of blocks on device 
   (sbDevType :UInt16)                          ;  device type 
   (sbDevId :UInt16)                            ;  device id 
   (sbData :UInt32)                             ;  not used 
   (sbDrvrCount :UInt16)                        ;  driver descriptor count 
   (ddBlock :UInt32)                            ;  1st driver's starting block 
   (ddSize :UInt16)                             ;  size of 1st driver (512-byte blks) 
   (ddType :UInt16)                             ;  system type (1 for Mac+) 
   (ddPad (:array :UInt16 243))                 ;  ARRAY[0..242] OF INTEGER; not used 
)

;type name? (%define-record :Block0 (find-record-descriptor ':Block0))
;  Driver descriptor 
(defrecord DDMap
   (ddBlock :UInt32)                            ;  1st driver's starting block 
   (ddSize :UInt16)                             ;  size of 1st driver (512-byte blks) 
   (ddType :UInt16)                             ;  system type (1 for Mac+) 
)

;type name? (%define-record :DDMap (find-record-descriptor ':DDMap))
;  Constants for the ddType field of the DDMap structure. 

(defconstant $kDriverTypeMacSCSI 1)
(defconstant $kDriverTypeMacATA #x701)
(defconstant $kDriverTypeMacSCSIChained #xFFFF)
(defconstant $kDriverTypeMacATAChained #xF8FF)
;  Partition Map Entry 
(defrecord Partition
   (pmSig :UInt16)                              ;  unique value for map entry blk 
   (pmSigPad :UInt16)                           ;  currently unused 
   (pmMapBlkCnt :UInt32)                        ;  # of blks in partition map 
   (pmPyPartStart :UInt32)                      ;  physical start blk of partition 
   (pmPartBlkCnt :UInt32)                       ;  # of blks in this partition 
   (pmPartName (:array :UInt8 32))              ;  ASCII partition name 
   (pmParType (:array :UInt8 32))               ;  ASCII partition type 
   (pmLgDataStart :UInt32)                      ;  log. # of partition's 1st data blk 
   (pmDataCnt :UInt32)                          ;  # of blks in partition's data area 
   (pmPartStatus :UInt32)                       ;  bit field for partition status 
   (pmLgBootStart :UInt32)                      ;  log. blk of partition's boot code 
   (pmBootSize :UInt32)                         ;  number of bytes in boot code 
   (pmBootAddr :UInt32)                         ;  memory load address of boot code 
   (pmBootAddr2 :UInt32)                        ;  currently unused 
   (pmBootEntry :UInt32)                        ;  entry point of boot code 
   (pmBootEntry2 :UInt32)                       ;  currently unused 
   (pmBootCksum :UInt32)                        ;  checksum of boot code 
   (pmProcessor (:array :UInt8 16))             ;  ASCII for the processor type 
   (pmPad (:array :UInt16 188))                 ;  ARRAY[0..187] OF INTEGER; not used 
)

;type name? (%define-record :Partition (find-record-descriptor ':Partition))
;  Flags for the pmPartStatus field of the Partition data structure. 

(defconstant $kPartitionAUXIsValid 1)
(defconstant $kPartitionAUXIsAllocated 2)
(defconstant $kPartitionAUXIsInUse 4)
(defconstant $kPartitionAUXIsBootValid 8)
(defconstant $kPartitionAUXIsReadable 16)
(defconstant $kPartitionAUXIsWriteable 32)
(defconstant $kPartitionAUXIsBootCodePositionIndependent 64)
(defconstant $kPartitionIsWriteable 32)
(defconstant $kPartitionIsMountedAtStartup #x40000000)
(defconstant $kPartitionIsStartup #x80000000)
(defconstant $kPartitionIsChainCompatible #x100)
(defconstant $kPartitionIsRealDeviceDriver #x200)
(defconstant $kPartitionCanChainToNext #x400)
;  Well known driver signatures, stored in the first four byte of pmPad. 

(defconstant $kPatchDriverSignature :|ptDR|)    ;  SCSI and ATA[PI] patch driver    

(defconstant $kSCSIDriverSignature #x10600)     ;  SCSI  hard disk driver           

(defconstant $kATADriverSignature :|wiki|)      ;  ATA   hard disk driver           

(defconstant $kSCSICDDriverSignature :|CDvr|)   ;  SCSI  CD-ROM    driver           

(defconstant $kATAPIDriverSignature :|ATPI|)    ;  ATAPI CD-ROM    driver           

(defconstant $kDriveSetupHFSSignature :|DSU1|)  ;  Drive Setup HFS partition        

; #pragma options align=reset

; #endif /* __APPLEDISKPARTITIONS__ */


(provide-interface "AppleDiskPartitions")