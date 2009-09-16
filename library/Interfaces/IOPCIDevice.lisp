(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPCIDevice.h"
; at Sunday July 2,2006 7:28:19 pm.
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
;  * Copyright (c) 1998-2003 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_IOPCIDEVICE_H
; #define _IOKIT_IOPCIDEVICE_H

(require-interface "IOKit/IOService")
;  Definitions of PCI Config Registers 

(defconstant $kIOPCIConfigVendorID 0)
(defconstant $kIOPCIConfigDeviceID 2)
(defconstant $kIOPCIConfigCommand 4)
(defconstant $kIOPCIConfigStatus 6)
(defconstant $kIOPCIConfigRevisionID 8)
(defconstant $kIOPCIConfigClassCode 9)
(defconstant $kIOPCIConfigCacheLineSize 12)
(defconstant $kIOPCIConfigLatencyTimer 13)
(defconstant $kIOPCIConfigHeaderType 14)
(defconstant $kIOPCIConfigBIST 15)
(defconstant $kIOPCIConfigBaseAddress0 16)
(defconstant $kIOPCIConfigBaseAddress1 20)
(defconstant $kIOPCIConfigBaseAddress2 24)
(defconstant $kIOPCIConfigBaseAddress3 28)
(defconstant $kIOPCIConfigBaseAddress4 32)
(defconstant $kIOPCIConfigBaseAddress5 36)
(defconstant $kIOPCIConfigCardBusCISPtr 40)
(defconstant $kIOPCIConfigSubSystemVendorID 44)
(defconstant $kIOPCIConfigSubSystemID 46)
(defconstant $kIOPCIConfigExpansionROMBase 48)
(defconstant $kIOPCIConfigCapabilitiesPtr 52)
(defconstant $kIOPCIConfigInterruptLine 60)
(defconstant $kIOPCIConfigInterruptPin 61)
(defconstant $kIOPCIConfigMinimumGrant 62)
(defconstant $kIOPCIConfigMaximumLatency 63)
;  Definitions of Capabilities PCI Config Register 

(defconstant $kIOPCICapabilityIDOffset 0)
(defconstant $kIOPCINextCapabilityOffset 1)
(defconstant $kIOPCIPowerManagementCapability 1)
(defconstant $kIOPCIAGPCapability 2)
(defconstant $kIOPCIVitalProductDataCapability 3)
(defconstant $kIOPCISlotIDCapability 4)
(defconstant $kIOPCIMSICapability 5)
(defconstant $kIOPCICPCIHotswapCapability 6)
(defconstant $kIOPCIPCIXCapability 7)
(defconstant $kIOPCILDTCapability 8)
(defconstant $kIOPCIVendorSpecificCapability 9)
(defconstant $kIOPCIDebugPortCapability 10)
(defconstant $kIOPCICPCIResourceControlCapability 11)
(defconstant $kIOPCIHotplugCapability 12)
(defconstant $kIOPCIAGP8Capability 14)
(defconstant $kIOPCISecureCapability 15)
(defconstant $kIOPCIPCIExpressCapability 16)
(defconstant $kIOPCIMSIXCapability 17)
;  Space definitions 

(defconstant $kIOPCIConfigSpace 0)
(defconstant $kIOPCIIOSpace 1)
(defconstant $kIOPCI32BitMemorySpace 2)
(defconstant $kIOPCI64BitMemorySpace 3)
;  Command register definitions 

(defconstant $kIOPCICommandIOSpace 1)
(defconstant $kIOPCICommandMemorySpace 2)
(defconstant $kIOPCICommandBusMaster 4)
(defconstant $kIOPCICommandSpecialCycles 8)
(defconstant $kIOPCICommandMemWrInvalidate 16)
(defconstant $kIOPCICommandPaletteSnoop 32)
(defconstant $kIOPCICommandParityError 64)
(defconstant $kIOPCICommandAddressStepping #x80)
(defconstant $kIOPCICommandSERR #x100)
(defconstant $kIOPCICommandFastBack2Back #x200)
;  Status register definitions 

(defconstant $kIOPCIStatusCapabilities 16)
(defconstant $kIOPCIStatusPCI66 32)
(defconstant $kIOPCIStatusUDF 64)
(defconstant $kIOPCIStatusFastBack2Back #x80)
(defconstant $kIOPCIStatusDevSel0 0)
(defconstant $kIOPCIStatusDevSel1 #x200)
(defconstant $kIOPCIStatusDevSel2 #x400)
(defconstant $kIOPCIStatusDevSel3 #x600)
(defconstant $kIOPCIStatusTargetAbortCapable #x800)
(defconstant $kIOPCIStatusTargetAbortActive #x1000)
(defconstant $kIOPCIStatusMasterAbortActive #x2000)
(defconstant $kIOPCIStatusSERRActive #x4000)
(defconstant $kIOPCIStatusParityErrActive #x8000)
;  constants which are part of the PCI Bus Power Management Spec.
;  capabilities bits in the 16 bit capabilities register

(defconstant $kPCIPMCPMESupportFromD3Cold #x8000)
(defconstant $kPCIPMCPMESupportFromD3Hot #x4000)
(defconstant $kPCIPMCPMESupportFromD2 #x2000)
(defconstant $kPCIPMCPMESupportFromD1 #x1000)
(defconstant $kPCIPMCPMESupportFromD0 #x800)
(defconstant $kPCIPMCD2Support #x400)
(defconstant $kPCIPMCD1Support #x200)
(defconstant $kPCIPMCD3Support 1)
;  bits in the power management control/status register

(defconstant $kPCIPMCSPMEStatus #x8000)
(defconstant $kPCIPMCSPMEEnable #x100)
(defconstant $kPCIPMCSPowerStateMask 3)
(defconstant $kPCIPMCSPowerStateD3 3)
(defconstant $kPCIPMCSPowerStateD2 2)
(defconstant $kPCIPMCSPowerStateD1 1)
(defconstant $kPCIPMCSPowerStateD0 0)
(defconstant $kPCIPMCSDefaultEnableBits -1)
(defrecord IOPCIAddressSpace
   (:variant
   (
   (bits :UInt32)
   )
   (

; #if __BIG_ENDIAN__
   (reloc :UInt32)
   (prefetch :UInt32)
   (t :UInt32)
   (resv :UInt32)
   (space :UInt32)
   (busNum :UInt32)
   (deviceNum :UInt32)
   (functionNum :UInt32)
   (registerNum :UInt32)
#| 
; #elif __LITTLE_ENDIAN__
   (registerNum :UInt32)
   (functionNum :UInt32)
   (deviceNum :UInt32)
   (busNum :UInt32)
   (space :UInt32)
   (resv :UInt32)
   (t :UInt32)
   (prefetch :UInt32)
   (reloc :UInt32)
 |#

; #endif

   )
   )
)
(defrecord IOPCIPhysicalAddress
   (physHi :IOPCIADDRESSSPACE)
   (physMid :UInt32)
   (physLo :UInt32)
   (lengthHi :UInt32)
   (lengthLo :UInt32)
)
;  IOPCIDevice matching property names
(defconstant $kIOPCIMatchKey "IOPCIMatch")
; #define kIOPCIMatchKey			"IOPCIMatch"
(defconstant $kIOPCIPrimaryMatchKey "IOPCIPrimaryMatch")
; #define kIOPCIPrimaryMatchKey		"IOPCIPrimaryMatch"
(defconstant $kIOPCISecondaryMatchKey "IOPCISecondaryMatch")
; #define kIOPCISecondaryMatchKey		"IOPCISecondaryMatch"
(defconstant $kIOPCIClassMatchKey "IOPCIClassMatch")
; #define kIOPCIClassMatchKey		"IOPCIClassMatch"
;  property to control PCI default config space save on sleep
(defconstant $kIOPMPCIConfigSpaceVolatileKey "IOPMPCIConfigSpaceVolatile")
; #define kIOPMPCIConfigSpaceVolatileKey	"IOPMPCIConfigSpaceVolatile"

(defconstant $kIOPCIDevicePowerStateCount 3)
(defconstant $kIOPCIDeviceOffState 0)
(defconstant $kIOPCIDeviceDozeState 1)
(defconstant $kIOPCIDeviceOnState 2)
; ! @class IOPCIDevice : public IOService
;     @abstract An IOService class representing a PCI device.
;     @discussion The discovery of an PCI device by the PCI bus family results in an instance of the IOPCIDevice being created and published. It provides services for looking up and mapping memory mapped hardware, and access to the PCI configuration and I/O spaces. 
; 
; <br><br>Matching Supported by IOPCIDevice<br><br>
; 
; Two types of matching are available, OpenFirmware name matching and PCI register matching. Currently, only one of these two matching schemes can be used in the same property table.
; 
; <br><br>OpenFirmware Name Matching<br><br>
; 
; IOService performs matching based on the IONameMatch property (see IOService). IOPCIDevices created with OpenFirmware device tree entries will name match based on the standard OpenFirmware name matching properties.
; 
; <br><br>PCI Register Matching<br><br>
; 
; A PCI device driver can also match on the values of certain config space registers.
; 
; In each case, several matching values can be specified, and an optional mask for the value of the config space register may follow the value, preceded by an '&' character.
; <br>
; <br>
; 	kIOPCIMatchKey, "IOPCIMatch"
; <br>
; The kIOPCIMatchKey property matches the vendor and device ID (0x00) register, or the subsystem register (0x2c).
; <br>
; <br>
; 	kIOPCIPrimaryMatchKey, "IOPCIPrimaryMatch"
; <br>
; The kIOPCIPrimaryMatchKey property matches the vendor and device ID (0x00) register.
; <br>
; <br>
; 	kIOPCISecondaryMatchKey, "IOPCISecondaryMatch"
; <br>
; The kIOPCISecondaryMatchKey property matches the subsystem register (0x2c).
; <br>
; <br>
; 	kIOPCIClassMatchKey, "IOPCIClassMatch"
; <br>
; The kIOPCIClassMatchKey property matches the class code register (0x08). The default mask for this register is 0xffffff00.
; <br>
; <br>
; Examples:
; <br>
; <br>
;       &ltkey&gtIOPCIMatch&lt/key&gt		<br>
; 	&ltstring&gt0x00261011&lt/string&gt
; <br>
; Matches a device whose vendor ID is 0x1011, and device ID is 0x0026, including subsystem IDs.
; <br>
; <br>
;       &ltkey&gtIOPCIMatch&lt/key&gt		<br>
; 	&ltstring&gt0x00789004&0x00ffffff 0x78009004&0x0xff00ffff&lt/string&gt
; <br>
; Matches with any device with a vendor ID of 0x9004, and a device ID of 0xzz78 or 0x78zz, where 'z' is don't care.
; <br>
; <br>
;       &ltkey&gtIOPCIClassMatch&lt/key&gt	<br>
; 	&ltstring&gt0x02000000&0xffff0000&lt/string&gt
; <br>
; <br>
; Matches a device whose class code is 0x0200zz, an ethernet device.
; 
; 
#|
 confused about CLASS IOPCIDevice #\: public IOService #\{ OSDeclareDefaultStructors #\( IOPCIDevice #\) friend class IOPCIBridge #\; friend class IOPCI2PCIBridge #\; protected #\: IOPCIBridge * parent #\; IOMemoryMap * ioMap #\; OSObject * slotNameProperty #\;
; ! @struct ExpansionData
;     @discussion This structure will be used to expand the capablilties of the IOWorkLoop in the future.
;     
 struct ExpansionData #\{ bool PMsleepEnabled #\;;  T if a client has enabled PCI Power Management
 UInt8 PMcontrolStatus #\;                      ;  if >0 this device supports PCI Power Management
 UInt16 sleepControlBits #\;                    ;  bits to set the control/status register to for sleep
 #\} #\;
; ! @var reserved
;     Reserved for future use.  (Internal use only)  
 ExpansionData * reserved #\; public #\: IOPCIAddressSpace space #\; UInt32 * savedConfig #\; public #\:;  IOService/IORegistryEntry methods 
 virtual bool init #\( OSDictionary * propTable #\) #\; virtual bool init #\( IORegistryEntry * from #\, const IORegistryPlane * inPlane #\) #\; virtual void free #\( #\) #\; virtual bool attach #\( IOService * provider #\) #\; virtual void detach #\( IOService * provider #\) #\; virtual IOReturn setPowerState #\( unsigned long #\, IOService * #\) #\; virtual bool compareName #\( OSString * name #\, OSString ** matched = 0 #\) const #\; virtual bool matchPropertyTable #\( OSDictionary * table #\, SInt32 * score #\) #\; virtual IOService * matchLocation #\( IOService * client #\) #\; virtual IOReturn getResources #\( void #\) #\;;  Config space accessors 
 virtual UInt32 configRead32 #\( IOPCIAddressSpace space #\, UInt8 offset #\) #\; virtual void configWrite32 #\( IOPCIAddressSpace space #\, UInt8 offset #\, UInt32 data #\) #\; virtual UInt16 configRead16 #\( IOPCIAddressSpace space #\, UInt8 offset #\) #\; virtual void configWrite16 #\( IOPCIAddressSpace space #\, UInt8 offset #\, UInt16 data #\) #\; virtual UInt8 configRead8 #\( IOPCIAddressSpace space #\, UInt8 offset #\) #\; virtual void configWrite8 #\( IOPCIAddressSpace space #\, UInt8 offset #\, UInt8 data #\) #\;
; ! @function configRead32
;     @abstract Reads a 32-bit value from the PCI device's configuration space.
;     @discussion This method reads a 32-bit configuration space register on the device and returns its value.
;     @param offset An 8-bit offset into configuration space, of which bits 0-1 are ignored.
;     @result An 32-bit value in host byte order (big endian on PPC). 
 virtual UInt32 configRead32 #\( UInt8 offset #\) #\;
; ! @function configRead16
;     @abstract Reads a 16-bit value from the PCI device's configuration space.
;     @discussion This method reads a 16-bit configuration space register on the device and returns its value.
;     @param offset An 8-bit offset into configuration space, of which bit 0 is ignored.
;     @result An 16-bit value in host byte order (big endian on PPC). 
 virtual UInt16 configRead16 #\( UInt8 offset #\) #\;
; ! @function configRead8
;     @abstract Reads a 8-bit value from the PCI device's configuration space.
;     @discussion This method reads a 8-bit configuration space register on the device and returns its value.
;     @param offset An 8-bit offset into configuration space.
;     @result An 8-bit value. 
 virtual UInt8 configRead8 #\( UInt8 offset #\) #\;
; ! @function configWrite32
;     @abstract Writes a 32-bit value to the PCI device's configuration space.
;     @discussion This method write a 32-bit value to a configuration space register on the device.
;     @param offset An 8-bit offset into configuration space, of which bits 0-1 are ignored.
;     @param data An 32-bit value to be written in host byte order (big endian on PPC). 
 virtual void configWrite32 #\( UInt8 offset #\, UInt32 data #\) #\;
; ! @function configWrite16
;     @abstract Writes a 16-bit value to the PCI device's configuration space.
;     @discussion This method write a 16-bit value to a configuration space register on the device.
;     @param offset An 8-bit offset into configuration space, of which bit 0 is ignored.
;     @param data An 16-bit value to be written in host byte order (big endian on PPC). 
 virtual void configWrite16 #\( UInt8 offset #\, UInt16 data #\) #\;
; ! @function configWrite8
;     @abstract Writes a 8-bit value to the PCI device's configuration space.
;     @discussion This method write a 8-bit value to a configuration space register on the device.
;     @param offset An 8-bit offset into configuration space.
;     @param data An 8-bit value to be written. 
 virtual void configWrite8 #\( UInt8 offset #\, UInt8 data #\) #\; virtual IOReturn saveDeviceState #\( IOOptionBits options = 0 #\) #\; virtual IOReturn restoreDeviceState #\( IOOptionBits options = 0 #\) #\;
; ! @function setConfigBits
;     @abstract Sets masked bits in a configuration space register.
;     @discussion This method sets masked bits in a configuration space register on the device by reading and writing the register. The value of the masked bits before the write is returned.
;     @param offset An 8-bit offset into configuration space, of which bits 0-1 are ignored.
;     @param mask An 32-bit mask indicating which bits in the value parameter are valid.
;     @param data An 32-bit value to be written in host byte order (big endian on PPC).
;     @result The value of the register masked with the mask before the write. 
 virtual UInt32 setConfigBits #\( UInt8 offset #\, UInt32 mask #\, UInt32 value #\) #\;
; ! @function setMemoryEnable
;     @abstract Sets the device's memory space response.
;     @discussion This method sets the memory space response bit in the device's command config space register to the passed value, and returns the previous state of the enable.
;     @param enable True or false to enable or disable the memory space response.
;     @result True if the memory space response was previously enabled, false otherwise. 
 virtual bool setMemoryEnable #\( bool enable #\) #\;
; ! @function setIOEnable
;     @abstract Sets the device's I/O space response.
;     @discussion This method sets the I/O space response bit in the device's command config space register to the passed value, and returns the previous state of the enable. The exclusive option allows only one exclusive device on the bus to be enabled concurrently, this should be only for temporary access.
;     @param enable True or false to enable or disable the I/O space response.
;     @param exclusive If true, only one setIOEnable with the exclusive flag set will be allowed at a time on the bus, this should be only for temporary access.
;     @result True if the I/O space response was previously enabled, false otherwise. 
 virtual bool setIOEnable #\( bool enable #\, bool exclusive = false #\) #\;
; ! @function setBusMasterEnable
;     @abstract Sets the device's bus master enable.
;     @discussion This method sets the bus master enable bit in the device's command config space register to the passed value, and returns the previous state of the enable.
;     @param enable True or false to enable or disable bus mastering.
;     @result True if bus mastering was previously enabled, false otherwise. 
 virtual bool setBusMasterEnable #\( bool enable #\) #\;
; ! @function findPCICapability
;     @abstract Search configuration space for a PCI capability register.
;     @discussion This method searchs the device's config space for a PCI capability register matching the passed capability ID, if the device supports PCI capabilities.
;     @param capabilityID An 8-bit PCI capability ID.
;     @param offset An optional pointer to return the offset into config space where the capability was found.
;     @result The 32-bit value of the capability register if one was found, zero otherwise. 
 virtual UInt32 findPCICapability #\( UInt8 capabilityID #\, UInt8 * offset = 0 #\) #\;
; ! @function getBusNumber
;     @abstract Accessor to return the PCI device's assigned bus number.
;     @discussion This method is an accessor to return the PCI device's assigned bus number.
;     @result The 8-bit value of device's PCI bus number. 
 virtual UInt8 getBusNumber #\( void #\) #\;
; ! @function getDeviceNumber
;     @abstract Accessor to return the PCI device's device number.
;     @discussion This method is an accessor to return the PCI device's device number.
;     @result The 5-bit value of device's device number. 
 virtual UInt8 getDeviceNumber #\( void #\) #\;
; ! @function getFunctionNumber
;     @abstract Accessor to return the PCI device's function number.
;     @discussion This method is an accessor to return the PCI device's function number.
;     @result The 3-bit value of device's function number. 
 virtual UInt8 getFunctionNumber #\( void #\) #\;;  Device memory accessors 
; ! @function getDeviceMemoryWithRegister
;     @abstract Returns an instance of IODeviceMemory representing one of the device's memory mapped ranges.
;     @discussion This method will return a pointer to an instance of IODeviceMemory for the physical memory range that was assigned to the configuration space base address register passed in. It is analogous to IOService::getDeviceMemoryWithIndex.
;     @param reg The 8-bit configuration space register that is the base address register for the desired range.
;     @result A pointer to an instance of IODeviceMemory, or zero no such range was found. The IODeviceMemory is retained by the provider, so is valid while attached, or while any mappings to it exist. It should not be released by the caller. 
 virtual IODeviceMemory * getDeviceMemoryWithRegister #\( UInt8 reg #\) #\;
; ! @function mapDeviceMemoryWithRegister
;     @abstract Maps a physical range of the device.
;     @discussion This method will create a mapping for the IODeviceMemory for the physical memory range that was assigned to the configuration space base address register passed in, with IODeviceMemory::map(options). The mapping is represented by the returned instance of IOMemoryMap, which should not be released until the mapping is no longer required. This method is analogous to IOService::mapDeviceMemoryWithIndex.
;     @param reg The 8-bit configuration space register that is the base address register for the desired range.
;     @param options Options to be passed to the IOMemoryDescriptor::map() method.
;     @result An instance of IOMemoryMap, or zero if the index is beyond the count available. The mapping should be released only when access to it is no longer required. 
 virtual IOMemoryMap * mapDeviceMemoryWithRegister #\( UInt8 reg #\, IOOptionBits options = 0 #\) #\;
; ! @function ioDeviceMemory
;     @abstract Accessor to the I/O space aperture for the bus.
;     @discussion This method will return a reference to the IODeviceMemory for the I/O aperture of the bus the device is on.
;     @result A pointer to an IODeviceMemory object for the I/O aperture. The IODeviceMemory is retained by the provider, so is valid while attached, or while any mappings to it exist. It should not be released by the caller. 
 virtual IODeviceMemory * ioDeviceMemory #\( void #\) #\;;  I/O space accessors 
; ! @function ioWrite32
;     @abstract Writes a 32-bit value to an I/O space aperture.
;     @discussion This method will write a 32-bit value to a 4 byte aligned offset in an I/O space aperture. If a map object is passed in, the value is written relative to it, otherwise to the value is written relative to the I/O space aperture for the bus. This function encapsulates the differences between architectures in generating I/O space operations. An eieio instruction is included on PPC.
;     @param offset An offset into a bus or device's I/O space aperture.
;     @param value The value to be written in host byte order (big endian on PPC).
;     @param map If the offset is relative to the beginning of a device's aperture, an IOMemoryMap object for that object should be passed in. Otherwise, passing zero will write the value relative to the beginning of the bus' I/O space. 
 virtual void ioWrite32 #\( UInt16 offset #\, UInt32 value #\, IOMemoryMap * map = 0 #\) #\;
; ! @function ioWrite16
;     @abstract Writes a 16-bit value to an I/O space aperture.
;     @discussion This method will write a 16-bit value to a 2 byte aligned offset in an I/O space aperture. If a map object is passed in, the value is written relative to it, otherwise to the value is written relative to the I/O space aperture for the bus. This function encapsulates the differences between architectures in generating I/O space operations. An eieio instruction is included on PPC.
;     @param offset An offset into a bus or device's I/O space aperture.
;     @param value The value to be written in host byte order (big endian on PPC).
;     @param map If the offset is relative to the beginning of a device's aperture, an IOMemoryMap object for that object should be passed in. Otherwise, passing zero will write the value relative to the beginning of the bus' I/O space. 
 virtual void ioWrite16 #\( UInt16 offset #\, UInt16 value #\, IOMemoryMap * map = 0 #\) #\;
; ! @function ioWrite8
;     @abstract Writes a 8-bit value to an I/O space aperture.
;     @discussion This method will write a 8-bit value to an offset in an I/O space aperture. If a map object is passed in, the value is written relative to it, otherwise to the value is written relative to the I/O space aperture for the bus. This function encapsulates the differences between architectures in generating I/O space operations. An eieio instruction is included on PPC.
;     @param offset An offset into a bus or device's I/O space aperture.
;     @param value The value to be written in host byte order (big endian on PPC).
;     @param map If the offset is relative to the beginning of a device's aperture, an IOMemoryMap object for that object should be passed in. Otherwise, passing zero will write the value relative to the beginning of the bus' I/O space. 
 virtual void ioWrite8 #\( UInt16 offset #\, UInt8 value #\, IOMemoryMap * map = 0 #\) #\;
; ! @function ioRead32
;     @abstract Reads a 32-bit value from an I/O space aperture.
;     @discussion This method will read a 32-bit value from a 4 byte aligned offset in an I/O space aperture. If a map object is passed in, the value is read relative to it, otherwise to the value is read relative to the I/O space aperture for the bus. This function encapsulates the differences between architectures in generating I/O space operations. An eieio instruction is included on PPC.
;     @param offset An offset into a bus or device's I/O space aperture.
;     @param map If the offset is relative to the beginning of a device's aperture, an IOMemoryMap object for that object should be passed in. Otherwise, passing zero will write the value relative to the beginning of the bus' I/O space.
;     @result The value read in host byte order (big endian on PPC). 
 virtual UInt32 ioRead32 #\( UInt16 offset #\, IOMemoryMap * map = 0 #\) #\;
; ! @function ioRead16
;     @abstract Reads a 16-bit value from an I/O space aperture.
;     @discussion This method will read a 16-bit value from a 2 byte aligned offset in an I/O space aperture. If a map object is passed in, the value is read relative to it, otherwise to the value is read relative to the I/O space aperture for the bus. This function encapsulates the differences between architectures in generating I/O space operations. An eieio instruction is included on PPC.
;     @param offset An offset into a bus or device's I/O space aperture.
;     @param map If the offset is relative to the beginning of a device's aperture, an IOMemoryMap object for that object should be passed in. Otherwise, passing zero will write the value relative to the beginning of the bus' I/O space.
;     @result The value read in host byte order (big endian on PPC). 
 virtual UInt16 ioRead16 #\( UInt16 offset #\, IOMemoryMap * map = 0 #\) #\;
; ! @function ioRead8
;     @abstract Reads a 8-bit value from an I/O space aperture.
;     @discussion This method will read a 8-bit value from an offset in an I/O space aperture. If a map object is passed in, the value is read relative to it, otherwise to the value is read relative to the I/O space aperture for the bus. This function encapsulates the differences between architectures in generating I/O space operations. An eieio instruction is included on PPC.
;     @param offset An offset into a bus or device's I/O space aperture.
;     @param map If the offset is relative to the beginning of a device's aperture, an IOMemoryMap object for that object should be passed in. Otherwise, passing zero will write the value relative to the beginning of the bus' I/O space.
;     @result The value read. 
 virtual UInt8 ioRead8 #\( UInt16 offset #\, IOMemoryMap * map = 0 #\) #\; OSMetaClassDeclareReservedUsed #\( IOPCIDevice #\, 0 #\) #\;
; ! @function hasPCIPowerManagement
;     @abstract determine whether or not the device supports PCI Bus Power Management.
;     @discussion This method will look at the device's capabilties registers and determine whether or not the device supports the PCI BUS Power Management Specification.
;     @param state(optional) Check for support of a specific state (e.g. kPCIPMCPMESupportFromD3Cold). If state is not suuplied or is 0, then check for a property in the registry which tells which state the hardware expects the device to go to during sleep.
;     @result true if the specified state is supported 
 virtual bool hasPCIPowerManagement #\( IOOptionBits state = 0 #\) #\; OSMetaClassDeclareReservedUsed #\( IOPCIDevice #\, 1 #\) #\;
; ! @function enablePCIPowerManagement
;     @abstract enable PCI power management for sleep state
;     @discussion This method will enable PCI Bus Powermanagement when going to sleep mode.
;     @param state(optional) Enables PCI Power Management by placing the function in the given state (e.g. kPCIPMCSPowerStateD3). If state is not specified or is 0xffffffff, then the IOPCIDevice determines the desired state. If state is kPCIPMCSPowerStateD0 (0) then PCI Power Management is disabled.
;     @result kIOReturnSuccess if there were no errors 
 virtual IOReturn enablePCIPowerManagement #\( IOOptionBits state = 0xffffffff #\) #\;;  Unused Padding
 OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 7 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 8 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 9 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 10 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 11 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 12 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 13 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 14 #\) #\; OSMetaClassDeclareReservedUnused #\( IOPCIDevice #\, 15 #\) #\;
|#

; #endif /* ! _IOKIT_IOPCIDEVICE_H */


(provide-interface "IOPCIDevice")