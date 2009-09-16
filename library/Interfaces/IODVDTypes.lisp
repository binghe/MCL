(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IODVDTypes.h"
; at Sunday July 2,2006 7:28:50 pm.
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
; #ifndef	_IODVDTYPES_H
; #define	_IODVDTYPES_H

(require-interface "IOKit/IOTypes")
; #pragma pack(1)                              /* (enable 8-bit struct packing) */
; 
;  *	The following CPRM Information is taken from Mt. Fuji
;  *	Specifications ( INf-8090i Rev 4.0 ) document pp. 425-426
;  

(def-mactype :DVDCPRMRegionCode (find-mactype ':UInt8))

(defconstant $kDVDCPRMRegion1 #xFE)
(defconstant $kDVDCPRMRegion2 #xFD)
(defconstant $kDVDCPRMRegion3 #xFB)
(defconstant $kDVDCPRMRegion4 #xF7)
(defconstant $kDVDCPRMRegion5 #xEF)
(defconstant $kDVDCPRMRegion6 #xDF)

(def-mactype :DVDRegionalPlaybackControlScheme (find-mactype ':UInt8))

(defconstant $kDVDRegionalPlaybackControlSchemePhase1 0)
(defconstant $kDVDRegionalPlaybackControlSchemePhase2 1)

(def-mactype :DVDBookType (find-mactype ':UInt8))

(defconstant $kDVDBookTypeROM 0)
(defconstant $kDVDBookTypeRAM 1)
(defconstant $kDVDBookTypeR 2)
(defconstant $kDVDBookTypeRW 3)
(defconstant $kDVDBookTypePlusRW 9)
(defconstant $kDVDBookTypePlusR 10)
(def-mactype :DVDKeyClass (find-mactype ':sint32))

(defconstant $kDVDKeyClassCSS_CPPM_CPRM 0)
(defconstant $kDVDKeyClassRSSA 1)

;type name? (def-mactype :DVDKeyClass (find-mactype ':DVDKeyClass))
(def-mactype :DVDKeyFormat (find-mactype ':sint32))

(defconstant $kDVDKeyFormatAGID_CSS 0)
(defconstant $kDVDKeyFormatChallengeKey 1)
(defconstant $kDVDKeyFormatKey1 2)
(defconstant $kDVDKeyFormatKey2 3)
(defconstant $kDVDKeyFormatTitleKey 4)
(defconstant $kDVDKeyFormatASF 5)
(defconstant $kDVDKeyFormatSetRegion 6)
(defconstant $kDVDKeyFormatRegionState 8)
(defconstant $kDVDKeyFormatAGID_CSS2 16)
(defconstant $kDVDKeyFormatAGID_CPRM 17)
(defconstant $kDVDKeyFormatAGID_Invalidate 63)

;type name? (def-mactype :DVDKeyFormat (find-mactype ':DVDKeyFormat))

(def-mactype :DVDStructureFormat (find-mactype ':UInt8))

(defconstant $kDVDStructureFormatPhysicalFormatInfo 0)
(defconstant $kDVDStructureFormatCopyrightInfo 1)
(defconstant $kDVDStructureFormatDiscKeyInfo 2) ;  skip BCA

(defconstant $kDVDStructureFormatManufacturingInfo 4)
;  Read DVD Structures Format 0x00
(defrecord DVDPhysicalFormatInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
; #ifdef __LITTLE_ENDIAN__
#| #|
		UInt8		partVersion:4;
	UInt8		bookType:4;
	
		UInt8		minimumRate:4;
	UInt8		discSize:4;
	
		UInt8		layerType:4;
	UInt8		trackPath:1;
	UInt8		numberOfLayers:2;
	UInt8		reserved2:1;
	
		UInt8		trackDensity:4;
	UInt8		linearDensity:4;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
                                                ;  Byte 0
   (bookType :UInt8)
   (partVersion :UInt8)
                                                ;  Byte 1
   (discSize :UInt8)
   (minimumRate :UInt8)
                                                ;  Byte 2
   (reserved2 :UInt8)
   (numberOfLayers :UInt8)
   (trackPath :UInt8)
   (layerType :UInt8)
                                                ;  Byte 3
   (linearDensity :UInt8)
   (trackDensity :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

                                                ;  Bytes 4-15
   (zero1 :UInt8)
                                                ;  always 0x00
   (startingPhysicalSectorNumberOfDataArea (:array :UInt8 3))
   (zero2 :UInt8)
                                                ;  always 0x00
   (endPhysicalSectorNumberOfDataArea (:array :UInt8 3))
   (zero3 :UInt8)
                                                ;  always 0x00
   (endSectorNumberInLayerZero (:array :UInt8 3))
                                                ;  Byte 16
; #ifdef __LITTLE_ENDIAN__
#| #|
	UInt8		reserved1:7;
	UInt8		bcaFlag:1;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (bcaFlag :UInt8)
   (reserved1 :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

                                                ;  Bytes 17-2047
   (mediaSpecific (:array :UInt8 2031))
)

;type name? (%define-record :DVDPhysicalFormatInfo (find-record-descriptor ':DVDPhysicalFormatInfo))
;  Read DVD Structures Format 0x01
(defrecord DVDCopyrightInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (copyrightProtectionSystemType :UInt8)
   (regionMask :UInt8)
   (reserved2 (:array :UInt8 2))
)

;type name? (%define-record :DVDCopyrightInfo (find-record-descriptor ':DVDCopyrightInfo))
;  Read DVD Structures Format 0x02
(defrecord DVDDiscKeyInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (discKeyStructures (:array :UInt8 2048))
)

;type name? (%define-record :DVDDiscKeyInfo (find-record-descriptor ':DVDDiscKeyInfo))
;  Read DVD Structures Format 0x04
(defrecord DVDManufacturingInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (discManufacturingInfo (:array :UInt8 2048))
)

;type name? (%define-record :DVDManufacturingInfo (find-record-descriptor ':DVDManufacturingInfo))
;  ReportKey Format 0x00
(defrecord DVDAuthenticationGrantIDInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (reserved2 (:array :UInt8 3))
; #ifdef __LITTLE_ENDIAN__
#| #|
	UInt8	reservedBits:6;
	UInt8	grantID:2;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (grantID :UInt8)
   (reservedBits :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

)

;type name? (%define-record :DVDAuthenticationGrantIDInfo (find-record-descriptor ':DVDAuthenticationGrantIDInfo))
;  ReportKey and SendKey Format 0x01
(defrecord DVDChallengeKeyInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (challengeKeyValue (:array :UInt8 10))
   (reserved2 (:array :UInt8 2))
)

;type name? (%define-record :DVDChallengeKeyInfo (find-record-descriptor ':DVDChallengeKeyInfo))
;  ReportKey Format 0x02
(defrecord DVDKey1Info
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (key1Value (:array :UInt8 5))
   (reserved2 (:array :UInt8 3))
)

;type name? (%define-record :DVDKey1Info (find-record-descriptor ':DVDKey1Info))
;  SendKey Format 0x03
(defrecord DVDKey2Info
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (key2Value (:array :UInt8 5))
   (reserved2 (:array :UInt8 3))
)

;type name? (%define-record :DVDKey2Info (find-record-descriptor ':DVDKey2Info))
;  ReportKey Format 0x04
(defrecord DVDTitleKeyInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
; #ifdef __LITTLE_ENDIAN__
#| #|
	UInt8	CP_MOD:4;
	UInt8	CGMS:2;
	UInt8	CP_SEC:1;
	UInt8	CPM:1;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (CPM :UInt8)
   (CP_SEC :UInt8)
   (CGMS :UInt8)
   (CP_MOD :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (titleKeyValue (:array :UInt8 5))
   (reserved2 (:array :UInt8 2))
)

;type name? (%define-record :DVDTitleKeyInfo (find-record-descriptor ':DVDTitleKeyInfo))
;  ReportKey Format 0x05
(defrecord DVDAuthenticationSuccessFlagInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
   (reserved2 (:array :UInt8 3))
; #ifdef __LITTLE_ENDIAN__
#| #|
	UInt8	successFlag:1;
	UInt8	reservedBits:7;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reservedBits :UInt8)
   (successFlag :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

)

;type name? (%define-record :DVDAuthenticationSuccessFlagInfo (find-record-descriptor ':DVDAuthenticationSuccessFlagInfo))
;  ReportKey Format 0x08
(defrecord DVDRegionPlaybackControlInfo
   (dataLength (:array :UInt8 2))
   (reserved (:array :UInt8 2))
; #ifdef __LITTLE_ENDIAN__
#| #|
	UInt8									numberUserResets:3;
	UInt8									numberVendorResets:3;
	UInt8									typeCode:2;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (typeCode :UInt8)
   (numberVendorResets :UInt8)
   (numberUserResets :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (driveRegion :UInt8)
   (rpcScheme :UInt8)
   (reserved2 :UInt8)
)

;type name? (%define-record :DVDRegionPlaybackControlInfo (find-record-descriptor ':DVDRegionPlaybackControlInfo))
;  Read Disc Information Format
(defrecord DVDDiscInfo
   (dataLength :UInt16)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  discStatus:2;
    UInt8  stateOfLastBorder:2;
    UInt8  erasable:1;
    UInt8  reserved:3;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reserved :UInt8)
   (erasable :UInt8)
   (stateOfLastBorder :UInt8)
   (discStatus :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (reserved2 :UInt8)
   (numberOfBordersLSB :UInt8)
   (firstRZoneNumberInLastBorderLSB :UInt8)
   (lastRZoneNumberInLastBorderLSB :UInt8)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  reserved3:5;
    UInt8  unrestrictedUse:1;
    UInt8  discBarCodeValid:1;
    UInt8  reserved4:1;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reserved4 :UInt8)
   (discBarCodeValid :UInt8)
   (unrestrictedUse :UInt8)
   (reserved3 :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (reserved5 :UInt8)
   (numberOfBordersMSB :UInt8)
   (firstRZoneNumberInLastBorderMSB :UInt8)
   (lastRZoneNumberInLastBorderMSB :UInt8)
   (reserved6 (:array :UInt8 4))
   (reserved7 (:array :UInt8 4))
   (reserved8 (:array :UInt8 4))
   (discBarCode (:array :UInt8 8))
   (reserved9 :UInt8)
   (numberOfOPCTableEntries :UInt8)
   (opcTableEntries (:array :UInt8 0))
)

;type name? (%define-record :DVDDiscInfo (find-record-descriptor ':DVDDiscInfo))
;  Read RZone Information Address Types

(def-mactype :DVDRZoneInfoAddressType (find-mactype ':UInt8))

(defconstant $kDVDRZoneInfoAddressTypeLBA 0)
(defconstant $kDVDRZoneInfoAddressTypeRZoneNumber 1)
(defconstant $kDVDRZoneInfoAddressTypeBorderNumber 2);  Read RZone Information Format
(defrecord DVDRZoneInfo
   (dataLength :UInt16)
   (rzoneNumberLSB :UInt8)
   (borderNumberLSB :UInt8)
   (reserved :UInt8)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  reserved2:4;
    UInt8  copy:1;
    UInt8  damage:1;
    UInt8  reserved3:2;

    UInt8  reserved4:4;
    UInt8  restrictedOverwrite:1;
    UInt8  incremental:1;
    UInt8  blank:1;
    UInt8  reservedRZone:1;

    UInt8  nextWritableAddressValid:1;
    UInt8  lastRecordedAddressValid:1;
    UInt8  reserved5:6;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reserved3 :UInt8)
   (damage :UInt8)
   (copy :UInt8)
   (reserved2 :UInt8)
   (reservedRZone :UInt8)
   (blank :UInt8)
   (incremental :UInt8)
   (restrictedOverwrite :UInt8)
   (reserved4 :UInt8)
   (reserved5 :UInt8)
   (lastRecordedAddressValid :UInt8)
   (nextWritableAddressValid :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (rzoneStartAddress :UInt32)
   (nextWritableAddress :UInt32)
   (freeBlocks :UInt32)
   (blockingFactor :UInt32)
   (rzoneSize :UInt32)
   (lastRecordedAddress :UInt32)
   (rzoneNumberMSB :UInt8)
   (borderNumberMSB :UInt8)
   (reserved6 :UInt8)
   (reserved7 :UInt8)
)

;type name? (%define-record :DVDRZoneInfo (find-record-descriptor ':DVDRZoneInfo))
(def-mactype :DVDMediaType (find-mactype ':sint32))

(defconstant $kDVDMediaTypeUnknown #x200)
(defconstant $kDVDMediaTypeROM #x202)           ;  DVD-ROM 

(defconstant $kDVDMediaTypeRAM #x203)           ;  DVD-RAM 

(defconstant $kDVDMediaTypeR #x204)             ;  DVD-R   

(defconstant $kDVDMediaTypeRW #x205)            ;  DVD-RW  

(defconstant $kDVDMediaTypePlusRW #x206)        ;  DVD+RW  

(defconstant $kDVDMediaTypePlusR #x207)         ;  DVD+R   

(defconstant $kDVDMediaTypeMin #x200)
(defconstant $kDVDMediaTypeMax #x2FF)

;type name? (def-mactype :DVDMediaType (find-mactype ':DVDMediaType))
(defconstant $kDVDSpeedMin 1350)
; #define kDVDSpeedMin 0x0546
(defconstant $kDVDSpeedMax 65535)
; #define kDVDSpeedMax 0xFFFF
; #pragma options align=reset              /* (reset to default struct packing) */

; #endif /* _IODVDTYPES_H */


(provide-interface "IODVDTypes")