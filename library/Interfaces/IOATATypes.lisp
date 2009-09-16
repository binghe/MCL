(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOATATypes.h"
; at Sunday July 2,2006 7:26:41 pm.
; 
;  * Copyright (c) 2000-2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOATATYPES_H
; #define _IOATATYPES_H

(require-interface "IOKit/IOTypes")
; #ifndef __OPEN_SOURCE__
; 
;  * Revision History
;  *
;  * $Log: IOATATypes.h,v $
;  * Revision 1.10  2003/03/14 23:57:11  barras
;  *
;  * Bug #: 3187923
;  * Submitted by:
;  * Reviewed by:
;  *
;  * Revision 1.9  2002/11/09 03:46:39  barras
;  *
;  * Bug #: 3083512, 3090979
;  *
;  * Submitted by:
;  * Reviewed by:
;  *
;  * Revision 1.8  2002/05/24 23:59:46  barras
;  *
;  * Bug #: 2931508 and 2876150
;  * Submitted by:
;  * Reviewed by:
;  *
;  * Revision 1.7  2002/02/27 02:30:33  barras
;  *
;  * Bug #: 2869416
;  *
;  * Add requested constants for extended LBA commands from mass storage, set the return type of IOExtendedLBA getCommand to 8 bit, bump to version 1.5.1d3
;  *
;  * Submitted by:
;  * Reviewed by:
;  *
;  * Revision 1.6  2002/02/14 04:02:07  barras
;  *
;  * Adding API's for 48 bit lba
;  *
;  * Bug #:
;  * Submitted by:
;  * Reviewed by:
;  *
;  * Revision 1.5  2001/11/07 22:12:48  jliu
;  * Swap the strings in the identify data for little endian machines.
;  * Defined x86 specific IOATAReg classes to access I/O space registers.
;  * Bug #: 2787594
;  *
;  * Revision 1.4  2001/07/24 00:07:41  barras
;  *
;  * Bringing TOT CVS in line with Puma builds.
;  *
;  * Bug #:
;  * Submitted by:
;  * Reviewed by:
;  *
;  * Revision 1.3.2.1  2001/06/13 03:04:07  barras
;  * Fix versioning string conflicts so kext loader is happy. Close Radar 2692663 which allows porting to other platforms.
;  *
;  * Revision 1.3  2001/05/04 01:50:37  barras
;  *
;  * Fix line endings to be all unix style in order to prevent CVS from corrupting source files.
;  *
;  * Bug #:
;  * Submitted by:
;  * Reviewed by:
;  *
;  *
;  

; #endif

; #ifdef DEBUG
; #define ATA_DEBUG 1
; #endif
; !
; 
; @header IOATAtypes.h
; @discussion contains various definitions and constants for use in the IOATAFamily and clients. Header Doc is incomplete at this point, but file is heavily commented.
; 
; 
;  property strings
(defconstant $kATADevPropertyKey "ata device type")
; #define kATADevPropertyKey "ata device type"
(defconstant $kATATypeATAString "ata")
; #define kATATypeATAString "ata"
(defconstant $kATATypeATAPIString "atapi")
; #define kATATypeATAPIString "atapi"
(defconstant $kATATypeUnknownString "unknown")
; #define kATATypeUnknownString "unknown"
(defconstant $kATAVendorPropertyKey "device model")
; #define kATAVendorPropertyKey "device model"
(defconstant $kATARevisionPropertyKey "device revision")
; #define kATARevisionPropertyKey "device revision"
(defconstant $kATASerialNumPropertyKey "device serial")
; #define kATASerialNumPropertyKey "device serial"
(defconstant $kATAUnitNumberKey "unit number")
; #define kATAUnitNumberKey "unit number"
(defconstant $kATASocketKey "socket type")
; #define kATASocketKey "socket type"
(defconstant $kATAInternalSocketString "internal")
; #define kATAInternalSocketString "internal"
(defconstant $kATAMediaBaySocketString "media-bay")
; #define kATAMediaBaySocketString "media-bay"
(defconstant $kATAPCCardSocketString "pccard")
; #define kATAPCCardSocketString "pccard"
(defconstant $kATAInternalSATAString "serial-ata")
; #define kATAInternalSATAString "serial-ata"
(defconstant $kATASATABayString "sata-bay")
; #define kATASATABayString "sata-bay"
(defconstant $kATAInternalSATA2 "serial-ata-2")
; #define kATAInternalSATA2 "serial-ata-2"
(defconstant $kATASATA2BayString "sata-2-bay")
; #define kATASATA2BayString "sata-2-bay"
(defconstant $kATAUnkownSocketString "unknown")
; #define kATAUnkownSocketString "unknown"
;  allows for porting to non-memory-mapped IO systems, such as x86.
;  for such a platform, create a class and overload the assignment operators
;  so that the correct IO operation is performed and define the type for that architecture port.
; #ifdef __ppc__
#| #|
#define IOATARegPtr8 volatile UInt8* 
#define IOATARegPtr16 volatile UInt16*
#define IOATARegPtr32 volatile UInt32*
#define IOATARegPtr8Cast(x) ((IOATARegPtr8)(x))
|#
 |#

; #elif defined( __i386__ )
#| |#

(require-interface "IOKit/ata/IOATARegI386")

#|
 |#
#| 
; #else

; #error Unknown machine architecture
 |#

; #endif

(def-mactype :ataSocketType (find-mactype ':sint32))

(defconstant $kUnknownSocket 0)
(defconstant $kInternalATASocket 1)
(defconstant $kMediaBaySocket 2)
(defconstant $kPCCardSocket 3)
(defconstant $kInternalSATA 4)
(defconstant $kSATABay 5)
(defconstant $kInternalSATA2 6)
(defconstant $kSATA2Bay 7)
(def-mactype :ataDeviceType (find-mactype ':sint32))

(defconstant $kUnknownATADeviceType 0)
(defconstant $kATADeviceType 1)
(defconstant $kATAPIDeviceType 2)
;  enum for bits 5 and 6 of word zero of 
;  the identify packet device info data.
;  shift word-0 5-bits left, mask 0x03 and these enums apply.
(def-mactype :atapiConfig (find-mactype ':sint32))

(defconstant $kATAPIDRQSlow 0)
(defconstant $kATAPIIRQPacket 1)
(defconstant $kATAPIDRQFast 16)
(defconstant $kATAPIUnknown 17)
(def-mactype :ataUnitID (find-mactype ':sint32))

(defconstant $kATAInvalidDeviceID -1)
(defconstant $kATADevice0DeviceID 0)            ;  aka, Master. Device 0 is the correct terminology 

(defconstant $kATADevice1DeviceID 1)            ;  aka, Slave. Device 1 is the correct terminology 


(defconstant $kATADefaultSectorSize #x200)
;  Task file definition еее Error Register еее

(defconstant $bATABadBlock 7)                   ;  bit number of bad block error bit

(defconstant $bATAUncorrectable 6)              ;  bit number of uncorrectable error bit

(defconstant $bATAMediaChanged 5)               ;  bit number of media changed indicator

(defconstant $bATAIDNotFound 4)                 ;  bit number of ID not found error bit

(defconstant $bATAMediaChangeReq 3)             ;  bit number of media changed request

(defconstant $bATACommandAborted 2)             ;  bit number of command abort bit

(defconstant $bATATrack0NotFound 1)             ;  bit number of track not found

(defconstant $bATAAddressNotFound 0)            ;  bit number of address mark not found

(defconstant $mATABadBlock #x80)                ;  Bad Block Detected

(defconstant $mATAUncorrectable 64)             ;  Uncorrectable Data Error

(defconstant $mATAMediaChanged 32)              ;  Media Changed Indicator (for removable)

(defconstant $mATAIDNotFound 16)                ;  ID Not Found

(defconstant $mATAMediaChangeReq 8)             ;  Media Change Requested (NOT IMPLEMENTED)

(defconstant $mATACommandAborted 4)             ;  Aborted Command

(defconstant $mATATrack0NotFound 2)             ;  Track 0 Not Found
;  Address Mark Not Found

(defconstant $mATAAddressNotFound 1)
;  Task file definition еее Features register еее

(defconstant $bATAPIuseDMA 0)                   ;  bit number of useDMA bit (ATAPI)

(defconstant $mATAPIuseDMA 1)
;  Task file definition еее ataTFSDH Register еее

(defconstant $mATAHeadNumber 15)                ;  Head Number (bits 0-3) 

(defconstant $mATASectorSize #xA0)              ;  bit 7=1; bit 5 = 01 (512 sector size) <DP4>

(defconstant $mATADriveSelect 16)               ;  Drive (0 = master, 1 = slave) 

(defconstant $mATALBASelect 64)                 ;  LBA mode bit (0 = chs, 1 = LBA)

;  Task file definition еее Status Register еее

(defconstant $bATABusy 7)                       ;  bit number of BSY bit

(defconstant $bATADriveReady 6)                 ;  bit number of drive ready bit

(defconstant $bATAWriteFault 5)                 ;  bit number of write fault bit

(defconstant $bATASeekComplete 4)               ;  bit number of seek complete bit

(defconstant $bATADataRequest 3)                ;  bit number of data request bit

(defconstant $bATADataCorrected 2)              ;  bit number of data corrected bit

(defconstant $bATAIndex 1)                      ;  bit number of index mark

(defconstant $bATAError 0)                      ;  bit number of error bit

(defconstant $mATABusy #x80)                    ;  Unit is busy

(defconstant $mATADriveReady 64)                ;  Unit is ready

(defconstant $mATAWriteFault 32)                ;  Unit has a write fault condition

(defconstant $mATASeekComplete 16)              ;  Unit seek complete

(defconstant $mATADataRequest 8)                ;  Unit data request

(defconstant $mATADataCorrected 4)              ;  Data corrected

(defconstant $mATAIndex 2)                      ;  Index mark - NOT USED
;  Error condition - see error register

(defconstant $mATAError 1)
;  Task file definition еее Device Control Register еее

(defconstant $bATADCROne 3)                     ;  bit number of always one bit

(defconstant $bATADCRReset 2)                   ;  bit number of reset bit

(defconstant $bATADCRnIntEnable 1)              ;  bit number of interrupt disable

(defconstant $mATADCROne 8)                     ;  always one bit

(defconstant $mATADCRReset 4)                   ;  Reset (1 = reset)
;  Interrupt Disable(0 = enabled)

(defconstant $mATADCRnIntEnable 2)
;  'ataRegMask' field of the ataRegAccess definition
(def-mactype :ataRegMask (find-mactype ':sint32))

(defconstant $bATAAltSDevCValid 14)             ;  bit number of alternate status/device cntrl valid bit

(defconstant $bATAStatusCmdValid 7)             ;  bit number of status/command valid bit

(defconstant $bATASDHValid 6)                   ;  bit number of ataTFSDH valid bit

(defconstant $bATACylinderHiValid 5)            ;  bit number of cylinder high valid bit

(defconstant $bATACylinderLoValid 4)            ;  bit number of cylinder low valid bit

(defconstant $bATASectorNumValid 3)             ;  bit number of sector number valid bit

(defconstant $bATASectorCntValid 2)             ;  bit number of sector count valid bit

(defconstant $bATAErrFeaturesValid 1)           ;  bit number of error/features valid bit

(defconstant $bATADataValid 0)                  ;  bit number of data valid bit

(defconstant $mATAAltSDevCValid #x4000)         ;  alternate status/device control valid

(defconstant $mATAStatusCmdValid #x80)          ;  status/command valid

(defconstant $mATASDHValid 64)                  ;  ataTFSDH valid

(defconstant $mATACylinderHiValid 32)           ;  cylinder high valid

(defconstant $mATACylinderLoValid 16)           ;  cylinder low valid

(defconstant $mATASectorNumValid 8)             ;  sector number valid

(defconstant $mATASectorCntValid 4)             ;  sector count valid

(defconstant $mATAErrFeaturesValid 2)           ;  error/features valid
;  data valid

(defconstant $mATADataValid 1)
(def-mactype :ataFlags (find-mactype ':sint32))

(defconstant $bATAFlagNoIRQ 19)                 ;  bit Number of no IRQ protocol flag

(defconstant $bATAFlag48BitLBA 18)
(defconstant $bATAFlagDMAQueued 17)
(defconstant $bATAFlagOverlapped 16)
(defconstant $bATAFlagUseConfigSpeed 15)        ;  bit number of use configured speed flag

(defconstant $bATAFlagByteSwap 14)              ;  bit number of byte swap flag

(defconstant $bATAFlagIORead 13)                ;  bit number of I/O read flag

(defconstant $bATAFlagIOWrite 12)               ;  bit number of I/O write flag

(defconstant $bATAFlagTFAccessResult 8)         ;  bit number of get register results on command completion.

(defconstant $bATAFlagUseDMA 7)                 ;  bit number of use DMA flag

(defconstant $bATAFlagProtocolATAPI 5)          ;  bit number of ATAPI protocol

(defconstant $bATAFlagImmediate 1)              ;  bit number of immediate flag 

(defconstant $bATAFlagTFAccess 0)               ;  bit number of TF access 

(defconstant $mATAFlagUseNoIRQ #x80000)         ;  Special purpose! Avoid using! No-IRQ, polled synchronous protocol valid only for PIO commands

(defconstant $mATAFlag48BitLBA #x40000)         ;  Use 48 bit extended LBA protocol on this command. Requires support from the controller.

(defconstant $mATAFlagDMAQueued #x20000)        ;  Use tagged dma queuing protocol on this command. Requires support from the controller.

(defconstant $mATAFlagOverlapped #x10000)       ;  Use overllaped protocol on this command. Requires support from the controller.

(defconstant $mATAFlagUseConfigSpeed #x8000)    ;  Use the configured interface speed = true. False = use default PIO (slow) speed. valid only for PIO commands

(defconstant $mATAFlagByteSwap #x4000)          ;  Swap data bytes (read - after; write - before)

(defconstant $mATAFlagIORead #x2000)            ;  Read (in) operation

(defconstant $mATAFlagIOWrite #x1000)           ;  Write (out) operation

(defconstant $mATAFlagTFAccessResult #x100)     ;  get contents of TaskFile registers indicated in TFMask on command completion, even if no error

(defconstant $mATAFlagUseDMA #x80)
(defconstant $mATAFlagProtocolATAPI 32)         ;  ATAPI protocol indicator

(defconstant $mATAFlagImmediate 2)              ;  Put command at head of queue 

(defconstant $mATAFlagTFAccess 1)               ;  Return Taskfile on error status
;  The Function codes sent to controllers
(def-mactype :ataOpcode (find-mactype ':sint32))

(defconstant $kATANoOp 0)
(defconstant $kATAFnExecIO 1)                   ;  Execute ATA I/O 

(defconstant $kATAPIFnExecIO 2)                 ;  ATAPI I/O 

(defconstant $kATAFnRegAccess 3)                ;  Register Access 

(defconstant $kATAFnQFlush 4)                   ;  I/O Queue flush requests for your unit number 
;  Reset ATA bus 

(defconstant $kATAFnBusReset 5)
;  The ATA Event codes╔
;  sent when calling the device driver's event handler
(def-mactype :ataEventCode (find-mactype ':sint32))

(defconstant $kATANullEvent 0)                  ;  Just kidding -- nothing happened

(defconstant $kATAOnlineEvent 1)                ;  An ATA device has come online

(defconstant $kATAOfflineEvent 2)               ;  An ATA device has gone offline

(defconstant $kATARemovedEvent 3)               ;  An ATA device has been removed from the bus

(defconstant $kATAResetEvent 4)                 ;  Someone gave a hard reset to the drive

(defconstant $kATAOfflineRequest 5)             ;  Someone requesting to offline the drive

(defconstant $kATAEjectRequest 6)               ;  Someone requesting to eject the drive

(defconstant $kATAPIResetEvent 7)               ;  Someone gave a ATAPI reset to the drive
;  These need to be combined with a new enumeration of the current ATA/ATAPI command set.
;  Some opcodes are of interest to ATA controllers, since they imply special protocols 
;  or handling.   Device Reset, Execute Device Diagnostics have subtle side effects that
;  controllers need to be aware of, so we snoop for those commands being issued.
;  the rest are here for informational purposes.
;  BUG make new enum for all current ATA commands.

(defconstant $kSOFTRESET 8)                     ;  ATAPI Soft Reset command

(defconstant $kPACKET #xA0)                     ;  ATAPI Packet command

(defconstant $kID_DRIVE #xA1)                   ;  ATAPI Identify drive command

;  ATA Command Opcode definition

(defconstant $kATAcmdWORetry 1)                 ;  Without I/O retry option

(defconstant $kATAcmdNOP 0)                     ;  NOP operation - media detect

(defconstant $kATAcmdRecal 16)                  ;  Recalibrate command 

(defconstant $kATAcmdRead 32)                   ;  Read command 

(defconstant $kATAcmdReadLong 34)               ;  Read Long command

(defconstant $kATAcmdReadExtended 36)           ;  Read Extended (with retries)

(defconstant $kATAcmdReadDMAExtended 37)        ;  Read DMA Extended (with retries)

(defconstant $kATAcmdWrite 48)                  ;  Write command 

(defconstant $kATAcmdWriteLong 50)              ;  Write Long

(defconstant $kATAcmdWriteExtended 52)          ;  Write Extended (with retries)

(defconstant $kATAcmdWriteDMAExtended 53)       ;  Write DMA Extended (with retries)

(defconstant $kATAcmdWriteVerify 60)            ;  Write verify

(defconstant $kATAcmdReadVerify 64)             ;  Read Verify command 

(defconstant $kATAcmdFormatTrack 80)            ;  Format Track command 

(defconstant $kATAcmdSeek 112)                  ;  Seek command 

(defconstant $kATAcmdDiagnostic #x90)           ;  Drive Diagnostic command 

(defconstant $kATAcmdInitDrive #x91)            ;  Init drive parameters command 

(defconstant $kATAcmdReadMultiple #xC4)         ;  Read multiple

(defconstant $kATAcmdWriteMultiple #xC5)        ;  Write multiple

(defconstant $kATAcmdSetRWMultiple #xC6)        ;  Set Multiple for Read/Write Multiple

(defconstant $kATAcmdReadDMA #xC8)              ;  Read DMA (with retries)

(defconstant $kATAcmdWriteDMA #xCA)             ;  Write DMA (with retries)

(defconstant $kATAcmdMCAcknowledge #xDB)        ;  Acknowledge media change - removable

(defconstant $kATAcmdDoorLock #xDE)             ;  Door lock

(defconstant $kATAcmdDoorUnlock #xDF)           ;  Door unlock

(defconstant $kATAcmdStandbyImmed #xE0)         ;  Standby Immediate

(defconstant $kATAcmdIdleImmed #xE1)            ;  Idle Immediate

(defconstant $kATAcmdStandby #xE2)              ;  Standby

(defconstant $kATAcmdIdle #xE3)                 ;  Idle

(defconstant $kATAcmdReadBuffer #xE4)           ;  Read sector buffer command 

(defconstant $kATAcmdCheckPowerMode #xE5)       ;  Check power mode command	<04/04/94>

(defconstant $kATAcmdSleep #xE6)                ;  Sleep

(defconstant $kATAcmdFlushCache #xE7)           ;  Flush Cache 

(defconstant $kATAcmdWriteBuffer #xE8)          ;  Write sector buffer command 

(defconstant $kATAcmdWriteSame #xE9)            ;  Write same data to multiple sectors

(defconstant $kATAcmdFlushCacheExtended #xEA)   ;  Flush Cache Extended 

(defconstant $kATAcmdDriveIdentify #xEC)        ;  Identify Drive command 

(defconstant $kATAcmdMediaEject #xED)           ;  Media Eject

(defconstant $kATAcmdSetFeatures #xEF)          ;  Set Features

;  Set feature command opcodes

(defconstant $kATAEnableWriteCache 2)           ; 		Enable write cache

(defconstant $kATASetTransferMode 3)            ; 		Set transfer mode

(defconstant $kATAEnableAPM 5)                  ;  		Enable Advanced Power Management

(defconstant $kATASetPIOMode 8)                 ; 		PIO Flow Control Tx Mode bit

(defconstant $kATADisableWriteCache #x82)       ; 		disable write cache

(defconstant $kATAEnableReadAhead #xAA)         ; 		Read look-ahead enable

;  revisit the opcode enumerations.
; ////////////////////
;  task file for ata 
(defrecord ataTaskFile
   (ataTFFeatures :UInt8)
                                                ;  <-> Error(R) or ataTFFeatures(W) register image 
   (ataTFCount :UInt8)
                                                ;  <-> Sector count/remaining 
   (ataTFSector :UInt8)
                                                ;  <-> Sector start/finish 
   (ataTFCylLo :UInt8)
                                                ;  <-> ataTFCylLo					
   (ataTFCylHigh :UInt8)
                                                ;  <-> ataTFCylHigh  
   (ataTFSDH :UInt8)
                                                ;  <-> ataTFSDH register image
   (ataTFCommand :UInt8)
                                                ;  <-> Status(R) or Command(W) register image 
)
(defrecord ataRegisterImage
   (taskFile :ATATASKFILE)
   (ataDataRegister :UInt16)
                                                ;  <-> Data register. 
   (ataAltSDevCReg :UInt8)
                                                ;  <->: Alternate status(R) or Device Control(W) register image
)
(defrecord ATAPICmdPacket
   (atapiPacketSize :UInt16)
                                                ;  Size of command packet in bytes	
   (atapiCommandByte (:array :UInt16 8))
                                                ;  The command packet itself
)
;  Error and result codes:  TBD

(defconstant $kATAErrUnknownType -1)
(defconstant $kATANoErr 0)
(defconstant $kATAQueueEmpty 1)
(defconstant $kATAUnknownOpcode 2)
(defconstant $kATATimeoutErr 3)
(defconstant $kATAInvalidDevID 4)
(defconstant $kATAErrDevBusy 5)
(defconstant $kATAModeNotSupported 6)
(defconstant $kATADevIntNoCmd 7)
(defconstant $kATADeviceError 8)
(defconstant $kATADMAErr 9)

; #endif /* !_IOATATYPES_H */


(provide-interface "IOATATypes")