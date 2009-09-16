(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCSICommandOperationCodes.h"
; at Sunday July 2,2006 7:31:39 pm.
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
; #ifndef _SCSI_COMMAND_OPERATION_CODES_H
; #define _SCSI_COMMAND_OPERATION_CODES_H
; #pragma mark About this file
;  This file contains the operation code definitions for all commands defined
;  * by the SCSI specifications.  The commands are listed in three formats:
;  * 1) All commands are listed in alphabetical order.  This list is the live
;  * enumeration for all of the command constants.
;  * 2) The commands are listed in ascending numerical order.
;  * 3) The commands are grouped by Peripheral Device Type.
;  * 
;  * In the command listings by Peripheral Device Type, there will be a comment
;  * following each command.  This comment indentifies the section of the related
;  * specification where the commands is defined and the requirement type of the
;  * command, Mandatory or Optional.
;  * If a specification redefines an optional command from SPC as mandatory,
;  * the command will be relisted in the Peripheral Device Type command list with
;  * the mandatory tag next to it.
;  * All commands that are listed in SPC as Device Type Specifc will be relisted
;  * as a comment in all specifications lists that support that command with the
;  * appropriate Mandatory or Optional tag for that specification.
;  *
;  * The section number and the requirement type of the command are based on the 
;  * version of the specification listed in the header comment for the Peripheral
;  * Device Type.  This data is provided for informational purposes only.  The 
;  * specification document and version that the device adheres to as indicated 
;  * by the data returned in response to the INQUIRY command should be used as
;  * the authorative source for supported and required behavior of the device.
;  * 
;  * The SPC set is listed before all other Peripheral Device Type commands as
;  * this is the base document from which all of the other documents are derived.  
;  *
;  * The Peripheral Device Types and associated command sets as defined by SPC-2,
;  * section 7.4.1 are as follows:
;  *  Peripheral Device Type                  Associated Command Specification
;  *  ------------------------------------    -----------------------------------
;  *  0x00 Direct Access Device               SBC - SCSI-3 Block Commands
;  *  0x01 Sequential Access Device           SSC - SCSI-3 Stream Commands
;  *  0x02 Printer Device                     SSC - SCSI-3 Stream Commands
;  *  0x03 Processor Device                   SPC - SCSI Primary Commands-2
;  *  0x04 Write Once Device                  SBC - SCSI-3 Block Commands
;  *  0x05 CD-ROM Device                      MMC - SCSI Multimedia Commands-2
;  *  0x06 Scanner Device                     SGC - SCSI-3 Graphics Commands
;  *  0x07 Optical Memory Device              SBC - SCSI-3 Block Commands
;  *  0x08 Medium Changer Device              SMC - SCSI-3 Medium Changer Cmds
;  *  0x09 Communications Device              SSC - SCSI-3 Stream Commands
;  *  0x0A - 0x0B Graphic Arts Prepress Dev   ASC IT8
;  *  0x0C Storage Array Controller Device    SCC-2 - SCSI Controller Commands-2
;  *  0x0D Enclosure Services                 SES - SCSI-3 Enclosure Services
;  *  0x0E Simplified Direct Access Device    RBC - SCSI Reduced Block Commands
;  *  0x0F Optical Card Reader/Writer Device  OCRW - SCSI Specification for 
;  *                                              Optical Card Reader/Writer
;  *  0x10 Reserved                    		No command specification
;  *	0x11 Object-Based Storage Device		OSD - SCSI Object Based Storage 
;  *												Device Commands
;  *  0x12 - 0x14 Reserved                    No command specification
;  *  0x15 Multimedia Media Access Engine     RMC - Reduced Multimedia Commands
;  *  0x16 - 0x1E Reserved                    No command specification
;  *  0x1F Unknown or No Device               No command specification
;  
; #pragma mark -
; #pragma mark Command Definitions by Name
;  All SCSI Commands listed in alphabetical order.  These are the live
;  * definitions of the commands.  All other command lists are informative.
;  

(defconstant $kSCSICmd_BLANK #xA1)
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)
(defconstant $kSCSICmd_CLOSE_TRACK_SESSION 91)
(defconstant $kSCSICmd_COMPARE 57)
(defconstant $kSCSICmd_COPY 24)
(defconstant $kSCSICmd_COPY_AND_VERIFY 58)
(defconstant $kSCSICmd_ERASE_10 44)
(defconstant $kSCSICmd_ERASE_12 #xAC)
(defconstant $kSCSICmd_EXTENDED_COPY #x83)
(defconstant $kSCSICmd_FORMAT_UNIT 4)
(defconstant $kSCSICmd_GET_CONFIGURATION 70)
(defconstant $kSCSICmd_GET_EVENT_STATUS_NOTIFICATION 74)
(defconstant $kSCSICmd_GET_PERFORMANCE #xAC)
(defconstant $kSCSICmd_INQUIRY 18)
(defconstant $kSCSICmd_LOAD_UNLOAD_MEDIUM #xA6)
(defconstant $kSCSICmd_LOCK_UNLOCK_CACHE 54)
(defconstant $kSCSICmd_LOG_SELECT 76)
(defconstant $kSCSICmd_LOG_SENSE 77)
(defconstant $kSCSICmd_MECHANISM_STATUS #xBD)
(defconstant $kSCSICmd_MEDIUM_SCAN 56)
(defconstant $kSCSICmd_MODE_SELECT_6 21)
(defconstant $kSCSICmd_MODE_SELECT_10 85)
(defconstant $kSCSICmd_MODE_SENSE_6 26)
(defconstant $kSCSICmd_MODE_SENSE_10 90)
(defconstant $kSCSICmd_MOVE_MEDIUM_ATTACHED #xA7)
(defconstant $kSCSICmd_PAUSE_RESUME 75)
(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94)
(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95)
(defconstant $kSCSICmd_PLAY_AUDIO_10 69)
(defconstant $kSCSICmd_PLAY_AUDIO_12 #xA5)
(defconstant $kSCSICmd_PLAY_AUDIO_MSF 71)
(defconstant $kSCSICmd_PLAY_AUDIO_TRACK_INDEX 72)
(defconstant $kSCSICmd_PLAY_CD #xBC)
(defconstant $kSCSICmd_PLAY_RELATIVE_10 73)
(defconstant $kSCSICmd_PLAY_RELATIVE_12 #xA9)
(defconstant $kSCSICmd_PREFETCH 52)
(defconstant $kSCSICmd_PREVENT_ALLOW_MEDIUM_REMOVAL 30)
(defconstant $kSCSICmd_READ_6 8)
(defconstant $kSCSICmd_READ_10 40)
(defconstant $kSCSICmd_READ_12 #xA8)
(defconstant $kSCSICmd_READ_BUFFER 60)
(defconstant $kSCSICmd_READ_BUFFER_CAPACITY 92)
(defconstant $kSCSICmd_READ_CAPACITY 37)
(defconstant $kSCSICmd_READ_CD #xBE)
(defconstant $kSCSICmd_READ_CD_MSF #xB9)
(defconstant $kSCSICmd_READ_DEFECT_DATA_10 55)
(defconstant $kSCSICmd_READ_DEFECT_DATA_12 #xB7)
(defconstant $kSCSICmd_READ_DISC_INFORMATION 81)
(defconstant $kSCSICmd_READ_DVD_STRUCTURE #xAD)
(defconstant $kSCSICmd_READ_ELEMENT_STATUS_ATTACHED #xB4)
(defconstant $kSCSICmd_READ_FORMAT_CAPACITIES 35)
(defconstant $kSCSICmd_READ_GENERATION 41)
(defconstant $kSCSICmd_READ_HEADER 68)
(defconstant $kSCSICmd_READ_LONG 62)
(defconstant $kSCSICmd_READ_MASTER_CUE 89)
(defconstant $kSCSICmd_READ_SUB_CHANNEL 66)
(defconstant $kSCSICmd_READ_TOC_PMA_ATIP 67)
(defconstant $kSCSICmd_READ_TRACK_INFORMATION 82)
(defconstant $kSCSICmd_READ_UPDATED_BLOCK_10 45)
(defconstant $kSCSICmd_REASSIGN_BLOCKS 7)
(defconstant $kSCSICmd_REBUILD #x81)
(defconstant $kSCSICmd_RECEIVE 8)
(defconstant $kSCSICmd_RECEIVE_COPY_RESULTS #x84)
(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28)
(defconstant $kSCSICmd_REGENERATE #x82)
(defconstant $kSCSICmd_RELEASE_6 23)
(defconstant $kSCSICmd_RELEASE_10 87)
(defconstant $kSCSICmd_REPAIR_TRACK 88)
(defconstant $kSCSICmd_REPORT_DEVICE_IDENTIFIER #xA3)
(defconstant $kSCSICmd_REPORT_KEY #xA4)
(defconstant $kSCSICmd_REPORT_LUNS #xA0)
(defconstant $kSCSICmd_REQUEST_SENSE 3)
(defconstant $kSCSICmd_RESERVE_6 22)
(defconstant $kSCSICmd_RESERVE_10 86)
(defconstant $kSCSICmd_RESERVE_TRACK 83)
(defconstant $kSCSICmd_REZERO_UNIT 1)
(defconstant $kSCSICmd_SCAN_MMC #xBA)
(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_10 49)
(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_12 #xB1)
(defconstant $kSCSICmd_SEARCH_DATA_HIGH_10 48)
(defconstant $kSCSICmd_SEARCH_DATA_HIGH_12 #xB0)
(defconstant $kSCSICmd_SEARCH_DATA_LOW_10 50)
(defconstant $kSCSICmd_SEARCH_DATA_LOW_12 #xB2)
(defconstant $kSCSICmd_SEEK_6 11)
(defconstant $kSCSICmd_SEEK_10 43)
(defconstant $kSCSICmd_SEND 10)
(defconstant $kSCSICmd_SEND_CUE_SHEET 93)
(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)
(defconstant $kSCSICmd_SEND_DVD_STRUCTURE #xBF)
(defconstant $kSCSICmd_SEND_EVENT #xA2)
(defconstant $kSCSICmd_SEND_KEY #xA3)
(defconstant $kSCSICmd_SEND_OPC_INFORMATION 84)
(defconstant $kSCSICmd_SET_CD_SPEED #xBB)
(defconstant $kSCSICmd_SET_DEVICE_IDENTIFIER #xA4)
(defconstant $kSCSICmd_SET_LIMITS_10 51)
(defconstant $kSCSICmd_SET_LIMITS_12 #xB3)
(defconstant $kSCSICmd_SET_READ_AHEAD #xA7)
(defconstant $kSCSICmd_SET_STREAMING #xB6)
(defconstant $kSCSICmd_START_STOP_UNIT 27)
(defconstant $kSCSICmd_STOP_PLAY_SCAN 78)
(defconstant $kSCSICmd_SYNCHRONIZE_CACHE 53)
(defconstant $kSCSICmd_TEST_UNIT_READY 0)
(defconstant $kSCSICmd_UPDATE_BLOCK 61)
(defconstant $kSCSICmd_VERIFY_10 47)
(defconstant $kSCSICmd_VERIFY_12 #xAF)
(defconstant $kSCSICmd_WRITE_6 10)
(defconstant $kSCSICmd_WRITE_10 42)
(defconstant $kSCSICmd_WRITE_12 #xAA)
(defconstant $kSCSICmd_WRITE_AND_VERIFY_10 46)
(defconstant $kSCSICmd_WRITE_AND_VERIFY_12 #xAE)
(defconstant $kSCSICmd_WRITE_BUFFER 59)
(defconstant $kSCSICmd_WRITE_LONG 63)
(defconstant $kSCSICmd_WRITE_SAME 65)
(defconstant $kSCSICmd_XDREAD 82)
(defconstant $kSCSICmd_XDWRITE 80)
(defconstant $kSCSICmd_XDWRITE_EXTENDED #x80)
(defconstant $kSCSICmd_XPWRITE 81)
; #pragma mark -
; #pragma mark Command Definitions by Number

; #if 0
#| 
 |#

; #endif

; #pragma mark -
; #pragma mark All Types SPC Commands
;  Commands defined by the T10:1236-D SCSI Primary Commands-2 (SPC-2) 
;  * command specification.  The definitions and section numbers are based on
;  * section 7 of the revision 18, 21 May 2000 version of the specification.
;  *
;  * These commands are defined for all devices.
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  Obsolete 

(defconstant $kSCSICmd_COMPARE 57)              ;  Sec. 7.2: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  Sec. 7.3: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  Sec. 7.4: Optional 

(defconstant $kSCSICmd_EXTENDED_COPY #x83)      ;  Sec. 7.5: Optional 

(defconstant $kSCSICmd_INQUIRY 18)              ;  Sec. 7.6: Mandatory 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  Sec. 7.7: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  Sec. 7.8: Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)
;  Sec. 7.9: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_MODE_SELECT_10 85)
;  Sec. 7.10: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_MODE_SENSE_6 26)
;  Sec. 7.11: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_MODE_SENSE_10 90)
;  Sec. 7.12: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_MOVE_MEDIUM_ATTACHED #xA7);  Defined in SMC 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94)
;  Sec. 7.13: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95)
;  Sec. 7.14: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_PREVENT_ALLOW_MEDIUM_REMOVAL 30)
;  Sec. 7.15: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  Sec. 7.16: Optional 

(defconstant $kSCSICmd_READ_ELEMENT_STATUS_ATTACHED #xB4);  Defined in SMC 

(defconstant $kSCSICmd_RECEIVE_COPY_RESULTS #x84);  Sec. 7.17: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  Sec. 7.18: Optional 

(defconstant $kSCSICmd_RELEASE_10 87)
;  Sec. 7.19: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_RELEASE_6 23)
;  Sec. 7.20: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_REPORT_DEVICE_IDENTIFIER #xA3);  Sec. 7.21: Optional 

(defconstant $kSCSICmd_REPORT_LUNS #xA0)
;  Sec. 7.22: Mandatory for
;                                                      * LUN Supporting devices

(defconstant $kSCSICmd_REQUEST_SENSE 3)
;  Sec. 7.23: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_RESERVE_10 86)
;  Sec. 7.24: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_RESERVE_6 22)
;  Sec. 7.25: Device Type
;                                                      * Specific 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  Sec. 7.26: Optional 

(defconstant $kSCSICmd_SET_DEVICE_IDENTIFIER #xA4);  Sec. 7.27: Optional 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  Sec. 7.28: Mandatory 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  Sec. 7.29: Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x00 SBC Direct Access Commands
;  Commands defined by the T10:990-D SCSI-3 Block Commands (SBC) command
;  * specification.  The definitions and section numbers are based on section 6.1
;  * of the revision 8c, 13 November 1997 version of the specification. 
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  Obsolete 

(defconstant $kSCSICmd_COMPARE 57)              ;  SPC: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  SPC: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  SPC: Optional

(defconstant $kSCSICmd_FORMAT_UNIT 4)           ;  Sec. 6.1.1: Mandatory 

(defconstant $kSCSICmd_INQUIRY 18)              ;  SPC: Mandatory 

(defconstant $kSCSICmd_LOCK_UNLOCK_CACHE 54)    ;  Sec. 6.1.2: Optional 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  SPC: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  SPC: Optional 

(defconstant $kSCSICmd_MOVE_MEDIUM_ATTACHED #xA7);  SMC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  SPC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  SPC: Optional 

(defconstant $kSCSICmd_PREFETCH 52)             ;  Sec. 6.1.3: Optional 

(defconstant $kSCSICmd_PREVENT_ALLOW_MEDIUM_REMOVAL 30);  SPC: Optional 

(defconstant $kSCSICmd_READ_6 8)                ;  Sec. 6.1.4: Mandatory 

(defconstant $kSCSICmd_READ_10 40)              ;  Sec. 6.1.5: Mandatory 

(defconstant $kSCSICmd_READ_12 #xA8)            ;  Sec. 6.2.4: Optional 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  SPC: Optional 

(defconstant $kSCSICmd_READ_CAPACITY 37)        ;  Sec. 6.1.6: Mandatory 

(defconstant $kSCSICmd_READ_DEFECT_DATA_10 55)  ;  Sec. 6.1.7: Optional 

(defconstant $kSCSICmd_READ_DEFECT_DATA_12 #xB7);  Sec. 6.2.5: Optional 

(defconstant $kSCSICmd_READ_ELEMENT_STATUS_ATTACHED #xB4);  SMC: Optional 

(defconstant $kSCSICmd_READ_GENERATION 41)      ;  Sec. 6.2.6: Optional 

(defconstant $kSCSICmd_READ_LONG 62)            ;  Sec. 6.1.8: Optional 

(defconstant $kSCSICmd_READ_UPDATED_BLOCK_10 45);  Sec. 6.2.7: Optional 

(defconstant $kSCSICmd_REASSIGN_BLOCKS 7)       ;  Sec. 6.1.9: Optional 

(defconstant $kSCSICmd_REBUILD #x81)            ;  Sec. 6.1.10: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  SPC: Optional 

(defconstant $kSCSICmd_REGENERATE #x82)         ;  Sec. 6.1.11: Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  SPC: Optional 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REPORT_LUNS #xA0)        ;  SPC: Optional 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  SPC: Optional 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REZERO_UNIT 1)           ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_10 49) ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_HIGH_10 48)  ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_LOW_10 50)   ;  Obsolete 

(defconstant $kSCSICmd_SEEK_6 11)               ;  Obsolete 

(defconstant $kSCSICmd_SEEK_10 43)              ;  Sec. 6.1.12: Optional 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  SPC: Mandatory 

(defconstant $kSCSICmd_SET_LIMITS_10 51)        ;  Sec. 6.1.13: Optional 

(defconstant $kSCSICmd_SET_LIMITS_12 #xB3)      ;  Sec. 6.2.8: Optional 

(defconstant $kSCSICmd_START_STOP_UNIT 27)      ;  Sec. 6.1.14: Optional 

(defconstant $kSCSICmd_SYNCHRONIZE_CACHE 53)    ;  Sec. 6.1.15: Optional 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  SPC: Mandatory 

(defconstant $kSCSICmd_UPDATE_BLOCK 61)         ;  Sec. 6.2.9: Optional 

(defconstant $kSCSICmd_VERIFY_10 47)            ;  Sec. 6.1.16: Optional 

(defconstant $kSCSICmd_WRITE_6 10)              ;  Sec. 6.1.17: Optional 

(defconstant $kSCSICmd_WRITE_10 42)             ;  Sec. 6.1.18: Optional 

(defconstant $kSCSICmd_WRITE_12 #xAA)           ;  Sec. 6.2.13: Optional 

(defconstant $kSCSICmd_WRITE_AND_VERIFY_10 46)  ;  Sec. 6.1.19: Optional 

(defconstant $kSCSICmd_WRITE_AND_VERIFY_12 #xAE);  Sec. 6.2.15: Optional 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  SPC: Optional 

(defconstant $kSCSICmd_WRITE_LONG 63)           ;  Sec. 6.1.20: Optional 

(defconstant $kSCSICmd_WRITE_SAME 65)           ;  Sec. 6.1.21: Optional 

(defconstant $kSCSICmd_XDREAD 82)               ;  Sec. 6.1.22: Optional 

(defconstant $kSCSICmd_XDWRITE 80)              ;  Sec. 6.1.23: Optional 

(defconstant $kSCSICmd_XDWRITE_EXTENDED #x80)   ;  Sec. 6.1.24: Optional 

(defconstant $kSCSICmd_XPWRITE 81)              ;  Sec. 6.1.25: Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x01 SSC Sequential Access Commands
;  Commands defined by the T10:997-D SCSI-3 Stream Commands (SSC) command
;  * specification.  The definitions and section numbers are based on section 5
;  * of the revision 22, January 1, 2000 version of the specification. 
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  Obsolete 

(defconstant $kSCSICmd_COMPARE 57)              ;  SPC: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  SPC: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  SPC: Optional 

(defconstant $kSCSICmd_ERASE 25)                ;  Sec. 5.3.1: Mandatory 

(defconstant $kSCSICmd_FORMAT_MEDIUM 4)         ;  Sec. 5.3.2: Optional 

(defconstant $kSCSICmd_INQUIRY 18)              ;  SPC: Mandatory 

(defconstant $kSCSICmd_LOAD_UNLOAD 27)          ;  Sec. 5.3.3: Optional 

(defconstant $kSCSICmd_LOCATE 43)               ;  Sec. 5.3.4: Optional 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  SPC: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  SPC: Optional 

(defconstant $kSCSICmd_MOVE_MEDIUM #xA5)        ;  SMC: Optional 

(defconstant $kSCSICmd_MOVE_MEDIUM_ATTACHED #xA7);  SMC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  SPC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  SPC: Optional 

(defconstant $kSCSICmd_PREVENT_ALLOW_MEDIUM_REMOVAL 30);  SPC: Optional 

(defconstant $kSCSICmd_READ_6 8)                ;  Sec. 5.3.5: Mandatory 

(defconstant $kSCSICmd_READ_BLOCK_LIMITS 5)     ;  Sec. 5.3.6: Mandatory 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  SPC: Optional 

(defconstant $kSCSICmd_READ_ELEMENT_STATUS #xB8);  SMC: Optional 

(defconstant $kSCSICmd_READ_ELEMENT_STATUS_ATTACHED #xB4);  SMC: Optional 

(defconstant $kSCSICmd_READ_POSITION 52)        ;  Sec. 5.3.7: Mandatory 

(defconstant $kSCSICmd_READ_REVERSE 15)         ;  Sec. 5.3.8: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  SPC: Optional 

(defconstant $kSCSICmd_RECOVER_BUFFERED_DATA 20);  Sec. 5.3.9: Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  SPC: Mandatory 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REPORT_DENSITY_SUPPORT 68);  Sec. 5.3.10: Mandatory

(defconstant $kSCSICmd_REPORT_LUNS #xA0)        ;  SPC: Mandatory 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REWIND 1)                ;  Sec. 5.3.11: Mandatory

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  SPC: Mandatory 

(defconstant $kSCSICmd_SPACE 17)                ;  Sec. 5.3.12: Mandatory

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  SPC: Mandatory 

(defconstant $kSCSICmd_VERIFY_6 19)             ;  Sec. 5.3.13: Optional 

(defconstant $kSCSICmd_WRITE_6 10)              ;  Sec. 5.3.14: Mandatory

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  SPC: Optional 

(defconstant $kSCSICmd_WRITE_FILEMARKS 16)      ;  Sec. 5.3.15: Mandatory

 |#

; #endif

; #pragma mark -
; #pragma mark 0x02 SSC Printer Commands
;  Commands defined by the T10:997-D SCSI-3 Stream Commands (SSC) command
;  * specification.  The definitions and section numbers are based on section 6
;  * of the revision 22, January 1, 2000 version of the specification. 
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  Obsolete 

(defconstant $kSCSICmd_COMPARE 57)              ;  SPC: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  SPC: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  SPC: Optional 

(defconstant $kSCSICmd_FORMAT 4)                ;  Sec. 6.2.1: Optional 

(defconstant $kSCSICmd_INQUIRY 18)              ;  SPC: Mandatory 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  SPC: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  SPC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  SPC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  SPC: Optional 

(defconstant $kSCSICmd_PRINT 10)                ;  Sec. 6.2.2: Mandatory 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  SPC: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  SPC: Optional 

(defconstant $kSCSICmd_RECOVER_BUFFERED_DATA 20);  Sec. 6.2.3: Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  SPC: Mandatory 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REPORT_LUNS #xA0)        ;  SPC: Mandatory 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  SPC: Mandatory 

(defconstant $kSCSICmd_SLEW_AND_PRINT 11)       ;  Sec. 6.2.4: Optional 

(defconstant $kSCSICmd_STOP_PRINT 27)           ;  Sec. 6.2.5: Optional 

(defconstant $kSCSICmd_SYNCHRONIZE_BUFFER 16)   ;  Sec. 6.2.6: Optional 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  SPC: Mandatory 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  SPC: Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x03 SPC Processor Commands
;  Commands defined by the T10:1236-D SCSI Primary Commands-2 (SPC-2) 
;  * command specification.  The definitions and section numbers are based on
;  * section 9 of the revision 18, 21 May 2000 version of the specification.
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  Obsolete 

(defconstant $kSCSICmd_COMPARE 57)              ;  Sec. 7.2: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  Sec. 7.3: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  Sec. 7.4: Optional 

(defconstant $kSCSICmd_EXTENDED_COPY #x83)      ;  Sec. 7.5: Optional 

(defconstant $kSCSICmd_INQUIRY 18)              ;  Sec. 7.6: Mandatory 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  Sec. 7.7: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  Sec. 7.8: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  Sec. 7.13: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  Sec. 7.14: Optional 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  Sec. 7.16: Optional 

(defconstant $kSCSICmd_RECEIVE 8)               ;  Sec. 9.2: Optional 

(defconstant $kSCSICmd_RECEIVE_COPY_RESULTS #x84);  Sec. 7.17: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  Sec. 7.18: Optional 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  Sec. 7.19: Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  Sec. 7.20: Optional 

(defconstant $kSCSICmd_REPORT_LUNS #xA0)        ;  Sec. 7.22: Optional 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  Sec. 7.23: Mandatory 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  Sec. 7.24: Optional 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  Sec. 7.25: Optional 

(defconstant $kSCSICmd_SEND 10)                 ;  Sec. 9.3: Optional 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  Sec. 7.26: Mandatory 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  Sec. 7.27: Mandatory 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  Sec. 7.29: Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x04 SBC Write Once Commands
;  Commands defined by the T10:990-D SCSI-3 Block Commands (SBC) command
;  * specification.  The definitions and section numbers are based on section 6.3
;  * of the revision 8c, 13 November 1997 version of the specification. 
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  SPC: Optional 

(defconstant $kSCSICmd_COMPARE 57)              ;  SPC: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  SPC: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  SPC: Optional

(defconstant $kSCSICmd_INQUIRY 18)              ;  SPC: Mandatory 

(defconstant $kSCSICmd_LOCK_UNLOCK_CACHE 54)    ;  Sec. 6.1.2: Optional 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  SPC: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  SPC: Optional 

(defconstant $kSCSICmd_MEDIUM_SCAN 56)          ;  Sec. 6.2.3: Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  SPC: Optional 

(defconstant $kSCSICmd_MOVE_MEDIUM #xA5)        ;  SMC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  SPC: Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  SPC: Optional 

(defconstant $kSCSICmd_PREFETCH 52)             ;  Sec. 6.1.3: Optional 

(defconstant $kSCSICmd_PREVENT_ALLOW_MEDIUM_REMOVAL 30);  SPC: Optional 

(defconstant $kSCSICmd_READ_6 8)                ;  Sec. 6.1.4: Optional 

(defconstant $kSCSICmd_READ_10 40)              ;  Sec. 6.1.5: Mandatory 

(defconstant $kSCSICmd_READ_12 #xA8)            ;  Sec. 6.2.4: Optional 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  SPC: Optional 

(defconstant $kSCSICmd_READ_CAPACITY 37)        ;  Sec. 6.1.6: Mandatory 

(defconstant $kSCSICmd_READ_ELEMENT_STATUS #xB8);  SMC: Optional 

(defconstant $kSCSICmd_READ_LONG 62)            ;  Sec. 6.1.8: Optional 

(defconstant $kSCSICmd_REASSIGN_BLOCKS 7)       ;  Sec. 6.1.9: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  SPC: Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  SPC: Optional 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  SPC: Optional 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  SPC: Mandatory 

(defconstant $kSCSICmd_REZERO_UNIT 1)           ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_10 49) ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_12 #xB1);  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_HIGH_10 48)  ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_HIGH_12 #xB0);  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_LOW_10 50)   ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_LOW_12 #xB2) ;  Obsolete 

(defconstant $kSCSICmd_SEEK_6 11)               ;  Obsolete 

(defconstant $kSCSICmd_SEEK_10 43)              ;  Sec. 6.1.12: Optional 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  SPC: Mandatory 

(defconstant $kSCSICmd_SET_LIMITS_10 51)        ;  Sec. 6.1.13: Optional 

(defconstant $kSCSICmd_SET_LIMITS_12 #xB3)      ;  Sec. 6.2.8: Optional 

(defconstant $kSCSICmd_START_STOP_UNIT 27)      ;  Sec. 6.1.14: Optional 

(defconstant $kSCSICmd_SYNCHRONIZE_CACHE 53)    ;  Sec. 6.1.15: Optional 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  SPC: Mandatory 

(defconstant $kSCSICmd_VERIFY_10 47)            ;  Sec. 6.2.10: Optional 

(defconstant $kSCSICmd_VERIFY_12 #xAF)          ;  Sec. 6.2.11: Optional 

(defconstant $kSCSICmd_WRITE_6 10)              ;  Sec. 6.1.17: Optional 

(defconstant $kSCSICmd_WRITE_10 42)             ;  Sec. 6.2.10: Mandatory

(defconstant $kSCSICmd_WRITE_12 #xAA)           ;  Sec. 6.2.13: Optional 

(defconstant $kSCSICmd_WRITE_AND_VERIFY_10 46)  ;  Sec. 6.2.14: Optional 

(defconstant $kSCSICmd_WRITE_AND_VERIFY_12 #xAE);  Sec. 6.2.15: Optional 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  SPC: Optional 

(defconstant $kSCSICmd_WRITE_LONG 63)           ;  Sec. 6.1.20: Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x05 MMC CD-ROM Commands
;  Commands defined by the T10:1363-D SCSI Multimedia Commands-3 (MMC-3) 
;  * specification.  The definitions and section numbers are based on section 6.1
;  * of the revision 01, March 03, 2000 version of the specification. 
;  *
;  * NOTE: The comments following each command may not be accurate.  These are
;  * not from the MMC-3 specification, but have been derived from the SCSI-2 and
;  * original MMC specifications.  Unlike the other SCSI command specifications,
;  * MMC-2 and MMC-3 do not provide a command requirement type and therefore does
;  * not relist the SPC commands with these requirements as they apply to MMC
;  * devices.  The MMC-2 and MMC-3 specifications also refer back to the SBC
;  * specification which seems invalid since MMC devices do not represent a
;  * Peripheral Device Type defined by SBC.  It is assumed that the SBC
;  * references refer to the Peripheral Device Type 0x00 - Direct Access Commands
;  * definitions from that specification.
;  

; #if 0
#| 
(defconstant $kSCSICmd_BLANK #xA1)              ;  Sec. 6.1.1: 

(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  Obsolete 

(defconstant $kSCSICmd_CLOSE_TRACK_SESSION 91)  ;  Sec. 6.1.2: 

(defconstant $kSCSICmd_COMPARE 57)              ;  SPC: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  SPC: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  SPC: Optional 

(defconstant $kSCSICmd_ERASE 44)                ;  SBC: 

(defconstant $kSCSICmd_FORMAT_UNIT 4)           ;  Sec. 6.1.3: 

(defconstant $kSCSICmd_GET_CONFIGURATION 70)    ;  Sec. 6.1.4: 

(defconstant $kSCSICmd_GET_EVENT_STATUS_NOTIFICATION 74);  Sec. 6.1.5: 

(defconstant $kSCSICmd_GET_PERFORMANCE #xAC)    ;  Sec. 6.1.6: 

(defconstant $kSCSICmd_INQUIRY 18)              ;  SPC: Mandatory 

(defconstant $kSCSICmd_LOAD_UNLOAD_MEDIUM #xA6) ;  Sec. 6.1.7: 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  SPC: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  SPC: Optional 

(defconstant $kSCSICmd_MECHANISM_STATUS #xBD)   ;  Sec. 6.1.8: 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  SPC: Mandatory 

(defconstant $kSCSICmd_PAUSE_RESUME 75)         ;  Sec. 6.1.9: 

(defconstant $kSCSICmd_PLAY_AUDIO_10 69)        ;  Sec. 6.1.10: 

(defconstant $kSCSICmd_PLAY_AUDIO_12 #xA5)      ;  Sec. 6.1.11: 

(defconstant $kSCSICmd_PLAY_AUDIO_MSF 71)       ;  Sec. 6.1.12: 

(defconstant $kSCSICmd_PLAY_AUDIO_TRACK_INDEX 72);  Obsolete 

(defconstant $kSCSICmd_PLAY_CD #xBC)            ;  Sec. 6.1.13: 

(defconstant $kSCSICmd_PLAY_RELATIVE_10 73)     ;  Obsolete 

(defconstant $kSCSICmd_PLAY_RELATIVE_12 #xA9)   ;  Obsolete 

(defconstant $kSCSICmd_PREFETCH 52)             ;  Optional 

(defconstant $kSCSICmd_PREVENT_ALLOW_MEDIUM_REMOVAL 30);  Optional 

(defconstant $kSCSICmd_READ_6 8)                ;  Optional 

(defconstant $kSCSICmd_READ_10 40)              ;  Mandatory 

(defconstant $kSCSICmd_READ_12 #xA8)            ;  Optional 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  Optional 

(defconstant $kSCSICmd_READ_BUFFER_CAPACITY 92) ;  Sec. 6.1.15: 

(defconstant $kSCSICmd_READ_CD #xBE)            ;  Sec. 6.1.16: 

(defconstant $kSCSICmd_READ_CD_MSF #xB9)        ;  Sec. 6.1.17: 

(defconstant $kSCSICmd_READ_CAPACITY 37)        ;  Sec. 6.1.18: 

(defconstant $kSCSICmd_READ_DISC_INFORMATION 81);  Sec. 6.1.19: 

(defconstant $kSCSICmd_READ_DVD_STRUCTURE #xAD) ;  Sec. 6.1.20: 

(defconstant $kSCSICmd_READ_FORMAT_CAPACITIES 35);  Sec. 6.1.21: 

(defconstant $kSCSICmd_READ_HEADER 68)          ;  Sec. 6.1.22: 

(defconstant $kSCSICmd_READ_LONG 62)            ;  Optional 

(defconstant $kSCSICmd_READ_MASTER_CUE 89)      ;  Sec. 6.1.23: 

(defconstant $kSCSICmd_READ_SUB_CHANNEL 66)     ;  Sec. 6.1.24: 

(defconstant $kSCSICmd_READ_TOC_PMA_ATIP 67)    ;  Sec. 6.1.25: 

(defconstant $kSCSICmd_READ_TRACK_INFORMATION 82);  Sec. 6.1.27: 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  Mandatory 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  Optional 

(defconstant $kSCSICmd_REPAIR_TRACK 88)         ;  Sec. 6.1.28: 

(defconstant $kSCSICmd_REPORT_KEY #xA4)         ;  Sec. 6.1.29: 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  Mandatory 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  Optional 

(defconstant $kSCSICmd_RESERVE_TRACK 83)        ;  Sec. 6.1.30: 

(defconstant $kSCSICmd_SCAN_MMC #xBA)           ;  Sec. 6.1.31: 

(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_10 49) ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_EQUAL_12 #xB1);  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_HIGH_10 48)  ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_HIGH_12 #xB0);  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_LOW_10 50)   ;  Obsolete 

(defconstant $kSCSICmd_SEARCH_DATA_LOW_12 #xB2) ;  Obsolete 

(defconstant $kSCSICmd_SEEK_6 11)               ;  Obsolete 

(defconstant $kSCSICmd_SEEK_10 43)              ;  SBC: 

(defconstant $kSCSICmd_SEND_CUE_SHEET 93)       ;  Sec. 6.1.32: 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  Mandatory 

(defconstant $kSCSICmd_SEND_DVD_STRUCTURE #xBF) ;  Sec. 6.1.33: 

(defconstant $kSCSICmd_SEND_EVENT #xA2)         ;  Sec. 6.1.34: 

(defconstant $kSCSICmd_SEND_KEY #xA3)           ;  Sec. 6.1.35: 

(defconstant $kSCSICmd_SEND_OPC_INFORMATION 84) ;  Sec. 6.1.36: 

(defconstant $kSCSICmd_SET_CD_SPEED #xBB)       ;  Sec. 6.1.37: 

(defconstant $kSCSICmd_SET_LIMITS_10 51)        ;  Optional 

(defconstant $kSCSICmd_SET_LIMITS_12 #xB3)      ;  Optional 

(defconstant $kSCSICmd_SET_READ_AHEAD #xA7)     ;  Sec. 6.1.38: 

(defconstant $kSCSICmd_SET_STREAMING #xB6)      ;  Sec. 6.1.39: 

(defconstant $kSCSICmd_START_STOP_UNIT 27)      ;  Optional 

(defconstant $kSCSICmd_STOP_PLAY_SCAN 78)       ;  Sec. 6.1.40: 

(defconstant $kSCSICmd_SYNCHRONIZE_CACHE 53)    ;  Sec. 6.1.41: 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  Mandatory 

(defconstant $kSCSICmd_VERIFY_10 47)            ;  Optional 

(defconstant $kSCSICmd_VERIFY_12 #xAF)          ;  Optional 

(defconstant $kSCSICmd_WRITE_10 42)             ;  Sec. 6.1.42: 

(defconstant $kSCSICmd_WRITE_12 #xAA)           ;  Sec. 6.1.43: 

(defconstant $kSCSICmd_WRITE_AND_VERIFY_10 46)  ;  Sec. 6.1.44: 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x06 SGC Scanner Commands
;  Commands defined by the T10:998-D SCSI-3 Graphics Commands (SGC)
;  * specification.  The definitions and section numbers are based on section 6
;  * of the revision 0, April 1995 version of the specification. 
;  

; #if 0
#| 
(defconstant $kSCSICmd_CHANGE_DEFINITION 64)    ;  SPC: Optional 

(defconstant $kSCSICmd_COMPARE 57)              ;  SPC: Optional 

(defconstant $kSCSICmd_COPY 24)                 ;  SPC: Optional 

(defconstant $kSCSICmd_COPY_AND_VERIFY 58)      ;  SPC: Optional 

(defconstant $kSCSICmd_GET_DATA_BUFFER_STATUS 52);  Sec. 6.1.1: Optional 

(defconstant $kSCSICmd_GET_WINDOW 37)           ;  Sec. 6.1.2: Optional 

(defconstant $kSCSICmd_INQUIRY 18)              ;  SPC: Mandatory 

(defconstant $kSCSICmd_LOG_SELECT 76)           ;  SPC: Optional 

(defconstant $kSCSICmd_LOG_SENSE 77)            ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  SPC: Optional 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  SPC: Optional 

(defconstant $kSCSICmd_OBJECT_POSITION 49)      ;  Sec. 6.1.3: Optional 

(defconstant $kSCSICmd_PORT_STATUS 17)
;  SPC (??): Mandatory
;                                                      * for dual port devices 

(defconstant $kSCSICmd_READ 40)                 ;  Sec. 6.1.4: Mandatory 

(defconstant $kSCSICmd_READ_BUFFER 60)          ;  SPC: Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 28);  SPC: Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  SPC: Mandatory 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  SPC: Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  SPC: Mandatory 

(defconstant $kSCSICmd_SCAN 27)                 ;  Sec. 6.1.5: Optional 

(defconstant $kSCSICmd_SEND 27)                 ;  Sec. 6.1.6: Optional 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  SPC: Mandatory 

(defconstant $kSCSICmd_SET_WINDOW 36)           ;  Sec. 6.1.7: Mandatory 

(defconstant $kSCSICmd_TEST_UNIT_READY 0)       ;  SPC: Mandatory 

(defconstant $kSCSICmd_WRITE_BUFFER 59)         ;  SPC: Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x07 SBC Optical Media Commands
;  Commands defined by the T10:990-D SCSI-3 Block Commands (SBC) 
;  * (revision 8c, 13 November 1998) command specification.  
;  
; #pragma mark -
; #pragma mark 0x08 SMC Medium Changer Commands
;  Commands defined by the T10:1228-D SCSI-3 Medium Changer Commands-2 (SMC-2)
;  * (revision 0, March 16, 2000) command specification.  
;  

; #if 0
#|                                              ;  Commands For Independent Medium Changers 

(defconstant $kSCSICmd_EXCHANGE_MEDIUM #xA6)    ;  Optional 

(defconstant $kSCSICmd_INITIALIZE_ELEMENT_STATUS 7);  Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  Optional 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  Optional 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  Optional 

(defconstant $kSCSICmd_MOVE_MEDIUM #xA5)        ;  Mandatory 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  Optional 

(defconstant $kSCSICmd_POSITION_TO_ELEMENT 43)  ;  Optional 

(defconstant $kSCSICmd_READ_ELEMENT_STATUS #xB8);  Mandatory 

(defconstant $kSCSICmd_RELEASE_ELEMENT_6 22)    ;  Optional 

(defconstant $kSCSICmd_RELEASE_ELEMENT_10 86)   ;  Optional 

(defconstant $kSCSICmd_REQUEST_VOLUME_ELEMENT_ADDRESS #xB5);  Optional 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  Mandatory 

(defconstant $kSCSICmd_RESERVE_ELEMENT_6 22)    ;  Optional 

(defconstant $kSCSICmd_RESERVE_ELEMENT_10 86)   ;  Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x09 SSC Communications Commands
;  Commands defined by the T10:997-D SCSI-3 Stream Commands (SSC) 
;  * (revision 22, January 1, 2000) command specification. 
;  
; #pragma mark -
; #pragma mark 0x0A ASC IT8 Prepress Commands
; #pragma mark 0x0B ASC IT8 Prepress Commands
;  Commands defined by the ASC IT8 <title goes here> specification
;  * (revision xx, month day, year) command specification.  
;  

; #if 0
#| 
 |#

; #endif

; #pragma mark -
; #pragma mark 0x0C SCC Array Controller Commands
;  Commands defined by the ANSI NCITS.318-199x SCSI Controller
;  * Commands (SCC-2) ratified command specification.  
;  

; #if 0
#| 
(defconstant $kSCSICmd_MAINTENANCE_IN #xA3)     ;  Mandatory 

(defconstant $kSCSICmd_MAINTENANCE_OUT #xA4)    ;  Optional 

(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  Optional 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  Optional 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  Optional 

(defconstant $kSCSICmd_PORT_STATUS 31)          ;  Optional 

(defconstant $kSCSICmd_REDUNDANCY_GROUP_IN #xBA);  Mandatory 

(defconstant $kSCSICmd_REDUNDANCY_GROUP_OUT #xBB);  Optional 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  Optional 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  Optional 

(defconstant $kSCSICmd_REPORT_LUNS #xA0)        ;  Mandatory 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  Optional 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  Optional

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  Optional 

(defconstant $kSCSICmd_SPARE_IN #xBC)           ;  Mandatory 

(defconstant $kSCSICmd_SPARE_OUT #xBD)          ;  Optional 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x0D SES Enclosure Services Commands
;  Commands defined by the T10:1212-D SCSI-3 Enclosure Services (SES) 
;  * (revision 8b, February 11, 1998) command specification.  
;  

; #if 0
#| 
(defconstant $kSCSICmd_MODE_SELECT_6 21)        ;  Optional 

(defconstant $kSCSICmd_MODE_SELECT_10 85)       ;  Optional 

(defconstant $kSCSICmd_MODE_SENSE_6 26)         ;  Optional 

(defconstant $kSCSICmd_MODE_SENSE_10 90)        ;  Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_IN 94);  Optional 

(defconstant $kSCSICmd_PERSISTENT_RESERVE_OUT 95);  Optional 

(defconstant $kSCSICmd_RECEIVE_DIAGNOSTICS_RESULTS 23);  Mandatory 

(defconstant $kSCSICmd_RELEASE_6 23)            ;  Optional 

(defconstant $kSCSICmd_RELEASE_10 87)           ;  Optional 

(defconstant $kSCSICmd_REQUEST_SENSE 3)         ;  Mandatory 

(defconstant $kSCSICmd_RESERVE_6 22)            ;  Optional 

(defconstant $kSCSICmd_RESERVE_10 86)           ;  Optional 

(defconstant $kSCSICmd_SEND_DIAGNOSTICS 29)     ;  Mandatory 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x0E RBC Reduced Block Commands
;  Commands defined by the T10:1240-D Reduced Block Commands (RBC) 
;  * (revision 10a, August 18, 1999) command specification.  
;  

; #if 0
#| 
(defconstant $kSCSICmd_FORMAT_UNIT 4)           ;  Optional 

(defconstant $kSCSICmd_READ_10 40)              ;  Mandatory 

(defconstant $kSCSICmd_READ_CAPACITY 37)        ;  Mandatory 

(defconstant $kSCSICmd_START_STOP_UNIT 27)      ;  Mandatory 

(defconstant $kSCSICmd_SYNCHRONIZE_CACHE 53)    ;  Optional 

(defconstant $kSCSICmd_VERIFY_10 47)            ;  Mandatory 

(defconstant $kSCSICmd_WRITE_10 42)             ;  Mandatory 

(defconstant $kSCSICmd_WRITE_BUFFER 59)
;  Mandatory for fixed media
;      *                                              Optional for removable 

 |#

; #endif

; #pragma mark -
; #pragma mark 0x0F OCRW Optical Card Commands
;  Commands defined by the ISO/IEC 14776-381 SCSI Specification for
;  * Optical Card Reader/Writer (OCRW) ratified command specification.  
;  

; #if 0
#| 
 |#

; #endif

; #pragma mark -
; #pragma mark 0x11 OSD Object-based Storage Commands
;  Commands defined by the T10:1355-D Object-based Storage Commands (OSD) 
;  * (revision 1, 18 May 2000) command specification.  
;  

; #if 0
#| 
 |#

; #endif

; #pragma mark -
; #pragma mark 0x15 RMC Simplified Multimedia Commands
;  Commands defined by the T10:1364-D Reduced Multimedia Commands (RMC) 
;  * (revision 1, November 11, 1999) command specification.  
;  

; #if 0
#| 
 |#

; #endif


; #endif	/* _SCSI_COMMAND_OPERATION_CODES_H */


(provide-interface "SCSICommandOperationCodes")