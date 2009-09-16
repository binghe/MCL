(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOATABlockStorageDriver.h"
; at Sunday July 2,2006 7:28:20 pm.
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
; #ifndef _IO_ATA_BLOCKSTORAGE_DRIVER_H_
; #define _IO_ATA_BLOCKSTORAGE_DRIVER_H_
;  osfmk includes 

(require-interface "kern/queue")
;  General IOKit includes 

(require-interface "IOKit/IOLib")

(require-interface "IOKit/IOMessage")

(require-interface "IOKit/IOService")

(require-interface "IOKit/IOSyncer")

(require-interface "IOKit/IOCommandGate")

(require-interface "IOKit/IOCommandPool")
;  IOKit ATA includes 

(require-interface "IOKit/storage/IOStorage")

(require-interface "IOKit/storage/ata/IOATAStorageDefines")

(require-interface "IOKit/ata/IOATADevice")

(require-interface "IOKit/ata/IOATATypes")
;  Forward class declaration

#|class IOATABlockStorageDriver;
|#
; ! 
; 	@typedef ATAClientData
; 	@param cmd IOATACommand for request.
; 	@param self Pointer to the object. 
; 	@param completion Either the async completion structure or an IOSyncer to wake up.
; 	@param isSync Flag - tells whether the command was sync or async.
; 	@param maxRetries Maxiumum number of retry attempts per I/O.
; 	@param returnCode Return code (errors).
; 	@param buffer Original memory descriptor.
; 	@param bufferOffset Offset into client's buffer.
; 	@param startBlock Original starting block.
; 	@param numberOfBlocks Original number of requested blocks.
; 	@param opCode ATA opcode.
; 	@param flags Flags to use for the operation.
; 	@param timeout Timeout value in milliseconds.
; 	@param regMask Register Mask.
; 	@param featuresReg Features register.
; 	@param sdhReg The SDH register
; 	@param command The command register.
; 	@param cylHigh The Cylinder high bits.
; 	@param cylLow The Cylinder low bits.
; 	@param sectorNumber The Sector Number register.
; 	@param sectorCount The Sector Count register.
; 	@discussion This structure is stuffed into the refcon so we can associate which
; 	IOATACommand is completing.
; 
(defrecord ATAClientData
   (cmd (:pointer :ioatacommand))
                                                ;  pointer to command object this wraps
   (self (:pointer :ioatablockstoragedriver))
                                                ;  pointer to self
   (:variant
   (
   (async :iostoragecompletion)
#|
; Warning: type-size: unknown type IOSTORAGECOMPLETION
|#
   )
                                                ;  completion target/action/param.
   (
   (syncLock (:pointer :iosyncer))
   )
                                                ;  used by sync commands.
   )
   (isSync :Boolean)
                                                ;  command is synchronous.
   (maxRetries :SInt32)
                                                ;  max retry attempts (0 = no retry).
   (returnCode :signed-long)
                                                ;  sync command return code.
   (buffer (:pointer :iomemorydescriptor))
                                                ;  needed for retries
   (bufferOffset :UInt32)
                                                ;  offset into client buffer
   (startBlock :UInt32)
                                                ;  needed for retries
   (numberOfBlocks :UInt32)
                                                ;  needed for retries
                                                ;  Saved state data for ATA registers
   (opCode :ataopcode)
#|
; Warning: type-size: unknown type ATAOPCODE
|#
                                                ;  Opcode of the desired operation
   (flags :UInt32)
                                                ;  Flags to use for this operation
   (timeout :UInt32)
                                                ;  Original timeout value
   (regMask :ataregmask)
#|
; Warning: type-size: unknown type ATAREGMASK
|#
                                                ;  Mask to tell controller what registers
                                                ;  to read/write
   (featuresReg :UInt8)
                                                ;  Features register
   (sdhReg :UInt8)
                                                ;  Set Device Head register
   (command :UInt8)
                                                ;  Command to use for this operation
   (cylHigh :UInt8)
                                                ;  High bits of the cylinder register
   (cylLow :UInt8)
                                                ;  Low bits of the cylinder register
   (sectorNumber :UInt8)
                                                ;  Value of the sectorNumber register
   (sectorCount :UInt8)
                                                ;  Value of the sectorCount register
                                                ;  added for 48-bit LBA support
   (useExtendedLBA :Boolean)
   (lbaLow16 :UInt16)
   (lbaMid16 :UInt16)
   (lbaHigh16 :UInt16)
   (sectorCount16 :UInt16)
   (features16 :UInt16)
   (device :UInt8)
   (command16 :UInt16)
)

;type name? (%define-record :ATAClientData (find-record-descriptor ':ATAClientData))
;  Property table keys
(defconstant $kIOATASupportedFeaturesKey "ATA Features")
; #define kIOATASupportedFeaturesKey		"ATA Features"
#|
 confused about CLASS IOATABlockStorageDriver #\: public IOService #\{ OSDeclareDefaultStructors #\( IOATABlockStorageDriver #\) protected #\: IOATADevice * fATADevice #\; ataUnitID fATAUnitID #\; ataDeviceType fATADeviceType #\; ataSocketType fATASocketType #\; UInt8 fPIOMode #\; UInt8 fDMAMode #\; UInt8 fUltraDMAMode #\; bool fUseLBAAddressing #\; IOCommandPool * fCommandPool #\; IOCommandGate * fCommandGate #\; UInt32 fNumCommandObjects #\; UInt32 fNumCommandsOutstanding #\;;  "Special commands"
 IOATACommand * fResetCommand #\; IOATACommand * fPowerManagementCommand #\; IOATACommand * fConfigurationCommand #\; UInt16 fDeviceIdentifyData #\[ 256 #\] #\; IOMemoryDescriptor * fDeviceIdentifyBuffer #\; char fRevision #\[ kSizeOfATARevisionString + 1 #\] #\; char fModel #\[ kSizeOfATAModelString + 1 #\] #\; UInt8 fAPMLevel #\; IOOptionBits fSupportedFeatures #\; thread_call_t fPowerManagementThread #\; bool fWakeUpResetOccurred #\; IOATAPowerState fCurrentPowerState #\; IOATAPowerState fProposedPowerState #\; bool fPowerTransitionInProgress #\; bool fPowerManagementInitialized #\; bool fResetInProgress #\;;  binary compatibility instance variable expansion
 struct ExpansionData #\{ bool fUseExtendedLBA #\; bool fPowerAckInProgress #\; IONotifier * fPowerDownNotifier #\; #\} #\; ExpansionData * reserved #\;
; #define fUseExtendedLBA		reserved->fUseExtendedLBA
; #define fPowerAckInProgress	reserved->fPowerAckInProgress
; #define fPowerDownNotifier	reserved->fPowerDownNotifier
 public #\:                                     ;  Called when system is going to power down
 IOReturn powerDownHandler #\( void * refCon #\, UInt32 messageType #\, IOService * provider #\, void * messageArgument #\, vm_size_t argSize #\) #\; protected #\:; -----------------------------------------------------------------------
;  Static member functions
 static void sSwapBytes16 #\( UInt8 * buffer #\, IOByteCount numBytesToSwap #\) #\; static UInt8 sConvertHighestBitToNumber #\( UInt16 bitField #\) #\; static void sHandleCommandCompletion #\( IOATACommand * cmd #\) #\; static void sHandleReset #\( IOATACommand * cmd #\) #\; static void sPowerManagement #\( thread_call_param_t whichDevice #\) #\; static void sHandleSetPowerState #\( IOATABlockStorageDriver * self #\, UInt32 powerStateOrdinal #\) #\; static void sHandleCheckPowerState #\( IOATABlockStorageDriver * self #\) #\; static void sHandleSimpleSyncTransaction #\( IOATACommand * cmd #\) #\; static void sConvertBlockToCHSAddress #\( IOATACommand * cmd #\, UInt32 block #\, UInt32 heads #\, UInt32 sectors #\, ataUnitID unitID #\) #\; static void sReissueCommandFromClientData #\( IOATACommand * cmd #\) #\; static void sSetCommandBuffers #\( IOATACommand * cmd #\, IOMemoryDescriptor * buffer #\, IOByteCount offset #\, IOByteCount numBlocks #\) #\; static void sSaveStateData #\( IOATACommand * cmd #\) #\; static IOReturn sValidateIdentifyData #\( UInt8 * deviceIdentifyData #\) #\;;  The sSetWakeupResetOccurred method is used to safely set member variables
;  behind the command gate.
 static void sSetWakeupResetOccurred #\( IOATABlockStorageDriver * driver #\, bool resetOccurred #\) #\;;  The sCheckWakeupResetOccur method is used to safely check member variables
;  behind the command gate.
 static void sCheckWakeupResetOccurred #\( IOATABlockStorageDriver * driver #\, void * resetOccurred #\) #\; static void sATAConfigStateMachine #\( IOATACommand * cmd #\) #\; static void sATAVoidCallback #\( IOATACommand * cmd #\) #\;; -----------------------------------------------------------------------
;  Release all allocated resource before calling super::free().
 virtual void free #\( void #\) #\;             ; -----------------------------------------------------------------------
;  Stop any power management
 virtual bool finalize #\( IOOptionBits options #\) #\;; -----------------------------------------------------------------------
;  Setup an ATATaskFile from the parameters given
 virtual void setupReadWriteTaskFile #\( IOATACommand * cmd #\, IOMemoryDescriptor * buffer #\, UInt32 block #\, UInt32 nblks #\) #\;; -----------------------------------------------------------------------
;  Return an IOATACommand initialized to perform a read/write operation.
 virtual IOATACommand * ataCommandReadWrite #\( IOMemoryDescriptor * buffer #\, UInt32 block #\, UInt32 nblks #\) #\;; -----------------------------------------------------------------------
;  Return an ATA Set Features command.
 virtual IOReturn ataCommandSetFeatures #\( UInt8 features #\, UInt8 sectorCount = 0 #\, UInt8 sectorNumber = 0 #\, UInt8 cylinderLow = 0 #\, UInt8 cylinderHigh = 0 #\, UInt32 flags = 0 #\, bool forceSync = false #\) #\;; -----------------------------------------------------------------------
;  Return an ATA Flush Cache command.
 virtual IOATACommand * ataCommandFlushCache #\( void #\) #\;; -----------------------------------------------------------------------
;  Issues a power transition
 virtual IOReturn issuePowerTransition #\( UInt32 function #\) #\;; -----------------------------------------------------------------------
;  Issue a synchronous ATA command.
 virtual IOReturn syncExecute #\( IOATACommand * cmd #\, UInt32 timeout = kATADefaultTimeout #\, UInt8 retries = kATADefaultRetries #\) #\;; -----------------------------------------------------------------------
;  Issue an asynchronous ATA command.
 virtual IOReturn asyncExecute #\( IOATACommand * cmd #\, IOStorageCompletion completion #\, UInt32 timeout = kATADefaultTimeout #\, UInt8 retries = kATADefaultRetries #\) #\;; -----------------------------------------------------------------------
;  Inspect the ATA device.
 virtual bool inspectDevice #\( IOATADevice * device #\) #\;; -----------------------------------------------------------------------
;  Returns an IOATABlockStorageDevice instance.
 virtual IOService * instantiateNub #\( void #\) #\;; -----------------------------------------------------------------------
;  Calls instantiateNub() then initialize, attach, and register the
;  drive nub.
 virtual bool createNub #\( IOService * provider #\) #\;; -----------------------------------------------------------------------
;  Power management support. Subclasses can override these functions
;  to replace/enhance the default power management support.
 virtual void initForPM #\( void #\) #\; virtual void handleSetPowerState #\( UInt32 powerStateOrdinal #\) #\;; -----------------------------------------------------------------------
;  Allocate/Deallocate ATA commands.
 virtual void allocateATACommandObjects #\( void #\) #\; virtual void deallocateATACommandObjects #\( void #\) #\;; -----------------------------------------------------------------------
;  Get/return ATA commands
 virtual IOATACommand * getATACommandObject #\( bool blockForCommand = true #\) #\; virtual void returnATACommandObject #\( IOATACommand * cmd #\) #\;; -----------------------------------------------------------------------
;  Initialization and Configuation calls
 virtual IOReturn setPIOTransferMode #\( bool forceSync #\) #\; virtual IOReturn setDMATransferMode #\( bool forceSync #\) #\; virtual IOReturn identifyAndConfigureATADevice #\( void #\) #\; virtual IOReturn configureATADevice #\( void #\) #\; virtual IOReturn reconfigureATADevice #\( void #\) #\; virtual IOReturn identifyATADevice #\( void #\) #\; virtual IOReturn resetATADevice #\( void #\) #\;;  The checkWakeupResetOccurred method is used to safely find out if a reset
;  occurred while we were asleep.
 virtual bool checkWakeupResetOccurred #\( void #\) #\;;  The setWakeupResetOccurred method is used to safely set/clear the reset flag.
 virtual void setWakeupResetOccurred #\( bool resetOccurred #\) #\; public #\:;  Overrides from IOService
 bool init #\( OSDictionary * propertyTable #\) #\; virtual bool start #\( IOService * provider #\) #\; virtual void stop #\( IOService * provider #\) #\;;  Necessary for calls from user space to set the APM level.
 virtual IOReturn setAdvancedPowerManagementLevel #\( UInt8 level #\, bool forceSync #\) #\;; -----------------------------------------------------------------------
;  Power management support. Functions inherited from IOService.
 virtual IOReturn setAggressiveness #\( UInt32 type #\, UInt32 minutes #\) #\;;  The initialPowerStateForDomainState() method is called by the power manager
;  to ask us what state we should be in based on the power flags of our parent
;  in the power tree.
 virtual UInt32 initialPowerStateForDomainState #\( IOPMPowerFlags flags #\) #\; virtual IOReturn setPowerState #\( UInt32 powerStateOrdinal #\, IOService * whatDevice #\) #\;; -----------------------------------------------------------------------
;  Report the type of ATA device (ATA vs. ATAPI).
 virtual ataDeviceType reportATADeviceType #\( void #\) const #\;; -----------------------------------------------------------------------
;  Handles read/write requests.
 virtual IOReturn doAsyncReadWrite #\( IOMemoryDescriptor * buffer #\, UInt32 block #\, UInt32 nblks #\, IOStorageCompletion completion #\) #\; virtual IOReturn doSyncReadWrite #\( IOMemoryDescriptor * buffer #\, UInt32 block #\, UInt32 nblks #\) #\;; -----------------------------------------------------------------------
;  Eject the media in the drive.
 virtual IOReturn doEjectMedia #\( void #\) #\; ; -----------------------------------------------------------------------
;  Format the media in the drive.
 virtual IOReturn doFormatMedia #\( UInt64 byteCapacity #\) #\;; -----------------------------------------------------------------------
;  Returns disk capacity in bytes.
 virtual UInt32 doGetFormatCapacities #\( UInt64 * capacities #\, UInt32 capacitiesMaxCount #\) const #\;; -----------------------------------------------------------------------
;  Lock the media and prevent a user-initiated eject.
 virtual IOReturn doLockUnlockMedia #\( bool doLock #\) #\;; -----------------------------------------------------------------------
;  Flush the write-cache to the physical media.
 virtual IOReturn doSynchronizeCache #\( void #\) #\;; -----------------------------------------------------------------------
;  Start/stop the drive.
 virtual IOReturn doStart #\( void #\) #\; virtual IOReturn doStop #\( void #\) #\;; -----------------------------------------------------------------------
;  Return device identification strings
 virtual char * getAdditionalDeviceInfoString #\( void #\) #\; virtual char * getProductString #\( void #\) #\; virtual char * getRevisionString #\( void #\) #\; virtual char * getVendorString #\( void #\) #\;; -----------------------------------------------------------------------
;  Report the device block size in bytes.
 virtual IOReturn reportBlockSize #\( UInt64 * blockSize #\) #\;; -----------------------------------------------------------------------
;  Report whether the media in the ATA device is ejectable.
 virtual IOReturn reportEjectability #\( bool * isEjectable #\) #\;; -----------------------------------------------------------------------
;  Report whether the media can be locked.
 virtual IOReturn reportLockability #\( bool * isLockable #\) #\;; -----------------------------------------------------------------------
;  Report the polling requirements for a removable media.
 virtual IOReturn reportPollRequirements #\( bool * pollRequired #\, bool * pollIsExpensive #\) #\;; -----------------------------------------------------------------------
;  Report the max number of bytes transferred for an ATA read command.
 virtual IOReturn reportMaxReadTransfer #\( UInt64 blocksize #\, UInt64 * max #\) #\;; -----------------------------------------------------------------------
;  Report the max number of bytes transferred for an ATA write command.
 virtual IOReturn reportMaxWriteTransfer #\( UInt64 blocksize #\, UInt64 * max #\) #\;; -----------------------------------------------------------------------
;  Returns the maximum addressable sector number.
 virtual IOReturn reportMaxValidBlock #\( UInt64 * maxBlock #\) #\;; -----------------------------------------------------------------------
;  Report whether the media is currently present, and whether a media
;  change has been registered since the last reporting.
 virtual IOReturn reportMediaState #\( bool * mediaPresent #\, bool * changed #\) #\;; -----------------------------------------------------------------------
;  Report whether the media is removable.
 virtual IOReturn reportRemovability #\( bool * isRemovable #\) #\;; -----------------------------------------------------------------------
;  Report if the media is write-protected.
 virtual IOReturn reportWriteProtection #\( bool * isWriteProtected #\) #\;; -----------------------------------------------------------------------
;  Gets the write cache state.
 IOReturn getWriteCacheState #\( bool * enabled #\) #\;; -----------------------------------------------------------------------
;  Sets the write cache state.
 IOReturn setWriteCacheState #\( bool enabled #\) #\;; -----------------------------------------------------------------------
;  Client calls this before making a request which could cause I/O to
;  happen.
 virtual void checkPowerState #\( void #\) #\;  ; -----------------------------------------------------------------------
;  Checks to see if we are in a good power state to fulfill the request
;  
 virtual void handleCheckPowerState #\( void #\) #\;; -----------------------------------------------------------------------
;  Handles power state changes
;  
 virtual void handlePowerChange #\( void #\) #\;; -----------------------------------------------------------------------
;  Handles messages (notifications) from our provider.
 virtual IOReturn message #\( UInt32 type #\, IOService * provider #\, void * argument #\) #\;; -----------------------------------------------------------------------
;  Returns the device type.
 virtual const char * getDeviceTypeName #\( void #\) #\;; -----------------------------------------------------------------------
;  Sends an ATA SMART command to the device.
;  Added with 10.1.4 
 OSMetaClassDeclareReservedUsed #\( IOATABlockStorageDriver #\, 1 #\) virtual IOReturn sendSMARTCommand #\( IOATACommand * command #\) #\;;  Binary Compatibility reserved method space
 OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 7 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 8 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 9 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 10 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 11 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 12 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 13 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 14 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 15 #\) #\; OSMetaClassDeclareReservedUnused #\( IOATABlockStorageDriver #\, 16 #\) #\;
|#

; #endif /* _IO_ATA_BLOCKSTORAGE_DRIVER_H_ */


(provide-interface "IOATABlockStorageDriver")