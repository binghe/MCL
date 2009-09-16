(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Bluetooth.h"
; at Sunday July 2,2006 7:27:08 pm.
; 
; 	File:		Bluetooth.h
; 	Contains:	Public interfaces for Bluetooth technology.
; 	Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 
; #pragma once
; #ifdef KERNEL
#| #|
#include <IOKitbluetoothBluetoothAssignedNumbers.h>
|#
 |#

; #else

(require-interface "CoreFoundation/CFBase")

(require-interface "IOBluetooth/BluetoothAssignedNumbers")

; #endif


(require-interface "IOKit/IOTypes")

(require-interface "libkern/OSByteOrder")
; ---------------------------------------------------------------------------------------------------------------------------
; !	@header		Bluetooth
; 	Bluetooth wireless technology
; 
; #ifdef	__cplusplus
#| #|
	extern "C" {
#endif
|#
 |#

; #if 0
#| ; #pragma mark ¥ Baseband ¥
 |#

; #endif

; ===========================================================================================================================
; 	Baseband
; ===========================================================================================================================

(def-mactype :BluetoothConnectionHandle (find-mactype ':UInt16))
;  Upper 4 bits are reserved.

(defconstant $kBluetoothConnectionHandleNone #xFFFF)

(def-mactype :BluetoothReasonCode (find-mactype ':UInt8))

(def-mactype :BluetoothEncryptionEnable (find-mactype ':UInt8))

(defconstant $kBluetoothEncryptionEnableOff 0)
(defconstant $kBluetoothEncryptionEnableOn 1)

(def-mactype :BluetoothKeyFlag (find-mactype ':UInt8))

(defconstant $kBluetoothKeyFlagSemiPermanent 0)
(defconstant $kBluetoothKeyFlagTemporary 1)

(def-mactype :BluetoothKeyType (find-mactype ':UInt8))

(defconstant $kBluetoothKeyTypeCombination 0)
(defconstant $kBluetoothKeyTypeLocalUnit 1)
(defconstant $kBluetoothKeyTypeRemoteUnit 2)
;  Packet types (Bluetooth spec section 4.3.5 Create Connection and 4.3.7 Add SCO Connection)

(def-mactype :BluetoothPacketType (find-mactype ':UInt16))

(defconstant $kBluetoothPacketTypeDM1 8)
(defconstant $kBluetoothPacketTypeDH1 16)
(defconstant $kBluetoothPacketTypeHV1 32)       ;  SCO only

(defconstant $kBluetoothPacketTypeHV2 64)       ;  SCO only

(defconstant $kBluetoothPacketTypeHV3 #x80)     ;  SCO only

(defconstant $kBluetoothPacketTypeDV #x100)     ;  SCO only

(defconstant $kBluetoothPacketTypeAUX #x200)
(defconstant $kBluetoothPacketTypeDM3 #x400)
(defconstant $kBluetoothPacketTypeDH3 #x800)
(defconstant $kBluetoothPacketTypeDM5 #x4000)
(defconstant $kBluetoothPacketTypeDH5 #x8000)   ;  All other values are reserved for future use.

(defconstant $kBluetoothPacketTypeEnd #x8001)
;  LAP/Inquiry Access Codes

(def-mactype :BluetoothLAP (find-mactype ':UInt32))

(defconstant $kBluetoothGeneralInquiryAccessCodeIndex 0);  General/Unlimited Inquiry Access Code (GIAC)

(defconstant $kBluetoothGeneralInquiryAccessCodeLAPValue #x9E8B33);  General/Unlimited Inquiry Access Code (GIAC)

(defconstant $kBluetoothLimitedInquiryAccessCodeIndex 1);  Limited Dedicated Inquiry Access Code (LIAC)

(defconstant $kBluetoothLimitedInquiryAccessCodeLAPValue #x9E8B00);  Limited Dedicated Inquiry Access Code (LIAC)
;  All other access codes are reserved for future use (indices 2-63, LAP values 0x9E8B01-0x9E8B32 and 0x9E8B34-0x9E8B3F).

(defconstant $kBluetoothLimitedInquiryAccessCodeEnd #x9E8B01)
;  PageScanRepetitionMode

(def-mactype :BluetoothPageScanRepetitionMode (find-mactype ':UInt8))

(defconstant $kBluetoothPageScanRepetitionModeR0 0)
(defconstant $kBluetoothPageScanRepetitionModeR1 1)
(defconstant $kBluetoothPageScanRepetitionModeR2 2);  All other values are reserved for future use.

;  PageScanPeriodMode

(def-mactype :BluetoothPageScanPeriodMode (find-mactype ':UInt8))

(defconstant $kBluetoothPageScanPeriodModeP0 0)
(defconstant $kBluetoothPageScanPeriodModeP1 1)
(defconstant $kBluetoothPageScanPeriodModeP2 2) ;  All other values are reserved for future use.

;  PageScanMode

(def-mactype :BluetoothPageScanMode (find-mactype ':UInt8))

(defconstant $kBluetoothPageScanModeMandatory 0)
(defconstant $kBluetoothPageScanModeOptional1 1)
(defconstant $kBluetoothPageScanModeOptional2 2)
(defconstant $kBluetoothPageScanModeOptional3 3);  All other values are reserved for future use.


; #if 0
#| ; #pragma mark -
; #pragma mark ¥ Devices ¥
 |#

; #endif


;type name? (def-mactype :BluetoothDeviceAddress (find-mactype ':BluetoothDeviceAddress))
(defrecord BluetoothDeviceAddress
   (data (:array :UInt8 6))
)

;type name? (def-mactype :BluetoothKey (find-mactype ':BluetoothKey))
(defrecord BluetoothKey
   (data (:array :UInt8 16))
)

;type name? (def-mactype :BluetoothPINCode (find-mactype ':BluetoothPINCode))
(defrecord BluetoothPINCode
   (data (:array :UInt8 16))
                                                ;  PIN codes may be up to 128 bits.
)
; 	Physical layout of the "class of device/service" field (see Bluetooth Assigned Numbers section 1.2):
; 
; 	 2 2 2 2 1 1 1 1 1 1 1 1 1 1
; 	 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0  <- Bit Transmission Order
; 	+---------------+---------------+---------------+
; 	|    octet 3    |    octet 2    |    octet 1    | <- Octet Transmission Order
; 	+---------------+---------------+---------------+
; 	<------ 11 bits ----->< 5 bits ><- 6 bits ->
; 	+---------------------+---------+-----------+-+-+
; 	|   Service Classes   | Major   |  Minor    | | |
; 	+-+-+-+-+-+-+-+-+-+-+-+  Device |   Device  |0|0|
; 	| | | | | | | |*|*|*| |   Class |    Class  | | |
; 	+-+-+-+-+-+-+-+-+-+-+-+---------+-----------+-+-+
; 	 | | | | | | |       |                        |
;    | | | | | | |       + Limited Discoverable   +- Format Type
; 	 | | | | | | +- Networking
; 	 | | | | | +- Rendering
; 	 | | | | +- Capturing
; 	 | | | +- Object Transfer
; 	 | | +- Audio
; 	 | +- Telephony
; 	 +- Information

(def-mactype :BluetoothClassOfDevice (find-mactype ':UInt32))
; #define		BluetoothGetDeviceClassMajor( inCOD )		( (inCOD & 0x00001F00) >> 8 )
; #define		BluetoothGetDeviceClassMinor( inCOD )		( (inCOD & 0x000000FC) >> 2 )
; #define		BluetoothGetServiceClassMajor( inCOD )		( (inCOD & 0x00FFE000) >> 13 )
; #define		BluetoothMakeClassOfDevice( inServiceClassMajor, inDeviceClassMajor, inDeviceClassMinor )												(((inServiceClassMajor << 13) & 0x00FFE000) | ((inDeviceClassMajor << 8) & 0x00001F00) | ((inDeviceClassMinor << 2) & 0x000000FC))
; /
; / Major Service Classes (11-bit value - bits 13-23 of Device/Service field)
; /

(def-mactype :BluetoothServiceClassMajor (find-mactype ':UInt32))
;  Service Class Major enum in BluetoothAssignedNumbers.h
; /
; / Major Device Classes (5-bit value - bits 8-12 of Device/Service field)
; /

(def-mactype :BluetoothDeviceClassMajor (find-mactype ':UInt32))
;  Device Class Major enum in BluetoothAssignedNumbers.h
; /
; / Minor Device Classes (6-bit value - bits 2-7 of Device/Service field)
; /

(def-mactype :BluetoothDeviceClassMinor (find-mactype ':UInt32))
;  Device Class Minor enum in BluetoothAssignedNumbers.h
;  Misc Device Types

(defconstant $kBluetoothDeviceNameMaxLength #xF8)
(defrecord BluetoothDeviceName
   (contents (:array :UInt8 256))
)                                               ;  Max 248 bytes of UTF-8 encoded Unicode.

(def-mactype :BluetoothClockOffset (find-mactype ':UInt16))
;  Bits 14-0 come from bits 16-2 of CLKslav-CLKmaster.

(def-mactype :BluetoothRole (find-mactype ':UInt8))
;  

(def-mactype :BluetoothAllowRoleSwitch (find-mactype ':UInt8))
;  0x00-0x01 valid, 0x02-0xFF reserved.

(defconstant $kBluetoothDontAllowRoleSwitch 0)
(defconstant $kBluetoothAllowRoleSwitch 1)

(defconstant $kBluetoothRoleBecomeMaster 0)
(defconstant $kBluetoothRoleRemainSlave 1)

;type name? (def-mactype :BluetoothSetEventMask (find-mactype ':BluetoothSetEventMask))
(defrecord BluetoothSetEventMask
   (data (:array :UInt8 8))
)

(def-mactype :BluetoothPINType (find-mactype ':UInt8))

; #if 0
#| ; #pragma mark -
; #pragma mark ¥ L2CAP ¥
 |#

; #endif

; ===========================================================================================================================
; 	Logical Link Control and Adaptation Protocol (L2CAP)
; ===========================================================================================================================
;  ACL Packet values (Bluetooth L2CAP spec section 1).

(defconstant $kBluetoothL2CAPMaxPacketSize #xFFFF);  Max number of data bytes in an L2CAP packet.

(defconstant $kBluetoothACLLogicalChannelReserved 0);  [00] Reserved for future use

(defconstant $kBluetoothACLLogicalChannelL2CAPContinue 1);  [01] Continuation of L2CAP packet.

(defconstant $kBluetoothACLLogicalChannelL2CAPStart 2);  [10] Start of L2CAP packet.

(defconstant $kBluetoothACLLogicalChannelLMP 3) ;  [11] Link Manager Protocol packet.

;  Channel Identifiers (Bluetooth L2CAP spec section 2.1).

(def-mactype :BluetoothL2CAPChannelID (find-mactype ':UInt16))

(defconstant $kBluetoothL2CAPChannelNull 0)     ;  Illegal, should not be used

(defconstant $kBluetoothL2CAPChannelSignalling 1);  L2CAP signalling channel

(defconstant $kBluetoothL2CAPChannelConnectionLessData 2);  L2CA connection less data
;  Range 0x0003 to 0x003F reserved for future use.

(defconstant $kBluetoothL2CAPChannelReservedStart 3)
(defconstant $kBluetoothL2CAPChannelReservedEnd 63);  Range 0x0040 to 0xFFFF are dynamically allocated.

(defconstant $kBluetoothL2CAPChannelDynamicStart 64)
(defconstant $kBluetoothL2CAPChannelDynamicEnd #xFFFF)
(defconstant $kBluetoothL2CAPChannelEnd #xFFFF)

(def-mactype :BluetoothL2CAPGroupID (find-mactype ':UInt16))
;  Protocol/Service Multiplexor (PSM) values (Bluetooth L2CAP spec section 5.2).

(def-mactype :BluetoothL2CAPPSM (find-mactype ':UInt16))
;  PSM enum in BluetoothAssignedNumbers.h
;  Command Codes

(defconstant $kBluetoothL2CAPCommandCodeReserved 0)
(defconstant $kBluetoothL2CAPCommandCodeCommandReject 1)
(defconstant $kBluetoothL2CAPCommandCodeConnectionRequest 2)
(defconstant $kBluetoothL2CAPCommandCodeConnectionResponse 3)
(defconstant $kBluetoothL2CAPCommandCodeConfigureRequest 4)
(defconstant $kBluetoothL2CAPCommandCodeConfigureResponse 5)
(defconstant $kBluetoothL2CAPCommandCodeDisconnectionRequest 6)
(defconstant $kBluetoothL2CAPCommandCodeDisconnectionResponse 7)
(defconstant $kBluetoothL2CAPCommandCodeEchoRequest 8)
(defconstant $kBluetoothL2CAPCommandCodeEchoResponse 9)
(defconstant $kBluetoothL2CAPCommandCodeInformationRequest 10)
(defconstant $kBluetoothL2CAPCommandCodeInformationResponse 11)
(def-mactype :BluetoothL2CAPCommandCode (find-mactype ':SINT32))
;  Command Reject

(defconstant $kBluetoothL2CAPCommandRejectReasonCommandNotUnderstood 0)
(defconstant $kBluetoothL2CAPCommandRejectReasonSignallingMTUExceeded 1)
(defconstant $kBluetoothL2CAPCommandRejectReasonInvalidCIDInRequest 2)
(def-mactype :BluetoothL2CAPCommandRejectReason (find-mactype ':SINT32))

(def-mactype :BluetoothL2CAPMTU (find-mactype ':UInt16))

(def-mactype :BluetoothL2CAPLinkTimeout (find-mactype ':UInt16))

(def-mactype :BluetoothL2CAPFlushTimeout (find-mactype ':UInt16))

(defconstant $kBluetoothL2CAPFlushTimeoutUseExisting 0)
(defconstant $kBluetoothL2CAPFlushTimeoutImmediate 1)
(defconstant $kBluetoothL2CAPFlushTimeoutForever #xFFFF)
(defconstant $kBluetoothL2CAPFlushTimeoutEnd #x10000)

;type name? (def-mactype :BluetoothL2CAPQualityOfServiceOptions (find-mactype ':BluetoothL2CAPQualityOfServiceOptions))
(defrecord BluetoothL2CAPQualityOfServiceOptions
   (flags :UInt8)
   (serviceType :UInt8)
   (tokenRate :UInt32)
   (tokenBucketSize :UInt32)
   (peakBandwidth :UInt32)
   (latency :UInt32)
   (delayVariation :UInt32)
)

(defconstant $kBluetoothL2CAPInfoTypeMaxConnectionlessMTUSize 1)
;  Packets

(defconstant $kBluetoothL2CAPPacketHeaderSize 4)

(def-mactype :BluetoothL2CAPByteCount (find-mactype ':UInt16))

(def-mactype :BluetoothL2CAPCommandID (find-mactype ':UInt8))

(def-mactype :BluetoothL2CAPCommandByteCount (find-mactype ':UInt16))

(defconstant $kBluetoothL2CAPConnectionResultSuccessful 0)
(defconstant $kBluetoothL2CAPConnectionResultPending 1)
(defconstant $kBluetoothL2CAPConnectionResultRefusedPSMNotSupported 2)
(defconstant $kBluetoothL2CAPConnectionResultRefusedSecurityBlock 3)
(defconstant $kBluetoothL2CAPConnectionResultRefusedNoResources 4)
(def-mactype :BluetoothL2CAPConnectionResult (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPConnectionStatusNoInfoAvailable 0)
(defconstant $kBluetoothL2CAPConnectionStatusAuthenticationPending 1)
(defconstant $kBluetoothL2CAPConnectionStatusAuthorizationPending 2)
(def-mactype :BluetoothL2CAPConnectionStatus (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPConfigurationResultSuccess 0)
(defconstant $kBluetoothL2CAPConfigurationResultUnacceptableParams 1)
(defconstant $kBluetoothL2CAPConfigurationResultRejected 2)
(defconstant $kBluetoothL2CAPConfigurationResultUnknownOptions 3)
(def-mactype :BluetoothL2CAPConfigurationResult (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPConfigurationOptionMTU 1)
(defconstant $kBluetoothL2CAPConfigurationOptionFlushTimeout 2)
(defconstant $kBluetoothL2CAPConfigurationOptionQoS 3)
(def-mactype :BluetoothL2CAPConfigurationOption (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPConfigurationOptionMTULength 2)
(defconstant $kBluetoothL2CAPConfigurationOptionFlushTimeoutLength 2)
(defconstant $kBluetoothL2CAPConfigurationOptionQoSLength 22)

(defconstant $kBluetoothL2CAPInformationTypeConnectionlessMTU 1)
(def-mactype :BluetoothL2CAPInformationType (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPInformationResultSuccess 0)
(defconstant $kBluetoothL2CAPInformationResultNotSupported 1)
(def-mactype :BluetoothL2CAPInformationResult (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPQoSTypeNoTraffic 0)
(defconstant $kBluetoothL2CAPQoSTypeBestEffort 1)
(defconstant $kBluetoothL2CAPQoSTypeGuaranteed 2)
(def-mactype :BluetoothL2CAPQoSType (find-mactype ':SINT32))

(defconstant $kBluetoothL2CAPMTUMinimum 48)     ;  48 bytes

(defconstant $kBluetoothL2CAPMTUDefault #x2A0)  ;  672 bytes

(defconstant $kBluetoothL2CAPMTUMaximum #xFFFF)
(defconstant $kBluetoothL2CAPMTUStart #x7FFF)
(defconstant $kBluetoothL2CAPMTUSIG 48)         ;  48 bytes

(defconstant $kBluetoothL2CAPFlushTimeoutDefault #xFFFF);  0xffff

(defconstant $kBluetoothL2CAPQoSFlagsDefault 0)
(defconstant $kBluetoothL2CAPQoSTypeDefault 1)  ;  0x01

(defconstant $kBluetoothL2CAPQoSTokenRateDefault 0)
(defconstant $kBluetoothL2CAPQoSTokenBucketSizeDefault 0)
(defconstant $kBluetoothL2CAPQoSPeakBandwidthDefault 0)
(defconstant $kBluetoothL2CAPQoSLatencyDefault #xFFFFFFFF)
(defconstant $kBluetoothL2CAPQoSDelayVariationDefault #xFFFFFFFF)

; #if 0
#| ; #pragma mark -
; #pragma mark ¥ HCI ¥
 |#

; #endif

; ===========================================================================================================================
; 	Host Controller Interface (HCI)
; ===========================================================================================================================
; 	HCI Command Packet
; 	------------------
; 	
; 	                     1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
; 	 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
; 	+--------------------------------+---------------+--------------+
; 	|            OpCode              |               |              |
; 	+--------------------+-----------| Param Length  |  Params...   |
; 	|         OCF        |    OGF    |               |              |
; 	+--------------------+-----------+---------------+--------------+
; 	|                                                               |
; 	|                         Params...                             |
; 	|                                                               |
; 	+---------------------------------------------------------------+
;  Commands

(def-mactype :BluetoothHCICommandOpCodeGroup (find-mactype ':UInt8))

(def-mactype :BluetoothHCICommandOpCodeCommand (find-mactype ':UInt16))

(def-mactype :BluetoothHCICommandOpCode (find-mactype ':UInt16))

(def-mactype :BluetoothHCIVendorCommandSelector (find-mactype ':UInt32))
; #define	BluetoothHCIMakeCommandOpCode( GROUP, CMD )				( ( ( ( GROUP ) & 0x003F ) << 10 ) | ( ( CMD ) & 0x03FF ) )
; #define	BluetoothHCIMakeCommandOpCodeEndianSwap( GROUP, CMD )	( ( ( ( ( GROUP ) & 0x003F ) << 10 ) >> 8) | ( ( ( CMD ) & 0x03FF ) << 8 ) )
; #define	BluetoothHCIExtractCommandOpCodeGroup( OPCODE )			( ( ( OPCODE ) >> 10 ) & 0x003F )
; #define	BluetoothHCIExtractCommandOpCodeCommand( OPCODE )		( ( OPCODE ) & 0x03FF )
; #define BluetoothHCIMakeCommandOpCodeHostOrder(GROUP, CMD )	OSSwapLittleToHostConstInt16( ( ( ( GROUP ) & 0x003F ) << 10 ) | ( ( CMD ) & 0x03FF ) )
;  Command Group: NoOp

(defconstant $kBluetoothHCIOpCodeNoOp 0)
(defconstant $kBluetoothHCICommandGroupNoOp 0)
(defconstant $kBluetoothHCICommandNoOp 0)       ;  Command Group: Link Control

(defconstant $kBluetoothHCICommandGroupLinkControl 1)
(defconstant $kBluetoothHCICommandInquiry 1)
(defconstant $kBluetoothHCICommandInquiryCancel 2)
(defconstant $kBluetoothHCICommandPeriodicInquiryMode 3)
(defconstant $kBluetoothHCICommandExitPeriodicInquiryMode 4)
(defconstant $kBluetoothHCICommandCreateConnection 5)
(defconstant $kBluetoothHCICommandDisconnect 6)
(defconstant $kBluetoothHCICommandAddSCOConnection 7)
(defconstant $kBluetoothHCICommandAcceptConnectionRequest 9)
(defconstant $kBluetoothHCICommandRejectConnectionRequest 10)
(defconstant $kBluetoothHCICommandLinkKeyRequestReply 11)
(defconstant $kBluetoothHCICommandLinkKeyRequestNegativeReply 12)
(defconstant $kBluetoothHCICommandPINCodeRequestReply 13)
(defconstant $kBluetoothHCICommandPINCodeRequestNegativeReply 14)
(defconstant $kBluetoothHCICommandChangeConnectionPacketType 15)
(defconstant $kBluetoothHCICommandAuthenticationRequested 17)
(defconstant $kBluetoothHCICommandSetConnectionEncryption 19)
(defconstant $kBluetoothHCICommandChangeConnectionLinkKey 21)
(defconstant $kBluetoothHCICommandMasterLinkKey 23)
(defconstant $kBluetoothHCICommandRemoteNameRequest 25)
(defconstant $kBluetoothHCICommandReadRemoteSupportedFeatures 27)
(defconstant $kBluetoothHCICommandReadRemoteVersionInformation 29)
(defconstant $kBluetoothHCICommandReadClockOffset 31);  Command Group: Link Policy

(defconstant $kBluetoothHCICommandGroupLinkPolicy 2)
(defconstant $kBluetoothHCICommandHoldMode 1)
(defconstant $kBluetoothHCICommandSniffMode 3)
(defconstant $kBluetoothHCICommandExitSniffMode 4)
(defconstant $kBluetoothHCICommandParkMode 5)
(defconstant $kBluetoothHCICommandExitParkMode 6)
(defconstant $kBluetoothHCICommandQoSSetup 7)
(defconstant $kBluetoothHCICommandRoleDiscovery 9)
(defconstant $kBluetoothHCICommandSwitchRole 11)
(defconstant $kBluetoothHCICommandReadLinkPolicySettings 12)
(defconstant $kBluetoothHCICommandWriteLinkPolicySettings 13);  Command Group: Host Controller & Baseband

(defconstant $kBluetoothHCICommandGroupHostController 3)
(defconstant $kBluetoothHCICommandSetEventMask 1)
(defconstant $kBluetoothHCICommandReset 3)
(defconstant $kBluetoothHCICommandSetEventFilter 5)
(defconstant $kBluetoothHCICommandFlush 8)
(defconstant $kBluetoothHCICommandReadPINType 9)
(defconstant $kBluetoothHCICommandWritePINType 10)
(defconstant $kBluetoothHCICommandCreateNewUnitKey 11)
(defconstant $kBluetoothHCICommandReadStoredLinkKey 13)
(defconstant $kBluetoothHCICommandWriteStoredLinkKey 17)
(defconstant $kBluetoothHCICommandDeleteStoredLinkKey 18)
(defconstant $kBluetoothHCICommandChangeLocalName 19)
(defconstant $kBluetoothHCICommandReadLocalName 20)
(defconstant $kBluetoothHCICommandReadConnectionAcceptTimeout 21)
(defconstant $kBluetoothHCICommandWriteConnectionAcceptTimeout 22)
(defconstant $kBluetoothHCICommandReadPageTimeout 23)
(defconstant $kBluetoothHCICommandWritePageTimeout 24)
(defconstant $kBluetoothHCICommandReadScanEnable 25)
(defconstant $kBluetoothHCICommandWriteScanEnable 26)
(defconstant $kBluetoothHCICommandReadPageScanActivity 27)
(defconstant $kBluetoothHCICommandWritePageScanActivity 28)
(defconstant $kBluetoothHCICommandReadInquiryScanActivity 29)
(defconstant $kBluetoothHCICommandWriteInquiryScanActivity 30)
(defconstant $kBluetoothHCICommandReadAuthenticationEnable 31)
(defconstant $kBluetoothHCICommandWriteAuthenticationEnable 32)
(defconstant $kBluetoothHCICommandReadEncryptionMode 33)
(defconstant $kBluetoothHCICommandWriteEncryptionMode 34)
(defconstant $kBluetoothHCICommandReadClassOfDevice 35)
(defconstant $kBluetoothHCICommandWriteClassOfDevice 36)
(defconstant $kBluetoothHCICommandReadVoiceSetting 37)
(defconstant $kBluetoothHCICommandWriteVoiceSetting 38)
(defconstant $kBluetoothHCICommandReadAutomaticFlushTimeout 39)
(defconstant $kBluetoothHCICommandWriteAutomaticFlushTimeout 40)
(defconstant $kBluetoothHCICommandReadNumberOfBroadcastRetransmissions 41)
(defconstant $kBluetoothHCICommandWriteNumberOfBroadcastRetransmissions 42)
(defconstant $kBluetoothHCICommandReadHoldModeActivity 43)
(defconstant $kBluetoothHCICommandWriteHoldModeActivity 44)
(defconstant $kBluetoothHCICommandReadTransmitPowerLevel 45)
(defconstant $kBluetoothHCICommandReadSCOFlowControlEnable 46)
(defconstant $kBluetoothHCICommandWriteSCOFlowControlEnable 47)
(defconstant $kBluetoothHCICommandSetHostControllerToHostFlowControl 49)
(defconstant $kBluetoothHCICommandHostBufferSize 51)
(defconstant $kBluetoothHCICommandHostNumberOfCompletedPackets 53)
(defconstant $kBluetoothHCICommandReadLinkSupervisionTimeout 54)
(defconstant $kBluetoothHCICommandWriteLinkSupervisionTimeout 55)
(defconstant $kBluetoothHCICommandReadNumberOfSupportedIAC 56)
(defconstant $kBluetoothHCICommandReadCurrentIACLAP 57)
(defconstant $kBluetoothHCICommandWriteCurrentIACLAP 58)
(defconstant $kBluetoothHCICommandReadPageScanPeriodMode 59)
(defconstant $kBluetoothHCICommandWritePageScanPeriodMode 60)
(defconstant $kBluetoothHCICommandReadPageScanMode 61)
(defconstant $kBluetoothHCICommandWritePageScanMode 62);  Command Group: Informational

(defconstant $kBluetoothHCICommandGroupInformational 4)
(defconstant $kBluetoothHCICommandReadLocalVersionInformation 1)
(defconstant $kBluetoothHCICommandReadLocalSupportedFeatures 3)
(defconstant $kBluetoothHCICommandReadBufferSize 5)
(defconstant $kBluetoothHCICommandReadCountryCode 7)
(defconstant $kBluetoothHCICommandReadDeviceAddress 9);  Command Group: Status

(defconstant $kBluetoothHCICommandGroupStatus 5)
(defconstant $kBluetoothHCICommandReadFailedContactCounter 1)
(defconstant $kBluetoothHCICommandResetFailedContactCounter 2)
(defconstant $kBluetoothHCICommandGetLinkQuality 3)
(defconstant $kBluetoothHCICommandReadRSSI 5)   ;  Command Group: Testing

(defconstant $kBluetoothHCICommandGroupTesting 6)
(defconstant $kBluetoothHCICommandReadLoopbackMode 1)
(defconstant $kBluetoothHCICommandWriteLoopbackMode 2)
(defconstant $kBluetoothHCICommandEnableDeviceUnderTestMode 3);  Command Group: Logo Testing (no commands yet)

(defconstant $kBluetoothHCICommandGroupLogoTesting 62);  Command Group: Vendor Specific (from Broadcom HCI Programmer's Reference Guide)

(defconstant $kBluetoothHCICommandGroupVendorSpecific 63)
(defconstant $kBluetoothHCICommandWriteDeviceAddress 1)
(defconstant $kBluetoothHCICommandWriteHoppingChannels 18)
(defconstant $kBluetoothHCICommandInvalidateFlashAndReboot 23)
(defconstant $kBluetoothHCICommandGroupMax 64)
(defconstant $kBluetoothHCICommandMax #x3FF)
;  HCI Data Types

(def-mactype :BluetoothHCIQoSFlags (find-mactype ':UInt8))

(def-mactype :BluetoothHCIParamByteCount (find-mactype ':UInt8))

(def-mactype :BluetoothHCIACLDataByteCount (find-mactype ':UInt16))

(def-mactype :BluetoothHCISCODataByteCount (find-mactype ':UInt8))

(def-mactype :BluetoothHCIInquiryLength (find-mactype ':UInt8))

(def-mactype :BluetoothHCIResponseCount (find-mactype ':UInt8))

(def-mactype :BluetoothHCICountryCode (find-mactype ':UInt8))

(def-mactype :BluetoothHCIModeInterval (find-mactype ':UInt16))

(def-mactype :BluetoothHCISniffAttemptCount (find-mactype ':UInt16))

(def-mactype :BluetoothHCISniffTimeout (find-mactype ':UInt16))

(def-mactype :BluetoothHCIParkModeBeaconInterval (find-mactype ':UInt16))

(def-mactype :BluetoothMaxSlots (find-mactype ':UInt8))

(def-mactype :BluetoothManufacturerName (find-mactype ':UInt16))

(def-mactype :BluetoothLMPVersion (find-mactype ':UInt8))

(def-mactype :BluetoothLMPSubversion (find-mactype ':UInt16))

(def-mactype :BluetoothHCIConnectionMode (find-mactype ':UInt8))
(def-mactype :BluetoothHCIConnectionModes (find-mactype ':sint32))

(defconstant $kConnectionActiveMode 0)
(defconstant $kConnectionHoldMode 1)
(defconstant $kConnectionSniffMode 2)
(defconstant $kConnectionParkMode 3)
(defconstant $kConnectionModeReservedForFutureUse 4)
;type name? (def-mactype :BluetoothHCISupportedFeatures (find-mactype ':BluetoothHCISupportedFeatures))
(defrecord BluetoothHCISupportedFeatures
   (data (:array :UInt8 8))
)
(def-mactype :BluetoothFeatureBits (find-mactype ':sint32))
;  Byte 8 of the support features data structure.

(defconstant $kBluetoothFeatureThreeSlotPackets 1)
(defconstant $kBluetoothFeatureFiveSlotPackets 2)
(defconstant $kBluetoothFeatureEncryption 4)
(defconstant $kBluetoothFeatureSlotOffset 8)
(defconstant $kBluetoothFeatureTimingAccuracy 16)
(defconstant $kBluetoothFeatureSwitchRoles 32)
(defconstant $kBluetoothFeatureHoldMode 64)
(defconstant $kBluetoothFeatureSniffMode #x80)  ;  Byte 7 of the support features data structure.

(defconstant $kBluetoothFeatureParkMode 1)
(defconstant $kBluetoothFeatureRSSI 2)
(defconstant $kBluetoothFeatureChannelQuality 4)
(defconstant $kBluetoothFeatureSCOLink 8)
(defconstant $kBluetoothFeatureHV2Packets 16)
(defconstant $kBluetoothFeatureHV3Packets 32)
(defconstant $kBluetoothFeatureULawLog 64)
(defconstant $kBluetoothFeatureALawLog #x80)    ;  Byte 6 of the support features data structure.

(defconstant $kBluetoothFeatureCVSD 1)
(defconstant $kBluetoothFeaturePagingScheme 2)
(defconstant $kBluetoothFeaturePowerControl 4)
(defconstant $kBluetoothFeatureTransparentSCOData 8)
(defconstant $kBluetoothFeatureFlowControlLagBit0 16)
(defconstant $kBluetoothFeatureFlowControlLagBit1 32)
(defconstant $kBluetoothFeatureFlowControlLagBit2 64)
(defconstant $kBluetoothFeatureBroadcastEncryption #x80);  Byte 5 of the support features data structure.	

(defconstant $kBluetoothFeatureScatterMode 1)
(defconstant $kBluetoothFeatureReserved1 2)
(defconstant $kBluetoothFeatureReserved2 4)
(defconstant $kBluetoothFeatureEnhancedInquiryScan 8)
(defconstant $kBluetoothFeatureInterlacedInquiryScan 16)
(defconstant $kBluetoothFeatureInterlacedPageScan 32)
(defconstant $kBluetoothFeatureRSSIWithInquiryResult 64)
(defconstant $kBluetoothFeatureExtendedSCOLink #x80);  Byte 4 of the support features data structure.	

(defconstant $kBluetoothFeatureEV4Packets 1)
(defconstant $kBluetoothFeatureEV5Packets 2)
(defconstant $kBluetoothFeatureAbsenceMasks 4)
(defconstant $kBluetoothFeatureAFHCapableSlave 8)
(defconstant $kBluetoothFeatureAFHClassificationSlave 16)
(defconstant $kBluetoothFeatureAliasAuhentication 32)
(defconstant $kBluetoothFeatureAnonymityMode 64);  Byte 3 of the support features data structure.	

(defconstant $kBluetoothFeatureAFHCapableMaster 8)
(defconstant $kBluetoothFeatureAFHClassificationMaster 16)

(def-mactype :BluetoothHCIFailedContactCount (find-mactype ':UInt16))

;type name? (def-mactype :BluetoothHCIFailedContactInfo (find-mactype ':BluetoothHCIFailedContactInfo))
(defrecord BluetoothHCIFailedContactInfo
   (count :UInt16)
   (handle :UInt16)
)

(def-mactype :BluetoothHCIRSSIValue (find-mactype ':UInt8))

;type name? (def-mactype :BluetoothHCIRSSIInfo (find-mactype ':BluetoothHCIRSSIInfo))
(defrecord BluetoothHCIRSSIInfo
   (handle :UInt16)
   (RSSIValue :UInt8)
)

(def-mactype :BluetoothHCILinkQuality (find-mactype ':UInt8))

;type name? (def-mactype :BluetoothHCILinkQualityInfo (find-mactype ':BluetoothHCILinkQualityInfo))
(defrecord BluetoothHCILinkQualityInfo
   (handle :UInt16)
   (qualityValue :UInt8)
)

(def-mactype :BluetoothHCIRole (find-mactype ':UInt8))

;type name? (def-mactype :BluetoothHCIRoleInfo (find-mactype ':BluetoothHCIRoleInfo))
(defrecord BluetoothHCIRoleInfo
   (role :UInt8)
   (handle :UInt16)
)
(def-mactype :BluetoothHCIRoles (find-mactype ':sint32))

(defconstant $kBluetoothHCIMasterRole 0)
(defconstant $kBluetoothHCISlaveRole 1)

(def-mactype :BluetoothHCILinkPolicySettings (find-mactype ':UInt16))
(def-mactype :BluetoothHCILinkPolicySettingsValues (find-mactype ':sint32))

(defconstant $kDisableAllLMModes 0)
(defconstant $kEnableMasterSlaveSwitch 1)
(defconstant $kEnableHoldMode 2)
(defconstant $kEnableSniffMode 4)
(defconstant $kEnableParkMode 8)
(defconstant $kReservedForFutureUse 16)

;type name? (def-mactype :BluetoothHCILinkPolicySettingsInfo (find-mactype ':BluetoothHCILinkPolicySettingsInfo))
(defrecord BluetoothHCILinkPolicySettingsInfo
   (settings :UInt16)
   (handle :UInt16)
)

;type name? (def-mactype :BluetoothHCIQualityOfServiceSetupParams (find-mactype ':BluetoothHCIQualityOfServiceSetupParams))
(defrecord BluetoothHCIQualityOfServiceSetupParams
   (flags :UInt8)
   (serviceType :UInt8)
   (tokenRate :UInt32)
   (peakBandwidth :UInt32)
   (latency :UInt32)
   (delayVariation :UInt32)
)

(def-mactype :BluetoothHCILoopbackMode (find-mactype ':UInt8))

(defconstant $kBluetoothHCILoopbackModeOff 0)
(defconstant $kBluetoothHCILoopbackModeLocal 1)
(defconstant $kBluetoothHCILoopbackModeRemote 2)

(def-mactype :BluetoothHCIOperationID (find-mactype '(:pointer :OpaqueBluetoothHCIOperationID)))

(def-mactype :BluetoothHCIEventID (find-mactype ':BluetoothHCIOperationID))

(def-mactype :BluetoothHCIDataID (find-mactype ':BluetoothHCIOperationID))

(def-mactype :BluetoothHCISignalID (find-mactype ':BluetoothHCIOperationID))

(def-mactype :BluetoothHCITransportID (find-mactype '(:pointer :OpaqueBluetoothHCITransportID)))

(def-mactype :BluetoothHCITransportCommandID (find-mactype '(:pointer :OpaqueBluetoothHCITransportCommandID)))

(def-mactype :BluetoothHCIRequestID (find-mactype '(:pointer :OpaqueBluetoothHCIRequestID)))
;  Version Information

;type name? (def-mactype :BluetoothHCIVersionInfo (find-mactype ':BluetoothHCIVersionInfo))
(defrecord BluetoothHCIVersionInfo
                                                ;  Local & Remote information
   (manufacturerName :UInt16)
   (lmpVersion :UInt8)
   (lmpSubVersion :UInt16)
                                                ;  Local information only
   (hciVersion :UInt8)
   (hciRevision :UInt16)
)
;  HCI buffer sizes.

;type name? (def-mactype :BluetoothHCIBufferSize (find-mactype ':BluetoothHCIBufferSize))
(defrecord BluetoothHCIBufferSize
   (ACLDataPacketLength :UInt16)
   (SCODataPacketLength :UInt8)
   (totalNumACLDataPackets :UInt16)
   (totalNumSCODataPackets :UInt16)
)
;  Timeouts

(def-mactype :BluetoothHCIConnectionAcceptTimeout (find-mactype ':UInt16))

(def-mactype :BluetoothHCIPageTimeout (find-mactype ':UInt16))
(def-mactype :BluetoothHCITimeoutValues (find-mactype ':sint32))

(defconstant $kDefaultPageTimeout #x2000)
; #define		BluetoothGetSlotsFromSeconds( inSeconds )		( (inSeconds/.000625 ) )
;  Link Keys

(def-mactype :BluetoothHCINumLinkKeysDeleted (find-mactype ':UInt16))

(def-mactype :BluetoothHCINumLinkKeysToWrite (find-mactype ':UInt8))

(def-mactype :BluetoothHCIDeleteStoredLinkKeyFlag (find-mactype ':UInt8))
(def-mactype :BluetoothHCIDeleteStoredLinkKeyFlags (find-mactype ':sint32))

(defconstant $kDeleteKeyForSpecifiedDeviceOnly 0)
(defconstant $kDeleteAllStoredLinkKeys 1)
(def-mactype :BluetoothHCIReadStoredLinkKeysFlag (find-mactype ':UInt8))
(def-mactype :BluetoothHCIReadStoredLinkKeysFlags (find-mactype ':sint32))

(defconstant $kReturnLinkKeyForSpecifiedDeviceOnly 0)
(defconstant $kReadAllStoredLinkKeys 1)
;type name? (def-mactype :BluetoothHCIStoredLinkKeysInfo (find-mactype ':BluetoothHCIStoredLinkKeysInfo))
(defrecord BluetoothHCIStoredLinkKeysInfo
   (numLinkKeysRead :UInt16)
   (maxNumLinkKeysAllowedInDevice :UInt16)
)
;  Page Scan

(def-mactype :BluetoothHCIPageScanMode (find-mactype ':UInt8))
(def-mactype :BluetoothHCIPageScanModes (find-mactype ':sint32))

(defconstant $kMandatoryPageScanMode 0)
(defconstant $kOptionalPageScanMode1 1)
(defconstant $kOptionalPageScanMode2 2)
(defconstant $kOptionalPageScanMode3 3)
(def-mactype :BluetoothHCIPageScanPeriodMode (find-mactype ':UInt8))
(def-mactype :BluetoothHCIPageScanPeriodModes (find-mactype ':sint32))

(defconstant $kP0Mode 0)
(defconstant $kP1Mode 1)
(defconstant $kP2Mode 2)
(def-mactype :BluetoothHCIPageScanEnableState (find-mactype ':UInt8))
(def-mactype :BluetoothHCIPageScanEnableStates (find-mactype ':sint32))

(defconstant $kNoScansEnabled 0)
(defconstant $kInquiryScanEnabledPageScanDisabled 1)
(defconstant $kInquiryScanDisabledPageScanEnabled 2)
(defconstant $kInquiryScanEnabledPageScanEnabled 3)
;type name? (def-mactype :BluetoothHCIScanActivity (find-mactype ':BluetoothHCIScanActivity))
(defrecord BluetoothHCIScanActivity
   (scanInterval :UInt16)
   (scanWindow :UInt16)
)

;type name? (def-mactype :BluetoothHCIInquiryAccessCode (find-mactype ':BluetoothHCIInquiryAccessCode))
(defrecord BluetoothHCIInquiryAccessCode
   (data (:array :UInt8 3))
)

(def-mactype :BluetoothHCIInquiryAccessCodeCount (find-mactype ':UInt8))

;type name? (def-mactype :BluetoothHCICurrentInquiryAccessCodes (find-mactype ':BluetoothHCICurrentInquiryAccessCodes))
(defrecord BluetoothHCICurrentInquiryAccessCodes
   (count :UInt8)
                                                ;  Number of codes in array.
   (codes (:pointer :BLUETOOTHHCIINQUIRYACCESSCODE))
                                                ;  Ptr to array of codes.
)

;type name? (def-mactype :BluetoothHCILinkSupervisionTimeout (find-mactype ':BluetoothHCILinkSupervisionTimeout))
(defrecord BluetoothHCILinkSupervisionTimeout
   (handle :UInt16)
   (timeout :UInt16)
)

(def-mactype :BluetoothHCIFlowControlState (find-mactype ':UInt8))
(def-mactype :BluetoothHCISCOFlowControlStates (find-mactype ':sint32))

(defconstant $kSCOFlowControlDisabled 0)
(defconstant $kSCOFlowControlEnabled 1)
(def-mactype :BluetoothHCIGeneralFlowControlStates (find-mactype ':sint32))

(defconstant $kHostControllerToHostFlowControlOff 0)
(defconstant $kHCIACLDataPacketsOnHCISCODataPacketsOff 1)
(defconstant $kHCIACLDataPacketsOffHCISCODataPacketsOn 2)
(defconstant $kHCIACLDataPacketsOnHCISCODataPacketsOn 3)
(def-mactype :BluetoothHCITransmitPowerLevel (find-mactype ':SInt8))

(def-mactype :BluetoothHCITransmitPowerLevelType (find-mactype ':UInt8))
(def-mactype :BluetoothHCITransmitReadPowerLevelTypes (find-mactype ':sint32))

(defconstant $kReadCurrentTransmitPowerLevel 0)
(defconstant $kReadMaximumTransmitPowerLevel 1)
;type name? (def-mactype :BluetoothHCITransmitPowerLevelInfo (find-mactype ':BluetoothHCITransmitPowerLevelInfo))
(defrecord BluetoothHCITransmitPowerLevelInfo
   (handle :UInt16)
   (level :SInt8)                               ;  Range: -30 <= N <= 20 (units are dBm)
)

(def-mactype :BluetoothHCINumBroadcastRetransmissions (find-mactype ':UInt8))

(def-mactype :BluetoothHCIHoldModeActivity (find-mactype ':UInt8))
(def-mactype :BluetoothHCIHoldModeActivityStates (find-mactype ':sint32))

(defconstant $kMaintainCurrentPowerState 0)
(defconstant $kSuspendPageScan 1)
(defconstant $kSuspendInquiryScan 2)
(defconstant $kSuspendPeriodicInquiries 3)
(def-mactype :BluetoothHCIVoiceSetting (find-mactype ':UInt16))

(def-mactype :BluetoothHCISupportedIAC (find-mactype ':UInt8))

(def-mactype :BluetoothHCIAuthenticationEnable (find-mactype ':UInt8))
(def-mactype :BluetoothHCIAuthentionEnableModes (find-mactype ':sint32))

(defconstant $kAuthenticationDisabled 0)
(defconstant $kAuthenticationEnabled 1)
(def-mactype :BluetoothHCIEncryptionMode (find-mactype ':UInt8))
(def-mactype :BluetoothHCIEncryptionModes (find-mactype ':sint32))

(defconstant $kEncryptionDisabled 0)            ;  Default.

(defconstant $kEncryptionOnlyForPointToPointPackets 1)
(defconstant $kEncryptionForBothPointToPointAndBroadcastPackets 2)
(def-mactype :BluetoothHCIAutomaticFlushTimeout (find-mactype ':UInt16))

;type name? (def-mactype :BluetoothHCIAutomaticFlushTimeoutInfo (find-mactype ':BluetoothHCIAutomaticFlushTimeoutInfo))
(defrecord BluetoothHCIAutomaticFlushTimeoutInfo
   (handle :UInt16)
   (timeout :UInt16)
)
(defconstant $kInfoStringMaxLength 25)
; #define	kInfoStringMaxLength		25

;type name? (def-mactype :BluetoothTransportInfo (find-mactype ':BluetoothTransportInfo))

(def-mactype :BluetoothTransportInfoPtr (find-mactype '(:pointer :BluetoothTransportInfo)))
(defrecord BluetoothTransportInfo
   (productID :UInt32)
   (vendorID :UInt32)
   (type :UInt32)
   (productName (:array :character 25))
   (vendorName (:array :character 25))
)
(def-mactype :BluetoothTransportTypes (find-mactype ':sint32))

(defconstant $kBluetoothTransportTypeUSB 1)
(defconstant $kBluetoothTransportTypePCCard 2)
(defconstant $kBluetoothTransportTypePCICard 3)
;  Inquiries

;type name? (def-mactype :BluetoothHCIInquiryResult (find-mactype ':BluetoothHCIInquiryResult))
(defrecord BluetoothHCIInquiryResult
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (pageScanRepetitionMode :UInt8)
   (pageScanPeriodMode :UInt8)
   (pageScanMode :UInt8)
   (classOfDevice :UInt32)
   (clockOffset :UInt16)
)

;type name? (def-mactype :BluetoothHCIInquiryResults (find-mactype ':BluetoothHCIInquiryResults))
(defrecord BluetoothHCIInquiryResults
   (results (:array :BLUETOOTHHCIINQUIRYRESULT 50))
   (count :UInt32)
)
;  Packet Sizes

(defconstant $kBluetoothHCICommandPacketHeaderSize 3)
(defconstant $kBluetoothHCICommandPacketMaxDataSize #xFF)
(defconstant $kBluetoothHCIMaxCommandPacketSize #x102)
(defconstant $kBluetoothHCIEventPacketHeaderSize 2)
(defconstant $kBluetoothHCIEventPacketMaxDataSize #xFF)
(defconstant $kBluetoothHCIMaxEventPacketSize #x101)
(defconstant $kBluetoothHCIDataPacketHeaderSize 4)
(defconstant $kBluetoothHCIDataPacketMaxDataSize #xFFFF)
(defconstant $kBluetoothHCIMaxDataPacketSize #x10003)

(def-mactype :BluetoothHCIEventCode (find-mactype ':UInt8))

(def-mactype :BluetoothLinkType (find-mactype ':UInt8))
(def-mactype :BluetoothLinkTypes (find-mactype ':sint32))

(defconstant $kBluetoothSCOConnection 0)
(defconstant $kBluetoothACLConnection 1)
(defconstant $kBluetoothLinkTypeNone #xFF)

(def-mactype :BluetoothHCIStatus (find-mactype ':UInt8))

(def-mactype :BluetoothHCIEventStatus (find-mactype ':UInt8))
;  Events.

(defconstant $kBluetoothHCIEventInquiryComplete 1)
(defconstant $kBluetoothHCIEventInquiryResult 2)
(defconstant $kBluetoothHCIEventConnectionComplete 3)
(defconstant $kBluetoothHCIEventConnectionRequest 4)
(defconstant $kBluetoothHCIEventDisconnectionComplete 5)
(defconstant $kBluetoothHCIEventAuthenticationComplete 6)
(defconstant $kBluetoothHCIEventRemoteNameRequestComplete 7)
(defconstant $kBluetoothHCIEventEncryptionChange 8)
(defconstant $kBluetoothHCIEventChangeConnectionLinkKeyComplete 9)
(defconstant $kBluetoothHCIEventMasterLinkKeyComplete 10)
(defconstant $kBluetoothHCIEventReadRemoteSupportedFeaturesComplete 11)
(defconstant $kBluetoothHCIEventReadRemoteVersionInformationComplete 12)
(defconstant $kBluetoothHCIEventQoSSetupComplete 13)
(defconstant $kBluetoothHCIEventCommandComplete 14)
(defconstant $kBluetoothHCIEventCommandStatus 15)
(defconstant $kBluetoothHCIEventHardwareError 16)
(defconstant $kBluetoothHCIEventFlushOccurred 17)
(defconstant $kBluetoothHCIEventRoleChange 18)
(defconstant $kBluetoothHCIEventNumberOfCompletedPackets 19)
(defconstant $kBluetoothHCIEventModeChange 20)
(defconstant $kBluetoothHCIEventReturnLinkKeys 21)
(defconstant $kBluetoothHCIEventPINCodeRequest 22)
(defconstant $kBluetoothHCIEventLinkKeyRequest 23)
(defconstant $kBluetoothHCIEventLinkKeyNotification 24)
(defconstant $kBluetoothHCIEventLoopbackCommand 25)
(defconstant $kBluetoothHCIEventDataBufferOverflow 26)
(defconstant $kBluetoothHCIEventMaxSlotsChange 27)
(defconstant $kBluetoothHCIEventReadClockOffsetComplete 28)
(defconstant $kBluetoothHCIEventConnectionPacketType 29)
(defconstant $kBluetoothHCIEventQoSViolation 30)
(defconstant $kBluetoothHCIEventPageScanModeChange 31)
(defconstant $kBluetoothHCIEventPageScanRepetitionModeChange 32)
(defconstant $kBluetoothHCIEventLogoTesting #xFE)
(defconstant $kBluetoothHCIEventVendorSpecific #xFF)
;  Event masks

(defconstant $kBluetoothHCIEventMaskNone 0)
(defconstant $kBluetoothHCIEventMaskInquiryComplete 1)
(defconstant $kBluetoothHCIEventMaskInquiryResult 2)
(defconstant $kBluetoothHCIEventMaskConnectionComplete 4)
(defconstant $kBluetoothHCIEventMaskConnectionRequest 8)
(defconstant $kBluetoothHCIEventMaskDisconnectionComplete 16)
(defconstant $kBluetoothHCIEventMaskAuthenticationComplete 32)
(defconstant $kBluetoothHCIEventMaskRemoteNameRequestComplete 64)
(defconstant $kBluetoothHCIEventMaskEncryptionChange #x80)
(defconstant $kBluetoothHCIEventMaskChangeConnectionLinkKeyComplete #x100)
(defconstant $kBluetoothHCIEventMaskMasterLinkKeyComplete #x200)
(defconstant $kBluetoothHCIEventMaskReadRemoteSupportedFeaturesComplete #x400)
(defconstant $kBluetoothHCIEventMaskReadRemoteVersionInformationComplete #x800)
(defconstant $kBluetoothHCIEventMaskQoSSetupComplete #x1000)
(defconstant $kBluetoothHCIEventMaskCommandComplete #x2000)
(defconstant $kBluetoothHCIEventMaskCommandStatus #x4000)
(defconstant $kBluetoothHCIEventMaskHardwareError #x8000)
(defconstant $kBluetoothHCIEventMaskFlushOccurred #x10000)
(defconstant $kBluetoothHCIEventMaskRoleChange #x20000)
(defconstant $kBluetoothHCIEventMaskNumberOfCompletedPackets #x40000)
(defconstant $kBluetoothHCIEventMaskModeChange #x80000)
(defconstant $kBluetoothHCIEventMaskReturnLinkKeys #x100000)
(defconstant $kBluetoothHCIEventMaskPINCodeRequest #x200000)
(defconstant $kBluetoothHCIEventMaskLinkKeyRequest #x400000)
(defconstant $kBluetoothHCIEventMaskLinkKeyNotification #x800000)
(defconstant $kBluetoothHCIEventMaskLoopbackCommand #x1000000)
(defconstant $kBluetoothHCIEventMaskDataBufferOverflow #x2000000)
(defconstant $kBluetoothHCIEventMaskMaxSlotsChange #x4000000)
(defconstant $kBluetoothHCIEventMaskReadClockOffsetComplete #x8000000)
(defconstant $kBluetoothHCIEventMaskConnectionPacketTypeChanged #x10000000)
(defconstant $kBluetoothHCIEventMaskQoSViolation #x20000000)
(defconstant $kBluetoothHCIEventMaskPageScanModeChange #x40000000)
(defconstant $kBluetoothHCIEventMaskPageScanRepetitionModeChange #x80000000)
(defconstant $kBluetoothHCIEventMaskAll #xFFFFFFFF)
(defconstant $kBluetoothHCIEventMaskDefault #xFFFFFFFF)
;  Event results structures.

;type name? (def-mactype :BluetoothHCIEventConnectionCompleteResults (find-mactype ':BluetoothHCIEventConnectionCompleteResults))
(defrecord BluetoothHCIEventConnectionCompleteResults
   (connectionHandle :UInt16)
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (linkType :UInt8)
   (encryptionMode :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventDisconnectionCompleteResults (find-mactype ':BluetoothHCIEventDisconnectionCompleteResults))
(defrecord BluetoothHCIEventDisconnectionCompleteResults
   (connectionHandle :UInt16)
   (reason :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventReadSupportedFeaturesResults (find-mactype ':BluetoothHCIEventReadSupportedFeaturesResults))
(defrecord BluetoothHCIEventReadSupportedFeaturesResults
   (connectionHandle :UInt16)
   (supportedFeatures :BLUETOOTHHCISUPPORTEDFEATURES)
)

;type name? (def-mactype :BluetoothHCIEventReadRemoteVersionInfoResults (find-mactype ':BluetoothHCIEventReadRemoteVersionInfoResults))
(defrecord BluetoothHCIEventReadRemoteVersionInfoResults
   (connectionHandle :UInt16)
   (lmpVersion :UInt8)
   (manufacturerName :UInt16)
   (lmpSubversion :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventRemoteNameRequestResults (find-mactype ':BluetoothHCIEventRemoteNameRequestResults))
(defrecord BluetoothHCIEventRemoteNameRequestResults
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (deviceName :BLUETOOTHDEVICENAME)
)

;type name? (def-mactype :BluetoothHCIEventReadClockOffsetResults (find-mactype ':BluetoothHCIEventReadClockOffsetResults))
(defrecord BluetoothHCIEventReadClockOffsetResults
   (connectionHandle :UInt16)
   (clockOffset :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventConnectionRequestResults (find-mactype ':BluetoothHCIEventConnectionRequestResults))
(defrecord BluetoothHCIEventConnectionRequestResults
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (classOfDevice :UInt32)
   (linkType :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventLinkKeyNotificationResults (find-mactype ':BluetoothHCIEventLinkKeyNotificationResults))
(defrecord BluetoothHCIEventLinkKeyNotificationResults
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (linkKey :BLUETOOTHKEY)
   (keyType :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventMaxSlotsChangeResults (find-mactype ':BluetoothHCIEventMaxSlotsChangeResults))
(defrecord BluetoothHCIEventMaxSlotsChangeResults
   (connectionHandle :UInt16)
   (maxSlots :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventModeChangeResults (find-mactype ':BluetoothHCIEventModeChangeResults))
(defrecord BluetoothHCIEventModeChangeResults
   (connectionHandle :UInt16)
   (mode :UInt8)
   (modeInterval :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventReturnLinkKeysResults (find-mactype ':BluetoothHCIEventReturnLinkKeysResults))
(defrecord BluetoothHCIEventReturnLinkKeysResults
   (numLinkKeys :UInt8)
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (linkKey :BLUETOOTHKEY)
)

;type name? (def-mactype :BluetoothHCIEventAuthenticationCompleteResults (find-mactype ':BluetoothHCIEventAuthenticationCompleteResults))
(defrecord BluetoothHCIEventAuthenticationCompleteResults
   (connectionHandle :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventEncryptionChangeResults (find-mactype ':BluetoothHCIEventEncryptionChangeResults))
(defrecord BluetoothHCIEventEncryptionChangeResults
   (connectionHandle :UInt16)
   (enable :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventChangeConnectionLinkKeyCompleteResults (find-mactype ':BluetoothHCIEventChangeConnectionLinkKeyCompleteResults))
(defrecord BluetoothHCIEventChangeConnectionLinkKeyCompleteResults
   (connectionHandle :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventMasterLinkKeyCompleteResults (find-mactype ':BluetoothHCIEventMasterLinkKeyCompleteResults))
(defrecord BluetoothHCIEventMasterLinkKeyCompleteResults
   (connectionHandle :UInt16)
   (keyFlag :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventQoSSetupCompleteResults (find-mactype ':BluetoothHCIEventQoSSetupCompleteResults))
(defrecord BluetoothHCIEventQoSSetupCompleteResults
   (connectionHandle :UInt16)
   (setupParams :BLUETOOTHHCIQUALITYOFSERVICESETUPPARAMS)
)

;type name? (def-mactype :BluetoothHCIEventHardwareErrorResults (find-mactype ':BluetoothHCIEventHardwareErrorResults))
(defrecord BluetoothHCIEventHardwareErrorResults
   (error :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventFlushOccurredResults (find-mactype ':BluetoothHCIEventFlushOccurredResults))
(defrecord BluetoothHCIEventFlushOccurredResults
   (connectionHandle :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventRoleChangeResults (find-mactype ':BluetoothHCIEventRoleChangeResults))
(defrecord BluetoothHCIEventRoleChangeResults
   (connectionHandle :UInt16)
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (role :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventDataBufferOverflowResults (find-mactype ':BluetoothHCIEventDataBufferOverflowResults))
(defrecord BluetoothHCIEventDataBufferOverflowResults
   (linkType :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventConnectionPacketTypeResults (find-mactype ':BluetoothHCIEventConnectionPacketTypeResults))
(defrecord BluetoothHCIEventConnectionPacketTypeResults
   (connectionHandle :UInt16)
   (packetType :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventReadRemoteSupportedFeaturesResults (find-mactype ':BluetoothHCIEventReadRemoteSupportedFeaturesResults))
(defrecord BluetoothHCIEventReadRemoteSupportedFeaturesResults
   (error :UInt8)
   (connectionHandle :UInt16)
   (lmpFeatures :BLUETOOTHHCISUPPORTEDFEATURES)
)

;type name? (def-mactype :BluetoothHCIEventQoSViolationResults (find-mactype ':BluetoothHCIEventQoSViolationResults))
(defrecord BluetoothHCIEventQoSViolationResults
   (connectionHandle :UInt16)
)

;type name? (def-mactype :BluetoothHCIEventPageScanModeChangeResults (find-mactype ':BluetoothHCIEventPageScanModeChangeResults))
(defrecord BluetoothHCIEventPageScanModeChangeResults
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (pageScanMode :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventPageScanRepetitionModeChangeResults (find-mactype ':BluetoothHCIEventPageScanRepetitionModeChangeResults))
(defrecord BluetoothHCIEventPageScanRepetitionModeChangeResults
   (deviceAddress :BLUETOOTHDEVICEADDRESS)
   (pageScanRepetitionMode :UInt8)
)

;type name? (def-mactype :BluetoothHCIEventVendorSpecificResults (find-mactype ':BluetoothHCIEventVendorSpecificResults))
(defrecord BluetoothHCIEventVendorSpecificResults
   (length :UInt8)
   (data (:array :UInt8 255))
)
; #define kNoNotifyProc	NULL
; #define kNoUserRefCon	NULL
;  For private lib API:

;type name? (def-mactype :BluetoothHCIRequestNotificationInfo (find-mactype ':BluetoothHCIRequestNotificationInfo))
(defrecord BluetoothHCIRequestNotificationInfo
   (HCIRequestID (:pointer :OpaqueBluetoothHCIRequestID))
                                                ;  [00] 		// ID of request that this data was generated from.
   (refCon :pointer)
                                                ;  [04]			// User-specified refCon.
   (reserved1 :pointer)
                                                ;  [08]			// Reserved.
   (eventCode :UInt8)
                                                ;  [12]			// HCI Event code.
   (eventStatus :UInt8)
                                                ;  [13]			// Status code from event.	
   (status :UInt8)
                                                ;  [14]			// Status code from the HCI layer.
   (reserved2 :UInt8)
                                                ;  [15]			// Reserved.
   (opCode :UInt16)
                                                ;  [16]			// HCI command opcode (if applicable).
   (dataSize :UInt32)
                                                ;  [20]			// Size of data following this structure.
                                                ;  [24+data] bytes total.
   (data (:pointer :UInt8))
)

;type name? (def-mactype :BluetoothHCIRequestCallbackInfo (find-mactype ':BluetoothHCIRequestCallbackInfo))
(defrecord BluetoothHCIRequestCallbackInfo
   (userCallback :pointer)
                                                ;  Proc to call when async handler is called.
   (userRefCon :pointer)
                                                ;  For user's info.
   (internalRefCon :pointer)
                                                ;  For our purposes.
   (asyncIDRefCon :pointer)
                                                ;  For our aync calls.
   (reserved :pointer)
                                                ;  For the future. Currently Unused.
)
;  Error codes

(defconstant $kBluetoothHCIErrorSuccess 0)
(defconstant $kBluetoothHCIErrorUnknownHCICommand 1)
(defconstant $kBluetoothHCIErrorNoConnection 2)
(defconstant $kBluetoothHCIErrorHardwareFailure 3)
(defconstant $kBluetoothHCIErrorPageTimeout 4)
(defconstant $kBluetoothHCIErrorAuthenticationFailure 5)
(defconstant $kBluetoothHCIErrorKeyMissing 6)
(defconstant $kBluetoothHCIErrorMemoryFull 7)
(defconstant $kBluetoothHCIErrorConnectionTimeout 8)
(defconstant $kBluetoothHCIErrorMaxNumberOfConnections 9)
(defconstant $kBluetoothHCIErrorMaxNumberOfSCOConnectionsToADevice 10)
(defconstant $kBluetoothHCIErrorACLConnectionAlreadyExists 11)
(defconstant $kBluetoothHCIErrorCommandDisallowed 12)
(defconstant $kBluetoothHCIErrorHostRejectedLimitedResources 13)
(defconstant $kBluetoothHCIErrorHostRejectedSecurityReasons 14)
(defconstant $kBluetoothHCIErrorHostRejectedRemoteDeviceIsPersonal 15)
(defconstant $kBluetoothHCIErrorHostTimeout 16)
(defconstant $kBluetoothHCIErrorUnsupportedFeatureOrParameterValue 17)
(defconstant $kBluetoothHCIErrorInvalidHCICommandParameters 18)
(defconstant $kBluetoothHCIErrorOtherEndTerminatedConnectionUserEnded 19)
(defconstant $kBluetoothHCIErrorOtherEndTerminatedConnectionLowResources 20)
(defconstant $kBluetoothHCIErrorOtherEndTerminatedConnectionAboutToPowerOff 21)
(defconstant $kBluetoothHCIErrorConnectionTerminatedByLocalHost 22)
(defconstant $kBluetoothHCIErrorRepeatedAttempts 23)
(defconstant $kBluetoothHCIErrorPairingNotAllowed 24)
(defconstant $kBluetoothHCIErrorUnknownLMPPDU 25)
(defconstant $kBluetoothHCIErrorUnsupportedRemoteFeature 26)
(defconstant $kBluetoothHCIErrorSCOOffsetRejected 27)
(defconstant $kBluetoothHCIErrorSCOIntervalRejected 28)
(defconstant $kBluetoothHCIErrorSCOAirModeRejected 29)
(defconstant $kBluetoothHCIErrorInvalidLMPParameters 30)
(defconstant $kBluetoothHCIErrorUnspecifiedError 31)
(defconstant $kBluetoothHCIErrorUnsupportedLMPParameterValue 32)
(defconstant $kBluetoothHCIErrorRoleChangeNotAllowed 33)
(defconstant $kBluetoothHCIErrorLMPResponseTimeout 34)
(defconstant $kBluetoothHCIErrorLMPErrorTransactionCollision 35)
(defconstant $kBluetoothHCIErrorLMPPDUNotAllowed 36)
(defconstant $kBluetoothHCIErrorEncryptionModeNotAcceptable 37);  1.1

(defconstant $kBluetoothHCIErrorUnitKeyUsed 38) ;  1.1

(defconstant $kBluetoothHCIErrorQoSNotSupported 39);  1.1

(defconstant $kBluetoothHCIErrorInstantPassed 40);  1.1

(defconstant $kBluetoothHCIErrorPairingWithUnitKeyNotSupported 41);  1.1

(defconstant $kBluetoothHCIErrorMax 41)

; #if 0
#| ; #pragma mark ¥ HCI Power Mode ¥
 |#

; #endif

; ===========================================================================================================================
; 	HCI Power Mode 
; ===========================================================================================================================

(defconstant $kBluetoothHCIPowerStateON 1)
(defconstant $kBluetoothHCIPowerStateOFF 0)
(def-mactype :BluetoothHCIPowerState (find-mactype ':SINT32))

(defconstant $kBluetoothHCIErrorPowerIsOFF 42)

; #if 0
#| ; #pragma mark ¥ HCI USB Transport ¥
 |#

; #endif

; ===========================================================================================================================
; 	HCI USB Transport
; ===========================================================================================================================
; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		BluetoothHCIUSBDeviceMatchingConstants
; 	@abstract	Bluetooth USB device matching constants
; 	@constant	kBluetoothHCITransportUSBClassCode			Wireless Controller
; 	@constant	kBluetoothHCITransportUSBSubClassCode		RF Controller
; 	@constant	kBluetoothHCITransportUSBProtocolCode		Bluetooth Programming
; 

(defconstant $kBluetoothHCITransportUSBClassCode #xE0)
(defconstant $kBluetoothHCITransportUSBSubClassCode 1)
(defconstant $kBluetoothHCITransportUSBProtocolCode 1)

; #if 0
#| ; #pragma mark ¥ TCI - L2CAP ¥
 |#

; #endif

; ===========================================================================================================================
; 	TCI - L2CAP
; ===========================================================================================================================

(defconstant $kBluetoothL2CAPTCIEventIDReserved 0)
(defconstant $kBluetoothL2CAPTCIEventIDL2CA_ConnectInd 1)
(defconstant $kBluetoothL2CAPTCIEventIDL2CA_ConfigInd 2)
(defconstant $kBluetoothL2CAPTCIEventIDL2CA_DisconnectInd 3)
(defconstant $kBluetoothL2CAPTCIEventIDL2CA_QoSViolationInd 4)
(defconstant $kBluetoothL2CAPTCIEventIDL2CA_TimeOutInd 5)

(defconstant $kBluetoothL2CAPTCICommandReserved 0)
(defconstant $kBluetoothL2CAPTCICommandL2CA_ConnectReq 1)
(defconstant $kBluetoothL2CAPTCICommandL2CA_DisconnectReq 2)
(defconstant $kBluetoothL2CAPTCICommandL2CA_ConfigReq 3)
(defconstant $kBluetoothL2CAPTCICommandL2CA_DisableCLT 4)
(defconstant $kBluetoothL2CAPTCICommandL2CA_EnableCLT 5)
(defconstant $kBluetoothL2CAPTCICommandL2CA_GroupCreate 6)
(defconstant $kBluetoothL2CAPTCICommandL2CA_GroupClose 7)
(defconstant $kBluetoothL2CAPTCICommandL2CA_GroupAddMember 8)
(defconstant $kBluetoothL2CAPTCICommandL2CA_GroupRemoveMember 9)
(defconstant $kBluetoothL2CAPTCICommandL2CA_GroupMembership 10)
(defconstant $kBluetoothL2CAPTCICommandL2CA_WriteData 11)
(defconstant $kBluetoothL2CAPTCICommandL2CA_ReadData 12)
(defconstant $kBluetoothL2CAPTCICommandL2CA_Ping 13)
(defconstant $kBluetoothL2CAPTCICommandL2CA_GetInfo 14)
(defconstant $kBluetoothL2CAPTCICommandL2CA_Reserved1 15)
(defconstant $kBluetoothL2CAPTCICommandL2CA_Reserved2 16)
(defconstant $kBluetoothL2CAPTCICommandL2CA_ConnectResp 17)
(defconstant $kBluetoothL2CAPTCICommandL2CA_DisconnectResp 18)
(defconstant $kBluetoothL2CAPTCICommandL2CA_ConfigResp 19)

; #if 0
#| ; #pragma mark -
; #pragma mark ¥ RFCOMM ¥
 |#

; #endif

; ===========================================================================================================================
; 	RFCOMM
; ===========================================================================================================================
(defconstant $kMaxChannelIDPerSide 31)
; #define kMaxChannelIDPerSide	31

(def-mactype :BluetoothRFCOMMChannelID (find-mactype ':UInt8))
; #define	RFCOMM_CHANNEL_ID_IS_VALID( CHANNEL ) (( CHANNEL >= 1 ) && ( CHANNEL <= 30 ))

(def-mactype :BluetoothRFCOMMMTU (find-mactype ':UInt16))
(def-mactype :BluetoothRFCOMMParityType (find-mactype ':sint32))

(defconstant $kBluetoothRFCOMMParityTypeNoParity 0)
(defconstant $kBluetoothRFCOMMParityTypeOddParity 1)
(defconstant $kBluetoothRFCOMMParityTypeEvenParity 2)
(defconstant $kBluetoothRFCOMMParityTypeMaxParity 3)
(def-mactype :BluetoothRFCOMMParityType (find-mactype ':SINT32))
(def-mactype :BluetoothRFCOMMLineStatus (find-mactype ':sint32))

(defconstant $BluetoothRFCOMMLineStatusNoError 0)
(defconstant $BluetoothRFCOMMLineStatusOverrunError 1)
(defconstant $BluetoothRFCOMMLineStatusParityError 2)
(defconstant $BluetoothRFCOMMLineStatusFramingError 3)
(def-mactype :BluetoothRFCOMMLineStatus (find-mactype ':SINT32))

; #if 0
#| ; #pragma mark -
; #pragma mark ¥ SDP ¥
 |#

; #endif

; ===========================================================================================================================
; 	SDP
; ===========================================================================================================================

(def-mactype :BluetoothSDPPDUID (find-mactype ':UInt8))

(defconstant $kBluetoothSDPPDUIDReserved 0)
(defconstant $kBluetoothSDPPDUIDErrorResponse 1)
(defconstant $kBluetoothSDPPDUIDServiceSearchRequest 2)
(defconstant $kBluetoothSDPPDUIDServiceSearchResponse 3)
(defconstant $kBluetoothSDPPDUIDServiceAttributeRequest 4)
(defconstant $kBluetoothSDPPDUIDServiceAttributeResponse 5)
(defconstant $kBluetoothSDPPDUIDServiceSearchAttributeRequest 6)
(defconstant $kBluetoothSDPPDUIDServiceSearchAttributeResponse 7)
; #define IS_REQUEST_PDU( _pduID ) (	( _pduID == kBluetoothSDPPDUIDServiceSearchRequest ) ||                                     ( _pduID == kBluetoothSDPPDUIDServiceAttributeRequest ) ||                                     ( _pduID == kBluetoothSDPPDUIDServiceSearchAttributeRequest ) )
; #define IS_RESPONSE_PDU( _pduID ) (	( _pduID == kBluetoothSDPPDUIDErrorResponse ) ||                                     ( _pduID == kBluetoothSDPPDUIDServiceSearchResponse ) ||                                     ( _pduID == kBluetoothSDPPDUIDServiceAttributeResponse ) ||                                     ( _pduID == kBluetoothSDPPDUIDServiceSearchAttributeResponse ) )

(def-mactype :BluetoothSDPErrorCode (find-mactype ':UInt16))

(defconstant $kBluetoothSDPErrorCodeSuccess 0)
(defconstant $kBluetoothSDPErrorCodeReserved 0)
(defconstant $kBluetoothSDPErrorCodeInvalidSDPVersion 1)
(defconstant $kBluetoothSDPErrorCodeInvalidServiceRecordHandle 2)
(defconstant $kBluetoothSDPErrorCodeInvalidRequestSyntax 3)
(defconstant $kBluetoothSDPErrorCodeInvalidPDUSize 4)
(defconstant $kBluetoothSDPErrorCodeInvalidContinuationState 5)
(defconstant $kBluetoothSDPErrorCodeInsufficientResources 6)
(defconstant $kBluetoothSDPErrorCodeReservedStart 7)
(defconstant $kBluetoothSDPErrorCodeReservedEnd #xFFFF)

(def-mactype :BluetoothSDPTransactionID (find-mactype ':UInt16))

(def-mactype :BluetoothSDPServiceRecordHandle (find-mactype ':UInt32))

(defconstant $kBluetoothSDPDataElementTypeNil 0)
(defconstant $kBluetoothSDPDataElementTypeUnsignedInt 1)
(defconstant $kBluetoothSDPDataElementTypeSignedInt 2)
(defconstant $kBluetoothSDPDataElementTypeUUID 3)
(defconstant $kBluetoothSDPDataElementTypeString 4)
(defconstant $kBluetoothSDPDataElementTypeBoolean 5)
(defconstant $kBluetoothSDPDataElementTypeDataElementSequence 6)
(defconstant $kBluetoothSDPDataElementTypeDataElementAlternative 7)
(defconstant $kBluetoothSDPDataElementTypeURL 8)
(defconstant $kBluetoothSDPDataElementTypeReservedStart 9)
(defconstant $kBluetoothSDPDataElementTypeReservedEnd 31)

(def-mactype :BluetoothSDPUUID16 (find-mactype ':UInt16))

(def-mactype :BluetoothSDPUUID32 (find-mactype ':UInt32))

(def-mactype :BluetoothSDPDataElementTypeDescriptor (find-mactype ':UInt8))

(def-mactype :BluetoothSDPDataElementSizeDescriptor (find-mactype ':UInt8))

(def-mactype :BluetoothSDPServiceAttributeID (find-mactype ':UInt16))
; #ifdef	__cplusplus
#| #|
	}
#endif
|#
 |#

(provide-interface "Bluetooth")