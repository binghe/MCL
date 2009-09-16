(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOAGPDevice.h"
; at Sunday July 2,2006 7:28:18 pm.
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
;  * Copyright (c) 1999 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_IOAGPDEVICE_H
; #define _IOKIT_IOAGPDEVICE_H

(require-interface "IOKit/IORangeAllocator")

(require-interface "IOKit/pci/IOPCIDevice")
;  Definitions of AGP config registers 

(defconstant $kIOPCIConfigAGPStatusOffset 4)
(defconstant $kIOPCIConfigAGPCommandOffset 8)
;  Definitions of AGP Command & Status registers 

(defconstant $kIOAGPRequestQueueMask #xFF000000)
(defconstant $kIOAGPSideBandAddresssing #x200)
(defconstant $kIOAGPEnable #x100)
(defconstant $kIOAGP4GbAddressing 32)
(defconstant $kIOAGPFastWrite 16)
(defconstant $kIOAGP4xDataRate 4)
(defconstant $kIOAGP2xDataRate 2)
(defconstant $kIOAGP1xDataRate 1)

(defconstant $kIOAGPGartInvalidate 1)
;  getAGPStatus() defines

(defconstant $kIOAGPDefaultStatus 0)

(defconstant $kIOAGPIdle 1)
(defconstant $kIOAGPInvalidGARTEntry 2)
(defconstant $kIOAGPAccessOutOfRange 4)
(defconstant $kIOAGPBusFlagsKey "IOAGPFlags")
; #define kIOAGPBusFlagsKey	"IOAGPFlags"
;  the AGP target must be idle before invalidating its gart tlb

(defconstant $kIOAGPGartIdleInvalidate 1)       ;  the AGP target cannot handle operations that cross page boundaries

(defconstant $kIOAGPDisablePageSpans 2)         ;  the AGP target cannot handle master -> target AGP writes

(defconstant $kIOAGPDisableAGPWrites 4)         ;  the AGP target cannot handle target -> master PCI reads

(defconstant $kIOAGPDisablePCIReads 8)          ;  the AGP target cannot handle master -> target PCI writes

(defconstant $kIOAGPDisablePCIWrites 16)        ;  the AGP target cannot handle all unaligned transactions 

(defconstant $kIOAGPDisableUnaligned 32)
(defconstant $kIOAGPDisableFeature6 64)
(defconstant $kIOAGPDisableFeature7 #x80)
(defconstant $kIOAGPDisableFeature8 #x100)
(defconstant $kIOAGPDisableFeature9 #x200)
;  masterState

(defconstant $kIOAGPStateEnabled 1)
(defconstant $kIOAGPStateEnablePending #x10000)
; ! @class IOAGPDevice : public IOPCIDevice
;     @abstract An IOService class representing an AGP master device.
;     @discussion The discovery of an AGP master device by the PCI bus family results in an instance of the IOAGPDevice being created and published. It provides services specific to AGP, in addition to the PCI services supplied by its superclass IOPCIDevice. 
#|
 confused about CLASS IOAGPDevice #\: public IOPCIDevice #\{ OSDeclareDefaultStructors #\( IOAGPDevice #\) protected #\:
; ! @struct ExpansionData
;     @discussion This structure will be used to expand the capablilties of the IOWorkLoop in the future.
;     
 struct ExpansionData #\{ #\} #\;
; ! @var reserved
;     Reserved for future use.  (Internal use only)  
 ExpansionData * reserved #\; public #\: UInt32 masterState #\; UInt8 masterAGPRegisters #\;
; ! @function createAGPSpace
;     @abstract Allocates the AGP space, and enables AGP transactions on the master and slave.
;     @discussion This method should be called by the driver for the AGP master device  to set the size of the space and enable AGP transactions. It will destroy any AGP space currently allocated.
;     @param options No options are currently defined, pass zero.
;     @param address The physical range allocated for the AGP space is passed back to the caller.
;     @param length An in/out parameter - the caller sets the devices maximum AGP addressing and the actual size created is passed back.
;     @result An IOReturn code indicating success or failure. 
 virtual IOReturn createAGPSpace #\( IOOptionBits options #\, IOPhysicalAddress * address #\, IOPhysicalLength * length #\) #\;
; ! @function destroyAGPSpace
;     @abstract Destroys the AGP space, and disables AGP transactions on the master and slave.
;     @discussion This method should be called by the driver to shutdown AGP transactions and release resources. 
 virtual IOReturn destroyAGPSpace #\( void #\) #\;
; ! @function getAGPRangeAllocator
;     @abstract Accessor to obtain the AGP range allocator.
;     @discussion To allocate ranges in AGP space, obtain a range allocator for the space with this method. It is retained while the space is created (until destroyAGPSpace is called) and should not be released by the caller.
;     @result A pointer to the range allocator for the AGP space. 
 virtual IORangeAllocator * getAGPRangeAllocator #\( void #\) #\;
; ! @function getAGPStatus
;     @abstract Returns the current state of the AGP bus.
;     @discussion Returns state bits for the AGP bus. Only one type of status is currently defined. 
;     @param which Type of status - only kIOAGPDefaultStatus is currently valid.
;     @result Mask of status bits for the AGP bus. 
 virtual IOOptionBits getAGPStatus #\( IOOptionBits which = kIOAGPDefaultStatus #\) #\;
; ! @function commitAGPMemory
;     @abstract Makes memory addressable by AGP transactions.
;     @discussion Makes the memory described by the IOMemoryDescriptor object addressable by AGP by entering its pages into the GART array, given an offset into AGP space supplied by the caller (usually allocated by the AGP range allocator). It  is the callers responsibility to prepare non-kernel pageable memory before calling this method, with IOMemoryDescriptor::prepare.
;     @param memory A IOMemoryDescriptor object describing the memory to add to the GART.
;     @param agpOffset An offset into AGP space that the caller has allocated - usually allocated by the AGP range allocator.
;     @param options Pass kIOAGPGartInvalidate if the AGP target should invalidate any GART TLB.
;     @result An IOReturn code indicating success or failure. 
 virtual IOReturn commitAGPMemory #\( IOMemoryDescriptor * memory #\, IOByteCount agpOffset #\, IOOptionBits options = 0 #\) #\;
; ! @function releaseAGPMemory
;     @abstract Releases memory addressable by AGP transactions.
;     @discussion Makes the memory described by the IOMemoryDescriptor object unaddressable by AGP by removing its pages from the GART array, given an offset into AGP space supplied by the caller (usually allocated by the AGP range allocator). It  is the callers responsibility to complete non-kernel pageable memory before calling this method, with IOMemoryDescriptor::complete.
;     @param memory A IOMemoryDescriptor object describing the memory to remove from the GART.
;     @param agpOffset An offset into AGP space that the caller has allocated - usually allocated by the AGP range allocator.
;     @param options Pass kIOAGPGartInvalidate if the AGP target should invalidate any GART TLB.
;     @result An IOReturn code indicating success or failure. 
 virtual IOReturn releaseAGPMemory #\( IOMemoryDescriptor * memory #\, IOByteCount agpOffset #\, IOOptionBits options = 0 #\) #\; virtual IOReturn resetAGP #\( IOOptionBits options = 0 #\) #\;
; ! @function getAGPSpace
;     @abstract Returns the allocated AGP space.
;     @discussion This method can be called by the driver for the AGP master device to retrieve the physical address and size of the space created with createAGPSpace.
;     @param address The physical range allocated for the AGP space is passed back to the caller. Zero may be pased if the address is not needed by the caller.
;     @param length The size of the the AGP space created is passed back. Zero may be pased if the length is not needed by the caller.
;     @result An IOReturn code indicating success or failure. 
 virtual IOReturn getAGPSpace #\( IOPhysicalAddress * address #\, IOPhysicalLength * length #\) #\;;  Unused Padding
 OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 7 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 8 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 9 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 10 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 11 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 12 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 13 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 14 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 15 #\) #\; OSMetaClassDeclareReservedUnused #\( IOAGPDevice #\, 16 #\) #\;
|#

; #endif /* ! _IOKIT_IOAGPDEVICE_H */


(provide-interface "IOAGPDevice")