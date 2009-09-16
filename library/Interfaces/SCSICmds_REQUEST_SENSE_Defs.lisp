(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCSICmds_REQUEST_SENSE_Defs.h"
; at Sunday July 2,2006 7:31:38 pm.
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
;  This file contains all definitions for the data returned from
;  the REQUEST SENSE (0x03) command and from auto sense on protocols
;  that support it.
; #ifndef _IOKIT_SCSI_CMDS_REQUEST_SENSE_H_
; #define _IOKIT_SCSI_CMDS_REQUEST_SENSE_H_

(defconstant $kSenseDefaultSize 18)
(defrecord SCSI_Sense_Data
   (VALID_RESPONSE_CODE :UInt8)
                                                ;  7 = Valid. 6-0 = Response Code.
   (SEGMENT_NUMBER :UInt8)
                                                ;  Segment number
   (SENSE_KEY :UInt8)
                                                ;  7 = FILEMARK, 6 = EOM, 5 = ILI, 3-0 = SENSE KEY.
   (INFORMATION_1 :UInt8)
                                                ;  INFORMATION.
   (INFORMATION_2 :UInt8)
                                                ;  INFORMATION.
   (INFORMATION_3 :UInt8)
                                                ;  INFORMATION.
   (INFORMATION_4 :UInt8)
                                                ;  INFORMATION.
   (ADDITIONAL_SENSE_LENGTH :UInt8)
                                                ;  Number of additional bytes available in sense data
   (COMMAND_SPECIFIC_INFORMATION_1 :UInt8)
                                                ;  Command Specific Information
   (COMMAND_SPECIFIC_INFORMATION_2 :UInt8)
                                                ;  Command Specific Information
   (COMMAND_SPECIFIC_INFORMATION_3 :UInt8)
                                                ;  Command Specific Information
   (COMMAND_SPECIFIC_INFORMATION_4 :UInt8)
                                                ;  Command Specific Information
   (ADDITIONAL_SENSE_CODE :UInt8)
                                                ;  Additional Sense Code
   (ADDITIONAL_SENSE_CODE_QUALIFIER :UInt8)
                                                ;  Additional Sense Code Qualifier
   (FIELD_REPLACEABLE_UNIT_CODE :UInt8)
                                                ;  Field Replaceable Unit Code
   (SKSV_SENSE_KEY_SPECIFIC_MSB :UInt8)
                                                ;  7 = Sense Key Specific Valid bit, 6-0 Sense Key Specific MSB
   (SENSE_KEY_SPECIFIC_MID :UInt8)
                                                ;  Sense Key Specific Middle
   (SENSE_KEY_SPECIFIC_LSB :UInt8)
                                                ;  Sense Key Specific LSB
)

;type name? (%define-record :SCSI_Sense_Data (find-record-descriptor ':SCSI_Sense_Data))
;  Sense Valid

(defconstant $kSENSE_DATA_VALID #x80)
(defconstant $kSENSE_NOT_DATA_VALID 0)
(defconstant $kSENSE_DATA_VALID_Mask #x80)
;  Sense Response Codes

(defconstant $kSENSE_RESPONSE_CODE_Current_Errors 112)
(defconstant $kSENSE_RESPONSE_CODE_Deferred_Errors 113)
(defconstant $kSENSE_RESPONSE_CODE_Mask 127)
;  Sense FileMark Bit field definitions

(defconstant $kSENSE_FILEMARK_Set #x80)
(defconstant $kSENSE_FILEMARK_Not_Set 0)
(defconstant $kSENSE_FILEMARK_Mask #x80)
;  Sense End Of Medium (EOM) Bit field definitions

(defconstant $kSENSE_EOM_Set 64)
(defconstant $kSENSE_EOM_Not_Set 0)
(defconstant $kSENSE_EOM_Mask 64)
;  Sense Incorrect Length Indicator (ILI) Bit field definitions

(defconstant $kSENSE_ILI_Set 32)
(defconstant $kSENSE_ILI_Not_Set 0)
(defconstant $kSENSE_ILI_Mask 32)
;  Sense Key definitions

(defconstant $kSENSE_KEY_NO_SENSE 0)
(defconstant $kSENSE_KEY_RECOVERED_ERROR 1)
(defconstant $kSENSE_KEY_NOT_READY 2)
(defconstant $kSENSE_KEY_MEDIUM_ERROR 3)
(defconstant $kSENSE_KEY_HARDWARE_ERROR 4)
(defconstant $kSENSE_KEY_ILLEGAL_REQUEST 5)
(defconstant $kSENSE_KEY_UNIT_ATTENTION 6)
(defconstant $kSENSE_KEY_DATA_PROTECT 7)
(defconstant $kSENSE_KEY_BLANK_CHECK 8)
(defconstant $kSENSE_KEY_VENDOR_SPECIFIC 9)
(defconstant $kSENSE_KEY_COPY_ABORTED 10)
(defconstant $kSENSE_KEY_ABORTED_COMMAND 11)    ;  SENSE KEY 0x0C is obsoleted 

(defconstant $kSENSE_KEY_VOLUME_OVERFLOW 13)
(defconstant $kSENSE_KEY_MISCOMPARE 14)         ;  SENSE KEY 0x0F is reserved 

(defconstant $kSENSE_KEY_Mask 15)

; #endif	/* _IOKIT_SCSI_CMDS_REQUEST_SENSE_H_ */


(provide-interface "SCSICmds_REQUEST_SENSE_Defs")