(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFireWireAVCConsts.h"
; at Sunday July 2,2006 7:27:44 pm.
; 
;  * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_IOFIREWIREAVCCONSTS_H
; #define _IOKIT_IOFIREWIREAVCCONSTS_H
;  Fields of AVC frame

(defconstant $kAVCCommandResponse 0)
(defconstant $kAVCAddress 1)
(defconstant $kAVCOpcode 2)
(defconstant $kAVCOperand0 3)
(defconstant $kAVCOperand1 4)
(defconstant $kAVCOperand2 5)
(defconstant $kAVCOperand3 6)
(defconstant $kAVCOperand4 7)
(defconstant $kAVCOperand5 8)
(defconstant $kAVCOperand6 9)
(defconstant $kAVCOperand7 10)
(defconstant $kAVCOperand8 11)
(def-mactype :IOAVCFrameFields (find-mactype ':SINT32))
;  Command/Response values

(defconstant $kAVCControlCommand 0)
(defconstant $kAVCStatusInquiryCommand 1)
(defconstant $kAVCSpecificInquiryCommand 2)
(defconstant $kAVCNotifyCommand 3)
(defconstant $kAVCGeneralInquiryCommand 4)
(defconstant $kAVCNotImplementedStatus 8)
(defconstant $kAVCAcceptedStatus 9)
(defconstant $kAVCRejectedStatus 10)
(defconstant $kAVCInTransitionStatus 11)
(defconstant $kAVCImplementedStatus 12)
(defconstant $kAVCChangedStatus 13)
(defconstant $kAVCInterimStatus 15)
(def-mactype :IOAVCCommandResponse (find-mactype ':SINT32))
;  Opcodes
;  Unit commands

(defconstant $kAVCPlugInfoOpcode 2)
(defconstant $kAVCOutputPlugSignalFormatOpcode 24)
(defconstant $kAVCInputPlugSignalFormatOpcode 25)
(defconstant $kAVCUnitInfoOpcode 48)
(defconstant $kAVCSubunitInfoOpcode 49)
(defconstant $kAVCConnectionsOpcode 34)
(defconstant $kAVCConnectOpcode 36)
(defconstant $kAVCDisconnectOpcode 37)
(defconstant $kAVCPowerOpcode #xB2)
(defconstant $kAVCSignalSourceOpcode 26)        ;  Vendor dependent commands

(defconstant $kAVCVendorDependentOpcode 0)      ;  Subunit commands

(defconstant $kAVCOutputSignalModeOpcode 120)
(defconstant $kAVCInputSignalModeOpcode 121)
(defconstant $kAVCSignalModeSD525_60 0)
(defconstant $kAVCSignalModeSDL525_60 4)
(defconstant $kAVCSignalModeHD1125_60 8)
(defconstant $kAVCSignalModeSD625_50 #x80)
(defconstant $kAVCSignalModeSDL625_50 #x84)
(defconstant $kAVCSignalModeHD1250_50 #x88)
(defconstant $kAVCSignalModeDVCPro525_60 120)
(defconstant $kAVCSignalModeDVCPro625_50 #xF8)
(defconstant $kAVCSignalModeDummyOperand #xFF)
(defconstant $kAVCSignalModeMask_50 #x80)
(defconstant $kAVCSignalModeMask_STYPE 124)
(defconstant $kAVCSignalModeMask_SDL 4)
(defconstant $kAVCSignalModeMask_DVCPro25 120)
(def-mactype :IOAVCOpcodes (find-mactype ':SINT32))
;  Unit/Subunit types

(defconstant $kAVCVideoMonitor 0)
(defconstant $kAVCAudio 1)
(defconstant $kAVCPrinter 2)
(defconstant $kAVCDiskRecorder 3)
(defconstant $kAVCTapeRecorder 4)
(defconstant $kAVCTuner 5)
(defconstant $kAVCVideoCamera 7)
(defconstant $kAVCCameraStorage 11)
(defconstant $kAVCVendorUnique 28)
(defconstant $kAVCNumSubUnitTypes 32)
(def-mactype :IOAVCUnitTypes (find-mactype ':SINT32))
(defconstant $kAVCAllOpcodes 255)
; #define kAVCAllOpcodes 0xFF
(defconstant $kAVCAllSubunitsAndUnit 238)
; #define kAVCAllSubunitsAndUnit 0xEE
(defconstant $kAVCMaxNumPlugs 31)
; #define kAVCMaxNumPlugs 31
(defconstant $kAVCAnyAvailableIsochPlug 127)
; #define kAVCAnyAvailableIsochPlug 0x7F
(defconstant $kAVCAnyAvailableExternalPlug 255)
; #define kAVCAnyAvailableExternalPlug 0xFF
(defconstant $kAVCAnyAvailableSubunitPlug 255)
; #define kAVCAnyAvailableSubunitPlug 0xFF
(defconstant $kAVCMultiplePlugs 253)
; #define kAVCMultiplePlugs 0xFD
(defconstant $kAVCInvalidPlug 254)
; #define kAVCInvalidPlug 0xFE
; #define IOAVCAddress(type, id) (((type) << 3) | (id))
(defconstant $kAVCUnitAddress 255)
; #define kAVCUnitAddress 0xff
; #define IOAVCType(address) ((address) >> 3)
; #define IOAVCId(address) ((address) & 0x7)
;  Macros for Plug Control Register field manipulation
;  Master control registers
; #define kIOFWPCRDataRate FWBitRange(0,1)
; #define kIOFWPCRDataRatePhase FWBitRangePhase(0,1)
; #define kIOFWPCRExtension FWBitRange(8,15)
; #define kIOFWPCRExtensionPhase FWBitRangePhase(8,15)
; #define kIOFWPCRNumPlugs FWBitRange(27,31)
; #define kIOFWPCRNumPlugsPhase FWBitRangePhase(27,31)
;  master output register
; #define kIOFWPCRBroadcastBase FWBitRange(2,7)
; #define kIOFWPCRBroadcastBasePhase FWBitRangePhase(2,7)
;  plug registers
; #define kIOFWPCROnline FWBitRange(0,0)
; #define kIOFWPCROnlinePhase FWBitRangePhase(0,0)
; #define kIOFWPCRBroadcast FWBitRange(1,1)
; #define kIOFWPCRBroadcastPhase FWBitRangePhase(1,1)
; #define kIOFWPCRP2PCount FWBitRange(2,7)
; #define kIOFWPCRP2PCountPhase FWBitRangePhase(2,7)
; #define kIOFWPCRChannel FWBitRange(10,15)
; #define kIOFWPCRChannelPhase FWBitRangePhase(10,15)
;  Extra fields for output plug registers
; #define kIOFWPCROutputDataRate FWBitRange(16,17)
; #define kIOFWPCROutputDataRatePhase FWBitRangePhase(16,17)
; #define kIOFWPCROutputOverhead FWBitRange(18,21)
; #define kIOFWPCROutputOverheadPhase FWBitRangePhase(18,21)
; #define kIOFWPCROutputPayload FWBitRange(22,31)
; #define kIOFWPCROutputPayloadPhase FWBitRangePhase(22,31)
;  async plug numbers

(defconstant $kFWAVCAsyncPlug0 #xA0)
(defconstant $kFWAVCAsyncPlug1 #xA1)
(defconstant $kFWAVCAsyncPlug2 #xA2)
(defconstant $kFWAVCAsyncPlug3 #xA3)
(defconstant $kFWAVCAsyncPlug4 #xA4)
(defconstant $kFWAVCAsyncPlug5 #xA5)
(defconstant $kFWAVCAsyncPlug6 #xA6)
(defconstant $kFWAVCAsyncPlug7 #xA7)
(defconstant $kFWAVCAsyncPlug8 #xA8)
(defconstant $kFWAVCAsyncPlug9 #xA9)
(defconstant $kFWAVCAsyncPlug10 #xA1)
(defconstant $kFWAVCAsyncPlug11 #xAB)
(defconstant $kFWAVCAsyncPlug12 #xAC)
(defconstant $kFWAVCAsyncPlug13 #xAD)
(defconstant $kFWAVCAsyncPlug14 #xAE)
(defconstant $kFWAVCAsyncPlug15 #xAF)
(defconstant $kFWAVCAsyncPlug16 #xB0)
(defconstant $kFWAVCAsyncPlug17 #xB1)
(defconstant $kFWAVCAsyncPlug18 #xB2)
(defconstant $kFWAVCAsyncPlug19 #xB3)
(defconstant $kFWAVCAsyncPlug20 #xB4)
(defconstant $kFWAVCAsyncPlug21 #xB5)
(defconstant $kFWAVCAsyncPlug22 #xB6)
(defconstant $kFWAVCAsyncPlug23 #xB7)
(defconstant $kFWAVCAsyncPlug24 #xB8)
(defconstant $kFWAVCAsyncPlug25 #xB9)
(defconstant $kFWAVCAsyncPlug26 #xBA)
(defconstant $kFWAVCAsyncPlug27 #xBB)
(defconstant $kFWAVCAsyncPlug28 #xBC)
(defconstant $kFWAVCAsyncPlug29 #xBD)
(defconstant $kFWAVCAsyncPlug30 #xBE)
(defconstant $kFWAVCAsyncPlugAny #xBF)

(defconstant $kFWAVCStateBusSuspended 0)
(defconstant $kFWAVCStateBusResumed 1)
(defconstant $kFWAVCStatePlugReconnected 2)
(defconstant $kFWAVCStatePlugDisconnected 3)
(defconstant $kFWAVCStateDeviceRemoved 4)

(defconstant $kFWAVCConsumerMode_MORE 1)
(defconstant $kFWAVCConsumerMode_LAST 4)
(defconstant $kFWAVCConsumerMode_LESS 5)
(defconstant $kFWAVCConsumerMode_JUNK 6)
(defconstant $kFWAVCConsumerMode_LOST 7)

(defconstant $kFWAVCProducerMode_SEND 5)
(defconstant $kFWAVCProducerMode_TOSS 7)

(defconstant $IOFWAVCPlugSubunitSourceType 0)
(defconstant $IOFWAVCPlugSubunitDestType 1)
(defconstant $IOFWAVCPlugIsochInputType 2)
(defconstant $IOFWAVCPlugIsochOutputType 3)
(defconstant $IOFWAVCPlugAsynchInputType 4)
(defconstant $IOFWAVCPlugAsynchOutputType 5)
(defconstant $IOFWAVCPlugExternalInputType 6)
(defconstant $IOFWAVCPlugExternalOutputType 7)
(def-mactype :IOFWAVCPlugTypes (find-mactype ':SINT32))

(defconstant $kIOFWAVCSubunitPlugMsgConnected 0)
(defconstant $kIOFWAVCSubunitPlugMsgDisconnected 1)
(defconstant $kIOFWAVCSubunitPlugMsgConnectedPlugModified 2)
(defconstant $kIOFWAVCSubunitPlugMsgSignalFormatModified 3)
(def-mactype :IOFWAVCSubunitPlugMessages (find-mactype ':SINT32))
;  Some plug signal formats
(defconstant $kAVCPlugSignalFormatNTSCDV 2147483648)
; #define kAVCPlugSignalFormatNTSCDV 0x80000000
(defconstant $kAVCPlugSignalFormatPalDV 2155872256)
; #define kAVCPlugSignalFormatPalDV 0x80800000 
(defconstant $kAVCPlugSignalFormatMPEGTS 2684354560)
; #define kAVCPlugSignalFormatMPEGTS 0xA0000000

; #endif // _IOKIT_IOFIREWIREAVCCONSTS_H


(provide-interface "IOFireWireAVCConsts")