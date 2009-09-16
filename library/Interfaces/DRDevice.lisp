(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRDevice.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingEngine/DRDevice.h
;  
;      Contains:   Handles obtaining information about cd/dvd burners connected 
;      			 to the computer. 
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>

; #import <DiscRecordingEngine/DRCoreDevice.h>

; #import <DiscRecordingEngine/DRMSF.h>

; #import <AvailabilityMacros.h>
; !
; 	@class 		DRDevice
; 	@abstract	Represents a CD or DVD burner connected to the computer.
; 	@discussion	
; 				<h3>About Devices</h3>
; 				A DRDevice represents a physical CD/DVD drive connected to the computer. This class is 
; 				mainly for informational purposes since the device is configured by the burn 
; 				engine before beginning to optimally handle the burn. The basis for obtaining the
; 				device information is through two methods <b>info</b> and <b>status</b>. <b>info</b> returns 
; 				information pertaining to the drive as a whole and is not affected by the state 
; 				of any media in the drive. <b>status</b> returns information about the media in the drive as
; 				well as those bits of information directly affected by the media (maximum burn speed,
; 				BSD dev node name, etc.)
; 	
; 				<h3>Obtaining Device instances</h3>
; 				DRDevices cannot be created by the programmer. Devices are managed by the burn engine
; 				and are asked for by client code. The preferred way of obtaining an instance is
; 				by registering with the <b>DRNotificationCenter</b> and listening for the 
; 				<i>DRDeviceAppearedNotification</i>. This notification is sent to all
; 				observers when a device is first detected by the burn engine (such as when a device
; 				is plugged in or turned on). A client is guaranteed to receive all 
; 				DRDeviceAppearedNotifications. When a client registers for the 
; 				DRDeviceAppearedNotification, the engine will ensure that
; 				the client gets notified of all devices currently connected to the machine. When a device
; 				is removed, registed observers will receive a DRDeviceDisappearedNotification.
; 				
; 				It's also possible to obtain a device instance from its IORegistry path 
; 				(<b>deviceForIORegistryEntryPath:</b>) or the BSD /dev node name (<b>deviceForBSDName:</b>).
; 				If you have a reference to a device instance, you can determine if the physical device
; 				is still valid and connected by sending the <b>isValid</b> method to the instance.
; 				
; 				<h3>Device Control</h3>
; 				There is a limited set of operations that can be performed on a device. The most
; 				important of these is <i>media reservation</i>. Reserving media is a process by which
; 				applications arbitrate for blank media. An application registers interest in 
; 				obtaining a media reservation by caling <b>acquireMediaReservation</b> and gives up
; 				its interest by calling releaseMediaReservation. asking to acquire a reservation does
; 				not mean you will get it! Another application may already have the reservation and 
; 				will refuse to give it up to you. In this case, the only thing to do is to play fair and
; 				wait until the DRDeviceMediaIsReservedKey indicates that your app has obtained 
; 				the reservation.
; 				
; 				The device tray can be opened (<b>openTray</b>) or closed (<b>closeTray</b>) and media 
; 				can be ejected (<b>ejectMedia</b>).
; 
#| @INTERFACE 
DRDevice : NSObject 
{ 
private
	void*	_ref;
}


+ (NSArray*) devices;


+ (DRDevice*) deviceForBSDName:(NSString*)bsdName;


+ (DRDevice*) deviceForIORegistryEntryPath:(NSString*)path;


- (BOOL) isValid;


- (NSDictionary*) info;


- (NSDictionary*) status;


- (BOOL) openTray;


- (BOOL) closeTray;


- (BOOL) ejectMedia;


- (BOOL) acquireExclusiveAccess;


- (void) releaseExclusiveAccess;


- (void) acquireMediaReservation;


- (void) releaseMediaReservation;


- (BOOL) isEqualToDevice:(DRDevice*) otherDevice;

|#
;  -------------------------------------- 
; " Convenience methods for accessing the various keys contained in the
; 	dictionary returned by <b>info</b>. Each time you want to burn to a disc, an
; 	instance of this class needs to be created. If you want all (or even a few bits)
; 	of this information it's much more efficient to call <b>info</b> yourself and
; 	then extract the needed values from the dictionary. "
#| @INTERFACE 
DRDevice (InfoConvenience)


- (BOOL) writesCD;


- (BOOL) writesDVD;


- (NSString*) displayName;


- (NSString*) ioRegistryEntryPath;

|#
;  -------------------------------------- 
; " Convienience methods for accessing the various keys contained in the 
; 	dictionary returned by <b>status</b>. If you want all (or even a few bits) 
; 	of this information it's much more efficient to get status yourself 
; 	and then extract the needed values from the dictionary. "
#| @INTERFACE 
DRDevice (StatusConvenience)



- (BOOL) mediaIsPresent;


- (BOOL) mediaIsTransitioning;


- (BOOL) mediaIsBusy;


- (NSString*) mediaType;


- (BOOL) mediaIsBlank;


- (BOOL) mediaIsAppendable;


- (BOOL) mediaIsOverwritable;


- (BOOL) mediaIsErasable;


- (BOOL) mediaIsReserved;


- (DRMSF*) mediaSpaceOverwritable;


- (DRMSF*) mediaSpaceUsed;


- (DRMSF*) mediaSpaceFree;


- (BOOL) trayIsOpen;


- (NSString*) bsdName;

|#
;  -------------------------------------- 
;  Burn speeds 

; #if 0
#| ; #pragma mark Device Burn Speeds
 |#

; #endif

; !
; 	@const	DRDeviceBurnSpeedCD1x		176.4 KB/sec.
; 
(def-mactype :DRDeviceBurnSpeedCD1x (find-mactype ':float)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	DRDeviceBurnSpeedDVD1x	1385.0 KB/sec.
; 
(def-mactype :DRDeviceBurnSpeedDVD1x (find-mactype ':float)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceBurnSpeedMax
; 	@discussion	A value representing the maximum speed at which a device can burn. The
; 				actual speed will vary from device to device.
; 
(def-mactype :DRDeviceBurnSpeedMax (find-mactype ':float)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------------- 
;  Notifications 

; #if 0
#| ; #pragma mark Device Notifications
 |#

; #endif

; !
; 	@const	 	DRDeviceAppearedNotification
; 	@discussion	Posted by a DRNotificationCenter when a device is added to the system.
; 
; 				This notification is registered for only by name. 
; 				
; 				The object associated with this notification
; 				is the the device that has appeared. The userInfo is the same dictionary 
; 				returned by <b>info</b> for that device. 
; 
(def-mactype :DRDeviceAppearedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceDisappearedNotification
; 	@discussion	Posted by a DRNotificationCenter when a device is removed from the system.
; 	
; 				The object associated with this notification
; 				is the the device that has disappeared. The userInfo is the same dictionary 
; 				returned by <b>info</b> for that device. 
; 
(def-mactype :DRDeviceDisappearedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	 	DRDeviceStatusChangedNotification
; 	@discussion	Posted by a DRNotificationCenter when the media
; 				in a device changes state. This can include being ejected, inserted, becoming busy, 
; 				etc. 
; 				
; 				The object for this notification is the device who's media is changing state.
; 				The userInfo for this notification is the same dictionary returned by <b>status</b> for 
; 				that device. 
; 
(def-mactype :DRDeviceStatusChangedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------------- 
;  Keys for the dictionary returned by -[DRDevice info]. 

; #if 0
#| ; #pragma mark Device Information
 |#

; #endif

; !
; 	@const		DRDeviceSupportLevelKey	
; 	@discussion	The info key whose value is an NSString describing the support level 
; 				the device enjoys from the engine.
; 
(def-mactype :DRDeviceSupportLevelKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceIORegistryEntryPathKey
; 	@discussion	The info key whose value is an NString containing the path 
; 				of the device in the IO Registry.
; 
(def-mactype :DRDeviceIORegistryEntryPathKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceWriteCapabilitiesKey
; 	@discussion	The info key whose value is an NSDictionary containing 
; 				the capabilities of the device for writing different kinds of media.
; 
(def-mactype :DRDeviceWriteCapabilitiesKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceVendorNameKey
; 	@discussion	The info key whose value is an NString containing the vendor name 
; 				extracted from the device.
; 
(def-mactype :DRDeviceVendorNameKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceProductNameKey
; 	@discussion	The info key whose value is an NString containing the product name 
; 				extracted from the device.
; 
(def-mactype :DRDeviceProductNameKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceFirmwareRevisionKey
; 	@discussion	The info key whose value is an NString containing the firmeware revision 
; 				extracted from the device.
; 
(def-mactype :DRDeviceFirmwareRevisionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectKey
; 	@discussion	The info key whose value is an NString describing the connection 
; 				of the device to the computer.
; 
(def-mactype :DRDevicePhysicalInterconnectKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectLocationKey
; 	@discussion	The info key whose value is an NString describing the location 
; 				of the device (internal/external/unknown).
; 
(def-mactype :DRDevicePhysicalInterconnectLocationKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRDeviceLoadingMechanismCanEjectKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyInfo. The value of this key
; 				is an NSNumber describing if the loading mechanism of the drive can eject.
; 
(def-mactype :DRDeviceLoadingMechanismCanEjectKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const DRDeviceLoadingMechanismCanInjectKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyInfo. The value of this key
; 				is an NSNumber describing if the loading mechanism of the drive can inject.
; 
(def-mactype :DRDeviceLoadingMechanismCanInjectKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const DRDeviceLoadingMechanismCanOpenKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyInfo. The value of this key
; 				is an NSNumber describing if the loading mechanism of the drive can open.
; 
(def-mactype :DRDeviceLoadingMechanismCanOpenKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const DRDeviceWriteBufferSizeKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyInfo. The value of this key
; 				is an NSNumber containing the size of the write buffer of the device.
; 
(def-mactype :DRDeviceWriteBufferSizeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ---------------------------------- 
;  Support levels 
; !
; 	@const		DRDeviceSupportLevelNone
; 	@discussion	The value of DRDeviceSupportLevelKey that indicates 
; 				this device is not supported.
; 
(def-mactype :DRDeviceSupportLevelNone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRDeviceSupportLevelUnsupported
; 	@discussion	One of the values for DRDeviceSupportLevelKey. This value indicates
; 				the device is unsupported, but the engine will try to use it anyway.
; 
(def-mactype :DRDeviceSupportLevelUnsupported (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceSupportLevelVendorSupported
; 	@discussion	The value of DRDeviceSupportLevelKey that indicates 
; 				this device has been tested by a third party for support.
; 
(def-mactype :DRDeviceSupportLevelVendorSupported (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceSupportLevelAppleSupported
; 	@discussion	The value of DRDeviceSupportLevelKey that indicates 
; 				this device has been tested by Apple for support.
; 
(def-mactype :DRDeviceSupportLevelAppleSupported (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceSupportLevelAppleShipping
; 	@discussion	The value of DRDeviceSupportLevelKey that indicates 
; 				this device is shipping in some Apple machine.
; 
(def-mactype :DRDeviceSupportLevelAppleShipping (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Types of physical interconnect 
; !
; 	@const		DRDevicePhysicalInterconnectATAPI
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectKey.
; 				Device is connected on an ATAPI interface.
; 
(def-mactype :DRDevicePhysicalInterconnectATAPI (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectFibreChannel
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectKey.
; 				Device is connected through a Fibre Channel interface.
; 
(def-mactype :DRDevicePhysicalInterconnectFibreChannel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectFireWire
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectKey.
; 				Device is connected through a Firewire interface.
; 
(def-mactype :DRDevicePhysicalInterconnectFireWire (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectSCSI
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectKey.
; 				Device is connected on a SCSI interface.
; 
(def-mactype :DRDevicePhysicalInterconnectSCSI (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectUSB
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectKey.
; 				Device is connected through a USB interface.
; 
(def-mactype :DRDevicePhysicalInterconnectUSB (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Physical interconnect locations 
; !
; 	@const		DRDevicePhysicalInterconnectLocationInternal
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectLocationKey.
; 				Device is connected to the machine internally.
; 
(def-mactype :DRDevicePhysicalInterconnectLocationInternal (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectLocationExternal
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectLocationKey.
; 				Device is connected to the machine externally.
; 
(def-mactype :DRDevicePhysicalInterconnectLocationExternal (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDevicePhysicalInterconnectLocationUnknown
; 	@discussion	One of the possible values of the DRDevicePhysicalInterconnectLocationKey.
; 				It's not known how the device is connected.
; 
(def-mactype :DRDevicePhysicalInterconnectLocationUnknown (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Keys for the write capabilities dictionary, which is a subdictionary under
; 	DRDeviceWriteCapabilitiesKey, in the dictionary returned by -[DRDevice info]. 
; !
; 	@const 		DRDeviceCanWriteKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to some type of media.
; 
(def-mactype :DRDeviceCanWriteKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteCDKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to some type of CD based media.
; 
(def-mactype :DRDeviceCanWriteCDKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteCDRKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to CD-R media.
; 
(def-mactype :DRDeviceCanWriteCDRKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteCDRWKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to CD-RW media.
; 
(def-mactype :DRDeviceCanWriteCDRWKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to some type of DVD based media.
; 
(def-mactype :DRDeviceCanWriteDVDKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDRKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to DVD-R media.
; 
(def-mactype :DRDeviceCanWriteDVDRKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDRWKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to DVD-RW media.
; 
(def-mactype :DRDeviceCanWriteDVDRWKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDRAMKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to DVD-RAM media.
; 
(def-mactype :DRDeviceCanWriteDVDRAMKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDPlusRKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to DVD+R media.
; 
(def-mactype :DRDeviceCanWriteDVDPlusRKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDPlusRWKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write to DVD+RW media.
; 
(def-mactype :DRDeviceCanWriteDVDPlusRWKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteIndexPointsKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write index points to CD media.
; 
(def-mactype :DRDeviceCanWriteIndexPointsKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteISRCKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can write ISRC to CD media.
; 
(def-mactype :DRDeviceCanWriteISRCKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteCDRawKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device supports a TAO (track-at-once)
; 				burn strategy for CD.
; 
(def-mactype :DRDeviceCanWriteCDTAOKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteCDSAOKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device supports a SAO (session-at-once)
; 				burn strategy for CD.
; 
(def-mactype :DRDeviceCanWriteCDSAOKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteCDRawKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device supports a raw mode burn strategy for CD.
; 				Raw mode is sometimes incorrectly referred to as DAO (disc-at-once).
; 
(def-mactype :DRDeviceCanWriteCDRawKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanWriteDVDDAOKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device supports a DAO (disc-at-once)
; 				burn strategy on DVD media.
; 
(def-mactype :DRDeviceCanWriteDVDDAOKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceCanTestWriteCDKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can perform a test burn to CD media.
; 
(def-mactype :DRDeviceCanTestWriteCDKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanTestWriteDVDKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device can perform a test burn to DVD media.
; 
(def-mactype :DRDeviceCanTestWriteDVDKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanUnderrunProtectCDKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device supports burn underrun protection when writing to CD media.
; 
(def-mactype :DRDeviceCanUnderrunProtectCDKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCanUnderrunProtectDVDKey
; 	@discussion	One of the keys in the dictionary associated with DRDeviceWriteCapabilitiesKey.
; 				NSNumber indicating whether the device supports burn underrun protection when writing to DVD media.
; 
(def-mactype :DRDeviceCanUnderrunProtectDVDKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
; 	Keys for the dictionary returned by -[DRDevice status]. 

; #if 0
#| ; #pragma mark Device Status
 |#

; #endif

; !
; 	@const		DRDeviceIsBusyKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSNumber indicating whether the device is busy or not.
; 
(def-mactype :DRDeviceIsBusyKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceIsTrayOpenKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSNumber indicating whether the device's tray is open or not.
; 
(def-mactype :DRDeviceIsTrayOpenKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMaximumWriteSpeedKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSNumber containing the maximum burning speed of this device.
; 
(def-mactype :DRDeviceMaximumWriteSpeedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceCurrentWriteSpeedKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSNumber containing the current burning speed of this device.
; 
(def-mactype :DRDeviceCurrentWriteSpeedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaStateKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSString describing the state of the media.
; 
(def-mactype :DRDeviceMediaStateKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaInfoKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSDictionary of information describing the media currently in the device. 
; 				This key may not be present if no media is inserted.
; 
(def-mactype :DRDeviceMediaInfoKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceBurnSpeedsKey
; 	@discussion	One of the keys in the dictionary returned by the status method.
; 				NSArray containing the possible burn speeds available to use.
; 				This key may not be present if no media is inserted.
; 
(def-mactype :DRDeviceBurnSpeedsKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceTrackRefsKey
; 	@discussion One of the keys in the dictionary returned by the status method.
; 				NSArray containing a list of DRTrack objects describing any tracks that
; 				are already on the disc.
; 
(def-mactype :DRDeviceTrackRefsKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceTrackInfoKey
; 	@discussion One of the keys in the dictionary returned by the status method.
; 				NSDictionary containing NSDictionaries describing the tracks.  DRTracks
; 				from the DRDeviceTrackRefsKey are used as keys into this dictionary.
; 
(def-mactype :DRDeviceTrackInfoKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ---------------------------------- 
; 	Media states 
; !
; 	@const		DRDeviceMediaStateMediaPresent
; 	@discussion	One of the possible values for the DRDeviceMediaStateKey.
; 				Device contains media of some type.
; 
(def-mactype :DRDeviceMediaStateMediaPresent (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaStateInTransition
; 	@discussion	One of the possible values for the DRDeviceMediaStateKey.
; 				The media is transitioning from one state to another (i.e., being spun up/down).
; 
(def-mactype :DRDeviceMediaStateInTransition (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaStateNone
; 	@discussion	One of the possible values for the DRDeviceMediaStateKey.
; 				No media is present in the device.
; 
(def-mactype :DRDeviceMediaStateNone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Keys for the media info dictionary, which is a subdictionary under DRDeviceMediaInfoKey,
; 	in the dictionary returned by -[DRDevice status]. 
; !
; 	@const		DRDeviceMediaBSDNameKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSString containing the BSD /dev node name assigned to the media in the device.
; 
(def-mactype :DRDeviceMediaBSDNameKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaIsBlankKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber indicating whether data bas previously been written to the media.
; 
(def-mactype :DRDeviceMediaIsBlankKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaIsAppendableKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber indicating that data can be appended to the exisiting data (if any).
; 
(def-mactype :DRDeviceMediaIsAppendableKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaIsOverwritableKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber indicating that data can be appended to the exisiting data (if any).
; 
(def-mactype :DRDeviceMediaIsOverwritableKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceMediaIsErasableKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber indicating whether this media can be erased.
; 
(def-mactype :DRDeviceMediaIsErasableKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaIsReservedKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber indicating whether the media is reserved for exclusive use by 
; 				the current process.
; 
(def-mactype :DRDeviceMediaIsReservedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaOverwritableSpaceKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				MSF value of the amount of writable space available on the media to be written to.
; 
(def-mactype :DRDeviceMediaOverwritableSpaceKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceMediaFreeSpaceKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				MSF value of the amount of space available on the media to be written to.
; 
(def-mactype :DRDeviceMediaFreeSpaceKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaUsedSpaceKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				MSF value of the amount of space currently used for exising data.
; 
(def-mactype :DRDeviceMediaUsedSpaceKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaBlocksOverwritableKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber containing the amount of writable space available (in blocks) on the media to be written to.
; 
(def-mactype :DRDeviceMediaBlocksOverwritableKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceMediaBlocksFreeKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber containing the amount of space available (in blocks) on the media to be written to.
; 
(def-mactype :DRDeviceMediaBlocksFreeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaBlocksUsedKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber containing the amount of space currently used (in blocks) for exising data.
; 
(def-mactype :DRDeviceMediaBlocksUsedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTrackCountKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber containing the number of tracks present on the media.
; 
(def-mactype :DRDeviceMediaTrackCountKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaSessionCountKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSNumber containing the sessions of tracks present on the media.
; 
(def-mactype :DRDeviceMediaSessionCountKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRDeviceMediaClassKey
; 	@discussion	A key for the dictionary for DRDeviceMediaInfoKey. The value of this key 
; 				is a NSString containing the class of media present in the drive.
; 
(def-mactype :DRDeviceMediaClassKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeKey
; 	@discussion	One of the keys in the dictionary for DRDeviceMediaInfoKey.
; 				NSString containing the type of media inserted in the device.
; 
(def-mactype :DRDeviceMediaTypeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  --------------------------------------- 
;  Media classes 
; !
; 	@const	DRDeviceMediaClassCD
; 	@discussion	One possible value of the DRDeviceMediaClassKey. Indicates the media
; 				is some type of CD based media.
; 
(def-mactype :DRDeviceMediaClassCD (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	DRDeviceMediaClassDVD
; 	@discussion	One possible value of the DRDeviceMediaClassKey. Indicates the media
; 				is some type of DVD based media.
; 
(def-mactype :DRDeviceMediaClassDVD (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	DRDeviceMediaClassUnknown
; 	@discussion	One possible value of the DRDeviceMediaClassKey.  Indicates the media
; 				class is unknown.
; 
(def-mactype :DRDeviceMediaClassUnknown (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  --------------------------------------- 
;  Media types 
; !
; 	@const		DRDeviceMediaTypeCDROM
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a CD-ROM.
; 
(def-mactype :DRDeviceMediaTypeCDROM (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeCDR
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a CD-R.
; 
(def-mactype :DRDeviceMediaTypeCDR (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeCDRW
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a CD-RW.
; 
(def-mactype :DRDeviceMediaTypeCDRW (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeDVDROM
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a DVD-ROM.
; 
(def-mactype :DRDeviceMediaTypeDVDROM (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeDVDRAM
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a DVD-RAM.
; 
(def-mactype :DRDeviceMediaTypeDVDRAM (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeDVDR
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a DVD-R.
; 
(def-mactype :DRDeviceMediaTypeDVDR (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeDVDRW
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a DVD-RW.
; 
(def-mactype :DRDeviceMediaTypeDVDRW (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDeviceMediaTypeDVDPlusR
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a DVD+R.
; 
(def-mactype :DRDeviceMediaTypeDVDPlusR (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceMediaTypeDVDPlusRW
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				Media is a DVD+RW.
; 
(def-mactype :DRDeviceMediaTypeDVDPlusRW (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRDeviceMediaTypeUnknown
; 	@discussion	One of the possible values of the DRDeviceMediaTypeKey.
; 				The type of the media cannot be determined.
; 
(def-mactype :DRDeviceMediaTypeUnknown (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

(provide-interface "DRDevice")