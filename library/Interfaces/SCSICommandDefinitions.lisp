(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCSICommandDefinitions.h"
; at Sunday July 2,2006 7:31:38 pm.
; 
;  * Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_SCSI_COMMAND_DEFINITIONS_H_
; #define _IOKIT_SCSI_COMMAND_DEFINITIONS_H_

; #if KERNEL
#| |#

(require-interface "IOKit/IOTypes")

#|
 |#

; #else

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #pragma mark About this file
;  This file contains all the definitions for types and constants that are
;  * used by the command set classes for building CDBs.  The field type
;  * definitions are used for the parameters passed to a method that builds and
;  * sends any SCSI defined command to clearly identify the type of value
;  * expected for a parameter.
;  * The command methods will then use the appropriate mask to verify that the
;  * value passed into a parameter is of the specified type.
;  * Currently only types and masks are defined for 4 bytes and smaller fields.
;  * If a command is defined that uses a larger field, these should be expanded
;  * to include those sizes.
;  
; #pragma mark Field Type Definitions
;  These are the type definitions used for the parameters of methods that
;  * build and send Command Descriptor Blocks.
;  
;  1 Byte or smaller fields.

(def-mactype :SCSICmdField1Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField2Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField3Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField4Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField5Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField6Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField7Bit (find-mactype ':UInt8))

(def-mactype :SCSICmdField1Byte (find-mactype ':UInt8))
;  2 Bytes or smaller fields.

(def-mactype :SCSICmdField9Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField10Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField11Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField12Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField13Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField14Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField15Bit (find-mactype ':UInt16))

(def-mactype :SCSICmdField2Byte (find-mactype ':UInt16))
;  3 Bytes or smaller fields.

(def-mactype :SCSICmdField17Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField18Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField19Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField20Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField21Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField22Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField23Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField3Byte (find-mactype ':UInt32))
;  4 Bytes or smaller fields.

(def-mactype :SCSICmdField25Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField26Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField27Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField28Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField29Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField30Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField31Bit (find-mactype ':UInt32))

(def-mactype :SCSICmdField4Byte (find-mactype ':UInt32))
; #pragma mark Field Mask Definitions
;  These are masks that are used to verify that the values passed into the
;  parameters for the fields are not larger than the field size.
;  1 Byte or smaller fields.

(defconstant $kSCSICmdFieldMask1Bit 1)
(defconstant $kSCSICmdFieldMask2Bit 3)
(defconstant $kSCSICmdFieldMask3Bit 7)
(defconstant $kSCSICmdFieldMask4Bit 15)
(defconstant $kSCSICmdFieldMask5Bit 31)
(defconstant $kSCSICmdFieldMask6Bit 63)
(defconstant $kSCSICmdFieldMask7Bit 127)
(defconstant $kSCSICmdFieldMask1Byte #xFF)
;  2 Byte or smaller fields.

(defconstant $kSCSICmdFieldMask9Bit #x1FF)
(defconstant $kSCSICmdFieldMask10Bit #x3FF)
(defconstant $kSCSICmdFieldMask11Bit #x7FF)
(defconstant $kSCSICmdFieldMask12Bit #xFFF)
(defconstant $kSCSICmdFieldMask13Bit #x1FFF)
(defconstant $kSCSICmdFieldMask14Bit #x3FFF)
(defconstant $kSCSICmdFieldMask15Bit #x7FFF)
(defconstant $kSCSICmdFieldMask2Byte #xFFFF)
;  3 Byte or smaller fields.

(defconstant $kSCSICmdFieldMask17Bit #x1FFFF)
(defconstant $kSCSICmdFieldMask18Bit #x3FFFF)
(defconstant $kSCSICmdFieldMask19Bit #x7FFFF)
(defconstant $kSCSICmdFieldMask20Bit #xFFFFF)
(defconstant $kSCSICmdFieldMask21Bit #x1FFFFF)
(defconstant $kSCSICmdFieldMask22Bit #x3FFFFF)
(defconstant $kSCSICmdFieldMask23Bit #x7FFFFF)
(defconstant $kSCSICmdFieldMask3Byte #xFFFFFF)
;  4 Byte or smaller fields.

(defconstant $kSCSICmdFieldMask25Bit #x1FFFFFF)
(defconstant $kSCSICmdFieldMask26Bit #x3FFFFFF)
(defconstant $kSCSICmdFieldMask27Bit #x7FFFFFF)
(defconstant $kSCSICmdFieldMask28Bit #xFFFFFFF)
(defconstant $kSCSICmdFieldMask29Bit #x1FFFFFFF)
(defconstant $kSCSICmdFieldMask30Bit #x3FFFFFFF)
(defconstant $kSCSICmdFieldMask31Bit #x7FFFFFFF)
(defconstant $kSCSICmdFieldMask4Byte #xFFFFFFFF)

; #endif	/* _IOKIT_SCSI_COMMAND_DEFINITIONS_H_ */


(provide-interface "SCSICommandDefinitions")