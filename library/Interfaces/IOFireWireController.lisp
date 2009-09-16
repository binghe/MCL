(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFireWireController.h"
; at Sunday July 2,2006 7:29:02 pm.
; 
;  * Copyright (c) 1998-2002 Apple Computer, Inc. All rights reserved.
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
;  * Copyright (c) 1999-2002 Apple Computer, Inc.  All rights reserved.
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_IOFIREWIRECONTROLLER_H
; #define _IOKIT_IOFIREWIRECONTROLLER_H
; #ifndef FIREWIREPRIVATE

; #warning Please do not include this file. Include IOFireWireBus.h instead.

; #endif


(require-interface "IOKit/IOEventSource")

(require-interface "IOKit/firewire/IOFireWireBus")

(require-interface "IOKit/firewire/IOFireWireFamilyCommon")

#|class OSData;
|#

#|class IOWorkLoop;
|#

#|class IOEventSource;
|#

#|class IOFWQEventSource;
|#

#|class IOTimerEventSource;
|#

#|class IOMemoryDescriptor;
|#

#|class IOFireWireController;
|#

#|class IOFWAddressSpace;
|#

#|class IOFWPseudoAddressSpace;
|#

#|class IOFireWireNub;
|#

#|class IOFireWireDevice;
|#

#|class IOFireWireUnit;
|#

#|class IODCLProgram;
|#

#|class IOLocalConfigDirectory;
|#

#|class IOFireWireLink;
|#

#|class IOFireWireSBP2ORB;
|#

#|class IOFireWireSBP2Login;
|#

#|class IOFireWireROMCache;
|#

#|class IOFireWireLocalNode;
|#

#|class IOFWWorkLoop;
|#

#|class IOFireWireIRM;
|#

#|class IOFireWirePowerManager;
|#

; #if FIRELOGCORE
#| 
#|class IOFireLog;
|#

#|class IOFireLogPublisher;
|#
 |#

; #endif

;  Phy packet defs.

(defconstant $kFWPhyPacketID #xC0000000)
(defconstant $kFWPhyPacketIDPhase 30)
(defconstant $kFWPhyPacketPhyID #xFF000000)
(defconstant $kFWPhyPacketPhyIDPhase 24)

(defconstant $kSelfIDPacketSize 8)
(defconstant $kMaxSelfIDs 4)                    ;  SelfID 0,1,3,8


(defconstant $kFWConfigurationPacketID 0)
(defconstant $kFWLinkOnPacketID 1)
(defconstant $kFWSelfIDPacketID 2)

(defconstant $kFWPhyConfigurationR #x800000)
(defconstant $kFWPhyConfigurationT #x400000)
(defconstant $kFWPhyConfigurationGapCnt #xFFFF0000)
(defconstant $kFWPhyConfigurationGapCntPhase 16)

(defconstant $kFWSelfIDPortStatusChild 3)
(defconstant $kFWSelfIDPortStatusParent 2)
(defconstant $kFWSelfIDPortStatusNotConnected 1)
(defconstant $kFWSelfIDPortStatusNotPresent 0)
(defconstant $kFWSelfIDNoPower 0)
(defconstant $kFWSelfIDSelfPowered15W 1)
(defconstant $kFWSelfIDSelfPowered30W 2)
(defconstant $kFWSelfIDSelfPowered45W 3)
(defconstant $kFWSelfIDBusPowered1W 4)
(defconstant $kFWSelfIDBusPowered3W 5)
(defconstant $kFWSelfIDBusPowered6W 6)
(defconstant $kFWSelfIDBusPowered10W 7)
(defconstant $kFWSelfIDPhyID #xFF000000)        ; zzz do we need or want this?

(defconstant $kFWSelfIDPhyIDPhase 24)
(defconstant $kFWSelfIDM 1)
(defconstant $kFWSelfID0L #x400000)
(defconstant $kFWSelfID0GapCnt #xFFFF0000)
(defconstant $kFWSelfID0GapCntPhase 16)
(defconstant $kFWSelfID0SP #xFFFFC000)
(defconstant $kFWSelfID0SPPhase 14)
(defconstant $kFWSelfID0Del #xFFFFF000)
(defconstant $kFWSelfID0DelPhase 12)
(defconstant $kFWSelfID0C #x800)
(defconstant $kFWSelfID0Pwr #xFFFFFF00)
(defconstant $kFWSelfID0PwrPhase 8)
(defconstant $kFWSelfID0P0 #xFFFFFFC0)
(defconstant $kFWSelfID0P0Phase 6)
(defconstant $kFWSelfID0P1 #xFFFFFFF0)
(defconstant $kFWSelfID0P1Phase 4)
(defconstant $kFWSelfID0P2 #xFFFFFFFC)
(defconstant $kFWSelfID0P2Phase 2)
(defconstant $kFWSelfID0I 2)
(defconstant $kFWSelfIDPacketType #x800000)
(defconstant $kFWSelfIDNN #xFFF00000)
(defconstant $kFWSelfIDNNPhase 20)
(defconstant $kFWSelfIDNPa #xFFFF0000)
(defconstant $kFWSelfIDNPaPhase 16)
(defconstant $kFWSelfIDNPb #xFFFFC000)
(defconstant $kFWSelfIDNPbPhase 14)
(defconstant $kFWSelfIDNPc #xFFFFF000)
(defconstant $kFWSelfIDNPcPhase 12)
(defconstant $kFWSelfIDNPd #xFFFFFC00)
(defconstant $kFWSelfIDNPdPhase 10)
(defconstant $kFWSelfIDNPe #xFFFFFF00)
(defconstant $kFWSelfIDNPePhase 8)
(defconstant $kFWSelfIDNPf #xFFFFFFC0)
(defconstant $kFWSelfIDNPfPhase 6)
(defconstant $kFWSelfIDNPg #xFFFFFFF0)
(defconstant $kFWSelfIDNPgPhase 4)
(defconstant $kFWSelfIDNPh #xFFFFFFFC)
(defconstant $kFWSelfIDNPhPhase 2)
(defconstant $kFWSelfIDMore 1)
;  Primary packet defs.

(defconstant $kFWPacketTCode #xFFFFFFF0)
(defconstant $kFWPacketTCodePhase 4)

(defconstant $kFWAsynchSpd #xFFFF0000)
(defconstant $kFWAsynchSpdPhase 16)
(defconstant $kFWAsynchTLabel #xFFFFFC00)
(defconstant $kFWAsynchTLabelPhase 10)
(defconstant $kFWAsynchTTotal #x400000)
(defconstant $kFWAsynchRt #xFFFFFF00)
(defconstant $kFWAsynchRtPhase 8)
(defconstant $kFWAsynchNew 0)
(defconstant $kFWAsynchRetryA 2)
(defconstant $kTIAsycnhRetryB 3)
(defconstant $kFWAsynchPriority #xFFFFFFFF)
(defconstant $kFWAsynchPriorityPhase 0)
(defconstant $kFWAsynchDestinationID #xFFFF0000)
(defconstant $kFWAsynchDestinationIDPhase 16)
(defconstant $kFWAsynchSourceID #xFFFF0000)
(defconstant $kFWAsynchSourceIDPhase 16)
(defconstant $kFWAsynchDestinationOffsetHigh #xFFFFFFFF)
(defconstant $kFWAsynchDestinationOffsetHighPhase 0)
(defconstant $kFWAsynchDestinationOffsetLow #xFFFFFFFF)
(defconstant $kFWAsynchDestinationOffsetLowPhase 0)
(defconstant $kFWAsynchDataLength #xFFFF0000)
(defconstant $kFWAsynchDataLengthPhase 16)
(defconstant $kFWAsynchExtendedTCode #xFFFFFFFF)
(defconstant $kFWAsynchExtendedTCodePhase 0)
(defconstant $kFWAsynchAckSent #xFFFFFFFF)
(defconstant $kFWAsynchAckSentPhase 0)
(defconstant $kFWAsynchRCode #xFFFFF000)
(defconstant $kFWAsynchRCodePhase 12)

(defconstant $kFWTCodeWriteQuadlet 0)
(defconstant $kFWTCodeWriteBlock 1)
(defconstant $kFWTCodeWriteResponse 2)
(defconstant $kFWTCodeReadQuadlet 4)
(defconstant $kFWTCodeReadBlock 5)
(defconstant $kFWTCodeReadQuadletResponse 6)
(defconstant $kFWTCodeReadBlockResponse 7)
(defconstant $kFWTCodeCycleStart 8)
(defconstant $kFWTCodeLock 9)
(defconstant $kFWTCodeIsochronousBlock 10)
(defconstant $kFWTCodeLockResponse 11)
(defconstant $kFWTCodePHYPacket 14)

(defconstant $kFWExtendedTCodeMaskSwap 1)
(defconstant $kFWExtendedTCodeCompareSwap 2)
(defconstant $kFWExtendedTCodeFetchAdd 3)
(defconstant $kFWExtendedTCodeLittleAdd 4)
(defconstant $kFWExtendedTCodeBoundedAdd 5)
(defconstant $kFWExtendedTCodeWrapAdd 6)
(defconstant $kFWExtendedTCodeVendorDependent 7)
(defrecord AsyncPendingTrans
   (fHandler (:pointer :iofwasynccommand))
   (fTCode :signed-long)
   (fInUse :Boolean)
)
(defrecord IOFWNodeScan
   (fControl (:pointer :iofirewirecontroller))
   (fAddr :FWADDRESSSTRUCT)
   (fBuf (:array :UInt32 5))
                                                ;  Enough for bus info block
   (fSelfIDs (:pointer :UInt32))
   (fNumSelfIDs :signed-long)
   (fROMSize :signed-long)
   (fRead :signed-long)
   (fCmd (:pointer :iofwreadquadcommand))
   (generation :UInt32)
   (speedChecking :Boolean)
)
; #define kMaxPendingTransfers kFWAsynchTTotal

#|class IOFireWireController;
|#
; #pragma mark -
; ! 
; 	@class IOFireWireControllerAux
; 
#|
 confused about CLASS IOFireWireControllerAux #\: public IOFireWireBusAux #\{ OSDeclareDefaultStructors #\( IOFireWireControllerAux #\) friend class IOFireWireController #\; protected #\: IOFireWireController * fPrimary #\;
; ! 
; 		@struct ExpansionData
; 		@discussion This structure will be used to expand the capablilties of the class in the future.
;     
 struct ExpansionData #\{ #\} #\;
; ! 
; 		@var reserved
; 		Reserved for future use.  (Internal use only)  
; 	
 ExpansionData * reserved #\; virtual bool init #\( IOFireWireController * primary #\) #\; virtual void free #\( #\) #\; virtual IOFWDCLPool * createDCLPool #\( unsigned capacity #\) const #\;; 	virtual IOFWBufferFillIsochPort *				createBufferFillIsochPort () const ;
 private #\: OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireControllerAux #\, 7 #\) #\;
|#
; #pragma mark -
; ! @class IOFireWireController
; 
#|
 confused about CLASS IOFireWireController #\: public IOFireWireBus #\{ OSDeclareAbstractStructors #\( IOFireWireController #\) protected #\: enum busState #\{ kStarting = 0 #\, kAsleep #\,;  Link off, zzzzzz
 kWaitingBusReset #\, kWaitingSelfIDs #\,       ;  Bus has been reset, no selfIDs yet
 kWaitingScan #\,                               ;  Got selfIDs, waiting a bit before hitting lame devices
 kScanning #\,                                  ;  Reading node ROMs
 kWaitingPrune #\,                              ;  Read all ROMs, pausing before pruning missing devices
 kRunning                                       ;  Normal happy state
 #\} #\; enum ResetState #\{ kResetStateResetting #\, kResetStateDisabled #\, kResetStateArbitrated #\} #\; enum #\{ kDisablePhysicalAccess = #\( 1 << 0 #\) #\} #\; struct timeoutQ #\: public IOFWCmdQ #\{ IOTimerEventSource * fTimer #\; virtual void headChanged #\( IOFWCommand * oldHead #\) #\; void busReset #\( #\) #\; #\} #\; struct pendingQ #\: public IOFWCmdQ #\{ IOFWQEventSource * fSource #\; virtual void headChanged #\( IOFWCommand * oldHead #\) #\; #\} #\; friend class IOFireWireLink #\; friend class IOFWAddressSpace #\; friend class IOFWPseudoAddressSpace #\; friend class IOFireWireSBP2ORB #\; friend class IOFireWireSBP2Login #\; friend class IOFWLocalIsochPort #\; friend class IOFWCommand #\; friend class IOFireWireDevice #\; friend class IOFireWirePCRSpace #\; friend class IOFireWireROMCache #\; friend class IOFWAsyncStreamCommand #\; friend class IOFWAddressSpaceAux #\; friend class IOFireWireAVCLocalUnit #\; friend class IOFireWireAVCUnit #\; friend class IOFireWireAVCCommand #\; friend class IOFireWirePowerManager #\; friend class IOFWWriteQuadCommand #\; friend class IOFWWriteCommand #\; friend class IOFWCompareAndSwapCommand #\;
; #if FIRELOGCORE
#|  friend class IOFireLog #\;
 |#

; #endif

 IOFireWireLink * fFWIM #\; IOFWWorkLoop * fWorkLoop #\; IOTimerEventSource * fTimer #\; OSSet * fLocalAddresses #\;;  Collection of local adress spaces
 OSIterator * fSpaceIterator #\;                ;  Iterator over local addr spaces
 OSSet * fAllocatedChannels #\;                 ;  Need to be informed of bus resets
 OSIterator * fAllocChannelIterator #\;         ;  Iterator over channels
;  Bus management variables (although we aren't a FireWire Bus Manager...)
 AbsoluteTime fResetTime #\;                    ;  Time of last reset
 UInt32 fBusGeneration #\;                      ;  ID of current bus topology.
 UInt16 fLocalNodeID #\;                        ;  ID of local node, ie. this computer
 UInt16 fRootNodeID #\;                         ;  ID of root, ie. highest node id in use.
 UInt16 fIRMNodeID #\;                          ;  ID of Isochronous resource manager, or kFWBadNodeID
 bool fBusMgr #\;                               ;  true if at least one node is bus manager capable
 IORegistryEntry * fNodes #\[ kFWMaxNodesPerBus #\] #\;;  FireWire nodes on this bus
 UInt32 * fNodeIDs #\[ kFWMaxNodesPerBus + 1 #\] #\;;  Pointer to SelfID list for each node
;  +1 so we know how many selfIDs the last node has
 UInt32 fGapCount #\;                           ;  What we think the gap count should be
 UInt8 fSpeedCodes #\[ #\( kFWMaxNodesPerBus + 1 #\) * kFWMaxNodesPerBus #\] #\;;  Max speed between two nodes
 busState fBusState #\;                         ;  Which state are we in?
 int fNumROMReads #\;                           ;  Number of device ROMs we are still reading
;  SelfIDs
 int fNumSelfIDs #\;                            ;  Total number of SelfID packets
 UInt32 fSelfIDs #\[ kMaxSelfIDs * kFWMaxNodesPerBus #\] #\;;  The local device's Config ROM
 UInt32 fROMHeader #\[ 5 #\] #\;                ;  More or less fixed header and bus info block
 IOLocalConfigDirectory * fRootDir #\;          ;  Local Config ROM root directory.
;  log base 2 of maximum packet size the FWIM can send/receive
;  Normally calculated from bus info block.
 int fMaxSendLog #\; int fMaxRecvLog #\; IOFWAddressSpace * fROMAddrSpace #\; IOMemoryDescriptor * fBadReadResponse #\;;  Send back easily identified bad data to out of range addrs. 
;  Array for outstanding requests (up to 64)
 AsyncPendingTrans fTrans #\[ kMaxPendingTransfers #\] #\; int fLastTrans #\;;  queue for executing commands that may timeout
 timeoutQ fTimeoutQ #\;                         ;  queue for commands that can't execute yet
 pendingQ fPendingQ #\;                         ;  queue for async commands interrupted by bus reset
 IOFWCmdQ fAfterResetHandledQ #\;               ;  Command to change bus state after a delay.
 IOFWDelayCommand * fDelayedStateChangeCmd #\; bool fDelayedStateChangeCmdNeedAbort #\; UInt32 fDelayedPhyPacket #\; bool fBusResetScheduled #\; ResetState fBusResetState #\; IOFWDelayCommand * fBusResetStateChangeCmd #\; UInt32 fBusResetDisabledCount #\;
; #if FIRELOGCORE
#|  IOFireLogPublisher * fFireLogPublisher #\;
 |#

; #else
 void * fFireLogPublisher #\;
; #endif

 OSData * fAllocatedAddresses #\; UInt32 fDevicePruneDelay #\; IOFWPhysicalAccessMode fPhysicalAccessMode #\; IOFWSecurityMode fSecurityMode #\; IONotifier * fKeyswitchNotifier #\; IOFireWireIRM * fIRM #\; IOFireWirePowerManager * fBusPowerManager #\; bool fGapCountMismatch #\; UInt8 fHopCounts #\[ #\( kFWMaxNodesPerBus + 1 #\) * kFWMaxNodesPerBus #\] #\;
; ! @struct ExpansionData
;     @discussion This structure will be used to expand the capablilties of the class in the future.
;     
 struct ExpansionData #\{ #\} #\;
; ! @var reserved
;     Reserved for future use.  (Internal use only)  
 ExpansionData * reserved #\; static void clockTick #\( OSObject * #\, IOTimerEventSource * #\) #\; static void readROMGlue #\( void * refcon #\, IOReturn status #\, IOFireWireNub * device #\, IOFWCommand * fwCmd #\) #\; static void delayedStateChange #\( void * refcon #\, IOReturn status #\, IOFireWireBus * bus #\, IOFWBusCommand * fwCmd #\) #\; virtual void processBusReset #\( #\) #\; virtual void processSelfIDs #\( UInt32 * IDs #\, int numIDs #\, UInt32 * ownIDs #\, int numOwnIDs #\) #\; virtual void processTimeout #\( IOTimerEventSource * src #\) #\; virtual void processRcvPacket #\( UInt32 * data #\, int numQuads #\) #\; virtual void processWriteRequest #\( UInt16 sourceID #\, UInt32 tlabel #\, UInt32 * hdr #\, void * buf #\, int len #\) #\; virtual void processLockRequest #\( UInt16 sourceID #\, UInt32 tlabel #\, UInt32 * hdr #\, void * buf #\, int len #\) #\;;  Process read from a local address, return rcode
 virtual UInt32 doReadSpace #\( UInt16 nodeID #\, IOFWSpeed &speed #\, FWAddress addr #\, UInt32 len #\, IOMemoryDescriptor ** buf #\, IOByteCount * offset #\, IOFWRequestRefCon refcon #\) #\;;  Process write to a local address, return rcode
 virtual UInt32 doWriteSpace #\( UInt16 nodeID #\, IOFWSpeed &speed #\, FWAddress addr #\, UInt32 len #\, const void * buf #\, IOFWRequestRefCon refcon #\) #\;;  Process lock to a local address, return rcode
 UInt32 doLockSpace #\( UInt16 nodeID #\, IOFWSpeed &speed #\, FWAddress addr #\, UInt32 inlen #\, const UInt32 * newVal #\, UInt32 &outLen #\, UInt32 * oldVal #\, UInt32 extType #\, IOFWRequestRefCon refcon #\) #\; virtual void updatePlane #\( #\) #\; virtual void startBusScan #\( #\) #\;;  Called when all devices on bus have been examined
 virtual void finishedBusScan #\( #\) #\; virtual void buildTopology #\( bool doFWPlane #\) #\; virtual void readDeviceROM #\( IOFWNodeScan * refCon #\, IOReturn status #\) #\; virtual IOReturn UpdateROM #\( #\) #\; virtual IOReturn allocAddress #\( IOFWAddressSpace * space #\) #\; virtual void freeAddress #\( IOFWAddressSpace * space #\) #\; IOFireWireBusAux * createAuxiliary #\( void #\) #\; public #\:;  Initialization
 virtual bool init #\( IOFireWireLink * fwim #\) #\; virtual void free #\( #\) #\; virtual bool start #\( IOService * provider #\) #\; virtual void stop #\( IOService * provider #\) #\; virtual bool finalize #\( IOOptionBits options #\) #\; virtual bool requestTerminate #\( IOService * provider #\, IOOptionBits options #\) #\;;  Power management
 virtual IOReturn setPowerState #\( unsigned long powerStateOrdinal #\, IOService * whatDevice #\) #\;;  Implement IOService::getWorkLoop
 virtual IOWorkLoop * getWorkLoop #\( #\) const #\;;  Allocate struct for tracking a transaction
 virtual AsyncPendingTrans * allocTrans #\( IOFWAsyncCommand * cmd = NULL #\) #\; virtual void freeTrans #\( AsyncPendingTrans * trans #\) #\;;  Really public methods
 virtual IOReturn getCycleTime #\( UInt32 &cycleTime #\) #\; virtual IOReturn getBusCycleTime #\( UInt32 &busTime #\, UInt32 &cycleTime #\) #\;;  Methods to manipulate the local Config ROM
 virtual IOReturn AddUnitDirectory #\( IOLocalConfigDirectory * unitDir #\) #\; virtual IOReturn RemoveUnitDirectory #\( IOLocalConfigDirectory * unitDir #\) #\;;  Cause a bus reset
 virtual IOReturn resetBus #\( #\) #\;          ;  Send async request packets
 virtual IOReturn asyncRead #\( UInt32 generation #\, UInt16 nodeID #\, UInt16 addrHi #\, UInt32 addrLo #\, int speed #\, int label #\, int size #\, IOFWAsyncCommand * cmd #\) #\; virtual IOReturn asyncWrite #\( UInt32 generation #\, UInt16 nodeID #\, UInt16 addrHi #\, UInt32 addrLo #\, int speed #\, int label #\, IOMemoryDescriptor * buf #\, IOByteCount offset #\, int size #\, IOFWAsyncCommand * cmd #\) #\;;  DEPRECATED 
 virtual IOReturn asyncWrite #\( UInt32 generation #\,;  DEPRECATED 
 UInt16 nodeID #\,                              ;  DEPRECATED 
 UInt16 addrHi #\,                              ;  DEPRECATED 
 UInt32 addrLo #\,                              ;  DEPRECATED 
 int speed #\,                                  ;  DEPRECATED 
 int label #\,                                  ;  DEPRECATED 
 void * data #\,                                ;  DEPRECATED 
 int size #\,                                   ;  DEPRECATED 
 IOFWAsyncCommand * cmd #\) #\;                 ;  DEPRECATED 
 virtual IOReturn asyncLock #\( UInt32 generation #\,;  DEPRECATED 
 UInt16 nodeID #\,                              ;  DEPRECATED 
 UInt16 addrHi #\,                              ;  DEPRECATED 
 UInt32 addrLo #\,                              ;  DEPRECATED 
 int speed #\,                                  ;  DEPRECATED 
 int label #\,                                  ;  DEPRECATED 
 int type #\,                                   ;  DEPRECATED 
 void * data #\,                                ;  DEPRECATED 
 int size #\,                                   ;  DEPRECATED 
 IOFWAsyncCommand * cmd #\) #\;                 ;  Send async read response packets
;  useful for pseudo address spaces that require servicing outside the FireWire work loop.
 virtual IOReturn asyncReadResponse #\( UInt32 generation #\, UInt16 nodeID #\, int speed #\, IOMemoryDescriptor * buf #\, IOByteCount offset #\, int len #\, IOFWRequestRefCon refcon #\) #\; virtual IOReturn asyncLockResponse #\( UInt32 generation #\, UInt16 nodeID #\, int speed #\, IOMemoryDescriptor * buf #\, IOByteCount offset #\, int len #\, IOFWRequestRefCon refcon #\) #\;;  Try to fix whatever might have caused the other device to not respond
 virtual IOReturn handleAsyncTimeout #\( IOFWAsyncCommand * cmd #\) #\;;  Convert a firewire nodeID into the IOFireWireDevice for it
 virtual IOFireWireDevice * nodeIDtoDevice #\( UInt32 generation #\, UInt16 nodeID #\) #\;;  Add/remove a channel from the list informed of bus resets
 virtual void addAllocatedChannel #\( IOFWIsochChannel * channel #\) #\; virtual void removeAllocatedChannel #\( IOFWIsochChannel * channel #\) #\;;  Create an Isochronous Channel object
;  doIRM = true => allocate channel and bandwith in Isochronous Resource Manager
;  packetSize packet size (in bytes), used to calculate bandwidth needed.
 virtual IOFWIsochChannel * createIsochChannel #\( bool doIRM #\, UInt32 packetSize #\, IOFWSpeed prefSpeed #\, FWIsochChannelForceStopNotificationProc stopProc = NULL #\, void * stopRefCon = NULL #\) #\;;  Create a local isochronous port to run the given DCL program
;  if task is 0, the DCL program is for the kernel task,
;  otherwise all DCL pointers are valid in the specified task.
;  opcodes is also pointer valid in the specified task.
 virtual IOFWLocalIsochPort * createLocalIsochPort #\( bool talking #\, DCLCommand * opcodes #\, DCLTaskInfo * info = 0 #\, UInt32 startEvent = 0 #\, UInt32 startState = 0 #\, UInt32 startMask = 0 #\) #\;;  Execute specified function on workloop after specified delay
;  Returned command is for delay, call it's cancel() function to cancel timeout.
 virtual IOFWDelayCommand * createDelayedCmd #\( UInt32 uSecDelay #\, FWBusCallback func #\, void * refcon #\) #\; virtual IOFWPhysicalAddressSpace * createPhysicalAddressSpace #\( IOMemoryDescriptor * mem #\) #\; virtual IOFWPseudoAddressSpace * createPseudoAddressSpace #\( FWAddress * addr #\, UInt32 len #\, FWReadCallback reader #\, FWWriteCallback writer #\, void * refcon #\) #\;;  Extract info about the async request 
 virtual bool isLockRequest #\( IOFWRequestRefCon refcon #\) #\; virtual bool isQuadRequest #\( IOFWRequestRefCon refcon #\) #\; virtual UInt32 getExtendedTCode #\( IOFWRequestRefCon refcon #\) #\;;  Inline accessors for protected member variables
 IOFWCmdQ &getTimeoutQ #\( #\) #\; IOFWCmdQ &getPendingQ #\( #\) #\; IOFWCmdQ &getAfterResetHandledQ #\( #\) #\; IOFireWireLink * getLink #\( #\) const #\; IOLocalConfigDirectory * getRootDir #\( #\) const #\; bool checkGeneration #\( UInt32 gen #\) const #\; UInt32 getGeneration #\( #\) const #\; UInt16 getLocalNodeID #\( #\) const #\; IOReturn getIRMNodeID #\( UInt32 &generation #\, UInt16 &id #\) const #\; const AbsoluteTime * getResetTime #\( #\) const #\; IOFWSpeed FWSpeed #\( UInt16 nodeAddress #\) const #\; IOFWSpeed FWSpeed #\( UInt16 nodeA #\, UInt16 nodeB #\) const #\;;  How big (as a power of two) can packets sent to/received from the node be?
 virtual int maxPackLog #\( bool forSend #\, UInt16 nodeAddress #\) const #\;;  How big (as a power of two) can packets sent from A to B be?
 virtual int maxPackLog #\( UInt16 nodeA #\, UInt16 nodeB #\) const #\;;  Force given node to be root (via root holdoff Phy packet)
 virtual IOReturn makeRoot #\( UInt32 generation #\, UInt16 nodeID #\) #\; virtual IOFWPseudoAddressSpace * createInitialAddressSpace #\( UInt32 addressLo #\, UInt32 len #\, FWReadCallback reader #\, FWWriteCallback writer #\, void * refcon #\) #\; virtual IOFWAddressSpace * getAddressSpace #\( FWAddress address #\) #\;;  Extract info about the async request - was the request ack'ed complete already?
 virtual bool isCompleteRequest #\( IOFWRequestRefCon refcon #\) #\;;  Are we currently scanning the bus?
 bool scanningBus #\( #\) const #\; protected #\: void openGate #\( #\) #\; void closeGate #\( #\) #\; protected #\: virtual void doBusReset #\( void #\) #\; static void resetStateChange #\( void * refcon #\, IOReturn status #\, IOFireWireBus * bus #\, IOFWBusCommand * fwCmd #\) #\; public #\: virtual IOReturn disableSoftwareBusResets #\( void #\) #\; virtual void enableSoftwareBusResets #\( void #\) #\; virtual IOFWAsyncStreamCommand * createAsyncStreamCommand #\( UInt32 generation #\, UInt32 channel #\, UInt32 sync #\, UInt32 tag #\, IOMemoryDescriptor * hostMem #\, UInt32 size #\, int speed #\, FWAsyncStreamCallback completion #\, void * refcon #\) #\; virtual IOReturn asyncStreamWrite #\( UInt32 generation #\, int speed #\, int tag #\, int sync #\, int channel #\, IOMemoryDescriptor * buf #\, IOByteCount offset #\, int size #\, IOFWAsyncStreamCommand * cmd #\) #\; protected #\: bool inGate #\( #\) #\; virtual IOReturn allocatePseudoAddress #\( FWAddress * addr #\, UInt32 lenDummy #\) #\; virtual void freePseudoAddress #\( FWAddress addr #\, UInt32 lenDummy #\) #\; virtual IORegistryEntry * createDummyRegistryEntry #\( IOFWNodeScan * scan #\) #\; static IOFireWireLocalNode * getLocalNode #\( IOFireWireController * control #\) #\; virtual void setPhysicalAccessMode #\( IOFWPhysicalAccessMode mode #\) #\; virtual IOFWPhysicalAccessMode getPhysicalAccessMode #\( void #\) #\; virtual void physicalAccessProcessBusReset #\( void #\) #\; virtual void setNodeIDPhysicalFilter #\( UInt16 nodeID #\, bool state #\) #\; virtual void initSecurity #\( void #\) #\; virtual void freeSecurity #\( void #\) #\; static bool serverKeyswitchCallback #\( void * target #\, void * refCon #\, IOService * service #\) #\; virtual void setSecurityMode #\( IOFWSecurityMode mode #\) #\; virtual IOFWSecurityMode getSecurityMode #\( void #\) #\; virtual IOReturn createTimeoutQ #\( void #\) #\; virtual void destroyTimeoutQ #\( void #\) #\; virtual IOReturn createPendingQ #\( void #\) #\; virtual void destroyPendingQ #\( void #\) #\; virtual UInt32 countNodeIDChildren #\( UInt16 nodeID #\) #\; public #\: virtual UInt32 hopCount #\( UInt16 nodeAAddress #\, UInt16 nodeBAddress #\) #\; virtual UInt32 hopCount #\( UInt16 nodeAAddress #\) #\; virtual IOFireWirePowerManager * getBusPowerManager #\( void #\) #\; protected #\: virtual void handleARxReqIntComplete #\( #\) #\; virtual IOReturn asyncLock #\( UInt32 generation #\, UInt16 nodeID #\, UInt16 addrHi #\, UInt32 addrLo #\, int speed #\, int label #\, int type #\, IOMemoryDescriptor * buf #\, IOByteCount offset #\, int size #\, IOFWAsyncCommand * cmd #\) #\; virtual IOReturn asyncWrite #\( UInt32 generation #\, UInt16 nodeID #\, UInt16 addrHi #\, UInt32 addrLo #\, int speed #\, int label #\, IOMemoryDescriptor * buf #\, IOByteCount offset #\, int size #\, IOFWAsyncCommand * cmd #\, IOFWWriteFlags flags #\) #\; protected #\: bool delayedStateCommandInUse #\( #\) const #\; void enterBusResetDisabledState #\( #\) #\; public #\: IOReturn clipMaxRec2K #\( Boolean clipMaxRec #\) #\; private #\: OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 7 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFireWireController #\, 8 #\) #\;
|#

; #endif /* ! _IOKIT_IOFIREWIRECONTROLLER_H */


(provide-interface "IOFireWireController")