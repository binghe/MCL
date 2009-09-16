(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOATAStorageDefines.h"
; at Sunday July 2,2006 7:26:51 pm.
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
; #ifndef _IOKIT_IO_ATA_STORAGE_DEFINES_H_
; #define _IOKIT_IO_ATA_STORAGE_DEFINES_H_
; 
;  * Important word offsets in device identify data as
;  * defined in ATA-5 standard
;  

(defconstant $kATAIdentifyConfiguration 0)
(defconstant $kATAIdentifyLogicalCylinderCount 1)
(defconstant $kATAIdentifyLogicalHeadCount 3)
(defconstant $kATAIdentifySectorsPerTrack 6)
(defconstant $kATAIdentifySerialNumber 10)
(defconstant $kATAIdentifyFirmwareRevision 23)
(defconstant $kATAIdentifyModelNumber 27)
(defconstant $kATAIdentifyMultipleSectorCount 47)
(defconstant $kATAIdentifyDriveCapabilities 49)
(defconstant $kATAIdentifyDriveCapabilitiesExtended 50)
(defconstant $kATAIdentifyPIOTiming 51)
(defconstant $kATAIdentifyExtendedInfoSupport 53)
(defconstant $kATAIdentifyCurrentCylinders 54)
(defconstant $kATAIdentifyCurrentHeads 55)
(defconstant $kATAIdentifyCurrentSectors 56)
(defconstant $kATAIdentifyCurrentCapacity 57)
(defconstant $kATAIdentifyCurrentMultipleSectors 59)
(defconstant $kATAIdentifyLBACapacity 60)
(defconstant $kATAIdentifySingleWordDMA 62)
(defconstant $kATAIdentifyMultiWordDMA 63)
(defconstant $kATAIdentifyAdvancedPIOModes 64)
(defconstant $kATAIdentifyMinMultiWordDMATime 65)
(defconstant $kATAIdentifyRecommendedMultiWordDMATime 66)
(defconstant $kATAIdentifyMinPIOTime 67)
(defconstant $kATAIdentifyMinPIOTimeWithIORDY 68)
(defconstant $kATAIdentifyQueueDepth 75)
(defconstant $kATAIdentifyMajorVersion 80)
(defconstant $kATAIdentifyMinorVersion 81)
(defconstant $kATAIdentifyCommandSetSupported 82)
(defconstant $kATAIdentifyCommandSetSupported2 83)
(defconstant $kATAIdentifyCommandExtension1 84)
(defconstant $kATAIdentifyCommandExtension2 85)
(defconstant $kATAIdentifyCommandsEnabled 86)
(defconstant $kATAIdentifyCommandsDefault 87)
(defconstant $kATAIdentifyUltraDMASupported 88)
(defconstant $kATAIdentifyIntegrity #xFF)
;  
;  * Important bits in device identify data
;  * as defined in ATA-5 standard
;  
;  Configuration field (word 0)

(defconstant $kFixedDeviceBit 6)                ;  Fixed disk indicator bit

(defconstant $kRemoveableMediaBit 7)            ;  Removable media indicator bit

(defconstant $kNonMagneticDriveBit 15)          ;  Non-magnetic drive indicator bit

(defconstant $kFixedDeviceMask 64)              ;  Mask for fixed disk indicator

(defconstant $kRemoveableMediaMask #x80)        ;  Mask for removable media indicator

(defconstant $kNonMagneticDriveMask #x8000)     ;  Mask for non-magnetic drive indicator
;  Capabilities field (word 49)

(defconstant $kDMABit 8)                        ;  DMA supported bit

(defconstant $kLBABit 9)                        ;  LBA supported bit

(defconstant $kIORDYDisableBit 10)              ;  IORDY can be disabled bit

(defconstant $kIORDYBit 11)                     ;  IORDY supported bit

(defconstant $kStandbyTimerBit 13)              ;  Standby timer supported bit

(defconstant $kDMASupportedMask #x100)          ;  Mask for DMA supported

(defconstant $kLBASupportedMask #x200)          ;  Mask for LBA supported

(defconstant $kDMADisableMask #x400)            ;  Mask for DMA supported

(defconstant $kIORDYSupportedMask #x800)        ;  Mask for IORDY supported

(defconstant $kStandbySupportedMask #x2000)     ;  Mask for Standby Timer supported
;  Extensions field (word 53)

(defconstant $kCurFieldsValidBit 0)             ;  Bit to show words 54-58 are valid

(defconstant $kExtFieldsValidBit 1)             ;  Bit to show words 64-70 are valid

(defconstant $kCurFieldsValidMask 1)            ;  Mask for current fields valid

(defconstant $kExtFieldsValidMask 2)            ;  Extension word valid
;  Advanced PIO Transfer Modes field (word 64)

(defconstant $kMode3Bit 0)                      ;  Bit to indicate mode 3 is supported

(defconstant $kMode3Mask 1)                     ;  Mask for mode 3 support
;  Integrity of Identify data (word 255)

(defconstant $kChecksumValidCookie #xA5)        ;  Bits 7:0 if device supports feature

;  String size constants 

(defconstant $kSizeOfATAModelString 40)
(defconstant $kSizeOfATARevisionString 8)
;  ATA Command timeout constants ( in milliseconds ) 

(defconstant $kATATimeout10Seconds #x2710)
(defconstant $kATATimeout30Seconds #x7530)
(defconstant $kATATimeout45Seconds #xAFC8)
(defconstant $kATATimeout1Minute #xEA60)
(defconstant $kATADefaultTimeout #x7530)
;  Retry constants 

(defconstant $kATAZeroRetries 0)
(defconstant $kATADefaultRetries 4)
;  max number of blocks supported in ATA transaction 

(defconstant $kIOATASectorCount8Bit 8)
(defconstant $kIOATASectorCount16Bit 16)

(defconstant $kIOATAMaximumBlockCount8Bit #x100)
(defconstant $kIOATAMaximumBlockCount16Bit #x10000);  For backwards compatibility

(defconstant $kIOATAMaxBlocksPerXfer #x100)
;  Power Management time constants (in seconds) 

(defconstant $kSecondsInAMinute 60)
(defconstant $k5Minutes #x12C)
;  Bits for features published in Word 82 of device identify data 

(defconstant $kATASupportsSMARTBit 0)
(defconstant $kATASupportsPowerManagementBit 3)
(defconstant $kATASupportsWriteCacheBit 5)
;  Masks for features published in Word 82 of device identify data 

(defconstant $kATASupportsSMARTMask 1)
(defconstant $kATASupportsPowerManagementMask 8)
(defconstant $kATASupportsWriteCacheMask 32)
;  Bits for features published in Word 83 of device identify data 

(defconstant $kATASupportsCompactFlashBit 2)
(defconstant $kATASupportsAdvancedPowerManagementBit 3)
(defconstant $kATASupports48BitAddressingBit 10)
(defconstant $kATASupportsFlushCacheBit 12)
(defconstant $kATASupportsFlushCacheExtendedBit 13);  Masks for features published in Word 83 of device identify data 

(defconstant $kATASupportsCompactFlashMask 4)
(defconstant $kATASupportsAdvancedPowerManagementMask 8)
(defconstant $kATASupports48BitAddressingMask #x400)
(defconstant $kATASupportsFlushCacheMask #x1000)
(defconstant $kATASupportsFlushCacheExtendedMask #x2000);  Mask to ensure data is valid

(defconstant $kATADataIsValidMask #xC000)
;  Bits for features published in Word 85 of device identify data 

(defconstant $kATAWriteCacheEnabledBit 5)
;  Masks for features published in Word 85 of device identify data 

(defconstant $kATAWriteCacheEnabledMask 32)
;  ATA supported features 

(defconstant $kIOATAFeaturePowerManagement 1)
(defconstant $kIOATAFeatureWriteCache 2)
(defconstant $kIOATAFeatureAdvancedPowerManagement 4)
(defconstant $kIOATAFeatureCompactFlash 8)
(defconstant $kIOATAFeature48BitLBA 16)
(defconstant $kIOATAFeatureSMART 32)
;  ATA Advanced Power Management settings (valid settings range from 1-254),
; the settings below are the more common settings 

(defconstant $kIOATAMaxPerformance #xFE)
(defconstant $kIOATADefaultPerformance #x80)
(defconstant $kIOATAMaxPowerSavings 1)
;  ATA power states, from lowest to highest power usage 

(def-mactype :IOATAPowerState (find-mactype ':UInt32))

(defconstant $kIOATAPowerStateSystemSleep 0)
(defconstant $kIOATAPowerStateSleep 1)
(defconstant $kIOATAPowerStateStandby 2)
(defconstant $kIOATAPowerStateIdle 3)
(defconstant $kIOATAPowerStateActive 4)
(defconstant $kIOATAPowerStates 5)
;  ATA Transfer Mode bit masks 

(defconstant $kATAEnableUltraDMAModeMask 64)
(defconstant $kATAEnableMultiWordDMAModeMask 32)
(defconstant $kATAEnablePIOModeMask 8)
; #endif	/* _IOKIT_IO_ATA_STORAGE_DEFINES_H_ */


(provide-interface "IOATAStorageDefines")