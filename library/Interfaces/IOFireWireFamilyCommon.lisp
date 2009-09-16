(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFireWireFamilyCommon.h"
; at Sunday July 2,2006 7:25:40 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
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
; 
;  *  IOFireWireFamilyCommon.h
;  *  IOFireWireUserClient/IOFireWireFamily
;  *
;  *  Created by NWG on Fri Apr 28 2000.
;  *  Copyright (c) 2000-2001 Apple Computer, Inc. All rights reserved.
;  *
;  
; 
; 	$Log: IOFireWireFamilyCommon.h,v $
; 	Revision 1.46  2003/07/22 10:49:47  niels
; 	*** empty log message ***
; 	
; 	Revision 1.45  2003/07/21 06:52:59  niels
; 	merge isoch to TOT
; 	
; 	Revision 1.44.4.5  2003/07/21 06:44:44  niels
; 	*** empty log message ***
; 	
; 	Revision 1.44.4.4  2003/07/18 00:17:42  niels
; 	*** empty log message ***
; 	
; 	Revision 1.44.4.3  2003/07/14 22:08:53  niels
; 	*** empty log message ***
; 	
; 	Revision 1.44.4.2  2003/07/09 21:24:01  niels
; 	*** empty log message ***
; 	
; 	Revision 1.44.4.1  2003/07/01 20:54:07  niels
; 	isoch merge
; 	
; 	Revision 1.44  2003/03/17 01:05:22  collin
; 	*** empty log message ***
; 	
; 	Revision 1.43  2003/03/07 01:26:06  collin
; 	*** empty log message ***
; 	
; 	Revision 1.42  2003/02/19 22:33:17  niels
; 	add skip cycle DCL
; 	
; 	Revision 1.41  2003/02/18 00:14:01  collin
; 	*** empty log message ***
; 	
; 	Revision 1.40  2003/02/17 21:47:52  collin
; 	*** empty log message ***
; 	
; 	Revision 1.39  2002/12/05 19:08:37  niels
; 	remove trailing commas from enums in IOFireWireFamilyCommon.h
; 	
; 	Revision 1.38  2002/11/01 20:45:57  collin
; 	add enhanced IRM with support for the BROADCAST_CHANNEL register
; 	
; 	Revision 1.37  2002/10/01 02:40:27  collin
; 	security mode support
; 	
; 	Revision 1.36  2002/09/25 21:17:14  collin
; 	fix headers again.
; 	
; 	Revision 1.35  2002/09/25 00:27:23  niels
; 	flip your world upside-down
; 	
; 	Revision 1.34  2002/09/12 22:41:53  niels
; 	add GetIRMNodeID() to user client
; 	
; 
; ! @header IOFireWireFamilyCommon.h
; This file contains useful definitions for working with FireWire
; in the kernel and in user space
; 
; #ifndef __IOFireWireFamilyCommon_H__
; #define __IOFireWireFamilyCommon_H__
; #ifdef KERNEL
#| #|
#ifndef__IOKIT_IOTYPES_H
	#include <IOKitIOTypes.h>
#endif
|#
 |#

; #else

(require-interface "IOKit/IOKitLib")

; #endif

; #define FW_OLD_DCL_DEFS
; #define FW_OLD_BIT_DEFS
;  =================================================================
;  bit ranges and fields
;  =================================================================
; #pragma mark -
; #pragma mark BITS
;  FireWire bit defs.
; #define BIT(x)		( 1 << (x) )
; #define FW_BIT(x)	( 1 << (31 - (x) ) )
; #define FWBitRange(start, end)						(														((((UInt32) 0xFFFFFFFF) << (start)) >>				 ((start) + (31 - (end)))) <<						(31 - (end))									)
; #define FWBitRangePhase(start, end)						(31 - (end))
; #define BitRange(start, end)						(														((((UInt32) 0xFFFFFFFF) << (31 - (end))) >>			 ((31 - (end)) + (start))) <<						(start)											)
; #define BitRangePhase(start, end)						(start)
;  =================================================================
;  FireWire messages & errors
;  =================================================================
; #pragma mark -
; #pragma mark MESSAGES AND ERRORS
; #define	iokit_fw_err(return) (sys_iokit|sub_iokit_firewire|return)
;  e0008010 -> 0xe000801f Response codes from response packets
;  Base of Response error codes
; #define kIOFireWireResponseBase							iokit_fw_err(0x10)
;  e0008020 -- Bus reset during command execution (current bus generation does
;              not match that specified in command.)
; #define kIOFireWireBusReset								(kIOFireWireResponseBase+kFWResponseBusResetError)
;  e0008001 -- Can't find requested entry in ROM
; #define kIOConfigNoEntry								iokit_fw_err(1)
;  e0008002 -- In pending queue waiting to execute
; #define kIOFireWirePending								iokit_fw_err(2)
;  e0008003 -- Last DCL callback of program (internal use)
; #define kIOFireWireLastDCLToken							iokit_fw_err(3)
;  e0008004
; #define kIOFireWireConfigROMInvalid						iokit_fw_err(4)
;  e0008005
; #define kIOFireWireAlreadyRegistered					iokit_fw_err(5)
;  e0008006
; #define kIOFireWireMultipleTalkers						iokit_fw_err(6)
;  e0008007
; #define kIOFireWireChannelActive						iokit_fw_err(7)
;  e0008008
; #define kIOFireWireNoListenerOrTalker					iokit_fw_err(8)
;  e0008009
; #define kIOFireWireNoChannels							iokit_fw_err(9)
;  e000800A
; #define kIOFireWireChannelNotAvailable					iokit_fw_err(10)
;  e000800B
; #define kIOFireWireSeparateBus							iokit_fw_err(11)
;  e000800C
; #define kIOFireWireBadSelfIDs							iokit_fw_err(12)
;  e000800D
; #define kIOFireWireLowCableVoltage						iokit_fw_err(13)
;  e000800E
; #define kIOFireWireInsufficientPower					iokit_fw_err(14)
;  e000800f
; #define kIOFireWireOutOfTLabels							iokit_fw_err(15)
;  NOTE: errors 16Ñ31 used for address space response codes.. (see above)
;  e0008101
; #define kIOFireWireBogusDCLProgram						iokit_fw_err(257)
;  e0008102		// let's resume here...
; #define kIOFireWireTalkingAndListening					iokit_fw_err(258)
;  e0008103		// let's resume here...
;  #define ???											iokit_fw_err(259)
;  e00087d0
; #define kIOFWMessageServiceIsRequestingClose 			(UInt32)iokit_fw_err(2000)
; #define kIOFWMessagePowerStateChanged 					(UInt32)iokit_fw_err(2001)
; #define kIOFWMessageTopologyChanged						(UInt32)iofit_fw_err(2002)
;  =================================================================
;  Pseudo address space response codes
;  =================================================================
; #pragma mark -
; #pragma mark PSEDUO ADDRESS SPACE RESPONSE CODES

(defconstant $kFWResponseComplete 0)            ;  OK!

(defconstant $kFWResponseConflictError 4)       ;  Resource conflict, may retry

(defconstant $kFWResponseDataError 5)           ;  Data not available

(defconstant $kFWResponseTypeError 6)           ;  Operation not supported

(defconstant $kFWResponseAddressError 7)        ;  Address not valid in target device

(defconstant $kFWResponseBusResetError 16)      ;  Pseudo response generated locally

(defconstant $kFWResponsePending 17)            ;  Pseudo response, real response sent later.

; 
;  Pseudo address space response codes
; 

(defconstant $kFWAckTimeout -1)                 ;  Pseudo ack generated locally

(defconstant $kFWAckComplete 1)
(defconstant $kFWAckPending 2)
(defconstant $kFWAckBusyX 4)
(defconstant $kFWAckBusyA 5)
(defconstant $kFWAckBusyB 6)
(defconstant $kFWAckDataError 13)
(defconstant $kFWAckTypeError 14)
;  =================================================================
;  FireWire bus speed numbers
;  =================================================================
; #pragma mark -
; #pragma mark BUS SPEED NUMBERS

(defconstant $kFWSpeed100MBit 0)
(defconstant $kFWSpeed200MBit 1)
(defconstant $kFWSpeed400MBit 2)
(defconstant $kFWSpeed800MBit 3)
(defconstant $kFWSpeedReserved 3)               ;  1394B Devices report this no matter what speed the PHY allows
;  Worse, each port of the PHY could be different

(defconstant $kFWSpeedUnknownMask #x80)         ;  Set this bit is speed map if speed was reserved and
;  we haven't probed it further

(defconstant $kFWSpeedMaximum #x7FFFFFFF)       ; zzz what are the best numbers???

(defconstant $kFWSpeedInvalid #x80000000)
(def-mactype :IOFWSpeed (find-mactype ':SINT32))
;  =================================================================
;  FWAddress
;  =================================================================
; #pragma mark -
; #pragma mark FWADDRESS
; 
;  The venerable FWAddress structure. This is the standard
;  struct to use for passing FireWire addresses.
; 
(defrecord FWAddressStruct
   (nodeID :UInt16)
                                                ;  bus/node
   (addressHi :UInt16)
                                                ;  Top 16 bits of node address.
   (addressLo :UInt32)
                                                ;  Bottom 32 bits of node address
                                                ; 
                                                ;  Useful C++ only constructors
                                                ; 
; #ifdef __cplusplus
#| #|
	FWAddressStruct(const FWAddressStruct & a): 
			nodeID(a.nodeID), addressHi(a.addressHi), addressLo(a.addressLo) {};
    FWAddressStruct(UInt16 h=0xdead, UInt32 l=0xcafebabe) : 
			nodeID(0), addressHi(h), addressLo(l) {};
	FWAddressStruct(UInt16 h, UInt32 l, UInt16 n) :
			nodeID(n), addressHi(h), addressLo(l) {};
	#endif
|#
 |#
)
(%define-record :FWAddress (find-record-descriptor :FWADDRESSSTRUCT))

(def-mactype :FWAddressPtr (find-mactype '(:POINTER :FWADDRESSSTRUCT)))
;  =================================================================
;  Config ROM
;  =================================================================
; #pragma mark -
; #pragma mark CONFIG ROM
; 
;  CSR bit defs.
; 
; #define CSR_BIT(x) FW_BIT(x)
; #define CSRBitRange(start, end)						(														((((UInt32) 0xFFFFFFFF) << (start)) >>				((start) + (31 - (end)))) <<						(31 - (end))									)
; #define CSRBitRangePhase(start, end)					(31 - end)
; 
;  Key types.
; 

(defconstant $kConfigImmediateKeyType 0)
(defconstant $kConfigOffsetKeyType 1)
(defconstant $kConfigLeafKeyType 2)
(defconstant $kConfigDirectoryKeyType 3)
(defconstant $kInvalidConfigROMEntryType #xFF)
(def-mactype :IOConfigKeyType (find-mactype ':SINT32))
; 
;  Key values.
; 

(defconstant $kConfigTextualDescriptorKey 1)
(defconstant $kConfigBusDependentInfoKey 2)
(defconstant $kConfigModuleVendorIdKey 3)
(defconstant $kConfigModuleHwVersionKey 4)
(defconstant $kConfigModuleSpecIdKey 5)
(defconstant $kConfigModuleSwVersionKey 6)
(defconstant $kConfigModuleDependentInfoKey 7)
(defconstant $kConfigNodeVendorIdKey 8)
(defconstant $kConfigNodeHwVersionKey 9)
(defconstant $kConfigNodeSpecIdKey 10)
(defconstant $kConfigNodeSwVersionKey 11)
(defconstant $kConfigNodeCapabilitiesKey 12)
(defconstant $kConfigNodeUniqueIdKey 13)
(defconstant $kConfigNodeUnitsExtentKey 14)
(defconstant $kConfigNodeMemoryExtentKey 15)
(defconstant $kConfigNodeDependentInfoKey 16)
(defconstant $kConfigUnitDirectoryKey 17)
(defconstant $kConfigUnitSpecIdKey 18)
(defconstant $kConfigUnitSwVersionKey 19)
(defconstant $kConfigUnitDependentInfoKey 20)
(defconstant $kConfigUnitLocationKey 21)
(defconstant $kConfigUnitPollMaskKey 22)
(defconstant $kConfigModelIdKey 23)
(defconstant $kConfigGenerationKey 56)          ;  Apple-specific

(defconstant $kConfigRootDirectoryKey #xFFFF)   ;  Not a real key

;  Core CSR registers.

(defconstant $kCSRStateUnitDepend #xFFFF0000)
(defconstant $kCSRStateUnitDependPhase 16)
(defconstant $kCSRStateBusDepend #xFFFFFF00)
(defconstant $kCSRStateBusDependPhase 8)
(defconstant $kCSRStateLost #x80)
(defconstant $kCSRStateDReq 64)
(defconstant $kCSRStateELog 16)
(defconstant $kCSRStateAtn 8)
(defconstant $kCSRStateOff 4)
(defconstant $kCSRStateState #xFFFFFFFF)
(defconstant $kCSRStateStatePhase 0)
(defconstant $kCSRStateStateRunning 0)
(defconstant $kCSRStateStateInitializing 1)
(defconstant $kCSRStateStateTesting 2)
(defconstant $kCSRStateStateDead 3)
;  Config ROM entry bit locations.

(defconstant $kConfigBusInfoBlockLength #xFF000000)
(defconstant $kConfigBusInfoBlockLengthPhase 24)
(defconstant $kConfigROMCRCLength #xFFFF0000)
(defconstant $kConfigROMCRCLengthPhase 16)
(defconstant $kConfigROMCRCValue #xFFFFFFFF)
(defconstant $kConfigROMCRCValuePhase 0)
(defconstant $kConfigEntryKeyType #xC0000000)
(defconstant $kConfigEntryKeyTypePhase 30)
(defconstant $kConfigEntryKeyValue #xFF000000)
(defconstant $kConfigEntryKeyValuePhase 24)
(defconstant $kConfigEntryValue #xFFFFFFFF)
(defconstant $kConfigEntryValuePhase 0)
(defconstant $kConfigLeafDirLength #xFFFF0000)
(defconstant $kConfigLeafDirLengthPhase 16)
(defconstant $kConfigLeafDirCRC #xFFFFFFFF)
(defconstant $kConfigLeafDirCRCPhase 0)
; 
;  Key types.
; 

(defconstant $kCSRImmediateKeyType 0)
(defconstant $kCSROffsetKeyType 1)
(defconstant $kCSRLeafKeyType 2)
(defconstant $kCSRDirectoryKeyType 3)
(defconstant $kInvalidCSRROMEntryType #xFF)
(def-mactype :IOCSRKeyType (find-mactype ':SINT32))
;  CSR 64-bit fixed address defs.

(defconstant $kCSRNodeID #xFFFF0000)
(defconstant $kCSRNodeIDPhase 16)
(defconstant $kCSRInitialMemorySpaceBaseAddressHi 0)
(defconstant $kCSRInitialMemorySpaceBaseAddressLo 0)
(defconstant $kCSRPrivateSpaceBaseAddressHi #xFFFF)
(defconstant $kCSRPrivateSpaceBaseAddressLo #xE0000000)
(defconstant $kCSRRegisterSpaceBaseAddressHi #xFFFF)
(defconstant $kCSRRegisterSpaceBaseAddressLo #xF0000000)
(defconstant $kCSRCoreRegistersBaseAddress #xF0000000)
(defconstant $kCSRStateClearAddress #xF0000000)
(defconstant $kCSRStateSetAddress #xF0000004)
(defconstant $kCSRNodeIDsAddress #xF0000008)
(defconstant $kCSRResetStartAddress #xF000000C)
(defconstant $kCSRIndirectAddressAddress #xF0000010)
(defconstant $kCSRIndirectDataAddress #xF0000014)
(defconstant $kCSRSplitTimeoutHiAddress #xF0000018)
(defconstant $kCSRSplitTimeoutLoAddress #xF000001C)
(defconstant $kCSRArgumentHiAddress #xF0000020)
(defconstant $kCSRArgumentLoAddress #xF0000024)
(defconstant $kCSRTestStartAddress #xF0000028)
(defconstant $kCSRTestStatusAddress #xF000002C)
(defconstant $kCSRUnitsBaseHiAddress #xF0000030)
(defconstant $kCSRUnitsBaseLoAddress #xF0000034)
(defconstant $kCSRUnitsBoundHiAddress #xF0000038)
(defconstant $kCSRUnitsBoundLoAddress #xF000003C)
(defconstant $kCSRMemoryBaseHiAddress #xF0000040)
(defconstant $kCSRMemoryBaseLoAddress #xF0000044)
(defconstant $kCSRMemoryBoundHiAddress #xF0000048)
(defconstant $kCSRMemoryBoundLoAddress #xF000004C)
(defconstant $kCSRInterruptTargetAddress #xF0000050)
(defconstant $kCSRInterruptMaskAddress #xF0000054)
(defconstant $kCSRClockValueHiAddress #xF0000058)
(defconstant $kCSRClockValueMidAddress #xF000005C)
(defconstant $kCSRClockTickPeriodMidAddress #xF0000060)
(defconstant $kCSRClockTickPeriodLoAddress #xF0000064)
(defconstant $kCSRClockStrobeArrivedHiAddress #xF0000068)
(defconstant $kCSRClockStrobeArrivedMidAddress #xF000006C)
(defconstant $kCSRClockInfo0Address #xF0000070)
(defconstant $kCSRClockInfo1Address #xF0000074)
(defconstant $kCSRClockInfo2Address #xF0000078)
(defconstant $kCSRClockInfo3Address #xF000007C)
(defconstant $kCSRMessageRequestAddress #xF0000080)
(defconstant $kCSRMessageResponseAddress #xF00000C0)
(defconstant $kCSRErrorLogBufferAddress #xF0000180)
(defconstant $kCSRBusDependentRegistersBaseAddress #xF0000200)
(defconstant $kCSRBusyTimeout #xF0000210)
(defconstant $kCSRBusManagerID #xF000021C)
(defconstant $kCSRBandwidthAvailable #xF0000220)
(defconstant $kCSRChannelsAvailable31_0 #xF0000224)
(defconstant $kCSRChannelsAvailable63_32 #xF0000228)
(defconstant $kCSRBroadcastChannel #xF0000234)
(defconstant $kConfigROMBaseAddress #xF0000400)
(defconstant $kConfigBIBHeaderAddress #xF0000400)
(defconstant $kConfigBIBBusNameAddress #xF0000404)
(defconstant $kPCRBaseAddress #xF0000900)
(defconstant $kFCPCommandAddress #xF0000B00)
(defconstant $kFCPResponseAddress #xF0000D00)
;  from figure 10-7 of 1394a
(defconstant $kBroadcastChannelInitialValues 2147483679)
; #define kBroadcastChannelInitialValues 	0x8000001f
(defconstant $kBroadcastChannelValidMask 1073741824)
; #define kBroadcastChannelValidMask 		0x40000000
;  CSR defined 64 bit unique ID.

(%define-record :CSRNodeUniqueID (find-record-descriptor ':UInt64))
;  FireWire core CSR registers.

(defconstant $kFWCSRStateGone #x8000)
(defconstant $kFWCSRStateLinkOff #x200)
(defconstant $kFWCSRStateCMstr #x100)
;  FireWire bus/nodeID address defs.

(defconstant $kFWAddressBusID #xFFFFFFC00000)
(defconstant $kFWAddressBusIDPhase 22)
(defconstant $kFWAddressNodeID #xFFFFFFFF0000)
(defconstant $kFWAddressNodeIDPhase 16)
(defconstant $kFWLocalBusID #x3FF)
(defconstant $kFWBroadcastNodeID 63)
(defconstant $kFWBadNodeID #xFFFF)
(defconstant $kFWLocalBusAddress #xFFC00000)
(defconstant $kFWBroadcastAddress #x3F0000)
; #define FWNodeBaseAddress(busID, nodeID)												(																							(busID << kFWAddressBusIDPhase) |														(nodeID << kFWAddressNodeIDPhase)													)
; #define FWNodeRegisterSpaceBaseAddressHi(busID, nodeID)									(																							FWNodeBaseAddress (busID, nodeID) |														kCSRRegisterSpaceBaseAddressHi														)
;  FireWire CSR bus info block defs.

(defconstant $kFWBIBHeaderAddress #xF0000400)
(defconstant $kFWBIBBusNameAddress #xF0000404)
(defconstant $kFWBIBNodeCapabilitiesAddress #xF0000408)
(defconstant $kFWBIBNodeUniqueIDHiAddress #xF000040C)
(defconstant $kFWBIBNodeUniqueIDLoAddress #xF0000410)
(defconstant $kFWBIBBusName #x31333934)         ; '1394'

(defconstant $kFWBIBIrmc #x80000000)
(defconstant $kFWBIBCmc #x40000000)
(defconstant $kFWBIBIsc #x20000000)
(defconstant $kFWBIBBmc #x10000000)
(defconstant $kFWBIBCycClkAcc #xFFFF0000)
(defconstant $kFWBIBCycClkAccPhase 16)
(defconstant $kFWBIBMaxRec #xFFFFF000)
(defconstant $kFWBIBMaxRecPhase 12)
(defconstant $kFWBIBMaxROM #xFFFFFC00)
(defconstant $kFWBIBMaxROMPhase 10)
(defconstant $kFWBIBGeneration #xFFFFFFF0)
(defconstant $kFWBIBGenerationPhase 4)
(defconstant $kFWBIBLinkSpeed #xFFFFFFFF)
(defconstant $kFWBIBLinkSpeedPhase 0)
;  =================================================================
;  Isoch defines
;  =================================================================
; #pragma mark -
; #pragma mark ISOCH

(defconstant $kFWIsochDataLength #xFFFF0000)
(defconstant $kFWIsochDataLengthPhase 16)
(defconstant $kFWIsochTag #xFFFFC000)
(defconstant $kFWIsochTagPhase 14)
(defconstant $kFWIsochChanNum #xFFFFFF00)
(defconstant $kFWIsochChanNumPhase 8)
(defconstant $kFWIsochTCode #xFFFFFFF0)
(defconstant $kFWIsochTCodePhase 4)
(defconstant $kFWIsochSy #xFFFFFFFF)
(defconstant $kFWIsochSyPhase 0)
; #define CHAN_BIT(x) 		(((UInt64)1) << (63 - (x))
; #define CHAN_MASK(x) 		(~CHAN_BIT(X))

(defconstant $kFWNeverMultiMode 0)
(defconstant $kFWAllowMultiMode 1)
(defconstant $kFWSuggestMultiMode 2)
(defconstant $kFWAlwaysMultiMode 3)
(defconstant $kFWDefaultIsochResourceFlags 0)
(def-mactype :IOFWIsochResourceFlags (find-mactype ':SINT32))

(defconstant $kFWIsochChannelDefaultFlags 0)
(defconstant $kFWIsochChannelDoNotResumeOnWake 2)
;  =================================================================
;  DCL opcode defs.
;  =================================================================
; #pragma mark -
; #pragma mark DCL OPCODES

(defconstant $kFWDCLImmediateEvent 0)
(defconstant $kFWDCLCycleEvent 1)
(defconstant $kFWDCLSyBitsEvent 2)

(defconstant $kFWDCLInvalidNotification 0)
(defconstant $kFWDCLUpdateNotification 1)
(defconstant $kFWDCLModifyNotification 2)
(defconstant $kFWNuDCLModifyNotification 3)
(defconstant $kFWNuDCLModifyJumpNotification 4)
(defconstant $kFWNuDCLUpdateNotification 5)
(def-mactype :IOFWDCLNotificationType (find-mactype ':SINT32))

(defconstant $kFWDCLOpDynamicFlag #x10000)
(defconstant $kFWDCLOpVendorDefinedFlag #x20000)
(defconstant $kFWDCLOpFlagMask #xFFFF0000)
(defconstant $kFWDCLOpFlagPhase 16)

(defconstant $kDCLInvalidOp 0)
(defconstant $kDCLSendPacketStartOp 1)
(defconstant $kDCLSendPacketWithHeaderStartOp 2)
(defconstant $kDCLSendPacketOp 3)
(defconstant $kDCLSendBufferOp 4)               ;  obsolete - do not use

(defconstant $kDCLReceivePacketStartOp 5)
(defconstant $kDCLReceivePacketOp 6)
(defconstant $kDCLReceiveBufferOp 7)            ;  obsolete - do not use

(defconstant $kDCLCallProcOp 8)
(defconstant $kDCLLabelOp 9)
(defconstant $kDCLJumpOp 10)
(defconstant $kDCLSetTagSyncBitsOp 11)
(defconstant $kDCLUpdateDCLListOp 12)
(defconstant $kDCLTimeStampOp 13)
(defconstant $kDCLPtrTimeStampOp 14)
(defconstant $kDCLSkipCycleOp 15)
(defconstant $kDCLNuDCLLeaderOp 20)             ;  compilerData field contains NuDCLRef to start of NuDCL
;  program.
;  Should not need to use this directly.

; #ifdef FW_OLD_DCL_DEFS
; typedef struct DCLCommandStruct ;
; typedef void (DCLCallCommandProc)(DCLCommandStruct* command);
#| 
; #else
; typedef struct DCLCommand ;
; typedef void (DCLCallCommandProc)(DCLCommand* command);
 |#

; #endif

;  =================================================================
;  DCL structs
;  =================================================================
; #pragma mark -
; #pragma mark DCL
(defrecord DCLCommandStruct
   (pNextDCLCommand (:pointer :dclcommandstruct))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (operands (:array :UInt32 1))
                                                ;  DCL operands (size varies)
)
(%define-record :DCLCommand (find-record-descriptor :DCLCOMMANDSTRUCT))

(def-mactype :DCLCallCommandProc (find-mactype ':void)); (DCLCommand * command)
(defrecord DCLTransferPacketStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (buffer :pointer)
                                                ;  Packet buffer.
   (size :UInt32)
                                                ;  Buffer size.
)
(%define-record :DCLTransferPacket (find-record-descriptor :DCLTRANSFERPACKETSTRUCT))
(defrecord DCLTransferBufferStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (buffer :pointer)
                                                ;  Buffer.
   (size :UInt32)
                                                ;  Buffer size.
   (packetSize :UInt16)
                                                ;  Size of packets to send.
   (reserved :UInt16)
   (bufferOffset :UInt32)
                                                ;  Current offset into buffer.
)
(%define-record :DCLTransferBuffer (find-record-descriptor :DCLTRANSFERBUFFERSTRUCT))
(defrecord DCLCallProcStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (proc (:pointer :DCLCALLCOMMANDPROC))
                                                ;  Procedure to call.
   (procData :UInt32)
                                                ;  Data for use by called procedure.
)
(%define-record :DCLCallProc (find-record-descriptor :DCLCALLPROCSTRUCT))
(defrecord DCLLabelStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
)
(%define-record :DCLLabel (find-record-descriptor :DCLLABELSTRUCT))
(defrecord DCLJumpStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (pJumpDCLLabel (:pointer :DCLLABEL))
                                                ;  DCL label to jump to.
)
(%define-record :DCLJump (find-record-descriptor :DCLJUMPSTRUCT))
(defrecord DCLSetTagSyncBitsStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (tagBits :UInt16)
                                                ;  Tag bits for following packets.
   (syncBits :UInt16)
                                                ;  Sync bits for following packets.
)
(%define-record :DCLSetTagSyncBits (find-record-descriptor :DCLSETTAGSYNCBITSSTRUCT))
(defrecord DCLUpdateDCLListStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (** (:pointer :callback))                    ;(DCLCommand dclCommandList)
                                                ;  List of DCL commands to update.
   (numDCLCommands :UInt32)
                                                ;  Number of DCL commands in list.
)
(%define-record :DCLUpdateDCLList (find-record-descriptor :DCLUPDATEDCLLISTSTRUCT))
(defrecord DCLTimeStampStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (timeStamp :UInt32)
                                                ;  Time stamp.
)
(%define-record :DCLTimeStamp (find-record-descriptor :DCLTIMESTAMPSTRUCT))
(defrecord DCLPtrTimeStampStruct
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  Next DCL command.
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  DCL opcode.
   (timeStampPtr (:pointer :UInt32))
                                                ;  Where to store the time stamp.
)
(%define-record :DCLPtrTimeStamp (find-record-descriptor :DCLPTRTIMESTAMPSTRUCT))
(defrecord DCLNuDCLLeader
   (pNextDCLCommand (:pointer :DCLCOMMAND))
                                                ;  unused - always NULL
   (compilerData :UInt32)
                                                ;  Data for use by DCL compiler.
   (opcode :UInt32)
                                                ;  must be kDCLNuDCLLeaderOp
   (program :pointer)
                                                ;  NuDCL program here...
)
; #ifdef FW_OLD_DCL_DEFS
;   should not use these...

(def-mactype :DCLCommandPtr (find-mactype '(:pointer :DCLCOMMANDSTRUCT)))

(def-mactype :DCLTransferBufferPtr (find-mactype '(:pointer :DCLTRANSFERBUFFERSTRUCT)))

(def-mactype :DCLTransferPacketPtr (find-mactype '(:pointer :DCLTRANSFERPACKETSTRUCT)))

(def-mactype :DCLCallProcPtr (find-mactype '(:pointer :DCLCALLPROCSTRUCT)))

(def-mactype :DCLLabelPtr (find-mactype '(:pointer :DCLLABELSTRUCT)))

(def-mactype :DCLJumpPtr (find-mactype '(:pointer :DCLJUMPSTRUCT)))

(def-mactype :DCLSetTagSyncBitsPtr (find-mactype '(:pointer :DCLSETTAGSYNCBITSSTRUCT)))

(def-mactype :DCLUpdateDCLListPtr (find-mactype '(:pointer :DCLUPDATEDCLLISTSTRUCT)))

(def-mactype :DCLTimeStampPtr (find-mactype '(:pointer :DCLTIMESTAMPSTRUCT)))

(def-mactype :DCLPtrTimeStampPtr (find-mactype '(:pointer :DCLPTRTIMESTAMPSTRUCT)))

(def-mactype :DCLCallCommandProcPtr (find-mactype '(:pointer :DCLCallCommandProc)))

; #endif

;  =================================================================
;  NuDCL
;  =================================================================
; #pragma mark -
; #pragma mark NUDCL

(def-mactype :NuDCLRef (find-mactype '(:pointer :__NuDCL)))

(def-mactype :NuDCLSendPacketRef (find-mactype ':NuDCLRef))

(def-mactype :NuDCLSkipCycleRef (find-mactype ':NuDCLRef))

(def-mactype :NuDCLReceivePacketRef (find-mactype ':NuDCLRef))

(def-mactype :NuDCLCallback (find-mactype ':pointer)); (void * refcon , NuDCLRef dcl)

(defconstant $kNuDCLDynamic 2)
(defconstant $kNuDCLUpdateBeforeCallback 4)
(def-mactype :NuDCLFlags (find-mactype ':SINT32))
;  =================================================================
;  Miscellaneous
;  =================================================================
; #pragma mark -
; #pragma mark MISCELLANEOUS

(def-mactype :FWClientCommandID (find-mactype '(:pointer :void)))

(def-mactype :IOFireWireSessionRef (find-mactype '(:pointer :IOFireWireSessionRefOpaqueStuct)))
; 
;  bus management constants.
; 

(defconstant $kFWBusManagerArbitrationTimeoutDuration #x271);  durationMillisecond

; 
;  bus characteristics.
; 

(defconstant $kFWMaxBusses #x3FF)
(defconstant $kFWMaxNodesPerBus 63)
(defconstant $kFWMaxNodeHops 16)
; 
;  node flags
; 

(defconstant $kIOFWDisablePhysicalAccess 1)
(defconstant $kIOFWDisableAllPhysicalAccess 2)
(defconstant $kIOFWEnableRetryOnAckD 4)
; 
;  write flags
; 
(def-mactype :IOFWWriteFlags (find-mactype ':sint32))

(defconstant $kIOFWWriteFlagsNone 0)
(defconstant $kIOFWWriteFlagsDeferredNotify 1)
; 
;  security modes
; 
(def-mactype :IOFWSecurityMode (find-mactype ':sint32))

(defconstant $kIOFWSecurityModeNormal 0)
(defconstant $kIOFWSecurityModeSecure 1)
(defconstant $kIOFWSecurityModeSecurePermanent 2)
; 
;  physical access settings
; 
(def-mactype :IOFWPhysicalAccessMode (find-mactype ':sint32))

(defconstant $kIOFWPhysicalAccessEnabled 0)
(defconstant $kIOFWPhysicalAccessDisabled 1)
(defconstant $kIOFWPhysicalAccessDisabledForGeneration 2)
;  old style bit defs
; #ifdef FW_OLD_BIT_DEFS
; #define kBit0	BIT(0)
; #define kBit1	BIT(1)
; #define kBit2	BIT(2)
; #define kBit3	BIT(3)
; #define kBit4	BIT(4)
; #define kBit5	BIT(5)
; #define kBit6	BIT(6)
; #define kBit7	BIT(7)
; #define kBit8	BIT(8)
; #define kBit9	BIT(9)
; #define kBit10	BIT(10)
; #define kBit11	BIT(11)
; #define kBit12	BIT(12)
; #define kBit13	BIT(13)
; #define kBit14	BIT(14)
; #define kBit15	BIT(15)
; #define kBit16	BIT(16)
; #define kBit17	BIT(17)
; #define kBit18	BIT(18)
; #define kBit19	BIT(19)
; #define kBit20	BIT(20)
; #define kBit21	BIT(21)
; #define kBit22	BIT(22)
; #define kBit23	BIT(23)
; #define kBit24	BIT(24)
; #define kBit25	BIT(25)
; #define kBit26	BIT(26)
; #define kBit27	BIT(27)
; #define kBit28	BIT(28)
; #define kBit29	BIT(29)
; #define kBit30	BIT(30)
; #define kBit31	BIT(31)

; #endif


; #endif //__IOFireWireFamilyCommon_H__


(provide-interface "IOFireWireFamilyCommon")