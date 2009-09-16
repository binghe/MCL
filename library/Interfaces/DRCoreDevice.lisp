(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRCoreDevice.h"
; at Sunday July 2,2006 7:27:34 pm.
; 
;      File:       DiscRecordingEngine/DRCoreDevice.h
;  
;      Contains:   Device interfaces for Disc Recording.
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
; #ifndef _H_DRCoreDevice
; #define _H_DRCoreDevice

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef _H_DRCoreObject
#| #|
#include <DiscRecordingEngineDRCoreObject.h>
#endif
|#
 |#
; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifndef _MATH_H_

(require-interface "math")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #ifndef _IOKIT_IOKITLIB_H
#| #|
#include <IOKitIOKitLib.h>
#endif
|#
 |#
; !
; 	@typedef DRDeviceRef
; 	This is the type of a reference to DRDevices.
; 

(def-mactype :DRDeviceRef (find-mactype '(:pointer :__DRDevice)))
; !
; 	@function	DRDeviceGetTypeID
; 	@abstract	Returns the type identifier of all DRDevice instances.
; 

(deftrap-inline "_DRDeviceGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; !
; 	@function	DRCopyDeviceArray
; 	@abstract	Returns an array of all writable devices connected to the system.
; 	@discussion	FireWire, USB, and other technologies allow users to connect and disconnect
; 				devices while a computer is on. The device array returned by this function
; 				is a snapshot that is not guaranteed to stay current for the lifetime
; 				of a process.
; 				
; 				Since device connections are dynamic, a better option than this function is to 
; 				maintain a list of attached devices by listening for 
; 				<tt>kDRDeviceAppearedNotification</tt> and <tt>kDRDeviceDisappearedNotification</tt>
; 				notifications. This function is most useful for initially populating a list of 
; 				devices.
; 	@result		A CFArray containing the devices attached to the system at the time the
; 				function is called.
; 

(deftrap-inline "_DRCopyDeviceArray" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFArray)
() )
; !
; 	@function	DRDeviceCopyDeviceForBSDName
; 	@abstract	Returns the device reference corresponding to the BSD device name.
; 	@param		name	The /dev entry for the device (i.e., disk1)
; 	@result		A DRDevice reference for the device corresponding to the BSD name.
; 

(deftrap-inline "_DRDeviceCopyDeviceForBSDName" 
   ((name (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRDevice)
() )
; !
; 	@function	DRDeviceCopyDeviceForIORegistryEntryPath
; 	@abstract	Returns the device reference corresponding to the IORegistry entry.
; 	@param		path	The IORegistry entry path corresponding to the device. 
; 	@result		A DRDevice reference for the device corresponding to the IORegistry entry path.
; 

(deftrap-inline "_DRDeviceCopyDeviceForIORegistryEntryPath" 
   ((path (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRDevice)
() )
; !
; 	@function	DRDeviceIsValid
; 	@abstract	Determines whether the device is still attached and turned on.
; 	@discussion	Devices can be removed from a system while a client has a reference to them. This function 
; 				allows clients to check if a device reference they are holding is still usable.
; 	@param		device	The device reference to check.
; 	@result		A boolean indicating whether the device reference is still usable (TRUE)
; 				or not (FALSE).
; 

(deftrap-inline "_DRDeviceIsValid" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; !
; 	@function	DRDeviceOpenTray
; 	@abstract	Commands a device to open up its tray.
; 	@discussion	This function will open the tray of the device, if it has one, if and only if
; 				the device does not currently have mounted media. 
; 	@param		device		Device to open.
; 	@result		An error code indicating if the tray could be opened.
; 

(deftrap-inline "_DRDeviceOpenTray" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; !
; 	@function	DRDeviceCloseTray
; 	@abstract	Commands a device to close its tray.
; 	@discussion	This function will close the tray of the device, if it has one. 
; 	@param		device		Device to close.
; 	@result		An error code indicating if the tray could be closed.
; 

(deftrap-inline "_DRDeviceCloseTray" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; !
; 	@function	DRDeviceEjectMedia
; 	@abstract	Commands a device to unmount and eject media.
; 	@discussion	If media is present but cannot be unmounted, this function will fail and return
; 				an error.  If there is no media in the device, this function is
; 				equivalent to DRDeviceOpenTray.
; 	@param		device		Device to eject.
; 	@result		An error code indicating whether the media could be ejected.
; 

(deftrap-inline "_DRDeviceEjectMedia" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; !
; 	@function	DRDeviceAcquireMediaReservation
; 	@abstract	Indicates an interest in reserving blank media.
; 	@discussion	Blank media participates in a reservation system thats allows applications
; 				to express claims on blank media to other applications. Indicating an
; 				interest to reserve blank media does not guarantee acquisition--there may be
; 				other applications that have indicated an interest in the same media.
; 				
; 				Your application will receive a <tt>kDRDeviceStatusChangedNotification</tt> 
; 				notification with a value of <tt>true</tt> for the <tt>kDRDeviceMediaIsReservedKey</tt>
; 				when a blank media reservation has been acquired.
; 				
; 				This function may be called multiple times. Each time it is called, a call to
; 				<tt>DRDeviceReleaseMediaReservation</tt> must be made at a later time or the
; 				process will never fully rescind its interest in the blank media reservation.
; 	@param		device	The device reference for which to indicate an interest.
; 

(deftrap-inline "_DRDeviceAcquireMediaReservation" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRDeviceReleaseMediaReservation
; 	@abstract	Rescind an interest in the blank media reservation.
; 	@discussion	If the process currently has a reservation, it will be released 
; 				and passed on to the next interested process.
; 	@param		device	The device reference for which to rescind an interest.
; 

(deftrap-inline "_DRDeviceReleaseMediaReservation" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRDeviceAcquireExclusiveAccess
; 	@abstract	Attempts to acquire an exclusive access session with the device.
; 	@discussion	If this function succeeds, the device becomes unusable by any other process.
; 				All volumes mounted from media in the drive must be unmounted before
; 				exclusive access can be granted.  The Disc Recording engine attempts to
; 				unmount volumes for you, but this call will fail if some volumes could
; 				not be unmounted.
; 				
; 				Your application may call this function multiple times. Each time,
; 				a call to DRDeviceReleaseExclusiveAccess must be made at a later time
; 				or the process will never release its exclusive access.
; 	@param		device	The device reference for which to acquire exclusive access.
; 	@result		An error code indicating whether exclusive access could be acquired.
; 

(deftrap-inline "_DRDeviceAcquireExclusiveAccess" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; !
; 	@function	DRDeviceReleaseExclusiveAccess
; 	@abstract	Release exclusive access to a device.
; 	@discussion	This function will release one request for exclusive access made by a process
; 				that called DRDeviceAcquireExclusiveAccess. A call to this function must be
; 				made for every call to DRDeviceAcquireExclusiveAccess, otherwise the process
; 				will never release its exclusive access.
; 	@param		device	The device reference for which to release exclusive access.
; 

(deftrap-inline "_DRDeviceReleaseExclusiveAccess" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRDeviceCopyInfo
; 	@abstract	Returns information about the device.
; 	@discussion	This function returns information that identifies the device and describes 
; 				its capabilites. The information includes the vendor's name, the product 
; 				identifier, whether the device can burn CDs or DVDs, and so on.
; 	@param		device		The device to query.
; 	@result		A CFDictionary object identifying the device and its capabilities.
; 

(deftrap-inline "_DRDeviceCopyInfo" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFDictionary)
() )
; !
; 	@function	DRDeviceCopyStatus
; 	@abstract	Returns the status of the device.
; 	@discussion	This function returns information about the status of the device. This
; 				information includes whether media is present or not, and, if present, 
; 				a descripton of the media including its size, kind, and so on. 
; 	@param		device		The device to query.
; 	@result		A CFDictionary object describing the status of the device and 
; 				any media it contains.
; 

(deftrap-inline "_DRDeviceCopyStatus" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFDictionary)
() )
;  ---------------------------------- 
; 	Device notifications. 
; !
; 	@const kDRDeviceAppearedNotification
; 	@discussion	Notification sent when a device has become available.
; 				Because users can connect and disconnect FireWire, USB, and other devices while a
; 				computer is on, you should maintain your own list of attached devices and rely on notifications
; 				to keep the list current.
; 
(def-mactype :kDRDeviceAppearedNotification (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceDisappearedNotification
; 	@discussion	Notification sent when a device is no longer available.
; 				Because users can connect and disconnect FireWire, USB, and other devices while a
; 				computer is on, you should maintain your own list of attached devices and rely on notifications
; 				to keep the list current.
;  
(def-mactype :kDRDeviceDisappearedNotification (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceStatusChangedNotification
; 	@discussion	Notification sent when a device's status changes, usually because a disc
; 				has been inserted or removed.  The value of the info parameter for your notification 
; 				callback is equivalent to the dictionary object reference returned from a call to 
; 				DRDeviceCopyStatus.
; 
(def-mactype :kDRDeviceStatusChangedNotification (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
; 	Keys for the dictionary returned by DRDeviceCopyInfo. 
; !
; 	@const kDRDeviceSupportLevelKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object indicating how well the engine supports the device.
; 
(def-mactype :kDRDeviceSupportLevelKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceIORegistryEntryPathKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object containing a copy of the path to the device entry in the IORegistry.
; 
(def-mactype :kDRDeviceIORegistryEntryPathKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceVendorNameKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object containing the vendor name extracted from the device.
; 
(def-mactype :kDRDeviceVendorNameKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceProductNameKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object containing the product name extracted from the device.
; 
(def-mactype :kDRDeviceProductNameKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceFirmwareRevisionKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object containing the firmware revision extracted from the device.
; 
(def-mactype :kDRDeviceFirmwareRevisionKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDevicePhysicalInterconnectKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object containing the type of the bus the device is on.
; 
(def-mactype :kDRDevicePhysicalInterconnectKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDevicePhysicalInterconnectLocationKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this
; 				key is a reference to a CFString object containing the physical interconnect location.
; 
(def-mactype :kDRDevicePhysicalInterconnectLocationKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceWriteCapabilitiesKey
; 	@discussion	A key for the dictionary object  returned by DRDeviceCopyInfo. The value of this key is 
; 				a reference to a CFString object describing the capabilities the drive has for writing to different 
; 				media.
; 
(def-mactype :kDRDeviceWriteCapabilitiesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceLoadingMechanismCanEjectKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key
; 				is a reference to a CFBoolean object that indicates if the loading mechanism of the drive can eject.
; 
(def-mactype :kDRDeviceLoadingMechanismCanEjectKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceLoadingMechanismCanInjectKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key
; 				is a reference to a CFBoolean object that indicates if the loading mechanism of the drive can inject.
; 
(def-mactype :kDRDeviceLoadingMechanismCanInjectKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceLoadingMechanismCanOpenKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key
; 				is a reference to a CFBoolean object that indicates if the loading mechanism of the drive can open.
; 
(def-mactype :kDRDeviceLoadingMechanismCanOpenKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceWriteBufferSizeKey
; 	@discussion	A key for the dictionary object returned by DRDeviceCopyInfo. The value of this key
; 				is a reference to a CFNumber object containing the size of the write buffer of the device.
; 
(def-mactype :kDRDeviceWriteBufferSizeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ---------------------------------- 
;  Support levels 
; !
; 	@const kDRDeviceSupportLevelNone
; 	@discussion	One value for the kDRDeviceSupportLevelKey dictionary key. This value indicates
; 				the engine does not support the device and it cannot be used.
; 
(def-mactype :kDRDeviceSupportLevelNone (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceSupportLevelUnsupported
; 	@discussion	One value for the kDRDeviceSupportLevelKey dictionary key. This value indicates
; 				the device is unsupported but the Disc Recording engine will try to use it anyway.
; 
(def-mactype :kDRDeviceSupportLevelUnsupported (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceSupportLevelVendorSupported
; 	@discussion	One value for the kDRDeviceSupportLevelKey dictionary key. This value
; 				indicates the device vendor has provided support for the device.
; 
(def-mactype :kDRDeviceSupportLevelVendorSupported (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceSupportLevelAppleSupported
; 	@discussion	One value for the kDRDeviceSupportLevelKey dictionary key. This value
; 				indicates that Apple has provided support for the device.
; 
(def-mactype :kDRDeviceSupportLevelAppleSupported (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceSupportLevelAppleShipping
; 	@discussion	One value for the kDRDeviceSupportLevelKey dictionary key. This value indicates that Apple
; 				has provided support for the device and it has shipped in a machine made by Apple.
; 
(def-mactype :kDRDeviceSupportLevelAppleShipping (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Types of physical interconnect 
; !
; 	@const	kDRDevicePhysicalInterconnectATAPI
; 	@discussion	One value for the kDRDevicePhysicalInterconnectKey dictionary key. This value indicates that the
; 				device is connected by an ATAPI interface.
; 
(def-mactype :kDRDevicePhysicalInterconnectATAPI (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDevicePhysicalInterconnectFibreChannel
; 	@discussion	One value for the kDRDevicePhysicalInterconnectKey dictionary key. This value indicates that the
; 				device is connected by a Fibre Channel interface.
; 
(def-mactype :kDRDevicePhysicalInterconnectFibreChannel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const	kDRDevicePhysicalInterconnectFireWire
; 	@discussion	One value for the kDRDevicePhysicalInterconnectKey dictionary key. This value indicates that the
; 				device is connected by a FireWire interface.
; 
(def-mactype :kDRDevicePhysicalInterconnectFireWire (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDevicePhysicalInterconnectUSB
; 	@discussion	One value for the kDRDevicePhysicalInterconnectKey dictionary key. This value indicates that the
; 				device is connected by a USB interface.
; 
(def-mactype :kDRDevicePhysicalInterconnectUSB (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDevicePhysicalInterconnectSCSI
; 	@discussion	One value for the kDRDevicePhysicalInterconnectKey dictionary key. This value indicates that the
; 				device is connected by a SCSI interface.
; 
(def-mactype :kDRDevicePhysicalInterconnectSCSI (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Physical interconnect locations 
; !
; 	@const	kDRDevicePhysicalInterconnectLocationInternal
; 	@discussion	One value for the kDRDevicePhysicalInterconnectLocationKey dictionary key.
; 				This value indicates that the device is on an internal bus.
; 
(def-mactype :kDRDevicePhysicalInterconnectLocationInternal (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDevicePhysicalInterconnectLocationExternal
; 	@discussion	One value for the kDRDevicePhysicalInterconnectLocationKey dictionary key.
; 				This value indicates that the device is on an external bus.
; 
(def-mactype :kDRDevicePhysicalInterconnectLocationExternal (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDevicePhysicalInterconnectLocationUnknown
; 	@discussion	One value for the kDRDevicePhysicalInterconnectLocationKey dictionary key.
; 				This value indicates that the software cannot determine whether the device is
; 				on an internal or external bus.
; 
(def-mactype :kDRDevicePhysicalInterconnectLocationUnknown (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Keys for the write capabilities dictionary, which is a subdictionary under
; 	kDRDeviceWriteCapabilitiesKey, in the dictionary returned by DRDeviceCopyInfo. 
; !
; 	@const kDRDeviceCanWriteKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to any type of media.
; 
(def-mactype :kDRDeviceCanWriteKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteCDKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to some type of CD-based media.
; 
(def-mactype :kDRDeviceCanWriteCDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteCDRKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to CD-R media.
; 
(def-mactype :kDRDeviceCanWriteCDRKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteCDRWKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to CD-RW media.
; 
(def-mactype :kDRDeviceCanWriteCDRWKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to some type of DVD-based media.
; 
(def-mactype :kDRDeviceCanWriteDVDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDRKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to DVD-R media.
; 
(def-mactype :kDRDeviceCanWriteDVDRKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDRWKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to DVD-RW media.
; 
(def-mactype :kDRDeviceCanWriteDVDRWKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDRAMKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to DVD-RAM media.
; 
(def-mactype :kDRDeviceCanWriteDVDRAMKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDPlusRKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to DVD+R media.
; 
(def-mactype :kDRDeviceCanWriteDVDPlusRKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDPlusRWKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write to DVD+RW media.
; 
(def-mactype :kDRDeviceCanWriteDVDPlusRWKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteIndexPointsKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write index points to CD media.
; 
(def-mactype :kDRDeviceCanWriteIndexPointsKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteISRCKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can write International
; 				Standard Recording Code (ISRC) to CD media.
; 
(def-mactype :kDRDeviceCanWriteISRCKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteCDTAOKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device supports a track-at-once (TAO)
; 				burn strategy for CD.
; 
(def-mactype :kDRDeviceCanWriteCDTAOKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteCDSAOKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device supports a session-at-once (SAO)
; 				burn strategy for CD.
; 
(def-mactype :kDRDeviceCanWriteCDSAOKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteCDRawKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device supports a raw mode 
; 				burn strategy for CD.
; 
; 				A raw mode burn writes client-defined lead-in, program area, and lead-out data to CD media 
; 				in a single pass. It supports options such as single-pass writing of a multisession 
; 				disc. The Multi-Media Command Set (MMC) standard name for this strategy is "raw" but it 
; 				is often called disc-at-once (DAO).
; 
(def-mactype :kDRDeviceCanWriteCDRawKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanWriteDVDDAOKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device supports a disc-at-once (DAO)
; 				burn strategy on DVD media. This burn strategy does not apply to CD media.
; 
(def-mactype :kDRDeviceCanWriteDVDDAOKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceCanTestWriteCDKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can perform a test write to CD media.
; 
(def-mactype :kDRDeviceCanTestWriteCDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanTestWriteDVDKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device can perform a test write to DVD media.
; 
(def-mactype :kDRDeviceCanTestWriteDVDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanUnderrunProtectCDKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device has burn underrun protection when
; 				writing to CD media.
; 
(def-mactype :kDRDeviceCanUnderrunProtectCDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCanUnderrunProtectDVDKey
; 	@discussion	A key for the write capabilities dictionary in the device info dictionary.  The value
; 				is a reference to a CFBoolean object indicating whether the device has burn underrun protection when
; 				writing to DVD media.
; 
(def-mactype :kDRDeviceCanUnderrunProtectDVDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
; 	Keys for the dictionary returned by DRDeviceCopyStatus. 
; !
; 	@const kDRDeviceIsBusyKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFBoolean object indicating if the device is busy.
; 
(def-mactype :kDRDeviceIsBusyKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceIsTrayOpenKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFBoolean object indicating if the device's tray is open.
; 
(def-mactype :kDRDeviceIsTrayOpenKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMaximumWriteSpeedKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFNumber object containing the maximum write speed in KB/s, where 1KB = 1000 bytes.
; 
(def-mactype :kDRDeviceMaximumWriteSpeedKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceCurrentWriteSpeedKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFNumber object containing the current write speed in KB/s, where 1KB = 1000 bytes.
; 
(def-mactype :kDRDeviceCurrentWriteSpeedKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaStateKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFString object containing information about the state of the media.
; 
(def-mactype :kDRDeviceMediaStateKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@constant kDRDeviceMediaInfoKey
; 	@discussion A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFDictionary object containing information about the media in the drive.
; 
(def-mactype :kDRDeviceMediaInfoKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceBurnSpeedsKey
; 	@discussion	A key for the dictionary returned by DRDeviceCopyStatus. The value of this key 
; 				is a reference to a CFArray object containing the available burn speeds. This key may not
; 				be accessible if there is no disc in the drive.
; 
(def-mactype :kDRDeviceBurnSpeedsKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@constant kDRDeviceTrackRefsKey
; 	@discussion A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFArray object containing a list of DRTrack objects describing any tracks that
; 				are already on the disc.
; 
(def-mactype :kDRDeviceTrackRefsKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@constant kDRDeviceTrackInfoKey
; 	@discussion A key for the dictionary returned by DRDeviceCopyStatus. The value of this key is 
; 				a reference to a CFDictionary object containing dictionaries describing on-disc tracks.  DRTrackRef
; 				dictionaries from the kDRDeviceTrackRefsKey constant are used as keys into this dictionary.
; 
(def-mactype :kDRDeviceTrackInfoKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ---------------------------------- 
; 	Media states 
; !
; 	@const	kDRDeviceMediaStateMediaPresent
; 	@discussion	One value for the kDRDeviceMediaStateKey dictionary key. This value indicates that some
; 				kind of media is present in the drive.  Check the value of the kDRDeviceMediaInfoKey dictionary key
; 				for specific media information.
; 
(def-mactype :kDRDeviceMediaStateMediaPresent (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaStateInTransition
; 	@discussion	One value for the kDRDeviceMediaStateKey dictionary key. This value indicates that the
; 				media is in transition, typically spinning up after being inserted or
; 				spinning down in preparation for ejecting.
; 
(def-mactype :kDRDeviceMediaStateInTransition (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaStateNone
; 	@discussion	One value for the kDRDeviceMediaStateKey dictionary key. This value indicates that there is
; 				no disc present in the drive.
; 
(def-mactype :kDRDeviceMediaStateNone (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Keys for the media info dictionary, which is a subdictionary under kDRDeviceMediaInfoKey,
; 	in the dictionary returned by DRDeviceCopyStatus. 
; !
; 	@const kDRDeviceMediaBSDNameKey
; 	@discussion	A key in the media info dictionary. The value of this key 
; 				is a reference to a CFString object containing the BSD name assigned to the device.
; 
(def-mactype :kDRDeviceMediaBSDNameKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaIsBlankKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFBoolean
; 				object indicating whether the media is blank and has no data on it.
; 
(def-mactype :kDRDeviceMediaIsBlankKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaIsAppendableKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFBoolean
; 				object indicating whether the disc is appendable -- in other words, whether new sessions can be written.
; 
(def-mactype :kDRDeviceMediaIsAppendableKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaIsOverwritableKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFBoolean
; 				object indicating whether the disc is writable -- in other words, whether it can be fully (re)written.
; 
(def-mactype :kDRDeviceMediaIsOverwritableKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceMediaIsErasableKey
; 	@discussion	A key in the media info dictionary. The value of this key 
; 				is a reference to a CFBoolean object indicating whether the disc can be erased.
; 
(def-mactype :kDRDeviceMediaIsErasableKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaIsReservedKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFBoolean
; 				object indicating whether the disc is reserved for exclusive use by the current process.
; 
(def-mactype :kDRDeviceMediaIsReservedKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaBlocksOverwritableKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFNumber
; 				object containing the number of writable blocks on the disc.
; 
(def-mactype :kDRDeviceMediaBlocksOverwritableKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const kDRDeviceMediaBlocksFreeKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFNumber
; 				object containing the number of free blocks on the disc.
; 
(def-mactype :kDRDeviceMediaBlocksFreeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaBlocksUsedKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFNumber
; 				object containing the number of blocks used by data on the disc.
; 
(def-mactype :kDRDeviceMediaBlocksUsedKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaTrackCountKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFNumber
; 				object containing the total number of tracks on the disc in all sessions.
; 
(def-mactype :kDRDeviceMediaTrackCountKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaSessionCountKey
; 	@discussion	A key in the media info dictionary. The value of this key is a reference to a CFNumber
; 				object containing the number of sessions on the disc.
; 
(def-mactype :kDRDeviceMediaSessionCountKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaClassKey
; 	@discussion	A key for the media info dictionary. The value of this key 
; 				is a reference to a CFString object indicating the class of media present in the drive.
; 
(def-mactype :kDRDeviceMediaClassKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRDeviceMediaTypeKey
; 	@discussion	A key in the media info dictionary. The value of this key 
; 				is a reference to a CFString object indicating the type of media present in the drive.
; 
(def-mactype :kDRDeviceMediaTypeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  --------------------------------------- 
;  Media classes 
; !
; 	@const	kDRDeviceMediaClassCD
; 	@discussion	One value for the kDRDeviceMediaClassKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is CD-based.
; 
(def-mactype :kDRDeviceMediaClassCD (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaClassDVD
; 	@discussion	One value for the kDRDeviceMediaClassKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is DVD-based.
; 
(def-mactype :kDRDeviceMediaClassDVD (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaClassUnknown
; 	@discussion	One value for the kDRDeviceMediaClassKey dictionary key in the media info dictionary.
; 				This value indicates that the media class is unknown.
; 
(def-mactype :kDRDeviceMediaClassUnknown (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  --------------------------------------- 
;  Media types 
; !
; 	@const	kDRDeviceMediaTypeCDROM
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a CD-ROM.
; 
(def-mactype :kDRDeviceMediaTypeCDROM (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeCDR
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a CD-R.
; 
(def-mactype :kDRDeviceMediaTypeCDR (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeCDRW
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a CD-RW.
; 
(def-mactype :kDRDeviceMediaTypeCDRW (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeDVDROM
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a DVD-ROM.
; 
(def-mactype :kDRDeviceMediaTypeDVDROM (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeDVDRAM
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a DVD-RAM.
; 
(def-mactype :kDRDeviceMediaTypeDVDRAM (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeDVDR
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a DVD-R.
; 
(def-mactype :kDRDeviceMediaTypeDVDR (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeDVDRW
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a DVD-RW.
; 
(def-mactype :kDRDeviceMediaTypeDVDRW (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeDVDPlusR
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a DVD+R.
; 
(def-mactype :kDRDeviceMediaTypeDVDPlusR (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeDVDPlusRW
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc is a DVD+RW.
; 
(def-mactype :kDRDeviceMediaTypeDVDPlusRW (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceMediaTypeUnknown
; 	@discussion	One value for the kDRDeviceMediaTypeKey dictionary key in the media info dictionary.
; 				This value indicates that the disc type is unknown.
; 
(def-mactype :kDRDeviceMediaTypeUnknown (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------------- 
;  Common predefined values for burn speeds. 
; !
; 	@const	kDRDeviceBurnSpeedCD1x
; 	@discussion			A predefined value for the minimum CD burn speed of 176.4 kilobytes 
; 						per second, where 1 kilobyte = 1,000 bytes.
; 
(def-mactype :kDRDeviceBurnSpeedCD1x (find-mactype ':float)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceBurnSpeedDVD1x
; 	@discussion			A predefined value for the minimum DVD burn speed of 1,385.0 kilobytes 
; 						per second, where 1 kilobyte = 1,000 bytes.
; 
(def-mactype :kDRDeviceBurnSpeedDVD1x (find-mactype ':float)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const	kDRDeviceBurnSpeedMax
; 	@discussion			A predefined value used to request the maximum speed at which a device can 
; 						perform a burn. On receiving a burn request of kDRDeviceBurnSpeedMax, a drive
; 						selects the highest usable speed given its capabilities, the bus bandwidth, and
; 						the capabilities of the recordable disc.
; 
(def-mactype :kDRDeviceBurnSpeedMax (find-mactype ':float)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------------- 
;  Macros for converting KPS speeds to and from approximate X-factors.  Note that the
; 	X-factor is an approximate measure, particularly in modern drives which rarely maintain
; 	a constant linear velocity.  As in the MMC specification, speeds in the engine are
; 	always specified as KPS at the innermost track of the disc. 
; !
; 	@defined DRDeviceKPSForCDXFactor
; 	@discussion	Macro for converting from an x-factor (1x, 8x, 20x, etc) to the real KB/s value 
; 				for a CD burn.  For this macro, 1 KB = 1000 bytes.
; 
; #define DRDeviceKPSForCDXFactor(xfactor)	((float)(xfactor) * kDRDeviceBurnSpeedCD1x)
; !
; 	@defined DRDeviceKPSForDVDXFactor
; 	@discussion	A macro for converting from an x-factor (1x, 8x, 20x, etc.) to the real KB/s value 
; 				for a DVD burn, where 1 KB = 1000 bytes.
; 
; #define DRDeviceKPSForDVDXFactor(xfactor)	((float)(xfactor) * kDRDeviceBurnSpeedDVD1x)
; !
; 	@defined DRDeviceCDXFactorForKPS
; 	@discussion	A macro for converting from a KB/s value to the equivalent x-factor (1x, 8x, 20x, etc.)
; 				for a CD burn, where 1 KB = 1000 bytes.
; 
; #define DRDeviceCDXFactorForKPS(kps)		(UInt32)floor((kps)/kDRDeviceBurnSpeedCD1x + 0.5)
; !
; 	@defined DRDeviceDVDXFactorForKPS
; 	@discussion	A macro for converting from a KB/s value to the equivalent x-factor (1x, 8x, 20x, etc.)
; 				for a DVD burn, where 1 KB = 1000 bytes.
; 
; #define DRDeviceDVDXFactorForKPS(kps)		(UInt32)floor((kps)/kDRDeviceBurnSpeedDVD1x + 0.5)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRCoreDevice */


(provide-interface "DRCoreDevice")