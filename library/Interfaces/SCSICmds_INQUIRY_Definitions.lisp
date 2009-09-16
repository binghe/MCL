(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCSICmds_INQUIRY_Definitions.h"
; at Sunday July 2,2006 7:29:54 pm.
; 
;  * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_SCSI_CMDS_INQUIRY_H_
; #define _IOKIT_SCSI_CMDS_INQUIRY_H_
;  This file contains all the definitions for the data returned from
;  the INQUIRY (0x12) command.

; #if 0
#| ; #pragma mark -
; #pragma mark еее INQUIRY Default Page 0 Definitions еее
; #pragma mark -
 |#

; #endif

; 
;  Sizes for some of the inquiry data fields
; 

(defconstant $kINQUIRY_VENDOR_IDENTIFICATION_Length 8)
(defconstant $kINQUIRY_PRODUCT_IDENTIFICATION_Length 16)
(defconstant $kINQUIRY_PRODUCT_REVISION_LEVEL_Length 4)
;  This structure defines the format of the required standard data that is 
;  returned for the INQUIRY command.  This is the data that is required to
;  be returned from all devices.
(defrecord SCSICmd_INQUIRY_StandardData
   (PERIPHERAL_DEVICE_TYPE :UInt8)
                                                ;  7-5 = Qualifier. 4-0 = Device type.
   (RMB :UInt8)
                                                ;  7 = removable
   (VERSION :UInt8)
                                                ;  7/6 = ISO/IEC, 5-3 = ECMA, 2-0 = ANSI.
   (RESPONSE_DATA_FORMAT :UInt8)
                                                ;  7 = AERC, 6 = Obsolete, 5 = NormACA, 4 = HiSup 3-0 = Response data format.
                                                ;  If ANSI Version = 0, this is ATAPI and bits 7-4 = ATAPI version.
   (ADDITIONAL_LENGTH :UInt8)
                                                ;  Number of additional bytes available in inquiry data
   (SCCSReserved :UInt8)
                                                ;  SCC-2 device flag and reserved fields
   (flags1 :UInt8)
                                                ;  First byte of support flags
   (flags2 :UInt8)
                                                ;  Second byte of support flags (Byte 7)
   (VENDOR_IDENTIFICATION (:array :character 8))
   (PRODUCT_IDENTIFICATION (:array :character 16))
   (PRODUCT_REVISION_LEVEL (:array :character 4))
)

;type name? (%define-record :SCSICmd_INQUIRY_StandardData (find-record-descriptor ':SCSICmd_INQUIRY_StandardData))

(def-mactype :SCSICmd_INQUIRY_StandardDataPtr (find-mactype '(:pointer :SCSICmd_INQUIRY_StandardData)))
;  This structure defines the all of the fields that can be returned in
;  repsonse to the INQUIRy request for the standard data.  There is no
;  requirement as to how much of the additional data must be returned by a device.
(defrecord SCSICmd_INQUIRY_StandardDataAll
   (PERIPHERAL_DEVICE_TYPE :UInt8)
                                                ;  7-5 = Qualifier. 4-0 = Device type.
   (RMB :UInt8)
                                                ;  7 = removable
   (VERSION :UInt8)
                                                ;  7/6 = ISO/IEC, 5-3 = ECMA, 2-0 = ANSI.
   (RESPONSE_DATA_FORMAT :UInt8)
                                                ;  7 = AERC, 6 = Obsolete, 5 = NormACA, 4 = HiSup 3-0 = Response data format.
                                                ;  If ANSI Version = 0, this is ATAPI and bits 7-4 = ATAPI version.
   (ADDITIONAL_LENGTH :UInt8)
                                                ;  Number of additional bytes available in inquiry data
   (SCCSReserved :UInt8)
                                                ;  SCC-2 device flag and reserved fields
   (flags1 :UInt8)
                                                ;  First byte of support flags (Byte 6)
   (flags2 :UInt8)
                                                ;  Second byte of support flags (Byte 7)
   (VENDOR_IDENTIFICATION (:array :character 8))
   (PRODUCT_IDENTIFICATION (:array :character 16))
   (PRODUCT_REVISION_LEVEL (:array :character 4))
                                                ;  Following is the optional data that may be returned by a device.
   (VendorSpecific1 (:array :UInt8 20))
   (flags3 :UInt8)
                                                ;  Third byte of support flags, mainly SPI-3 (Byte 56)
   (Reserved1 :UInt8)
   (VERSION_DESCRIPTOR (:array :UInt16 8))
   (Reserved2 (:array :UInt8 22))
   (VendorSpecific2 (:array :UInt8 160))
)

;type name? (%define-record :SCSICmd_INQUIRY_StandardDataAll (find-record-descriptor ':SCSICmd_INQUIRY_StandardDataAll))

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 0 Definitions
; #pragma mark -
 |#

; #endif

;  Inquiry Peripheral Qualifier

(defconstant $kINQUIRY_PERIPHERAL_QUALIFIER_Connected 0)
(defconstant $kINQUIRY_PERIPHERAL_QUALIFIER_SupportedButNotConnected 32)
(defconstant $kINQUIRY_PERIPHERAL_QUALIFIER_NotSupported 96)
(defconstant $kINQUIRY_PERIPHERAL_QUALIFIER_Mask #xE0)
;  Inquiry Peripheral Device types

(defconstant $kINQUIRY_PERIPHERAL_TYPE_DirectAccessSBCDevice 0)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_SequentialAccessSSCDevice 1)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_PrinterSSCDevice 2)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_ProcessorSPCDevice 3)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_WriteOnceSBCDevice 4)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_CDROM_MMCDevice 5)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_ScannerSCSI2Device 6)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_OpticalMemorySBCDevice 7)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_MediumChangerSMCDevice 8)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_CommunicationsSSCDevice 9);  0x0A - 0x0B ASC IT8 Graphic Arts Prepress Devices 

(defconstant $kINQUIRY_PERIPHERAL_TYPE_StorageArrayControllerSCC2Device 12)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_EnclosureServicesSESDevice 13)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_SimplifiedDirectAccessRBCDevice 14)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_OpticalCardReaderOCRWDevice 15);  0x10 - 0x1E Reserved Device Types 

(defconstant $kINQUIRY_PERIPHERAL_TYPE_UnknownOrNoDeviceType 31)
(defconstant $kINQUIRY_PERIPHERAL_TYPE_Mask 31)

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 1 Definitions
; #pragma mark -
 |#

; #endif

;  Inquiry Removable Bit field definitions

(defconstant $kINQUIRY_PERIPHERAL_RMB_MediumFixed 0)
(defconstant $kINQUIRY_PERIPHERAL_RMB_MediumRemovable #x80)
(defconstant $kINQUIRY_PERIPHERAL_RMB_BitMask #x80)

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 2 Definitions
; #pragma mark -
 |#

; #endif

;  Inquiry ISO/IEC Version field definitions

(defconstant $kINQUIRY_ISO_IEC_VERSION_Mask #xC0)
;  Inquiry ECMA Version field definitions

(defconstant $kINQUIRY_ECMA_VERSION_Mask 56)
;  Inquiry ANSI Version field definitions

(defconstant $kINQUIRY_ANSI_VERSION_NoClaimedConformance 0)
(defconstant $kINQUIRY_ANSI_VERSION_SCSI_1_Compliant 1)
(defconstant $kINQUIRY_ANSI_VERSION_SCSI_2_Compliant 2)
(defconstant $kINQUIRY_ANSI_VERSION_SCSI_SPC_Compliant 3)
(defconstant $kINQUIRY_ANSI_VERSION_SCSI_SPC_2_Compliant 4)
(defconstant $kINQUIRY_ANSI_VERSION_Mask 7)

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 3 Definitions
; #pragma mark -
 |#

; #endif

;  Bit definitions
;  Bits 0-3: RESPONSE DATA FORMAT

(defconstant $kINQUIRY_Byte3_HISUP_Bit 4)
(defconstant $kINQUIRY_Byte3_NORMACA_Bit 5)     ;  Bit 6 is Obsolete

(defconstant $kINQUIRY_Byte3_AERC_Bit 7)        ;  Masks

(defconstant $kINQUIRY_RESPONSE_DATA_FORMAT_Mask 15);  Bits 0-3

(defconstant $kINQUIRY_Byte3_HISUP_Mask 16)
(defconstant $kINQUIRY_Byte3_NORMACA_Mask 32)   ;  Bit 6 is Obsolete

(defconstant $kINQUIRY_Byte3_AERC_Mask #x80)

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 6 Definitions
; #pragma mark -
 |#

; #endif

;  Inquiry Byte 6 features (flags1 field)
;  Byte offset

(defconstant $kINQUIRY_Byte6_Offset 6)          ;  Bit definitions

(defconstant $kINQUIRY_Byte6_ADDR16_Bit 0)      ;  SPI Specific
;  Bit 1 is Obsolete
;  Bit 2 is Obsolete

(defconstant $kINQUIRY_Byte6_MCHNGR_Bit 3)
(defconstant $kINQUIRY_Byte6_MULTIP_Bit 4)
(defconstant $kINQUIRY_Byte6_VS_Bit 5)
(defconstant $kINQUIRY_Byte6_ENCSERV_Bit 6)
(defconstant $kINQUIRY_Byte6_BQUE_Bit 7)        ;  Masks

(defconstant $kINQUIRY_Byte6_ADDR16_Mask 1)     ;  SPI Specific
;  Bit 1 is Obsolete
;  Bit 2 is Obsolete

(defconstant $kINQUIRY_Byte6_MCHNGR_Mask 8)
(defconstant $kINQUIRY_Byte6_MULTIP_Mask 16)
(defconstant $kINQUIRY_Byte6_VS_Mask 32)
(defconstant $kINQUIRY_Byte6_ENCSERV_Mask 64)
(defconstant $kINQUIRY_Byte6_BQUE_Mask #x80)

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 7 Definitions
; #pragma mark -
 |#

; #endif

;  Inquiry Byte 7 features (flags2 field)
;  Byte offset

(defconstant $kINQUIRY_Byte7_Offset 7)          ;  Bit definitions

(defconstant $kINQUIRY_Byte7_VS_Bit 0)
(defconstant $kINQUIRY_Byte7_CMDQUE_Bit 1)
(defconstant $kINQUIRY_Byte7_TRANDIS_Bit 2)     ;  SPI Specific

(defconstant $kINQUIRY_Byte7_LINKED_Bit 3)
(defconstant $kINQUIRY_Byte7_SYNC_Bit 4)        ;  SPI Specific

(defconstant $kINQUIRY_Byte7_WBUS16_Bit 5)      ;  SPI Specific
;  Bit 6 is Obsolete

(defconstant $kINQUIRY_Byte7_RELADR_Bit 7)      ;  Masks

(defconstant $kINQUIRY_Byte7_VS_Mask 1)
(defconstant $kINQUIRY_Byte7_CMDQUE_Mask 2)
(defconstant $kINQUIRY_Byte7_TRANDIS_Mask 4)    ;  SPI Specific

(defconstant $kINQUIRY_Byte7_LINKED_Mask 8)
(defconstant $kINQUIRY_Byte7_SYNC_Mask 16)      ;  SPI Specific

(defconstant $kINQUIRY_Byte7_WBUS16_Mask 32)    ;  SPI Specific
;  Bit 6 is Obsolete

(defconstant $kINQUIRY_Byte7_RELADR_Mask #x80)

; #if 0
#| ; #pragma mark -
; #pragma mark е INQUIRY Byte 56 Definitions
; #pragma mark -
 |#

; #endif

;  Inquiry Byte 56 features (for devices that report an ANSI VERSION of
;  kINQUIRY_ANSI_VERSION_SCSI_SPC_Compliant or later)
;  These are SPI-3 Specific
;  Byte offset

(defconstant $kINQUIRY_Byte56_Offset 56)        ;  Bit definitions

(defconstant $kINQUIRY_Byte56_IUS_Bit 0)
(defconstant $kINQUIRY_Byte56_QAS_Bit 1)        ;  Bits 2 and 3 are the CLOCKING bits
;  All other bits are reserved

(defconstant $kINQUIRY_Byte56_IUS_Mask 1)
(defconstant $kINQUIRY_Byte56_QAS_Mask 2)
(defconstant $kINQUIRY_Byte56_CLOCKING_Mask 12) ;  Definitions for the CLOCKING bits

(defconstant $kINQUIRY_Byte56_CLOCKING_ONLY_ST 0)
(defconstant $kINQUIRY_Byte56_CLOCKING_ONLY_DT 4);  kINQUIRY_Byte56_CLOCKING_RESERVED	= 0x08,

(defconstant $kINQUIRY_Byte56_CLOCKING_ST_AND_DT 12)
;  IORegistry property names for information derived from the Inquiry data.
;  The Peripheral Device Type is the only property that the 
;  generic Logical Unit Drivers will use to match.
(defconstant $kIOPropertySCSIPeripheralDeviceType "Peripheral Device Type")
; #define kIOPropertySCSIPeripheralDeviceType		"Peripheral Device Type"
;  The bit size of the property
(defconstant $kIOPropertySCSIPeripheralDeviceTypeSize 8)
; #define kIOPropertySCSIPeripheralDeviceTypeSize	8
;  These properties are listed in order of matching priority.
(defconstant $kIOPropertySCSIVendorIdentification "Vendor Identification")
; #define kIOPropertySCSIVendorIdentification		"Vendor Identification"
(defconstant $kIOPropertySCSIProductIdentification "Product Identification")
; #define kIOPropertySCSIProductIdentification	"Product Identification"
(defconstant $kIOPropertySCSIProductRevisionLevel "Product Revision Level")
; #define kIOPropertySCSIProductRevisionLevel		"Product Revision Level"

; #if 0
#| ; #pragma mark -
; #pragma mark еее INQUIRY Supported Vital Products Page 00 Definitions еее
; #pragma mark -
 |#

; #endif

;  This section contians all structures and definitions used by the INQUIRY
;  command in response to a request for page 83h - Device Identification Page 
(defrecord SCSICmd_INQUIRY_Page00_Header
   (PERIPHERAL_DEVICE_TYPE :UInt8)
                                                ;  7-5 = Qualifier. 4-0 = Device type.
   (PAGE_CODE :UInt8)
                                                ;  Must be equal to 00h
   (RESERVED :UInt8)
                                                ;  reserved field
   (PAGE_LENGTH :UInt8)
                                                ;  n-3 bytes
)

;type name? (%define-record :SCSICmd_INQUIRY_Page00_Header (find-record-descriptor ':SCSICmd_INQUIRY_Page00_Header))

; #if 0
#| ; #pragma mark -
; #pragma mark еее INQUIRY Device ID Page 83 Definitions еее
; #pragma mark -
 |#

; #endif

;  This section contians all structures and definitions used by the INQUIRY
;  command in response to a request for page 83h - Device Identification Page 

(defconstant $kINQUIRY_Page83_PageCode #x83)
(defrecord SCSICmd_INQUIRY_Page83_Header
   (PERIPHERAL_DEVICE_TYPE :UInt8)
                                                ;  7-5 = Qualifier. 4-0 = Device type.
   (PAGE_CODE :UInt8)
                                                ;  Must be equal to 83h
   (RESERVED :UInt8)
                                                ;  reserved field
   (PAGE_LENGTH :UInt8)
                                                ;  n-3 bytes
)

;type name? (%define-record :SCSICmd_INQUIRY_Page83_Header (find-record-descriptor ':SCSICmd_INQUIRY_Page83_Header))
(defrecord SCSICmd_INQUIRY_Page83_Identification_Descriptor
   (CODE_SET :UInt8)
   (IDENTIFIER_TYPE :UInt8)
   (RESERVED :UInt8)
   (IDENTIFIER_LENGTH :UInt8)
   (IDENTIFIER :UInt8)
)

;type name? (%define-record :SCSICmd_INQUIRY_Page83_Identification_Descriptor (find-record-descriptor ':SCSICmd_INQUIRY_Page83_Identification_Descriptor))
;  Definitions for the Code Set field

(defconstant $kINQUIRY_Page83_CodeSetReserved 0)
(defconstant $kINQUIRY_Page83_CodeSetBinaryData 1)
(defconstant $kINQUIRY_Page83_CodeSetASCIIData 2);  0x3 - 0xF

(defconstant $kINQUIRY_Page83_CodeSetMask 15)
;  Definitions for the Association field

(defconstant $kINQUIRY_Page83_AssociationDevice 0)
(defconstant $kINQUIRY_Page83_AssociationPort 16);  0x20 - 0x30

(defconstant $kINQUIRY_Page83_AssociationMask 48)
;  Definitions for the Identifier type field

(defconstant $kINQUIRY_Page83_IdentifierTypeUndefined 0)
(defconstant $kINQUIRY_Page83_IdentifierTypeVendorID 1)
(defconstant $kINQUIRY_Page83_IdentifierTypeIEEE_EUI64 2)
(defconstant $kINQUIRY_Page83_IdentifierTypeFCNameIdentifier 3)
(defconstant $kINQUIRY_Page83_IdentifierTypeRelativePortIdentifier 4);  0x5 - 0xF

(defconstant $kINQUIRY_Page83_IdentifierTypeMask 15)
(defconstant $kIOPropertySCSIINQUIRYDeviceIdentification "INQUIRY Device Identification")
; #define kIOPropertySCSIINQUIRYDeviceIdentification		"INQUIRY Device Identification"
(defconstant $kIOPropertySCSIINQUIRYDeviceIdCodeSet "Code Set")
; #define kIOPropertySCSIINQUIRYDeviceIdCodeSet			"Code Set"
(defconstant $kIOPropertySCSIINQUIRYDeviceIdType "Identifier Type")
; #define kIOPropertySCSIINQUIRYDeviceIdType				"Identifier Type"
(defconstant $kIOPropertySCSIINQUIRYDeviceIdAssociation "Association")
; #define kIOPropertySCSIINQUIRYDeviceIdAssociation		"Association"
(defconstant $kIOPropertySCSIINQUIRYDeviceIdentifier "Identifier")
; #define kIOPropertySCSIINQUIRYDeviceIdentifier			"Identifier"

; #endif	/* _IOKIT_SCSI_CMDS_INQUIRY_H_ */


(provide-interface "SCSICmds_INQUIRY_Definitions")