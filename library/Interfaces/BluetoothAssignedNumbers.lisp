(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:BluetoothAssignedNumbers.h"
; at Sunday July 2,2006 7:27:09 pm.
; 
; 	File:		BluetoothAssignedNumbers.h
; 	Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 
; #pragma once
; #ifdef	__cplusplus
#| #|
	extern "C" {
#endif
|#
 |#
; #pragma mark -
; #pragma mark ¥ Baseband ¥
; ==================================================================================================================
; 	Baseband
; ==================================================================================================================
; 
;  Service Class Major
; 

(defconstant $kBluetoothServiceClassMajorLimitedDiscoverableMode 1);  Bit 13 - Limited Discoverable Mode

(defconstant $kBluetoothServiceClassMajorReserved1 2);  Bit 14 - Reserved for future use.

(defconstant $kBluetoothServiceClassMajorReserved2 4);  Bit 15 - Reserved for future use.

(defconstant $kBluetoothServiceClassMajorPositioning 8);  Bit 16 - Positioning (Location ID)

(defconstant $kBluetoothServiceClassMajorNetworking 16);  Bit 17 - LAN, Ad hoc, etc...

(defconstant $kBluetoothServiceClassMajorRendering 32);  Bit 18 - Printing, Speaker, etc...

(defconstant $kBluetoothServiceClassMajorCapturing 64);  Bit 19 - Scanner, Microphone, etc...

(defconstant $kBluetoothServiceClassMajorObjectTransfer #x80);  Bit 20 - v-Inbox, v-Folder, etc...

(defconstant $kBluetoothServiceClassMajorAudio #x100);  Bit 21 - Speaker, Microphone, Headset, etc...

(defconstant $kBluetoothServiceClassMajorTelephony #x200);  Bit 22 - Cordless telephony, Modem, Headset, etc...

(defconstant $kBluetoothServiceClassMajorInformation #x400);  Bit 23 - Web server, WAP server, etc...

(defconstant $kBluetoothServiceClassMajorAny :|****|);  Pseudo-class - means anything acceptable.

(defconstant $kBluetoothServiceClassMajorNone :|none|);  Pseudo-class - means no matching.

(defconstant $kBluetoothServiceClassMajorEnd #x401)
; 
;  Device Class Major
; 

(defconstant $kBluetoothDeviceClassMajorMiscellaneous 0);  [00000] Miscellaneous

(defconstant $kBluetoothDeviceClassMajorComputer 1);  [00001] Desktop, Notebook, PDA, Organizers, etc...

(defconstant $kBluetoothDeviceClassMajorPhone 2);  [00010] Cellular, Cordless, Payphone, Modem, etc...

(defconstant $kBluetoothDeviceClassMajorLANAccessPoint 3);  [00011] LAN Access Point

(defconstant $kBluetoothDeviceClassMajorAudio 4);  [00100] Headset, Speaker, Stereo, etc...

(defconstant $kBluetoothDeviceClassMajorPeripheral 5);  [00101] Mouse, Joystick, Keyboards, etc...

(defconstant $kBluetoothDeviceClassMajorImaging 6);  [00110] Printing, scanner, camera, display, etc...

(defconstant $kBluetoothDeviceClassMajorUnclassified 31);  [11111] Specific device code not assigned
;  Range 0x06 to 0x1E Reserved for future use.

(defconstant $kBluetoothDeviceClassMajorAny :|****|);  Pseudo-class - means anything acceptable.

(defconstant $kBluetoothDeviceClassMajorNone :|none|);  Pseudo-class - means no matching.

(defconstant $kBluetoothDeviceClassMajorEnd 32)
; 
;  Device Class Minor
; 
; /
; / Computer Major Class
; /

(defconstant $kBluetoothDeviceClassMinorComputerUnclassified 0);  [000000] Specific device code not assigned

(defconstant $kBluetoothDeviceClassMinorComputerDesktopWorkstation 1);  [000001] Desktop workstation

(defconstant $kBluetoothDeviceClassMinorComputerServer 2);  [000010] Server-class computer

(defconstant $kBluetoothDeviceClassMinorComputerLaptop 3);  [000011] Laptop

(defconstant $kBluetoothDeviceClassMinorComputerHandheld 4);  [000100] Handheld PC/PDA (clam shell)

(defconstant $kBluetoothDeviceClassMinorComputerPalmSized 5);  [000101] Palm-sized PC/PDA

(defconstant $kBluetoothDeviceClassMinorComputerWearable 6);  [000110] Wearable computer (watch sized)
;  Range 0x06 to 0x7F Reserved for future use.
; /
; / Phone Major Class
; /

(defconstant $kBluetoothDeviceClassMinorPhoneUnclassified 0);  [000000] Specific device code not assigned

(defconstant $kBluetoothDeviceClassMinorPhoneCellular 1);  [000001] Cellular

(defconstant $kBluetoothDeviceClassMinorPhoneCordless 2);  [000010] Cordless

(defconstant $kBluetoothDeviceClassMinorPhoneSmartPhone 3);  [000011] Smart phone

(defconstant $kBluetoothDeviceClassMinorPhoneWiredModemOrVoiceGateway 4);  [000100] Wired modem or voice gateway

(defconstant $kBluetoothDeviceClassMinorPhoneCommonISDNAccess 5);  [000101] Common ISDN Access
;  Range 0x05 to 0x7F Reserved for future use.
; /
; / LAN Access Point Major Class
; /
;  $$$ TO DO: LAN Access Point minor classes are broken into bits 5-7 for utilization and bits 2-4 for class.
; /
; / Audio Major Class
; /

(defconstant $kBluetoothDeviceClassMinorAudioUnclassified 0);  [000000] Specific device code not assigned

(defconstant $kBluetoothDeviceClassMinorAudioHeadset 1);  [000001] Device conforms to the Headset profile

(defconstant $kBluetoothDeviceClassMinorAudioHandsFree 2);  [000010] Hands-free

(defconstant $kBluetoothDeviceClassMinorAudioReserved1 3);  [000011] Reserved

(defconstant $kBluetoothDeviceClassMinorAudioMicrophone 4);  [000100] Microphone

(defconstant $kBluetoothDeviceClassMinorAudioLoudspeaker 5);  [000101] Loudspeaker

(defconstant $kBluetoothDeviceClassMinorAudioHeadphones 6);  [000110] Headphones

(defconstant $kBluetoothDeviceClassMinorAudioPortable 7);  [000111] Portable Audio

(defconstant $kBluetoothDeviceClassMinorAudioCar 8);  [001000] Car Audio

(defconstant $kBluetoothDeviceClassMinorAudioSetTopBox 9);  [001001] Set-top box

(defconstant $kBluetoothDeviceClassMinorAudioHiFi 10);  [001010] HiFi Audio Device

(defconstant $kBluetoothDeviceClassMinorAudioVCR 11);  [001011] VCR

(defconstant $kBluetoothDeviceClassMinorAudioVideoCamera 12);  [001100] Video Camera

(defconstant $kBluetoothDeviceClassMinorAudioCamcorder 13);  [001101] Camcorder

(defconstant $kBluetoothDeviceClassMinorAudioVideoMonitor 14);  [001110] Video Monitor

(defconstant $kBluetoothDeviceClassMinorAudioVideoDisplayAndLoudspeaker 15);  [001111] Video Display and Loudspeaker

(defconstant $kBluetoothDeviceClassMinorAudioVideoConferencing 16);  [010000] Video Conferencing

(defconstant $kBluetoothDeviceClassMinorAudioReserved2 17);  [010001] Reserved

(defconstant $kBluetoothDeviceClassMinorAudioGamingToy 18);  [010010] Gaming/Toy
;  Range 0x13 to 0x7F Reserved for future use.
; /
; / Peripheral Major Class
; /
;  Peripheral1 subclass is bits 7 & 6

(defconstant $kBluetoothDeviceClassMinorPeripheral1Keyboard 16);  [01XXXX] Keyboard

(defconstant $kBluetoothDeviceClassMinorPeripheral1Pointing 32);  [10XXXX] Pointing device

(defconstant $kBluetoothDeviceClassMinorPeripheral1Combo 48);  [11XXXX] Combo keyboard/pointing device
;  Peripheral2 subclass is bits 5-2

(defconstant $kBluetoothDeviceClassMinorPeripheral2Unclassified 0);  [XX0000] Uncategorized device

(defconstant $kBluetoothDeviceClassMinorPeripheral2Joystick 1);  [XX0001] Joystick

(defconstant $kBluetoothDeviceClassMinorPeripheral2Gamepad 2);  [XX0010] Gamepad

(defconstant $kBluetoothDeviceClassMinorPeripheral2RemoteControl 3);  [XX0011] Remote control

(defconstant $kBluetoothDeviceClassMinorPeripheral2SensingDevice 4);  [XX0100] Sensing device
;  Range 0x05 to 0x0f reserved for future use
; /
; / Imaging Major Class
; /
;  Imaging1 subclass is bits 7 - 4

(defconstant $kBluetoothDeviceClassMinorImaging1Display 4);  [XXX1XX] Display

(defconstant $kBluetoothDeviceClassMinorImaging1Camera 8);  [XX1XXX] Camera

(defconstant $kBluetoothDeviceClassMinorImaging1Scanner 16);  [X1XXXX] Scanner

(defconstant $kBluetoothDeviceClassMinorImaging1Printer 32);  [1XXXXX] Printer
;  Imaging2 subclass is bits 3 - 2

(defconstant $kBluetoothDeviceClassMinorImaging2Unclassified 0);  [XXXX00] Uncategorized, default
;  Range 0x01 - 0x03 reserved for future use
; /
; /	Misc
; /

(defconstant $kBluetoothDeviceClassMinorAny :|****|);  Pseudo-class - means anything acceptable.

(defconstant $kBluetoothDeviceClassMinorNone :|none|);  Pseudo-class - means no matching.

(defconstant $kBluetoothDeviceClassMinorEnd 1)
; #pragma mark -
; #pragma mark ¥ L2CAP ¥
; ===========================================================================================================================
; 	L2CAP
; ===========================================================================================================================

(defconstant $kBluetoothL2CAPPSMSDP 1)
(defconstant $kBluetoothL2CAPPSMRFCOMM 3)
(defconstant $kBluetoothL2CAPPSMTCS_BIN 5)      ;  Telephony Control Specifictation / TCS Binary

(defconstant $kBluetoothL2CAPPSMTCS_BIN_Cordless 7);  Telephony Control Specifictation / TCS Binary

(defconstant $kBluetoothL2CAPPSMBNEP 15)        ;  Bluetooth Network Encapsulation Protocol

(defconstant $kBluetoothL2CAPPSMHIDControl 17)  ;  HID profile - control interface

(defconstant $kBluetoothL2CAPPSMHIDInterrupt 19);  HID profile - interrupt interface

(defconstant $kBluetoothL2CAPPSMAVCTP 23)       ;  Audio/Video Control Transport Protocol

(defconstant $kBluetoothL2CAPPSMAVDTP 25)       ;  Audio/Video Distribution Transport Protocol

(defconstant $kBluetoothL2CAPPSMUID_C_Plane 29) ;  Unrestricted Digital Information Profile (UDI)
;  Range < 0x1000 reserved.

(defconstant $kBluetoothL2CAPPSMReservedStart 1)
(defconstant $kBluetoothL2CAPPSMReservedEnd #x1000);  Range 0x1001-0xFFFF dynamically assigned.

(defconstant $kBluetoothL2CAPPSMDynamicStart #x1001)
(defconstant $kBluetoothL2CAPPSMDynamicEnd #xFFFF)
(defconstant $kBluetoothL2CAPPSMNone 0)
; #pragma mark -
; #pragma mark ¥ SDP ¥
; ===========================================================================================================================
; 	Service Discovery Protocol
; ===========================================================================================================================
;  General

(defconstant $kBluetoothSDPUUID16Base 0)        ;  00000000-0000-1000-8000-00805f9b34fb
;  Protocols

(defconstant $kBluetoothSDPUUID16SDP 1)         ;  00000001-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16UDP 2)         ;  00000002-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16RFCOMM 3)      ;  00000003-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16TCP 4)         ;  00000004-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16TCSBIN 5)      ;  00000005-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16TCSAT 6)       ;  00000006-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16OBEX 8)        ;  00000008-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16IP 9)          ;  00000009-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16FTP 10)        ;  0000000A-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16HTTP 12)       ;  0000000C-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16WSP 14)        ;  0000000E-0000-1000-8000-00805f9b34fb 

(defconstant $kBluetoothSDPUUID16BNEP 15)
(defconstant $kBluetoothSDPUUID16UPNP 16)
(defconstant $kBluetoothSDPUUID16HIDP 17)
(defconstant $kBluetoothSDPUUID16HardcopyControlChannel 18)
(defconstant $kBluetoothSDPUUID16HardcopyDataChannel 20)
(defconstant $kBluetoothSDPUUID16HardcopyNotification 22)
(defconstant $kBluetoothSDPUUID16AVCTP 23)
(defconstant $kBluetoothSDPUUID16AVDTP 25)
(defconstant $kBluetoothSDPUUID16CMPT 27)
(defconstant $kBluetoothSDPUUID16UDI_C_Plane 29)
(defconstant $kBluetoothSDPUUID16L2CAP #x100)   ;  00000100-0000-1000-8000-00805f9b34fb 
(def-mactype :SDPServiceClasses (find-mactype ':sint32))

(defconstant $kBluetoothSDPUUID16ServiceClassServiceDiscoveryServer #x1000);  00001000-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassBrowseGroupDescriptor #x1001);  00001001-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassPublicBrowseGroup #x1002);  00001002-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassSerialPort #x1101);  00001101-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassLANAccessUsingPPP #x1102);  00001102-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassDialupNetworking #x1103);  00001103-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassIrMCSync #x1104);  00001104-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassOBEXObjectPush #x1105);  00001105-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassOBEXFileTransfer #x1106);  00001106-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassIrMCSyncCommand #x1107);  00001107-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassHeadset #x1108);  00001108-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassCordlessTelephony #x1109);  00001109-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassAudioSource #x110A)
(defconstant $kBluetoothSDPUUID16ServiceClassAudioSink #x110B)
(defconstant $kBluetoothSDPUUID16ServiceClassAVRemoteControlTarget #x110C)
(defconstant $kBluetoothSDPUUID16ServiceClassAdvancedAudioDistribution #x110D)
(defconstant $kBluetoothSDPUUID16ServiceClassAVRemoteControl #x110E)
(defconstant $kBluetoothSDPUUID16ServiceClassVideoConferencing #x110F)
(defconstant $kBluetoothSDPUUID16ServiceClassIntercom #x1110);  00001110-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassFax #x1111);  00001111-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassHeadsetAudioGateway #x1112);  00001112-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassWAP #x1113)
(defconstant $kBluetoothSDPUUID16ServiceClassWAPClient #x1114)
(defconstant $kBluetoothSDPUUID16ServiceClassPANU #x1115)
(defconstant $kBluetoothSDPUUID16ServiceClassNAP #x1116)
(defconstant $kBluetoothSDPUUID16ServiceClassGN #x1117)
(defconstant $kBluetoothSDPUUID16ServiceClassDirectPrinting #x1118)
(defconstant $kBluetoothSDPUUID16ServiceClassReferencePrinting #x1119)
(defconstant $kBluetoothSDPUUID16ServiceClassImaging #x111A)
(defconstant $kBluetoothSDPUUID16ServiceClassImagingResponder #x111B)
(defconstant $kBluetoothSDPUUID16ServiceClassImagingAutomaticArchive #x111C)
(defconstant $kBluetoothSDPUUID16ServiceClassImagingReferencedObjects #x111D)
(defconstant $kBluetoothSDPUUID16ServiceClassHandsfree #x111E)
(defconstant $kBluetoothSDPUUID16ServiceClassHandsfreeAudioGateway #x111F)
(defconstant $kBluetoothSDPUUID16ServiceClassDirectPrintingReferenceObjectsService #x1120)
(defconstant $kBluetoothSDPUUID16ServiceClassReflectedUI #x1121)
(defconstant $kBluetoothSDPUUID16ServiceClassBasicPrinting #x1122)
(defconstant $kBluetoothSDPUUID16ServiceClassPrintingStatus #x1123)
(defconstant $kBluetoothSDPUUID16ServiceClassHumanInterfaceDeviceService #x1124)
(defconstant $kBluetoothSDPUUID16ServiceClassHardcopyCableReplacement #x1125)
(defconstant $kBluetoothSDPUUID16ServiceClassHCR_Print #x1126)
(defconstant $kBluetoothSDPUUID16ServiceClassHCR_Scan #x1127)
(defconstant $kBluetoothSDPUUID16ServiceClassCommonISDNAccess #x1128)
(defconstant $kBluetoothSDPUUID16ServiceClassVideoConferencingGW #x1129)
(defconstant $kBluetoothSDPUUID16ServiceClassUDI_MT #x112A)
(defconstant $kBluetoothSDPUUID16ServiceClassUDI_TA #x112B)
(defconstant $kBluetoothSDPUUID16ServiceClassPnPInformation #x1200);  00001200-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassGenericNetworking #x1201);  00001201-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassGenericFileTransfer #x1202);  00001202-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassGenericAudio #x1203);  00001203-0000-1000-8000-00805f9b34fb

(defconstant $kBluetoothSDPUUID16ServiceClassGenericTelephony #x1204);  00001204-0000-1000-8000-00805f9b34fb

(def-mactype :SDPAttributeIdentifierCodes (find-mactype ':sint32))

(defconstant $kBluetoothSDPAttributeIdentifierServiceRecordHandle 0)
(defconstant $kBluetoothSDPAttributeIdentifierServiceClassIDList 1)
(defconstant $kBluetoothSDPAttributeIdentifierServiceRecordState 2)
(defconstant $kBluetoothSDPAttributeIdentifierServiceID 3)
(defconstant $kBluetoothSDPAttributeIdentifierProtocolDescriptorList 4)
(defconstant $kBluetoothSDPAttributeIdentifierBrowseGroupList 5)
(defconstant $kBluetoothSDPAttributeIdentifierLanguageBaseAttributeIDList 6)
(defconstant $kBluetoothSDPAttributeIdentifierServiceInfoTimeToLive 7)
(defconstant $kBluetoothSDPAttributeIdentifierServiceAvailability 8)
(defconstant $kBluetoothSDPAttributeIdentifierBluetoothProfileDescriptorList 9)
(defconstant $kBluetoothSDPAttributeIdentifierDocumentationURL 10)
(defconstant $kBluetoothSDPAttributeIdentifierClientExecutableURL 11)
(defconstant $kBluetoothSDPAttributeIdentifierIconURL 12)
(defconstant $kBluetoothSDPAttributeIdentifierAdditionalProtocolsDescriptorList 13);  Service Discovery Server

(defconstant $kBluetoothSDPAttributeIdentifierVersionNumberList #x200)
(defconstant $kBluetoothSDPAttributeIdentifierServiceDatabaseState #x201);  Browse Group Descriptor

(defconstant $kBluetoothSDPAttributeIdentifierGroupID #x200);  PAN

(defconstant $kBluetoothSDPAttributeIdentifierIPSubnet #x200)
(defconstant $kBluetoothSDPAttributeIdentifierServiceVersion #x300)
(defconstant $kBluetoothSDPAttributeIdentifierExternalNetwork #x301);  Cordless telephony

(defconstant $kBluetoothSDPAttributeIdentifierNetwork #x301);  Handsfree Profile (HFP)

(defconstant $kBluetoothSDPAttributeIdentifierSupportedDataStoresList #x301);  Sync Profile

(defconstant $kBluetoothSDPAttributeIdentifierFaxClass1Support #x302);  Fax Profile

(defconstant $kBluetoothSDPAttributeIdentifierRemoteAudioVolumeControl #x302);  GAP???

(defconstant $kBluetoothSDPAttributeIdentifierFaxClass2_0Support #x303)
(defconstant $kBluetoothSDPAttributeIdentifierSupporterFormatsList #x303)
(defconstant $kBluetoothSDPAttributeIdentifierFaxClass2Support #x304)
(defconstant $kBluetoothSDPAttributeIdentifierAudioFeedbackSupport #x305)
(defconstant $kBluetoothSDPAttributeIdentifierNetworkAddress #x306);  WAP

(defconstant $kBluetoothSDPAttributeIdentifierWAPGateway #x307);  WAP

(defconstant $kBluetoothSDPAttributeIdentifierHomepageURL #x308);  WAP

(defconstant $kBluetoothSDPAttributeIdentifierWAPStackType #x309);  WAP

(defconstant $kBluetoothSDPAttributeIdentifierSecurityDescription #x30A);  PAN

(defconstant $kBluetoothSDPAttributeIdentifierNetAccessType #x30B);  PAN

(defconstant $kBluetoothSDPAttributeIdentifierMaxNetAccessRate #x30C);  PAN

(defconstant $kBluetoothSDPAttributeIdentifierSupportedCapabilities #x310);  Imaging

(defconstant $kBluetoothSDPAttributeIdentifierSupportedFeatures #x311);  Imaging & HFP

(defconstant $kBluetoothSDPAttributeIdentifierSupportedFunctions #x312);  Imaging

(defconstant $kBluetoothSDPAttributeIdentifierTotalImagingDataCapacity #x313);  Imaging

(defconstant $kBluetoothSDPAttributeIdentifierServiceName 0);  +language base offset

(defconstant $kBluetoothSDPAttributeIdentifierServiceDescription 1);  +language base offset

(defconstant $kBluetoothSDPAttributeIdentifierProviderName 2);  +language base offset

(def-mactype :SDPAttributeDeviceIdentificationRecord (find-mactype ':sint32))
;  Values taken from the Bluetooth Device Identification specification, 1.0 draft, 1.16.2003 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierServiceDescription 1);  String 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierDocumentationURL 10);  URL 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierClientExecutableURL 11);  URL 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierSpecificationID #x200);  2 byte unsigned integer 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierVendorID #x201);  2 byte unsigned integer 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierProductID #x202);  2 byte unsigned integer 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierVersion #x203);  2 byte unsigned integer 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierPrimaryRecord #x204);  Boolean 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierVendorIDSource #x205);  2 byte unsigned integer 

(defconstant $kBluetoothSDPAttributeDeviceIdentifierReservedRangeStart #x206)
(defconstant $kBluetoothSDPAttributeDeviceIdentifierReservedRangeEnd #x2FF)
(def-mactype :ProtocolParameters (find-mactype ':sint32))

(defconstant $kBluetoothSDPProtocolParameterL2CAPPSM 1)
(defconstant $kBluetoothSDPProtocolParameterRFCOMMChannel 1)
(defconstant $kBluetoothSDPProtocolParameterTCPPort 1)
(defconstant $kBluetoothSDPProtocolParameterUDPPort 1)
(defconstant $kBluetoothSDPProtocolParameterBNEPVersion 1)
(defconstant $kBluetoothSDPProtocolParameterBNEPSupportedNetworkPacketTypeList 2)
; #ifdef	__cplusplus
#| #|
	}
#endif
|#
 |#

(provide-interface "BluetoothAssignedNumbers")