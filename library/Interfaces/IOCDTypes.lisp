(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCDTypes.h"
; at Sunday July 2,2006 7:28:38 pm.
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
; #ifndef	_IOCDTYPES_H
; #define	_IOCDTYPES_H

(require-interface "IOKit/IOTypes")

(require-interface "libkern/OSByteOrder")
; #pragma pack(1)                              /* (enable 8-bit struct packing) */
; 
;  * Minutes, Seconds, Frames (M:S:F)
;  *
;  * All M:S:F values passed across I/O Kit APIs are guaranteed to be
;  * binary-encoded numbers (no BCD-encoded numbers are ever passed).
;  
(defrecord CDMSF
   (minute :UInt8)
   (second :UInt8)
   (frame :UInt8)
)
; 
;  * Media Catalogue Numbers (MCN), International Standard Recording Codes (ISRC)
;  *
;  * All MCN and ISRC values passed across I/O Kit APIs are guaranteed
;  * to have a zero-terminating byte, for convenient use as C strings.
;  
(defconstant $kCDMCNMaxLength 13)
; #define kCDMCNMaxLength  13
(defconstant $kCDISRCMaxLength 12)
; #define kCDISRCMaxLength 12
(defrecord CDMCN
   (contents (:array :character 14))
)
(defrecord CDISRC
   (contents (:array :character 13))
)
; 
;  * Audio Status
;  *
;  * All CDAudioStatus fields passed across I/O Kit APIs are guaranteed to
;  * be binary-encoded numbers (no BCD-encoded numbers are ever passed).
;  
(defconstant $kCDAudioStatusUnsupported 0)
; #define kCDAudioStatusUnsupported 0x00
(defconstant $kCDAudioStatusActive 17)
; #define kCDAudioStatusActive      0x11
(defconstant $kCDAudioStatusPaused 18)
; #define kCDAudioStatusPaused      0x12
(defconstant $kCDAudioStatusSuccess 19)
; #define kCDAudioStatusSuccess     0x13
(defconstant $kCDAudioStatusFailure 20)
; #define kCDAudioStatusFailure     0x14
(defconstant $kCDAudioStatusNone 21)
; #define kCDAudioStatusNone        0x15
(defrecord CDAudioStatus
   (status :UInt8)
   (time :CDMSF)
   (index :UInt8)
   (number :UInt8)
   (time :CDMSF)
)
; 
;  * Table Of Contents
;  *
;  * All CDTOC fields passed across I/O Kit APIs are guaranteed to be
;  * binary-encoded numbers (no BCD-encoded numbers are ever passed).
;  
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8 control:4, adr:4;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */

; #endif /* !__LITTLE_ENDIAN__ */

(defrecord CDTOCDescriptor
   (session :UInt8)
   (adr :UInt8)                                 ;(: 4)
                                                ;(control : 4)
   (tno :UInt8)
   (point :UInt8)
   (address :CDMSF)
   (zero :UInt8)
   (p :CDMSF)
)
(defrecord CDTOC
   (length :UInt16)
   (sessionFirst :UInt8)
   (sessionLast :UInt8)
   (descriptors (:array :CDTOCDESCRIPTOR 0))
)
; 
;  * Table Of Contents Descriptor Count Convenience Function
;  
#|
 confused about STATIC UInt32 __inline CDTOCGetDescriptorCount #\( CDTOC * toc #\) #\{ UInt32 tocSize = OSSwapBigToHostInt16 #\( toc - > length #\) + sizeof #\( toc - > length #\) #\; return #\( tocSize < sizeof #\( CDTOC #\) #\) ? 0 #\: #\( tocSize - sizeof #\( CDTOC #\) #\) / sizeof #\( CDTOCDescriptor #\) #\;
|#
; 
;  * M:S:F To LBA Convenience Function
;  
#|
 confused about STATIC UInt32 __inline CDConvertMSFToLBA #\( CDMSF msf #\) #\{ return #\( #\( #\( msf.minute * 60UL #\) + msf.second #\) * 75UL #\) + msf.frame - 150 #\;
|#
; 
;  * M:S:F To Clipped LBA Convenience Function
;  
#|
 confused about STATIC UInt32 __inline CDConvertMSFToClippedLBA #\( CDMSF msf #\) #\{ return #\( msf.minute == 0 && msf.second <= 1 #\) ? 0 #\: CDConvertMSFToLBA #\( msf #\) #\;
|#
; 
;  * LBA To M:S:F Convenience Function
;  
#|
 confused about STATIC CDMSF __inline CDConvertLBAToMSF #\( UInt32 lba #\) #\{ CDMSF msf #\; lba + = 150 #\; msf.minute = #\( lba / #\( 75 * 60 #\) #\) #\; msf.second = #\( lba % #\( 75 * 60 #\) #\) / 75 #\; msf.frame = #\( lba % #\( 75 #\) #\) #\; return msf #\;
|#
; 
;  * Track Number To M:S:F Convenience Function
;  *
;  * The CDTOC structure is assumed to be complete, that is, none of
;  * the descriptors are missing or clipped due to an insufficiently
;  * sized buffer holding the CDTOC contents.
;  
#|
 confused about STATIC CDMSF __inline CDConvertTrackNumberToMSF #\( UInt8 track #\, CDTOC * toc #\) #\{ UInt32 count = CDTOCGetDescriptorCount #\( toc #\) #\; UInt32 i #\; CDMSF msf = #\{ 0xFF #\, 0xFF #\, 0xFF #\} #\; for #\( i = 0 #\; i < count #\; i + + #\) #\{ if #\( toc - > descriptors #\[ i #\] .point == track && toc - > descriptors #\[ i #\] .adr == 1 #\) #\{ msf = toc - > descriptors #\[ i #\] .p #\; break #\; #\} #\} return msf #\;
|#
; 
;  * Sector Areas, Sector Types
;  *
;  * Bytes Per Type      CDDA       Mode1      Mode2   Mode2Form1 Mode2Form2
;  *       Per Area  +----------+----------+----------+----------+----------+
;  * Sync            | 0        | 12       | 12       | 12       | 12       |
;  * Header          | 0        | 4        | 4        | 4        | 4        |
;  * SubHeader       | 0        | 0        | 0        | 8        | 8        |
;  * User            | 2352     | 2048     | 2336     | 2048     | 2328     |
;  * Auxiliary       | 0        | 288      | 0        | 280      | 0        |
;  * ErrorFlags      | 294      | 294      | 294      | 294      | 294      |
;  * SubChannel      | 96       | 96       | 96       | 96       | 96       |
;  * SubChannelQ     | 16       | 16       | 16       | 16       | 16       |
;  *                 +----------+----------+----------+----------+----------+
;  

(defconstant $kCDSectorAreaSync #x80)
(defconstant $kCDSectorAreaHeader 32)
(defconstant $kCDSectorAreaSubHeader 64)
(defconstant $kCDSectorAreaUser 16)
(defconstant $kCDSectorAreaAuxiliary 8)
(defconstant $kCDSectorAreaErrorFlags 2)
(defconstant $kCDSectorAreaSubChannel 1)
(defconstant $kCDSectorAreaSubChannelQ 4)
(def-mactype :CDSectorArea (find-mactype ':SINT32))

(defconstant $kCDSectorTypeUnknown 0)
(defconstant $kCDSectorTypeCDDA 1)
(defconstant $kCDSectorTypeMode1 2)
(defconstant $kCDSectorTypeMode2 3)
(defconstant $kCDSectorTypeMode2Form1 4)
(defconstant $kCDSectorTypeMode2Form2 5)
(defconstant $kCDSectorTypeCount 6)
(def-mactype :CDSectorType (find-mactype ':SINT32))

(defconstant $kCDSectorSizeCDDA #x930)
(defconstant $kCDSectorSizeMode1 #x800)
(defconstant $kCDSectorSizeMode2 #x920)
(defconstant $kCDSectorSizeMode2Form1 #x800)
(defconstant $kCDSectorSizeMode2Form2 #x918)
(defconstant $kCDSectorSizeWhole #x930)
(def-mactype :CDSectorSize (find-mactype ':SINT32))
; 
;  * Media Types
;  

(defconstant $kCDMediaTypeUnknown #x100)
(defconstant $kCDMediaTypeROM #x102)            ;  CD-ROM 

(defconstant $kCDMediaTypeR #x104)              ;  CD-R   

(defconstant $kCDMediaTypeRW #x105)             ;  CD-RW  

(defconstant $kCDMediaTypeMin #x100)
(defconstant $kCDMediaTypeMax #x1FF)
(def-mactype :CDMediaType (find-mactype ':SINT32))
; 
;  * Media Speed (kB/s)
;  
(defconstant $kCDSpeedMin 176)
; #define kCDSpeedMin 0x00B0
(defconstant $kCDSpeedMax 65535)
; #define kCDSpeedMax 0xFFFF
; 
;  * MMC Formats
;  
;  Read Table Of Contents Format Types

(def-mactype :CDTOCFormat (find-mactype ':UInt8))

(defconstant $kCDTOCFormatTOC 2)                ;  CDTOC

(defconstant $kCDTOCFormatPMA 3)                ;  CDPMA

(defconstant $kCDTOCFormatATIP 4)               ;  CDATIP

(defconstant $kCDTOCFormatTEXT 5)               ;  CDTEXT

;  Read Table Of Contents Format 0x03
(defrecord CDPMADescriptor
   (reserved :UInt8)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8 control:4, adr:4;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (adr :UInt8)                                 ;(: 4)
                                                ;(control : 4)

; #endif /* !__LITTLE_ENDIAN__ */

   (tno :UInt8)
   (point :UInt8)
   (address :CDMSF)
   (zero :UInt8)
   (p :CDMSF)
)

;type name? (%define-record :CDPMADescriptor (find-record-descriptor ':CDPMADescriptor))
(defrecord CDPMA
   (dataLength :UInt16)
   (reserved :UInt8)
   (reserved2 :UInt8)
   (descriptors (:array :CDPMADescriptor 0))
)

;type name? (%define-record :CDPMA (find-record-descriptor ':CDPMA))
;  Read Table Of Contents Format 0x04
(defrecord CDATIP
   (dataLength :UInt16)
   (reserved (:array :UInt8 2))
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  referenceSpeed:3;
    UInt8  reserved3:1;
    UInt8  indicativeTargetWritingPower:3;
    UInt8  reserved2:1;

    UInt8  reserved5:6;
    UInt8  unrestrictedUse:1;
    UInt8  reserved4:1;

    UInt8  a3Valid:1;
    UInt8  a2Valid:1;
    UInt8  a1Valid:1;
    UInt8  discSubType:3;
    UInt8  discType:1;
    UInt8  reserved6:1;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reserved2 :UInt8)
   (indicativeTargetWritingPower :UInt8)
   (reserved3 :UInt8)
   (referenceSpeed :UInt8)
   (reserved4 :UInt8)
   (unrestrictedUse :UInt8)
   (reserved5 :UInt8)
   (reserved6 :UInt8)
   (discType :UInt8)
   (discSubType :UInt8)
   (a1Valid :UInt8)
   (a2Valid :UInt8)
   (a3Valid :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (reserved7 :UInt8)
   (startTimeOfLeadIn :CDMSF)
   (reserved8 :UInt8)
   (lastPossibleStartTimeOfLeadOut :CDMSF)
   (reserved9 :UInt8)
   (a1 (:array :UInt8 3))
   (reserved10 :UInt8)
   (a2 (:array :UInt8 3))
   (reserved11 :UInt8)
   (a3 (:array :UInt8 3))
   (reserved12 :UInt8)
)

;type name? (%define-record :CDATIP (find-record-descriptor ':CDATIP))
;  Read Table Of Contents Format 0x05
(defrecord CDTEXTDescriptor
   (packType :UInt8)
   (trackNumber :UInt8)
   (sequenceNumber :UInt8)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8 characterPosition:4;
    UInt8 blockNumber:3;
    UInt8 doubleByteCharacterCode:1;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (doubleByteCharacterCode :UInt8)
   (blockNumber :UInt8)
   (characterPosition :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (textData (:array :UInt8 12))
   (reserved (:array :UInt8 2))
)

;type name? (%define-record :CDTEXTDescriptor (find-record-descriptor ':CDTEXTDescriptor))
(defrecord CDTEXT
   (dataLength :UInt16)
   (reserved :UInt8)
   (reserved2 :UInt8)
   (descriptors (:array :CDTEXTDescriptor 0))
)

;type name? (%define-record :CDTEXT (find-record-descriptor ':CDTEXT))
;  Read Disc Information Format
(defrecord CDDiscInfo
   (dataLength :UInt16)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  discStatus:2;
    UInt8  stateOfLastSession:2;
    UInt8  erasable:1;
    UInt8  reserved:3;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reserved :UInt8)
   (erasable :UInt8)
   (stateOfLastSession :UInt8)
   (discStatus :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (numberOfFirstTrack :UInt8)
   (numberOfSessionsLSB :UInt8)
   (firstTrackNumberInLastSessionLSB :UInt8)
   (lastTrackNumberInLastSessionLSB :UInt8)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  reserved3:5;
    UInt8  unrestrictedUse:1;
    UInt8  discBarCodeValid:1;
    UInt8  discIdentificationValid:1;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (discIdentificationValid :UInt8)
   (discBarCodeValid :UInt8)
   (unrestrictedUse :UInt8)
   (reserved3 :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (discType :UInt8)
   (numberOfSessionsMSB :UInt8)
   (firstTrackNumberInLastSessionMSB :UInt8)
   (lastTrackNumberInLastSessionMSB :UInt8)
   (discIdentification :UInt32)
   (reserved7 :UInt8)
   (lastSessionLeadInStartTime :CDMSF)
   (reserved8 :UInt8)
   (lastPossibleStartTimeOfLeadOut :CDMSF)
   (discBarCode (:array :UInt8 8))
   (reserved9 :UInt8)
   (numberOfOPCTableEntries :UInt8)
   (opcTableEntries (:array :UInt8 0))
)

;type name? (%define-record :CDDiscInfo (find-record-descriptor ':CDDiscInfo))
;  Read Track Information Address Types

(def-mactype :CDTrackInfoAddressType (find-mactype ':UInt8))

(defconstant $kCDTrackInfoAddressTypeLBA 0)
(defconstant $kCDTrackInfoAddressTypeTrackNumber 1)
(defconstant $kCDTrackInfoAddressTypeSessionNumber 2);  Read Track Information Format
(defrecord CDTrackInfo
   (dataLength :UInt16)
   (trackNumberLSB :UInt8)
   (sessionNumberLSB :UInt8)
   (reserved :UInt8)
; #ifdef __LITTLE_ENDIAN__
#| #|
    UInt8  trackMode:4;
    UInt8  copy:1;
    UInt8  damage:1;
    UInt8  reserved3:2;

    UInt8  dataMode:4;
    UInt8  fixedPacket:1;
    UInt8  packet:1;
    UInt8  blank:1;
    UInt8  reservedTrack:1;

    UInt8  nextWritableAddressValid:1;
    UInt8  lastRecordedAddressValid:1;
    UInt8  reserved5:6;
|#
 |#

; #else /* !__LITTLE_ENDIAN__ */
   (reserved3 :UInt8)
   (damage :UInt8)
   (copy :UInt8)
   (trackMode :UInt8)
   (reservedTrack :UInt8)
   (blank :UInt8)
   (packet :UInt8)
   (fixedPacket :UInt8)
   (dataMode :UInt8)
   (reserved5 :UInt8)
   (lastRecordedAddressValid :UInt8)
   (nextWritableAddressValid :UInt8)

; #endif /* !__LITTLE_ENDIAN__ */

   (trackStartAddress :UInt32)
   (nextWritableAddress :UInt32)
   (freeBlocks :UInt32)
   (fixedPacketSize :UInt32)
   (trackSize :UInt32)
   (lastRecordedAddress :UInt32)
   (trackNumberMSB :UInt8)
   (sessionNumberMSB :UInt8)
   (reserved6 :UInt8)
   (reserved7 :UInt8)
)

;type name? (%define-record :CDTrackInfo (find-record-descriptor ':CDTrackInfo))
; #pragma options align=reset              /* (reset to default struct packing) */

; #endif /* _IOCDTYPES_H */


(provide-interface "IOCDTypes")