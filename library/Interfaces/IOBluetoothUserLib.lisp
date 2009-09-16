(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothUserLib.h"
; at Sunday July 2,2006 7:28:34 pm.
; 
; 	File:		IOBluetoothUserLib.h
; 	Contains:	Library to allow user-side clients to use Bluetooth API's.
; 	Version:	1.0
; 	Copyright:	й 2002 by Apple Computer, Inc. All rights reserved.
; 	DRI:		Jason Giles
; 	Technology:	Bluetooth
; 
; #pragma once

(require-interface "IOKit/IOKitLib")

(require-interface "CoreFoundation/CFMachPort")

(require-interface "IOBluetooth/Bluetooth")
; #ifdef __OBJC__
#| #|
#import 	<FoundationFoundation.h>
#endif
|#
 |#
; --------------------------------------------------------------------------------------------------------------------------
; !	@header		IOBluetoothUserLib.h
; 	@abstract	Public Interfaces for Apple's implementation of Bluetooth technology.
; 	@discussion	There is an accompanying header to this, "Bluetooth.h", which contains all technology-specific typedefs and information. This header relies heavily on it.
; 
; ===========================================================================================================================
;  Availability Macros
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее Availability Macros ее
 |#

; #endif


; #if !defined( MAC_OS_X_VERSION_MIN_REQUIRED ) || ( MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_X_VERSION_10_2 )

; #warning MAC_OS_X_VERSION_MIN_REQUIRED should be at least MAC_OS_X_VERSION_10_2 for Bluetooth support
; #ifdef MAC_OS_X_VERSION_MIN_REQUIRED
#| #|
		#undef MAC_OS_X_VERSION_MIN_REQUIRED
	#endif
|#
 |#
; #define MAC_OS_X_VERSION_MIN_REQUIRED	MAC_OS_X_VERSION_10_2

; #endif


(require-interface "AvailabilityMacros")
; #ifndef MAC_OS_X_VERSION_10_2_1
(defconstant $MAC_OS_X_VERSION_10_2_1 1021)
; #define MAC_OS_X_VERSION_10_2_1	1021

; #endif

; #ifndef MAC_OS_X_VERSION_10_2_2
(defconstant $MAC_OS_X_VERSION_10_2_2 1022)
; #define MAC_OS_X_VERSION_10_2_2	1022

; #endif

; #ifndef MAC_OS_X_VERSION_10_2_3
(defconstant $MAC_OS_X_VERSION_10_2_3 1023)
; #define MAC_OS_X_VERSION_10_2_3	1023

; #endif

; #ifndef MAC_OS_X_VERSION_10_2_4
(defconstant $MAC_OS_X_VERSION_10_2_4 1024)
; #define MAC_OS_X_VERSION_10_2_4	1024

; #endif

; #ifndef MAC_OS_X_VERSION_10_2_5
(defconstant $MAC_OS_X_VERSION_10_2_5 1025)
; #define MAC_OS_X_VERSION_10_2_5	1025

; #endif

; #ifndef MAC_OS_X_VERSION_10_2_6
(defconstant $MAC_OS_X_VERSION_10_2_6 1026)
; #define MAC_OS_X_VERSION_10_2_6	1026

; #endif

; #ifndef MAC_OS_X_VERSION_10_2_7
(defconstant $MAC_OS_X_VERSION_10_2_7 1027)
; #define MAC_OS_X_VERSION_10_2_7	1027

; #endif

(defconstant $BLUETOOTH_VERSION_1_0 10000)
; #define BLUETOOTH_VERSION_1_0	010000
; #define BLUETOOTH_VERSION_1_0_0	BLUETOOTH_VERSION_1_0
(defconstant $BLUETOOTH_VERSION_1_0_1 10001)
; #define BLUETOOTH_VERSION_1_0_1	010001
(defconstant $BLUETOOTH_VERSION_1_1 10100)
; #define BLUETOOTH_VERSION_1_1	010100
; #define BLUETOOTH_VERSION_1_1_0	BLUETOOTH_VERSION_1_1
(defconstant $BLUETOOTH_VERSION_1_2 10200)
; #define BLUETOOTH_VERSION_1_2	010200
; #define BLUETOOTH_VERSION_1_2_0	BLUETOOTH_VERSION_1_2
(defconstant $BLUETOOTH_VERSION_1_2_1 10201)
; #define BLUETOOTH_VERSION_1_2_1 010201
(defconstant $BLUETOOTH_VERSION_1_3 10300)
; #define BLUETOOTH_VERSION_1_3	010300
; #define BLUETOOTH_VERSION_1_3_0	BLUETOOTH_VERSION_1_3
(defconstant $BLUETOOTH_VERSION_1_3_1 10301)
; #define BLUETOOTH_VERSION_1_3_1 010301
; #define BLUETOOTH_VERSION_CURRENT	BLUETOOTH_VERSION_1_3_1
; #ifdef BLUETOOTH_VERSION_USE_CURRENT
#| #|
	#define BLUETOOTH_VERSION_MIN_REQUIRED	BLUETOOTH_VERSION_CURRENT
	#define BLUETOOTH_VERSION_MAX_ALLOWED	BLUETOOTH_VERSION_CURRENT
|#
 |#

; #else
; #ifdef MAC_OS_X_VERSION_MIN_REQUIRED

; #if MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_2_7
; #define BLUETOOTH_VERSION_MIN_REQUIRED	BLUETOOTH_VERSION_1_3_1
#| 
; #elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_2_5
; #define BLUETOOTH_VERSION_MIN_REQUIRED	BLUETOOTH_VERSION_1_2

; #elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_2_4
; #define BLUETOOTH_VERSION_MIN_REQUIRED	BLUETOOTH_VERSION_1_1

; #elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_2_2
; #define BLUETOOTH_VERSION_MIN_REQUIRED	BLUETOOTH_VERSION_1_0_1

; #elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_2
; #define BLUETOOTH_VERSION_MIN_REQUIRED	BLUETOOTH_VERSION_1_0
 |#

; #else

; #error MAC_OS_X_VERSION_MIN_REQUIRED must be >= MAC_OS_X_VERSION_10_2 for Bluetooth support

; #endif


; #endif

; #ifdef MAC_OS_X_VERSION_MAX_ALLOWED

; #if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_2
; #define BLUETOOTH_VERSION_MAX_ALLOWED	BLUETOOTH_VERSION_1_0
#| 
; #elif MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_2_2
; #define BLUETOOTH_VERSION_MAX_ALLOWED	BLUETOOTH_VERSION_1_0_1

; #elif MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_2_4
; #define BLUETOOTH_VERSION_MAX_ALLOWED	BLUETOOTH_VERSION_1_1

; #elif MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_2_5
; #define BLUETOOTH_VERSION_MAX_ALLOWED	BLUETOOTH_VERSION_1_2
 |#

; #else 
; #define BLUETOOTH_VERSION_MAX_ALLOWED	BLUETOOTH_VERSION_1_3_1

; #endif


; #endif


; #endif

; 
;  * AVAILABLE_BLUETOOTH_VERSION_1_0_1_AND_LATER
;  *
;  * Used on declarations introduced in Mac OS X 10.2.2 (Bluetooth version 1.0.1)
;  

; #if BLUETOOTH_VERSION_MAX_ALLOWED < BLUETOOTH_VERSION_1_0_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_0_1_AND_LATER		UNAVAILABLE_ATTRIBUTE
#| 
; #elif BLUETOOTH_VERSION_MIN_REQUIRED < BLUETOOTH_VERSION_1_0_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_0_1_AND_LATER		WEAK_IMPORT_ATTRIBUTE
 |#

; #else
; #define AVAILABLE_BLUETOOTH_VERSION_1_0_1_AND_LATER

; #endif

; 
;  * AVAILABLE_BLUETOOTH_VERSION_1_1_AND_LATER
;  *
;  * Used on declarations introduced in Mac OS X 10.2.4 (Bluetooth version 1.1)
;  

; #if BLUETOOTH_VERSION_MAX_ALLOWED < BLUETOOTH_VERSION_1_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_1_AND_LATER		UNAVAILABLE_ATTRIBUTE
#| 
; #elif BLUETOOTH_VERSION_MIN_REQUIRED < BLUETOOTH_VERSION_1_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_1_AND_LATER		WEAK_IMPORT_ATTRIBUTE
 |#

; #else
; #define AVAILABLE_BLUETOOTH_VERSION_1_1_AND_LATER

; #endif

; 
;  * AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
;  *
;  * Used on declarations introduced in Mac OS X 10.2.5 (Bluetooth version 1.2)
;  

; #if BLUETOOTH_VERSION_MAX_ALLOWED < BLUETOOTH_VERSION_1_2
; #define AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER		UNAVAILABLE_ATTRIBUTE
#| 
; #elif BLUETOOTH_VERSION_MIN_REQUIRED < BLUETOOTH_VERSION_1_2
; #define AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER		WEAK_IMPORT_ATTRIBUTE
 |#

; #else
; #define AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER

; #endif

; 
;  * AVAILABLE_BLUETOOTH_VERSION_1_2_1_AND_LATER
;  *
;  * Used on declarations introduced in Bluetooth Software Update 1.2.1 (Bluetooth version 1.2.1)
;  

; #if BLUETOOTH_VERSION_MAX_ALLOWED < BLUETOOTH_VERSION_1_2_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_2_1_AND_LATER		UNAVAILABLE_ATTRIBUTE
#| 
; #elif BLUETOOTH_VERSION_MIN_REQUIRED < BLUETOOTH_VERSION_1_2_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_2_1_AND_LATER		WEAK_IMPORT_ATTRIBUTE
 |#

; #else
; #define AVAILABLE_BLUETOOTH_VERSION_1_2_1_AND_LATER

; #endif

; 
;  * AVAILABLE_BLUETOOTH_VERSION_1_3_AND_LATER
;  *
;  * Used on declarations introduced in Mac OS X 10.2.7 (Bluetooth version 1.3)
;  

; #if BLUETOOTH_VERSION_MAX_ALLOWED < BLUETOOTH_VERSION_1_3
; #define AVAILABLE_BLUETOOTH_VERSION_1_3_AND_LATER		UNAVAILABLE_ATTRIBUTE
#| 
; #elif BLUETOOTH_VERSION_MIN_REQUIRED < BLUETOOTH_VERSION_1_3
; #define AVAILABLE_BLUETOOTH_VERSION_1_3_AND_LATER		WEAK_IMPORT_ATTRIBUTE
 |#

; #else
; #define AVAILABLE_BLUETOOTH_VERSION_1_3_AND_LATER

; #endif

; 
;  * AVAILABLE_BLUETOOTH_VERSION_1_3_1_AND_LATER
;  *
;  * Used on declarations introduced in Mac OS X 10.2.7 (Bluetooth version 1.3.1)
;  

; #if BLUETOOTH_VERSION_MAX_ALLOWED < BLUETOOTH_VERSION_1_3_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_3_1_AND_LATER		UNAVAILABLE_ATTRIBUTE
#| 
; #elif BLUETOOTH_VERSION_MIN_REQUIRED < BLUETOOTH_VERSION_1_3_1
; #define AVAILABLE_BLUETOOTH_VERSION_1_3_1_AND_LATER		WEAK_IMPORT_ATTRIBUTE
 |#

; #else
; #define AVAILABLE_BLUETOOTH_VERSION_1_3_1_AND_LATER

; #endif

; ===========================================================================================================================
;  General
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее General ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothGetVersion
; 	@abstract	Returns the versions of the bluetooth software and local hardware.
; 	@param		outSoftwareVersion		Bluetooth software stack version. This parameter is optional.
; 	@param		outHardwareVersion		HCI/Controller version information. This parameter is optional.
; 	@result		IOReturn				Determines if successful at getting local hardware version or not.
; 	@discussion	Error or not, the software version will be returned correctly.
; 

(deftrap-inline "_IOBluetoothGetVersion" 
   ((outSoftwareVersion (:pointer :NumVersion))
    (outHardwareVersion (:pointer :BLUETOOTHHCIVERSIONINFO))
   )
   :signed-long
() )

(def-mactype :IOBluetoothObjectRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothDeviceRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothL2CAPChannelRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothRFCOMMChannelRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothSDPServiceRecordRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothSDPUUIDRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothSDPDataElementRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothUserNotificationRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothObjectID (find-mactype ':UInt32))
(defconstant $kIOBluetoothObjectIDNULL 0)
; #define kIOBluetoothObjectIDNULL	((IOBluetoothObjectID)0)
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothObjectRetain
; 	@abstract	Increments the ref count on the target object.
; 	@discussion	The Bluetooth user lib implements a reference counting scheme similar to CoreFoundation.  In general,
;                 any function that is named with Create returns an IOBluetoothObjectRef that must be released by
;                 the caller.  Unless otherwise documented, the other functions do not return an object that must
;                 be released.  However, if the caller wants to keep a reference to the returned object outside
;                 of the caller's scope, that object must be retained.
;     @param		bluetoothObject The target IOBluetoothObjectRef
; 	@result		Returns the IOBluetoothObjectRef passed in with one more ref count.
; 

(deftrap-inline "_IOBluetoothObjectRetain" 
   ((bluetoothObject (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothObjectRelease
; 	@abstract	Decrements the ref count on the target object.
; 	@discussion	The ref counting scheme allows the IOBluetoothObjectRefs to be freed when they are no longer used.
;                 When the ref count reaches zero, the target object will be freed.
;     @param		bluetoothObject The target IOBluetoothObjectRef
; 

(deftrap-inline "_IOBluetoothObjectRelease" 
   ((bluetoothObject (:pointer :OpaqueIOBluetoothObjectRef))
   )
   nil
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothGetObjectIDFromArguments
; 	@abstract	Returns the BluetoothObjectID passed as an argument to an auto-launched app.
; 	@discussion	When an application gets auto-launched by the blued process (as a result of an incoming connection
; 				to an appropriately configured service), it has a BluetoothObjectID passed to it on the command
; 				line.  To get the BluetoothObjectID, simply pass the argc and argv parameters received in main()
; 				to this function.  The returned BluetoothObjectID can then be used to find the appropriate
; 				IOBluetoothL2CAPChannel or IOBluetoothRFCOMMChannel depending on the type of service (using 
; 				IOBluetoothL2CAPChannelCreateFromObjectID() or IOBluetoothRFCOMMChannelCreateFromObjectID.)
;     @param		argc The argc parameter passed to main()
; 	@param		argv The argv parameter passed to main()
; 	@result		Returns the BluetoothObjectID passed in the given arguments.  If no ID is present,
; 				kIOBluetoothObjectIDNULL is returned.
; 

(deftrap-inline "_IOBluetoothGetObjectIDFromArguments" 
   ((argc :signed-long)
    (argv (:pointer :char))
   )
   :UInt32
() )
; !
;     @typedef IOBluetoothRemoteNameRequestCallback
;     @abstract Callback function definition for a remote name request.
;     @discussion This callback will be invoked when a remote name request command completes.
;     @param userRefCon			(void *) This user defined parameter was provided during the original call to initiate
;                                 the remote name request.
;     @param deviceRef			(IOBluetoothDeviceRef) The IOBluetoothDevice which the ReadRemoteName call is completing for.
;     @param status				(BluetoothHCIStatus) The status of the call.  Could be success, page timeout, host timeout.
;     @result None.
; 

(def-mactype :IOBluetoothRemoteNameRequestCallback (find-mactype ':pointer)); (void * userRefCon , IOBluetoothDeviceRef deviceRef , IOReturn status)
; !
;     @typedef IOBluetoothCreateConnectionCallback
;     @abstract Callback function definition for a create connection call.
;     @discussion This callback will be invoked when a create connection command completes.
;     @param userRefCon	(void *) This user defined parameter was provided during the original call to IOBluetoothCreateConnection.
;     @param deviceRef	(IOBluetoothDeviceRef) The IOBluetoothDevice which the CreateConnection call is completing for.
;     @param status		(OSStatus) The status of the call.  Could be success, page timeout, host timeout, already exists, etc.
;     @result None.
; 

(def-mactype :IOBluetoothCreateConnectionCallback (find-mactype ':pointer)); (void * userRefCon , IOBluetoothDeviceRef deviceRef , IOReturn status)
; !
;     @typedef IOBluetoothSDPQueryCallback
;     @abstract Callback function definition for a perform SDP query call.
;     @discussion This callback will be invoked when an SDP query completes (or an error is encountered performing the query).
;     @param userRefCon	(void *) This user defined parameter was provided during the original call to perform the query.
;     @param deviceRef	(IOBluetoothDeviceRef) The IOBluetoothDevice on which the SDP query will be performed.
;     @param status		(OSStatus) The status of the call.  Could be success, page timeout, host timeout, etc.
;     @result None.
; 

(def-mactype :IOBluetoothSDPQueryCallback (find-mactype ':pointer)); (void * userRefCon , IOBluetoothDeviceRef deviceRef , IOReturn status)
; ===========================================================================================================================
;  Device interaction.
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее Device ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceCreateWithAddress
; 	@abstract	Returns the IOBluetoothDeviceRef for the given BluetoothDeviceAddress
; 	@discussion	Within a single application, there will be only one IOBluetoothDeviceRef for a
;                 given remote device address.  This function will return that shared device object.  The
;                 IOBluetoothDeviceRef MUST be released by the caller (by calling IOBluetoothObjectRelease()).
; 	@param		bdAddr	Pointer to a BluetoothDeviceAddress for which an IOBluetoothDeviceRef is desired
; 	@result		Returns the IOBluetoothDeviceRef for the given BluetoothDeviceAddress.
; 

(deftrap-inline "_IOBluetoothDeviceCreateWithAddress" 
   ((bdAddr (:pointer :BLUETOOTHDEVICEADDRESS))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenConnection
; 	@abstract	Create a baseband connection to the device.
; 	@discussion	This method can be either synchronous or asynchronous.  If a callback is specified, the
;                 operation is performed asynchronously and the callback called when the connection complete
;                 event is received.  If no callback is specified, the operation is synchronous and the 
;                 function will not return until the connection complete event is received.
;     @param		btDevice The target IOBluetoothDeviceRef
;     @param		callback The function to be called when the connection has been established (or the
;                 create connection has failed).
;     @param		refCon A client-supplied reference to be passed to the callback.
;     @result		Returns kIOReturnSuccess if the connection was successfully created (synchronously) or if
;                 the create connection call was successfully sent (asynchronously).  If kIOReturnSuccess
;                 is not received in the asynchronous case, the callback will not be called.
; 

(deftrap-inline "_IOBluetoothDeviceOpenConnection" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (callback :pointer)
    (refCon :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenConnectionWithOptions
; 	@abstract	Create a baseband connection to the device.
; 	@discussion	This function can be either synchronous or asynchronous.  If a callback is specified, the
;                 operation is performed asynchronously and the callback called when the connection complete
;                 event is received.  If no callback is specified, the operation is synchronous and the 
;                 function will not return until the connection complete event is received.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.7 (Bluetooth v1.3) or later.
;     @param		btDevice The target IOBluetoothDeviceRef
;     @param		callback The function to be called when the connection has been established (or the
;                 create connection has failed).
;     @param		refCon A client-supplied reference to be passed to the callback.
;     @param		inPageTimeout A client-supplied Page timeout value to use for the create connection call.
;     @param		inAuthenticationRequired A client-supplied Boolean to indicate whether we require authentication for the new connection.
;     @result		Returns kIOReturnSuccess if the connection was successfully created (synchronously) or if
;                 the create connection call was successfully sent (asynchronously).  If kIOReturnSuccess
;                 is not received in the asynchronous case, the callback will not be called.
; 

(deftrap-inline "_IOBluetoothDeviceOpenConnectionWithOptions" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (callback :pointer)
    (refCon :pointer)
    (inPageTimeout :UInt16)
    (inAuthenticationRequired :Boolean)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_3_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceCloseConnection
; 	@abstract	Close down the baseband connection to the device.
; 	@discussion	This method is synchronous and will not return until the connection has been closed (or the 
;                 command failed).  In the future this API will be changed to allow asynchronous operation.
;     @param		btDevice The target IOBluetoothDeviceRef
;     @result		Returns kIOReturnSuccess if the connection has successfully been closed.
; 

(deftrap-inline "_IOBluetoothDeviceCloseConnection" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceRemoteNameRequest
; 	@abstract	Issues a remote name request to the target device.
; 	@discussion	If a callback is specified, the request is asynchronous and on completion of the REMOTE_NAME_REQUEST
;                 command, the callback will be called with the given refCon.
;                 If no target is specified, the request is made synchronously and won't return until the request is 
;                 complete.
;     @param		inDeviceRef The target IOBluetoothDeviceRef
;     @param		inCallback The callback to call when the remote name request is complete
;     @param		inUserRefCon User-supplied reference that will be passed to the callback
;     @param		outDeviceName Contains the device name if the request is synchronous and completes successfully.
;     @result		Returns kIOReturnSuccess if the remote name request was successfully issued (and if synchronous, if
;                 the request completed successfully).
; 

(deftrap-inline "_IOBluetoothDeviceRemoteNameRequest" 
   ((inDeviceRef (:pointer :OpaqueIOBluetoothObjectRef))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (outDeviceName (:pointer :BLUETOOTHDEVICENAME))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceRemoteNameRequestWithTimeout
; 	@abstract	Issues a remote name request to the target device.
; 	@discussion	If a callback is specified, the request is asynchronous and on completion of the REMOTE_NAME_REQUEST
;                 command, the callback will be called with the given refCon.
;                 If no target is specified, the request is made synchronously and won't return until the request is 
;                 complete.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.7 (Bluetooth v1.3) or later.
;     @param		inDeviceRef The target IOBluetoothDeviceRef
;     @param		inCallback The callback to call when the remote name request is complete
;     @param		inUserRefCon User-supplied reference that will be passed to the callback
;     @param		outDeviceName Contains the device name if the request is synchronous and completes successfully.
;     @param		inTimeout User supplied page timeout value to use for the remote name request call.
;     @result		Returns kIOReturnSuccess if the remote name request was successfully issued (and if synchronous, if
;                 the request completed successfully).
; 

(deftrap-inline "_IOBluetoothDeviceRemoteNameRequestWithTimeout" 
   ((inDeviceRef (:pointer :OpaqueIOBluetoothObjectRef))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (outDeviceName (:pointer :BLUETOOTHDEVICENAME))
    (inTimeout :UInt16)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_3_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDevicePerformSDPQuery
; 	@abstract	Performs an SDP query on the target device.
; 	@discussion	As a result of this call, a baseband connection will be built to the device (if not already connected).
; 				Then, an L2CAP channel will be opened to the SDP server on the device.  At that point, a Service
; 				Search Attribute request will be issued with a UUID of 0x0100 (L2CAP) and an attribute range of
; 				0x0000 - 0xffff specified.  This will cause the SDP server to return all attributes of all L2CAP-derived 
; 				services on the device.  The results essentially encompass all services on the device.
; 				This function is always asynchronous.  If a callback is specified, when the SDP query is complete (or
; 				an error is encountered), the callback will be called with the given refCon.  If no target is specified, 
; 				the request is still asynchronous, but no callback will be made.  That can be useful if the client has
; 				registered for SDP service changed notifications.
; 	@param		inDeviceRef The target IOBluetoothDeviceRef
;     @param		inCallback The callback to call when the SDP query is complete
;     @param		inUserRefCon User-supplied reference that will be passed to the callback
;     @result		Returns kIOReturnSuccess if the SDP query was successfully started.
; 

(deftrap-inline "_IOBluetoothDevicePerformSDPQuery" 
   ((inDeviceRef (:pointer :OpaqueIOBluetoothObjectRef))
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :signed-long
() )
; ===========================================================================================================================
;  Device attributes
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее Device - attributes ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetClassOfDevice
; 	@abstract	Gets the full class of device value for the remote device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the class of device for the remote device.
; 

(deftrap-inline "_IOBluetoothDeviceGetClassOfDevice" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetServiceClassMajor
; 	@abstract	Get the major service class of the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the major service class of the device.
; 

(deftrap-inline "_IOBluetoothDeviceGetServiceClassMajor" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetDeviceClassMajor
; 	@abstract	Get the major device class of the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the major device class of the remote device.
; 

(deftrap-inline "_IOBluetoothDeviceGetDeviceClassMajor" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetDeviceClassMinor
; 	@abstract	Get the minor service class of the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the minor device class of the remote device.
; 

(deftrap-inline "_IOBluetoothDeviceGetDeviceClassMinor" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetName
; 	@abstract	Get the human readable name of the remote device.
; 	@discussion	This only returns a value if a remote name request has been performed on the target device.  If a
;                 successful remote name request has not been completed, NULL is returned.  To perform a remote
;                 name request, call IOBluetoothDeviceRemoteNameRequest().  If a remote name request has been 
;                 successfully completed, the function IOBluetoothDeviceGetLastNameUpdate() will return the 
;                 date/time of the last successful request.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the name of the remote device name.  This value is a CFStringRef generated from the UTF-8
;                 format of the most recent remote name request.  The returned string does NOT need to be released
;                 by the caller.
; 

(deftrap-inline "_IOBluetoothDeviceGetName" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFString)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetNameOrAddress
; 	@abstract	Get the human readable name of the remote device.  If the name is not present, it will return a string
;                 containing the device's address.
; 	@discussion	If a remote name request has been successfully completed, the device name will be returned.  If not,
;                 a string containg the device address in the format of "XX-XX-XX-XX-XX-XX" will be returned.  Because this
;                 function may have to create a new string object, the resulting string must be released by the caller
;                 (by calling CFRelease()).
;     @param		device The target IOBluetoothDeviceRef
;     @result		Returns the device's name or a string containing the device's address.  The returned string MUST be released
;                 by the caller by calling CFRelease().
; 

(deftrap-inline "_IOBluetoothDeviceGetNameOrAddress" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFString)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetLastNameUpdate
; 	@abstract	Get the date/time of the last successful remote name request.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the date/time of the last successful remote name request.  If no remote name request has been
;                 completed on the target device, NULL is returned.  The returned CFDateRef does NOT need to be released by 
;                 the caller.
; 

(deftrap-inline "_IOBluetoothDeviceGetLastNameUpdate" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFDate)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetAddress
; 	@abstract	Get the Bluetooth device address for the target device.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns a pointer to the Bluetooth device address of the target device.
; 

(deftrap-inline "_IOBluetoothDeviceGetAddress" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :BLUETOOTHDEVICEADDRESS)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetAddressString
; 	@abstract	Get a string containing the Bluetooth device address for the target device.
; 	@discussion	Because this function may have to create a new string object, the resulting 
; 				string must be released by the caller (by calling CFRelease()).
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns a pointer to a CFStringRef containing the Bluetooth device address of the target device.
; 				The returned string MUST be released by the caller by calling CFRelease().
; 

(deftrap-inline "_IOBluetoothDeviceGetAddressString" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   (:pointer :__CFString)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetPageScanRepetitionMode
; 	@abstract	Get the value of the page scan repetition mode for the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the page scan repetition mode value for this device.
; 

(deftrap-inline "_IOBluetoothDeviceGetPageScanRepetitionMode" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetPageScanPeriodMode
; 	@abstract	Get the value of the page scan period mode for the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns page scan period mode value for the device.
; 

(deftrap-inline "_IOBluetoothDeviceGetPageScanPeriodMode" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetPageScanMode
; 	@abstract	Get the page scan mode for the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the value for the page scan mode for the device.
; 

(deftrap-inline "_IOBluetoothDeviceGetPageScanMode" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetClockOffset
; 	@abstract	Get the clock offset value of the device.
; 	@discussion	This value is only meaningful if the target device has been seen during an inquiry.  This can be
;                 by checking the result of IOBluetoothDeviceGetLastInquiryUpdate().  If NULL is returned, then the 
;                 device hasn't been seen.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the clock offset value for the device.
; 

(deftrap-inline "_IOBluetoothDeviceGetClockOffset" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetLastInquiryUpdate
; 	@abstract	Get the date/time of the last time the device was returned during an inquiry.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the date/time of the last time the device was seen during an inquiry.
;                 If the device has never been seen during an inquiry, NULL is returned.  The returned CFDateRef
;                 does NOT need to be released by the caller.
; 

(deftrap-inline "_IOBluetoothDeviceGetLastInquiryUpdate" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFDate)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceIsConnected
; 	@abstract	Indicates whether a baseband connection to the device exists.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns YES if a baseband connection to the device exists.
; 

(deftrap-inline "_IOBluetoothDeviceIsConnected" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceRequestAuthentication
; 	@abstract	Requests that the existing baseband connection be authenticated.
; 	@discussion	In order to authenticate a baseband connection, a link key needs to be generated as a result of 
;                 the pairing process.  This call will synchronously initiate the pairing process with the target device
;                 and not return until the authentication process is complete.  This API will be updated to allow
;                 for asynchronous operation.
;     @param		device The target IOBluetoothDeviceRef
;     @result		Returns kIOReturnSuccess if the connection has been successfully been authenticated.  Returns an error
;                 if authentication fails or no baseband connection exists.
; 

(deftrap-inline "_IOBluetoothDeviceRequestAuthentication" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetConnectionHandle
; 	@abstract	Get the connection handle for the baseband connection.
; 	@discussion	This method only returns a valid result if a baseband connection is present
;                 (IOBluetoothDeviceIsConnected() returns TRUE).
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the connection handle for the baseband connection.  If no baseband connection is present,
;                 kBluetoothConnectionHandleNone is returned.
; 

(deftrap-inline "_IOBluetoothDeviceGetConnectionHandle" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetLinkType
; 	@abstract	Get the link type for the baseband connection.
; 	@discussion	This method only returns a valid result if a baseband connection is present
;                 (IOBluetoothDeviceIsConnected() returns TRUE).
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the link type for the baseband connection.  If no baseband connection is present,
;                 kBluetoothLinkTypeNone is returned.
; 

(deftrap-inline "_IOBluetoothDeviceGetLinkType" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetEncryptionMode
; 	@abstract	Get the encryption mode for the baseband connection.
; 	@discussion	This method only returns a valid result if a baseband connection is present
;                 (IOBluetoothDeviceIsConnected() returns TRUE).
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the encryption mode for the baseband connection.  If no baseband connection is present,
;                 kEncryptionDisabled is returned.
; 

(deftrap-inline "_IOBluetoothDeviceGetEncryptionMode" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetServices
; 	@abstract	Gets an array of service records for the device.
; 	@discussion	The resulting array contains IOBluetoothSDPServiceRecordRefs.  The service records are only
;                 present if an SDP query has been done on the target object.  This can be determined by calling
;                 IOBluetoothDeviceGetLastServicesUpdate().  It will return the last date/time of the SDP query. 
;                 Currently, the only way to have an SDP query executed is to use the search manager 
;                 (IOBluetoothDeviceSearchGetSDPData()).  This will change in the future as API will be added to 
;                 IOBluetoothDevice to initiate the SDP query. 
;                 
;                 Instead of allowing individual clients to query for different services and service attributes,
;                 the system request all of the device's services and service attributes.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns an array of service records (IOBluetoothDeviceRefs) for the device if an SDP query has 
;                 been performed.  If no SDP query has been performed, NULL is returned.  The resulting CFArrayRef
;                 does NOT need to be released by the caller.
; 

(deftrap-inline "_IOBluetoothDeviceGetServices" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFArray)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetLastServicesUpdate
; 	@abstract	Get the date/time of the last SDP query.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns the date/time of the last SDP query.  If an SDP query has never been performed on the
;                 device, NULL is returned.  The resulting CFDateRef does NOT need to be released by the caller.
; 

(deftrap-inline "_IOBluetoothDeviceGetLastServicesUpdate" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFDate)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetServiceRecordForUUID
; 	@abstract	Search for a service record containing the given UUID.
; 	@discussion	This method searches through the device's services to find a service that contains the given
;                 UUID.  Only the first service record will be returned.  This method only operates on services
;                 that have already been queried.  It will not initiate a new query.  This method should probably 
;                 be updated to return an array of service records if more than one contains the UUID.  
;     @param		device The target IOBluetoothDeviceRef
;     @param		sdpUUID UUID value to search for.  
; 	@result		Returns the first service record that contains the given uuid.  If no service record is found,
;                 NULL is returned.  The resulting IOBluetoothSDPServiceRecordRef does NOT need to be released by
;                 the caller.
; 

(deftrap-inline "_IOBluetoothDeviceGetServiceRecordForUUID" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
    (uuidRef (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothFavoriteDevices
; 	@abstract	Returns an array containing all of the user's favorite devices.
; 	@discussion	The CFArrayRef returned by this function must be released by calling CFRelease().
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
; 	@result		Returns a CFArray of IOBluetoothDeviceRef objects.  The resulting CFArrayRef must be released by
; 				the caller by calling CFRelease().
; 

(deftrap-inline "_IOBluetoothFavoriteDevices" 
   ((ARG2 (:NIL :NIL))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   (:pointer :__CFArray)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceIsFavorite
; 	@abstract	Indicates whether the target device is a favorite.
; 	@discussion	NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns TRUE if the device is one of the user's favorites.
; 

(deftrap-inline "_IOBluetoothDeviceIsFavorite" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :Boolean
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceAddToFavorites
; 	@abstract	Adds the target device to the user's list of favorite devices.
; 	@discussion	NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns kIOReturnSuccess if the device was successfully added to the user's list of
; 				favorite devices.
; 

(deftrap-inline "_IOBluetoothDeviceAddToFavorites" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceRemoveFromFavorites
; 	@abstract	Removes the target device from the user's list of favorite devices.
; 	@discussion	NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns kIOReturnSuccess if the device was successfully removed from the user's list of
; 				favorite devices or if the device was not in the list at all.
; 

(deftrap-inline "_IOBluetoothDeviceRemoveFromFavorites" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothRecentDevices
; 	@abstract	Returns an array of the most recently accessed devices.
; 	@discussion	The CFArrayRef returned by this function must be released by calling CFRelease().
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
; 	@param		numDevices	The number of recent devices to return.  If numDevices is zero, all devices accessed
; 							by the user will be returned.
; 	@result		Returns a CFArray of the most recently accessed IOBluetoothDeviceRef objects.  The resulting CFArrayRef 
; 				must be released by the caller by calling CFRelease().
; 

(deftrap-inline "_IOBluetoothRecentDevices" 
   ((numDevices :UInt32)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   (:pointer :__CFArray)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceGetRecentAccessDate
; 	@abstract	Returns a date representing the last time the user accessed the target device.
; 	@discussion	The CFDateRef returned by this function must be released by calling CFRelease().
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns a CFDateRef representing the last date/time that the user accessed the
; 				target device.  The resulting CFDateRef must be released by the caller by calling CFRelease().
; 

(deftrap-inline "_IOBluetoothDeviceGetRecentAccessDate" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   (:pointer :__CFDate)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothPairedDevices
; 	@abstract	Returns an array of the currently paired devices.
; 	@discussion	The CFArrayRef returned by this function must be released by calling CFRelease().
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
; 	@result		Returns a CFArray of IOBluetoothDeviceRef objects.  The resulting CFArrayRef must be released by
; 				the caller by calling CFRelease().
; 

(deftrap-inline "_IOBluetoothPairedDevices" 
   ((ARG2 (:NIL :NIL))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   (:pointer :__CFArray)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceIsPaired
; 	@abstract	Indicates whether the target device is paired.
; 	@discussion	NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		device The target IOBluetoothDeviceRef
; 	@result		Returns TRUE if the device is paired.
; 

(deftrap-inline "_IOBluetoothDeviceIsPaired" 
   ((device (:pointer :OpaqueIOBluetoothObjectRef))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :Boolean
() )
; ===========================================================================================================================
;  Device searching.
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее Device Searching ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothDeviceSearchOptions
; 

(def-mactype :IOBluetoothDeviceSearchOptions (find-mactype ':UInt32))
; --------------------------------------------------------------------------------------------------------------------------
; !	@enum		IOBluetoothDeviceSearchOptionsBits
; 	@abstract	
; 
(def-mactype :IOBluetoothDeviceSearchOptionsBits (find-mactype ':sint32))

(defconstant $kSearchOptionsNone 0)
(defconstant $kSearchOptionsAlwaysStartInquiry 1)
(defconstant $kSearchOptionsDiscardCachedResults 2)
;type name? (def-mactype :IOBluetoothDeviceSearchDeviceAttributes (find-mactype ':IOBluetoothDeviceSearchDeviceAttributes))
(defrecord IOBluetoothDeviceSearchDeviceAttributes
   (address :BLUETOOTHDEVICEADDRESS)
                                                ;  00 08 22 44 AB 56, etc.
   (name :BLUETOOTHDEVICENAME)
                                                ;  "Al Yankovic's Phone", etc.
   (serviceClassMajor :UInt32)
                                                ;  Networking, Rendering, etc.
   (deviceClassMajor :UInt32)
                                                ;  Computer, Phone, Audio, etc.
   (deviceClassMinor :UInt32)
                                                ;  Desktop, cordless, headset, etc.
)
; --------------------------------------------------------------------------------------------------------------------------
; !	@struct		IOBluetoothDeviceSearchAttributes
; 	@discussion You can search for general device classes and service classes, or you can search for a 
; 				specific device address or name. If you pass NULL as the attribute structure,
; 				you will get ALL devices in the vicinity found during a search. Note that passing a zeroed
; 				out block of attributes is NOT equivalent to passing in NULL!	
; 

;type name? (def-mactype :IOBluetoothDeviceSearchAttributes (find-mactype ':IOBluetoothDeviceSearchAttributes))
(defrecord IOBluetoothDeviceSearchAttributes
   (options :UInt32)
                                                ;  Options.
   (maxResults :UInt32)
                                                ;  Maximum number of results you desire. 0 means infinite.
   (deviceAttributeCount :UInt32)
   (attributeList (:pointer :IOBLUETOOTHDEVICESEARCHDEVICEATTRIBUTES))
)
; ===========================================================================================================================
;  Local Device Interaction
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее  Local Device Interaction ее
 |#

; #endif


(def-mactype :IOBluetoothReadNameCallback (find-mactype ':pointer)); (void * userRefCon , OSStatus status , BluetoothDeviceName * name)

(def-mactype :IOBluetoothReadAddressCallback (find-mactype ':pointer)); (void * userRefCon , OSStatus status , BluetoothDeviceAddress * address)

(def-mactype :IOBluetoothReadLocalVersionInformationCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIVersionInfo * versionInfo)

(def-mactype :IOBluetoothReadLocalSupportedFeaturesCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCISupportedFeatures * features)

(def-mactype :IOBluetoothReadConnectionAcceptTimeoutCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIConnectionAcceptTimeout timeout)

(def-mactype :IOBluetoothReadPageTimeoutCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIPageTimeout timeout)

(def-mactype :IOBluetoothReadPageScanEnableCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIPageScanMode mode)

(def-mactype :IOBluetoothReadAuthenticationEnableCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIAuthenticationEnable enabled)

(def-mactype :IOBluetoothReadEncryptionModeCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIEncryptionMode mode)

(def-mactype :IOBluetoothReadClassOfDeviceCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothClassOfDevice classOfDevice)

(def-mactype :IOBluetoothReadPageScanPeriodModeCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIPageScanPeriodMode mode)

(def-mactype :IOBluetoothReadPageScanModeCallback (find-mactype ':pointer)); (void * userRefCon , BluetoothHCIStatus status , BluetoothHCIPageScanMode mode)
; ===========================================================================================================================
;  Local Device Configuration
; ===========================================================================================================================
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceAvailable
; 	@abstract	Determines if a bluetooth device is available on a local machine or not.
; 	@result		A Boolean value. TRUE if a Bluetooth device is connected to the local machine, FALSE otherwise.
; 	@discussion	Determines if a bluetooth device is available on a local machine or not.
; 

(deftrap-inline "_IOBluetoothLocalDeviceAvailable" 
   ((ARG2 (:NIL :NIL))
   )
   :Boolean
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceGetDiscoverable
; 	@abstract	Returns the discoverability state of the local device.
;     @param		discoverableStatus is a pointer to boolean, it will hold the discoverabilty state.
; 	@result		An error code value. 0 if successful.
; 	@discussion	Returns the discoverability state of the local device. 
; 

(deftrap-inline "_IOBluetoothLocalDeviceGetDiscoverable" 
   ((discoverableStatus (:pointer :Boolean))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceGetPowerState
; 	@abstract	Determines the current power state of the Bluetooth hardware.
; 	@discussion	If successful, it passes the current power state of the Bluetooth hardware back to the caller.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.4 (Bluetooth v1.1) or later.
; 	@result		An error code value. 0 if successful.
; 

(deftrap-inline "_IOBluetoothLocalDeviceGetPowerState" 
   ((powerState (:pointer :BluetoothHCIPowerState))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_1_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadVersionInformation
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadVersionInformation" 
   ((outResults (:pointer :BLUETOOTHHCIVERSIONINFO))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadSupportedFeatures
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadSupportedFeatures" 
   ((outResults (:pointer :BLUETOOTHHCISUPPORTEDFEATURES))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadAddress
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadAddress" 
   ((outResults (:pointer :BLUETOOTHDEVICEADDRESS))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadName
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadName" 
   ((outResults (:pointer :BLUETOOTHDEVICENAME))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadConnectionAcceptTimeout
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadConnectionAcceptTimeout" 
   ((outResults (:pointer :BLUETOOTHHCICONNECTIONACCEPTTIMEOUT))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadPageTimeout
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadPageTimeout" 
   ((outResults (:pointer :BLUETOOTHHCIPAGETIMEOUT))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadScanEnable
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadScanEnable" 
   ((outResults (:pointer :BLUETOOTHHCIPAGESCANMODE))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadAuthenticationEnable
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadAuthenticationEnable" 
   ((outResults (:pointer :BLUETOOTHHCIAUTHENTICATIONENABLE))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadEncryptionMode
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadEncryptionMode" 
   ((outResults (:pointer :BLUETOOTHHCIENCRYPTIONMODE))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadClassOfDevice
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadClassOfDevice" 
   ((outResults (:pointer :BLUETOOTHCLASSOFDEVICE))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadPageScanPeriodMode
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadPageScanPeriodMode" 
   ((outResults (:pointer :BLUETOOTHHCIPAGESCANPERIODMODE))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothLocalDeviceReadPageScanMode
; 	@abstract	
; 	@param		outResults				
; 	@param		inCallback			
; 	@param		inUserRefCon	
; 	@param		reserved			Pass NULL here.
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothLocalDeviceReadPageScanMode" 
   ((outResults (:pointer :BLUETOOTHHCIPAGESCANMODE))
    (inCallback :pointer)
    (inUserRefCon :pointer)
    (reserved :pointer)
   )
   :signed-long
() )
; ===========================================================================================================================
;  L2CAP channel user client stuff.
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее L2CAP ее
 |#

; #endif

; ===========================================================================================================================
;  L2CAP channel events
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее L2CAP channel eventsее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothL2CAPEvent
; 	@discussion	The events generated by an L2CAP channel:
;         <br>
;         kIOBluetoothL2CAPChannelEventTypeData:	new data.
;         <br>
;         kIOBluetoothL2CAPChannelEventTypeClosed: channel closed.
;         <br>
;         kIOBluetoothL2CAPChannelEventTypeReconfigured: channel was reconfigured (check if the MTU changed)
;         <br>
;         kIOBluetoothL2CAPChannelEventTypeOpenCompete: channel is open.
; 		<br>
; 		kIOBluetoothL2CAPChannelEventTypeWriteComplete: write opetation is completed
; 		<br>
; 		kIOBluetoothL2CAPChannelEventTypeQueueSpaceAvailable: the internal l2cap queue has some room
; 		
;         See the description of IOBluetoothL2CAPDataBlock this event.
; 
(def-mactype :IOBluetoothL2CAPChannelEventType (find-mactype ':sint32))

(defconstant $kIOBluetoothL2CAPChannelEventTypeData 1)
(defconstant $kIOBluetoothL2CAPChannelEventTypeOpenComplete 2)
(defconstant $kIOBluetoothL2CAPChannelEventTypeClosed 3)
(defconstant $kIOBluetoothL2CAPChannelEventTypeReconfigured 4)
(defconstant $kIOBluetoothL2CAPChannelEventTypeWriteComplete 5)
(defconstant $kIOBluetoothL2CAPChannelEventTypeQueueSpaceAvailable 6)
(def-mactype :IOBluetoothL2CAPChannelEventType (find-mactype ':SINT32))
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothL2CAPChannelDataBlock
; 	@discussion	Associted to the kIOBluetoothL2CAPChannelEventTypeData it carries a pointer and a size of the new incoming data.
; 
; 
(defrecord IOBluetoothL2CAPChannelDataBlock
   (dataPtr :pointer)
   (dataSize :unsigned-long)
)
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothL2CAPChannelEvent
; 	@discussion	Structure that holds an L2CAP event. Developers that wishes to pass events along are to copy the event (or
; 	its fields) one by one and not with memory copy methods (as bcopy or memcopy). We do not ensure the size of an event to
; 	be constant between releases (it is actually likely that will change).
; 
(defrecord IOBluetoothL2CAPChannelEvent
   (eventType :SInt32)
                                                ;  Caution:  You cannot add any more values here for binary compatibility reasons
   (:variant
                                                ;  Caution:  An element of this union cannot grow beyond 32 bytes in size for binary compatibility reasons.
   (
   (data :IOBLUETOOTHL2CAPCHANNELDATABLOCK)
   )
   (
   (writeRefCon :pointer)
   )
   (
   (padding (:array :UInt8 32))
   )
   )
   (status :signed-long)
                                                ;  Add new items above this comment.
)
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothL2CAPChannelIncomingDataListener
; 	@abstract	Callback for listening to L2CAP data.
; 	@param		l2capChannel	(IOBluetoothL2CAPChannelRef)	The L2CAP channel which received the data.
; 	@param		data			(void *)						A pointer to the data received.
; 	@param		length			(UInt16)						The length of the data received.
; 	@param		refCon			(void *)						The refCon provided to the framework when
;                                                                 you registered for data on this channel.
; 	@discussion	This call back will be called when data comes in on an L2CAP channel.
; 

(def-mactype :IOBluetoothL2CAPChannelIncomingDataListener (find-mactype ':pointer)); (IOBluetoothL2CAPChannelRef l2capChannel , void * data , UInt16 length , void * refCon)
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothL2CAPChannelIncomingEventListener
; 	@abstract	Typedef for the L2CAP channel event listener.
; 	@param		l2capChannel	(IOBluetoothL2CAPChannelRef) L2CAP channel which received the events.
; 	@param		refCon		(void *) User-defined refCon provided upon registration.
; 	@param		event		(IOBluetoothL2CAPChannelEvent) The type of event for this notification.
; 	@discussion	This is the definition for the callback which will be invoked upon receiving data on a L2CAP channel.
;         
;         For example an event listener function:
;         
;         <pre>
; 
;     void l2capEventListener (IOBluetoothL2CAPChannelRef l2capChannel, void *refCon, IOBluetoothL2CAPChannelEvent *event)
;     {
;         switch (event->eventType)
;         {
;                 case kIOBluetoothL2CAPNewDataEvent:
;                     // In thise case:
;                     // event->u.newData.dataPtr  is a pointer to the block of data received.
;                     // event->u.newData.dataSize is the size of the block of data.
;                 break;
;                 
; 					......
; 					
;                 case kIOBluetoothL2CAPChannelTerminatedEvent:
;                     // In this case:
;                     // event->u.terminatedChannel is the channel that was terminated. It can be converted in an IOBluetoothL2CAPChannel
;                     // object with [IOBluetoothL2CAPChannel withL2CAPChannelRef:]. (see below).
;                 break;
;         }
;     }
; 

(def-mactype :IOBluetoothL2CAPChannelIncomingEventListener (find-mactype ':pointer)); (IOBluetoothL2CAPChannelRef l2capChannel , void * refCon , IOBluetoothL2CAPChannelEvent * event)
; ===========================================================================================================================
;  L2CAP channel creation
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее Device - L2CAP channel creation ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenL2CAPChannel
; 	@abstract	Opens a new L2CAP channel to the target device.
; 	@discussion	This function will begin the process of opening a new L2CAP channel to the target device.  
;                 The baseband connection to the device will be opened if it is not open already.  The L2CAP
;                 channel open process will not complete until the client has registered an incoming data 
;                 listener on the new channel.  This prevents a situation where the channel succeeds
;                 in being configured and opened and receives data before the client is listening and
;                 is ready for it.
;                 
;                 Because a new IOBluetoothL2CAPChannelRef will be created for the client as a result of this
;                 function, the client is responsible for releasing the resulting IOBluetoothL2CAPChannelRef
;                 (by calling IOBluetoothObjectRelease()).
;     @param		btDevice 		The target IOBluetoothDeviceRef
; 	@param		psm				The L2CAP PSM value for the new channel.
; 	@param		findExisting	This value should be set to TRUE if it should look for an existing channel 
;                                 with the PSM.  Typically this value will be FALSE.  It should be TRUE only
;                                 in the case where a single channel is allowed by the spec for the given PSM.
; 	@param		newChannel		A pointer to an IOBluetoothL2CAPChannelRef to receive the L2CAP channel 
;                                 requested to be opened.  The newChannel pointer will only be set if 
;                                 kIOReturnSuccess is returned.
; 	@result		Returns kIOReturnSuccess if the open process was successfully started (or if an existing
;                 L2CAP channel was found). 
; 

(deftrap-inline "_IOBluetoothDeviceOpenL2CAPChannel" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (psm :UInt16)
    (findExisting :Boolean)
    (newChannel (:pointer :IOBLUETOOTHL2CAPCHANNELREF))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceSendL2CAPEchoRequest
; 	@abstract	Send an echo request over the L2CAP connection to a remote device.
; 	@discussion	The current implementation returns when the request has been sent, but does not indicate when
;                 a response is received.  Also, the baseband connection must be up for the echo request to be sent.
;                 In the future, this method will also open the connection if necessary.  The API will be updated
;                 to allow the client to be informed when the echo response has been received (both synchronously
;                 and asynchronously).
;     @param		btDevice The target IOBluetoothDeviceRef
; 	@param		data	(void *) - Pointer to buffer to send.
; 	@param		length	(UInt16) - Length of the buffer to send
; 	@result		Returns kIOReturnSuccess if the echo request was able to be sent.
; 

(deftrap-inline "_IOBluetoothDeviceSendL2CAPEchoRequest" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenL2CAPChannelAsync
; 	@abstract	Opens a new L2CAP channel to the target device. Returns immedialty after starting the opening process.
; 	@discussion	This function will begin the process of opening a new L2CAP channel to the target device.  
;                 The baseband connection to the device will be opened if it is not open already.  The L2CAP
;                 channel open process will not complete until the client has registered an incoming data 
;                 listener on the new channel.  This prevents a situation where the channel succeeds
;                 in being configured and opened and receives data before the client is listening and
;                 is ready for it.
;                 
;                 Because a new IOBluetoothL2CAPChannelRef will be created for the client as a result of this
;                 function, the client is responsible for releasing the resulting IOBluetoothL2CAPChannelRef
;                 (by calling IOBluetoothObjectRelease()).
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		btDevice 		The target IOBluetoothDeviceRef
; 	@param		newChannel		A pointer to an IOBluetoothL2CAPChannelRef to receive the L2CAP channel 
;                                 requested to be opened.  The newChannel pointer will only be set if 
;                                 kIOReturnSuccess is returned.
; 	@param		psm				The L2CAP PSM value for the new channel.
; 	@param		withEventListener a IOBluetoothL2CAPChannelIncomingEventListener where to receive events
; 								  regarding the channel (MUST be specified).
; 	@param		refCon			a refcon pointer (for the callback specified above).
; 	@result		Returns kIOReturnSuccess if the open process was successfully started (or if an existing
;                 L2CAP channel was found). 
; 

(deftrap-inline "_IOBluetoothDeviceOpenL2CAPChannelAsync" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (newChannel (:pointer :IOBLUETOOTHL2CAPCHANNELREF))
    (psm :UInt16)
    (eventListener :pointer)
    (refcon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenL2CAPChannelSync
; 	@abstract	Opens a new L2CAP channel to the target device.  Returns only after the channel is opened.
; 	@discussion	This function will begin the process of opening a new L2CAP channel to the target device.  
;                 The baseband connection to the device will be opened if it is not open already.  The L2CAP
;                 channel open process will not complete until the client has registered an incoming data 
;                 listener on the new channel.  This prevents a situation where the channel succeeds
;                 in being configured and opened and receives data before the client is listening and
;                 is ready for it.
;                 
;                 Because a new IOBluetoothL2CAPChannelRef will be created for the client as a result of this
;                 function, the client is responsible for releasing the resulting IOBluetoothL2CAPChannelRef
;                 (by calling IOBluetoothObjectRelease()).
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		btDevice 		The target IOBluetoothDeviceRef
; 	@param		newChannel		A pointer to an IOBluetoothL2CAPChannelRef to receive the L2CAP channel 
;                                 requested to be opened.  The newChannel pointer will only be set if 
;                                 kIOReturnSuccess is returned.
; 	@param		psm				The L2CAP PSM value for the new channel.
; 	@param		withEventListener a IOBluetoothL2CAPChannelIncomingEventListener where to receive events
; 								  regarding the channel (MUST be specified).
; 	@param		refCon			a refcon pointer (for the callback specified above).
; 	@result		Returns kIOReturnSuccess if the open process was successfully started (or if an existing
;                 L2CAP channel was found). 
; 

(deftrap-inline "_IOBluetoothDeviceOpenL2CAPChannelSync" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (newChannel (:pointer :IOBLUETOOTHL2CAPCHANNELREF))
    (psm :UInt16)
    (eventListener :pointer)
    (refcon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее  L2CAP channel ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelCreateFromObjectID
; 	@abstract	Returns the IOBluetoothL2CAPChannelRef with the given IOBluetoothObjectID.
;     @discussion	The IOBluetoothObjectID can be used as a global reference for a given IOBluetoothL2CAPChannelRef.  It allows
; 				two separate applications to refer to the same IOBluetoothL2CAPChannelRef.
;     @param		objectID	IOBluetoothObjectID of the desired IOBluetoothL2CAPChannelRef
; 	@result		Returns the IOBluetoothL2CAPChannelRef that matches the given IOBluetoothObjectID if one exists.  The 
; 				resulting IOBluetoothL2CAPChannelRef must be released by the caller by calling IOBluetoothObjectRelease.
; 				If no matching L2CAP channel exists, NULL is returned.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelCreateFromObjectID" 
   ((objectID :UInt32)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetObjectID
; 	@abstract	Returns the IOBluetoothObjectID of the given IOBluetoothL2CAPChannelRef.
;     @discussion	The IOBluetoothObjectID can be used as a global reference for a given IOBluetoothL2CAPChannelRef.  It allows
; 				two separate applications to refer to the same IOBluetoothL2CAPChannelRef.
;     @param		l2capChannel	Target IOBluetoothL2CAPChannelRef
; 	@result		Returns the IOBluetoothObjectID of the given IOBluetoothl2CAPChannelRef.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetObjectID" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelCloseChannel
; 	@abstract	Initiates the close process on an open L2CAP channel.
;     @discussion	This method may only be called by the client that opened the channel in the first place.  In the future
;                 asynchronous and synchronous versions will be provided that let the client know when the close process
;                 has been finished.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns kIOReturnSuccess on success.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelCloseChannel" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelRequestRemoteMTU
; 	@abstract	Initiates the process to reconfigure the L2CAP channel with a new outgoing MTU.
;     @discussion	Currently, this API does not give an indication that the re-config process has completed.  In
;                 the future additional API will be available to provide that information both synchronously and
;                 asynchronously.
;     @param		l2capChannel	Target L2CAP channel ref
;     @param		remoteMTU		The desired outgoing MTU. 
; 	@result		Returns kIOReturnSuccess if the channel re-configure process was successfully initiated.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelRequestRemoteMTU" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (remoteMTU :UInt16)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelWrite
; 	@abstract	Writes the given data over the target L2CAP channel to the remote device.
;     @discussion	The length of the data may not exceed the L2CAP channel's ougoing MTU.
;     @param		l2capChannel	Target L2CAP channel ref
;     @param		data	Pointer to the buffer containing the data to send.
;     @param		length	The length of the given data buffer.
; 	@result		Returns kIOReturnSuccess if the data was buffered successfully.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelWrite" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelWriteAsync
; 	@abstract	Writes asynchronously the given data over the target L2CAP channel to the remote device.
;     @discussion	The length of the data may not exceed the L2CAP channel's ougoing MTU.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
; 	@param		l2capChannel	Target L2CAP channel ref
;     @param		data	Pointer to the buffer containing the data to send.
;     @param		length	The length of the given data buffer.
; 	@param		refcon	a write identificator (is a void*, so it is up to the developer) that will be returned in the kIOBluetoothL2CAPWriteCompletedEvent.
; 	@result		Returns kIOReturnSuccess if the data was buffered successfully.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelWriteAsync" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
    (refcon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelWriteAsync
; 	@abstract	Writes synchronously the given data over the target L2CAP channel to the remote device.
;     @discussion	The length of the data may not exceed the L2CAP channel's ougoing MTU. This method may block if previous writes have not been delivered.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		l2capChannel	Target L2CAP channel ref
;     @param		data	Pointer to the buffer containing the data to send.
;     @param		length	The length of the given data buffer.
; 	@result		Returns kIOReturnSuccess if the data was buffered successfully.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelWriteSync" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelRegisterIncomingDataListener
; 	@abstract	Allows a client to register a callback that gets called when new incoming data arrives.
;     @discussion A newly opened L2CAP channel will not complete its configuration process until the client
;                 that opened it registers an incoming data listener.  This prevents that case where incoming
;                 data is received before the client is ready.  
;     @param		l2capChannel	Target L2CAP channel ref
;     @param		listener	Callback function that gets called when new incoming data is received.
;     @param		refCon 		Client-supplied reference that gets passed to the listener function.
; 	@result		Returns kIOReturnSuccess if the listener is successfully registered.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelRegisterIncomingDataListener" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (listener :pointer)
    (refCon :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothL2CAPChannelRegisterIncomingEventListener
;         @abstract Registers a callback for events. 
;         @discussion Registers a callback for events generated by the L2CAP channel. The form for the callback is:
; 
; 					NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;         @param		l2capChannel (IOBluetoothRFCOMMChannelRef) The channel reference
;         @param 		listener is the callback function.
;         @param 		refCon is a void*, its meaning is up to the developer. This parameter will be passed back as second parameter of
;                         the callback function.
;         @result An error code value. 0 if successful. 
; 

(deftrap-inline "_IOBluetoothL2CAPChannelRegisterIncomingEventListener" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (listener :pointer)
    (refCon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetOutgoingMTU
; 	@abstract	Returns the current outgoing MTU for the L2CAP channel.
;     @discussion	The outgoing MTU represents the maximum L2CAP packet size for packets being sent to the remote device.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns the current outgoing MTU for the L2CAP channel.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetOutgoingMTU" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetIncomingMTU
; 	@abstract	Returns the current incoming MTU for the L2CAP channel.
;     @discussion	The incoming MTU represents the maximum L2CAP packet size for packets being sent by the remote device.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns the current incoming MTU for the L2CAP channel.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetIncomingMTU" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetDevice
; 	@abstract	Returns the IOBluetoothDevice to which the target L2CAP channel is open.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns the IOBluetoothDevice to which the target L2CAP channel is open.  The caller
;                 does NOT need to release the returned IOBluetoothDeviceRef.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetDevice" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetPSM
; 	@abstract	Returns the PSM for the target L2CAP channel.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns the PSM for the target L2CAP channel.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetPSM" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetLocalChannelID
; 	@abstract	Returns the local L2CAP channel ID for the target L2CAP channel.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns the local L2CAP channel ID for the target L2CAP channel.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetLocalChannelID" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelGetRemoteChannelID
; 	@abstract	Returns the remote L2CAP channel ID for the target L2CAP channel.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns the remote L2CAP channel ID for the target L2CAP channel.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelGetRemoteChannelID" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothL2CAPChannelIsIncoming
; 	@abstract	Returns TRUE if the channel is an incoming channel.
;     @discussion	An incoming channel is one that was initiated by a remote device.
;     @param		l2capChannel	Target L2CAP channel ref
; 	@result		Returns TRUE if the channel is an incoming channel.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelIsIncoming" 
   ((l2capChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )
; ===========================================================================================================================
;  RFCOMM channel user client routines
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее RFCOMM ее
 |#

; #endif

; ===========================================================================================================================
;  RFCOMM channel events
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее RFCOMM channel eventsее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothRFCOMMEvent
; 	@discussion	The events generated by an RFCOMM channel:
; 	
;         <br>
;         kIOBluetoothRFCOMMChannelEventTypeData:	new data.
;         <br>
;         kIOBluetoothRFCOMMChannelEventTypeFlowControlChanged: flow control changed.
;         <br>
;         kIOBluetoothRFCOMMChannelEventTypeClosed: channel terminated.
;         <br>
;         kIOBluetoothRFCOMMChannelEventTypeControlSignalsChanged: signals (like DTR, CTR) changed. (not yet supported)
;         <br>
; 		kIOBluetoothRFCOMMChannelEventTypeWriteComplete:	write operation completed
; 		<br>
; 		kIOBluetoothRFCOMMChannelEventTypeQueueSpaceAvailable: more room in the RFCOMM channel output queue
; 		
; 		Obsolete Event types:
; 		
;         <br>
;         kIOBluetoothRFCOMMNewDataEvent:	new data.
;         <br>
;         kIOBluetoothRFCOMMFlowControlChangedEvent: flow control changed.
;         <br>
;         kIOBluetoothRFCOMMChannelTerminatedEvent: channel terminated.
;         <br>
;         kIOBluetoothRFCOMMControlSignalsChangedEvent: signals (like DTR, CTR) changed. (not yet supported)
;         <br>
;         
;         See the description of kIOBluetoothRFCOMMChannelEventTypeDataType and  kIOBluetoothRFCOMMChannelEventTypeFlowControlChangedType for more
;         information on these events.
; 
(def-mactype :IOBluetoothRFCOMMChannelEventType (find-mactype ':sint32))
;  New event types added in 1.2 (Mac OS X 10.2.5)

(defconstant $kIOBluetoothRFCOMMChannelEventTypeData 0)
(defconstant $kIOBluetoothRFCOMMChannelEventTypeFlowControlChanged 1)
(defconstant $kIOBluetoothRFCOMMChannelEventTypeClosed 2)
(defconstant $kIOBluetoothRFCOMMChannelEventTypeOpenComplete 3)
(defconstant $kIOBluetoothRFCOMMChannelEventTypeControlSignalsChanged 4)
(defconstant $kIOBluetoothRFCOMMChannelEventTypeWriteComplete 5)
(defconstant $kIOBluetoothRFCOMMChannelEventTypeQueueSpaceAvailable 6);  Obsolete Event names:

(defconstant $kIOBluetoothRFCOMMNewDataEvent 0)
(defconstant $kIOBluetoothRFCOMMFlowControlChangedEvent 1)
(defconstant $kIOBluetoothRFCOMMChannelTerminatedEvent 2)
(def-mactype :IOBluetoothRFCOMMChannelEventType (find-mactype ':SINT32))
;  This is to keep build build. Please use the new type, this is going to be deprecated

(def-mactype :IOBluetoothRFCOMMEvent (find-mactype ':SInt32))
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothRFCOMMDataBlock
; 	@discussion	Associted to the kIOBluetoothRFCOMMNewDataEvent it carries a pointer and a size of the new incoming data.
; 
; 
(defrecord IOBluetoothRFCOMMDataBlock
   (dataPtr :pointer)
   (dataSize :unsigned-long)
)
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothRFCOMMFlowControlStatus
; 	@discussion	Related to the kIOBluetoothRFCOMMFlowControlChangedEvent it carries the status of the flow control.
;                         For the first release of the APIs this event is generated only when flow control switches from OFF
;                         to ON. Future releases will support the switch from ON to OFF as well.
; 
(def-mactype :IOBluetoothRFCOMMFlowControlStatus (find-mactype ':sint32))

(defconstant $kIOBluetoothRFCOMMChannelFlowControlStatusIsOff 0)
(defconstant $kIOBluetoothRFCOMMChannelFlowControlStatusIsOn 1)
(def-mactype :IOBluetoothRFCOMMFlowControlStatus (find-mactype ':SINT32))
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothRFCOMMChannelEvent
; 	@discussion	Structure that holds an RFCOMM event.
; 
(defrecord IOBluetoothRFCOMMChannelEvent
                                                ;  Caution:  You cannot add any more values here for binary compatibility reasons
   (eventType :SInt32)
   (:variant
                                                ;  Caution:  An element of this union cannot grow beyond 32 bytes in size for binary compatibility reasons.
   (
   (data :IOBLUETOOTHRFCOMMDATABLOCK)
   )
   (
   (flowStatus :SInt32)
   )
   (
   (terminatedChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (
   (writeRefCon :pointer)
   )
   (
   (padding (:array :UInt8 32))
   )
                                                ;  Old name, is going to be deprecated, use data instead
   (
   (newData :IOBLUETOOTHRFCOMMDATABLOCK)
   )
   )
   (status :signed-long)
                                                ;  Add new items above this comment.
)
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothRFCOMMChannelIncomingDataListener
; 	@abstract	Typedef for the RFCOMM channel data listener.
; 	@param		rfcommChannel	(IOBluetoothRFCOMMChannelRef)	RFCOMM channel which received the data.
; 	@param		data			(void *)						Pointer to the data received.
; 	@param		length			(UInt16)						Length of the data received.
; 	@param		refCon			(void *)						User-defined refCon provided upon registration.
; 	@discussion	This is the definition for the callback which will be invoked upon receiving data on a RFCOMM channel. This is a
;         semplified version of IOBluetoothRFCOMMChannelIncomingEventListener. See IOBluetoothRFCOMMChannelIncomingEventListener for more
;         information on the rfcommChannel parameter.
; 

(def-mactype :IOBluetoothRFCOMMChannelIncomingDataListener (find-mactype ':pointer)); (IOBluetoothRFCOMMChannelRef rfcommChannel , void * data , UInt16 length , void * refCon)
; --------------------------------------------------------------------------------------------------------------------------
; !	@typedef	IOBluetoothRFCOMMChannelIncomingEventListener
; 	@abstract	Typedef for the RFCOMM channel event listener.
; 	@param		rfcommChannel	(IOBluetoothRFCOMMChannelRef)		RFCOMM channel which received the events.
; 	@param		refCon		(void *)				User-defined refCon provided upon registration.
; 	@param		event		(IOBluetoothRFCOMMChannelEvent)		The type of event for this notification.
; 	@discussion	This is the definition for the callback which will be invoked upon receiving data on a RFCOMM channel.
;         
;         For example an event listener function:
;         
;         <pre>
; 
;     void rfcommEventListener (IOBluetoothRFCOMMChannelRef rfcommChannel, void *refCon, IOBluetoothRFCOMMChannelEvent *event)
;     {
;         switch (event->eventType)
;         {
;                 case kIOBluetoothRFCOMMNewDataEvent:
;                     // In thise case:
;                     // event->u.newData.dataPtr  is a pointer to the block of data received.
;                     // event->u.newData.dataSize is the size of the block of data.
;                 break;
;                 
;                 case kIOBluetoothRFCOMMFlowControlChangedEvent:
;                     // In thise case:
;                     // event->u.flowStatus       is the status of flow control (see IOBluetoothRFCOMMFlowControlStatus for current restrictions)
;                 break;
;                 
;                 case kIOBluetoothRFCOMMChannelTerminatedEvent:
;                     // In this case:
;                     // event->u.terminatedChannel is the channel that was terminated. It can be converted in an IOBluetoothRFCOMMChannel
;                     // object with [IOBluetoothRFCOMMChannel withRFCOMMChannelRef:]. (see below).
;                 break;
;         }
;     }
; 
;         </pre>
;         
;         rfcommChannel is the channel that generated the event and it is the channel where the callback was generated. 
;         rfcommChannel is a  IOBluetoothRFCOMMChannelRef reference, it can be converted in an Objective C IOBluetoothRFCOMMChannel
;         object with:
;         
;         <pre>
;         
;     IOBluetoothRFCOMMChannel *myOBJCChannel = [IOBluetoothRFCOMMChannel withRFCOMMChannelRef:rfcommChannel];
;         
;         </pre>
; 

(def-mactype :IOBluetoothRFCOMMChannelIncomingEventListener (find-mactype ':pointer)); (IOBluetoothRFCOMMChannelRef rfcommChannel , void * refCon , IOBluetoothRFCOMMChannelEvent * event)
; ===========================================================================================================================
;  RFCOMM channel creation
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ее Device - RFCOMM channel creationее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenRFCOMMChannel
; 	@abstract	Opens a new RFCOMM channel to the target device.
; 	@discussion	This function will begin the process of opening a new RFCOMM channel to the target device.  
;                 The baseband connection to the device will be opened if it is not open already.  The RFCOMM
;                 channel open process will not complete until the client has registered an incoming data 
;                 listener on the new channel.
;                                 
;                 Because a new IOBluetoothL2CAPChannelRef will be created for the client as a result of this
;                 function, the client is responsible for releasing the resulting IOBluetoothL2CAPChannelRef
;                 (by calling IOBluetoothObjectRelease()).
;     @param		btDevice The target IOBluetoothDeviceRef
; 	@param		channelID		The RFCOMM channel ID for the new channel.
; 	@param		rfcommChannel	A pointer to an IOBluetoothRFCOMMChannelRef to receive the RFCOMM channel 
;                                 requested to be opened.  The rfcommChannel pointer will only be set if 
;                                 kIOReturnSuccess is returned.
; 	@result		Returns kIOReturnSuccess if the open process was successfully started (or if an existing
;                 RFCOMM channel was found). 
; 

(deftrap-inline "_IOBluetoothDeviceOpenRFCOMMChannel" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (channelID :UInt8)
    (rfcommChannel (:pointer :IOBLUETOOTHRFCOMMCHANNELREF))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenRFCOMMChannelAsync
; 	@abstract	Opens a new RFCOMM channel to the target device. Returns immedialty after starting the opening process.
; 	@discussion	This function will begin the process of opening a new RFCOMM channel to the target device.  
;                 The baseband connection to the device will be opened if it is not open already.  The RFCOMM
;                 channel open process will not complete until the client has registered an incoming data 
;                 listener on the new channel.
;                                 
;                 Because a new IOBluetoothL2CAPChannelRef will be created for the client as a result of this
;                 function, the client is responsible for releasing the resulting IOBluetoothL2CAPChannelRef
;                 (by calling IOBluetoothObjectRelease()).
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		btDevice The target IOBluetoothDeviceRef
; 	@param		rfcommChannel	A pointer to an IOBluetoothRFCOMMChannelRef to receive the RFCOMM channel 
;                                 requested to be opened.  The rfcommChannel pointer will only be set if 
;                                 kIOReturnSuccess is returned.
; 	@param		channelID		The RFCOMM channel ID for the new channel.
; 	@param		withEventListener a IOBluetoothRFCOMMChannelIncomingEventListener where to receive events
; 								  regarding the channel (MUST be specified).
; 	@param		refCon			a refcon pointer (for the callback specified above).
; 	@result		Returns kIOReturnSuccess if the open process was successfully started .
; 

(deftrap-inline "_IOBluetoothDeviceOpenRFCOMMChannelAsync" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (newChannel (:pointer :IOBLUETOOTHRFCOMMCHANNELREF))
    (channelID :UInt8)
    (eventListener :pointer)
    (refcon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothDeviceOpenRFCOMMChannelSync
; 	@abstract	Opens a new RFCOMM channel to the target device. Does not return until the channel is open or failed to open.
; 	@discussion	This function will begin the process of opening a new RFCOMM channel to the target device.  
;                 The baseband connection to the device will be opened if it is not open already.  The RFCOMM
;                 channel open process will not complete until the client has registered an incoming data 
;                 listener on the new channel.
;                                 
;                 Because a new IOBluetoothL2CAPChannelRef will be created for the client as a result of this
;                 function, the client is responsible for releasing the resulting IOBluetoothL2CAPChannelRef
;                 (by calling IOBluetoothObjectRelease()).
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
;     @param		btDevice The target IOBluetoothDeviceRef
; 	@param		rfcommChannel	A pointer to an IOBluetoothRFCOMMChannelRef to receive the RFCOMM channel 
;                                 requested to be opened.  The rfcommChannel pointer will only be set if 
;                                 kIOReturnSuccess is returned.
; 	@param		channelID		The RFCOMM channel ID for the new channel.
; 	@param		withEventListener a IOBluetoothRFCOMMChannelIncomingEventListener where to receive events
; 								  regarding the channel (MUST be specified).
; 	@param		refCon			a refcon pointer (for the callback specified above).
; 	@result		Returns kIOReturnSuccess if the open process was successfully started .
; 

(deftrap-inline "_IOBluetoothDeviceOpenRFCOMMChannelSync" 
   ((btDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (newChannel (:pointer :IOBLUETOOTHRFCOMMCHANNELREF))
    (channelID :UInt8)
    (eventListener :pointer)
    (refcon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее RFCOMM Channel ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothRFCOMMChannelCreateFromObjectID
; 	@abstract	Returns the IOBluetoothRFCOMMChannelRef with the given IOBluetoothObjectID.
;     @discussion	The IOBluetoothObjectID can be used as a global reference for a given IOBluetoothRFCOMMChannelRef.  It allows
; 				two separate applications to refer to the same IOBluetoothRFCOMMChannelRef.
;     @param		objectID	IOBluetoothObjectID of the desired IOBluetoothRFCOMMChannelRef
; 	@result		Returns the IOBluetoothRFCOMMChannelRef that matches the given IOBluetoothObjectID if one exists.  The 
; 				resulting IOBluetoothRFCOMMChannelRef must be released by the caller by calling IOBluetoothObjectRelease.
; 				If no matching RFCOMM channel exists, NULL is returned.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelCreateFromObjectID" 
   ((objectID :UInt32)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !
;     @function	IOBluetoothRFCOMMChannelGetObjectID
; 	@abstract	Returns the IOBluetoothObjectID of the given IOBluetoothRFCOMMChannelRef.
;     @discussion	The IOBluetoothObjectID can be used as a global reference for a given IOBluetoothRFCOMMChannelRef.  It allows
; 				two separate applications to refer to the same IOBluetoothRFCOMMChannelRef.
;     @param		rfcommChannel	Target IOBluetoothRFCOMMChannelRef
; 	@result		Returns the IOBluetoothObjectID of the given IOBluetoothRFCOMMChannelRef.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelGetObjectID" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelCloseChannel
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@result		An error code value. 0 if successful.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelCloseChannel" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelIsOpen
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@result		true if the channel is open false if the channel is not open.
; 	@discussion	note that "not open" means closed, opening and closing
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelIsOpen" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelGetMTU
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@result		Channel MTU size.
;         @discussion Returns the length of the largest chunk of data that this channel can carry. If the
;         caller wishes to use the write:length:sleep: api the length of the data can not be bigger than
;         the channel MTU (maximum transfer unit).	
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelGetMTU" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt16
() )
; -------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelIsTransmissionPaused
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@result		true if the action of sending data will block the current thread, false otherwise.
; 	@discussion Returns true if the remote device flow control is stopping out transmission. This is
;                 useful because we do not buffer data, we stop the transmitting actor. With this method
;                 the transmitter can check if sending data is going to be successful or is going to block. 
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelIsTransmissionPaused" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelGetChannelID
; 	@abstract	Returns the RFCOMM channel number for a given IOBluetoothRFCOMMChannelRef.
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@result		the RFCOMM channel number for this channel.
; 	@discussion	Returns the RFCOMM channel number for a given IOBluetoothRFCOMMChannelRef.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelGetChannelID" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelWrite
; 	@abstract	Write data to a RFCOMM channel synchronusly.
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
;         @param 		data is a pointer to the data buffer to be sent.
;         @param 		length the length of the buffer to be sent (in bytes).
;         @param 		sleepFlag is a boolean if set to TRUE the call will wait until it is possible to send data.
;                         If set to FALSE and it is not possible to send data the method will return immediately with an
;                         error
; 	@result		An error code value. 0 if successful.
;         @discussion Sends data tough the channel. The number of bytes to be sent must not exceed the channel MTU. 
;         If the return value is an error condition none of the data was sent.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelWrite" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
    (sleepFlag :Boolean)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelWriteAsync
; 	@abstract	Write data to a RFCOMM channel asynchronously.
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@param 		data is a pointer to the data buffer to be sent.
; 	@param 		length the length of the buffer to be sent (in bytes).
; 	@param		refcon a NON NULL value that will be contained in the return event (once the data is sent).
; 	@result		An error code value. 0 if successful.
; 	@discussion	Sends data tough the channel. The number of bytes to be sent must not exceed the channel MTU. 
; 				If the return value is an error condition none of the data was sent.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelWriteAsync" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
    (refcon :pointer)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelWriteSync
; 	@abstract	Write data to a RFCOMM channel synchronously.
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@param 		data is a pointer to the data buffer to be sent.
; 	@param 		length the length of the buffer to be sent (in bytes).
; 	@param		refcon a NON NULL value that will be contained in the return event (once the data is sent).
; 	@result		An error code value. 0 if successful.
; 	@discussion	Sends data tough the channel. The number of bytes to be sent must not exceed the channel MTU. 
; 				If the return value is an error condition none of the data was sent.
; 				
; 				NOTE: This function is only available in Mac OS X 10.2.5 (Bluetooth v1.2) or later.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelWriteSync" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_2_AND_LATER
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelWriteSimple
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
;         @param data a pointer to the data buffer to be sent.
;         @param length the length of the buffer to be sent (in bytes).
;         @param sleepFlag a boolean if set to true the call will wait until it is possible to send all the data.
;         @param a UInt32 pointer in which the caller received the nuber of bytes sent.
;         If set to FALSE and it is not possible to send part of the data the method will return immediately.
;         @result An error code value. 0 if successful.
;         @discussion Sends data tough the channel. The number of bytes to be sent is arbitrary. The caller
;         does not have to worry about the MTU. 
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelWriteSimple" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (data :pointer)
    (length :UInt16)
    (sleepFlag :Boolean)
    (numBytesSent (:pointer :UInt32))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMSetSerialParameters
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@param		speed				
; 	@param		nBits				
; 	@param		parity	
; 	@param		bitStop			
; 	@result		An error code value. 0 if successful.	
; 

(deftrap-inline "_IOBluetoothRFCOMMSetSerialParameters" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (speed :UInt32)
    (nBits :UInt8)
    (parity :SInt32)
    (bitStop :UInt8)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelGetDevice
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
;         @result		A reference to the device where this RFCOMM channel was open. 0 if unsuccessful.  The caller does NOT
;                     need to release the returned IOBluetoothDeviceRef.
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelGetDevice" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMSendRemoteLineStatus
; 	@abstract	
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
; 	@param 		lineStatus the error type. The error code can be NoError, OverrunError, ParityError or FramingError.							
; 	@result		An error code value. 0 if successful.	
; 

(deftrap-inline "_IOBluetoothRFCOMMSendRemoteLineStatus" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (lineStatus :SInt32)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelRegisterIncomingDataListener
; 	@abstract	
;         @discussion Registers a callback for the incoming data. The form for the callback is:
;         
;         <br>void function(IOBluetoothRFCOMMChannelRef rfcommChannel, void *data, UInt16 length, void *refCon)<br>
;         
;         where rfcommChannel is the refernce to the channel that received data, data is a buffer with the received data, length is the buffer length
;         (in bytes) and refCon is a user defined void* (maybe the reference to the object to call back ?).
;         
; 	@param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
;         @param 		listener is the callback function.
;         @param 		refCon is a void*, its meaning is up to the developer. This parameter will be passed back as last parameter of
;                         the callback function.
;         @result An error code value. 0 if successful. 	
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelRegisterIncomingDataListener" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (listener :pointer)
    (refCon :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelRegisterIncomingEventListener
;         @abstract Registers a callback for events. 
;         @discussion Registers a callback for events generated by the RFCOMM channel. The form for the callback is:
;         
;         <br>void function(IOBluetoothRFCOMMChannelRef rfcommChannel, void *refCon, IOBluetoothRFCOMMChannelEvent *event)<br>
;         
;         where rfcommChannel is the refernce to the channel that generated the event, refCon is a user defined void* (maybe the reference to the object to
;         call back ?) and event is the generated event. There are three types of events available:
;     
;         <br>
;         kIOBluetoothRFCOMMNewDataEvent when new data is received.<br>
;         kIOBluetoothRFCOMMFlowControlChangedEvent change of flow control.<br>
;         kIOBluetoothRFCOMMChannelTerminatedEvent when the rfcomm channel is no more valid.<br>
;         <br>
;         
;         Note that the kIOBluetoothRFCOMMNewDataEvent provides the same functionality
;         of the data listener callback. This means that if the developer has both an event callback and a datalistener callback both
;         functions will be called when new data arrives. It is up to the developer to properly filter the events (or better to use only
;         one callback). For a better descriptions of the events and the event structure see IOBluetoothUserLib.h.
;         @param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference
;         @param 		listener is the callback function.
;         @param 		refCon is a void*, its meaning is up to the developer. This parameter will be passed back as second parameter of
;                         the callback function.
;         @result An error code value. 0 if successful. 
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelRegisterIncomingEventListener" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (listener :pointer)
    (refCon :pointer)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRFCOMMChannelIsIncoming
;         @abstract 	Returns the direction of the channel.  An incoming channel is one that was opened by the remote
;                     device.
;         @param		rfcommChannel (IOBluetoothRFCOMMChannelRef) The channel reference				
;         @result 	Returns TRUE if the channel was opened by the remote device, FALSE if the channel was opened by this object.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelIsIncoming" 
   ((rfcommChannel (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее SDP ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothAddServiceDict
; 	@abstract	Adds a service to the local SDP server.
;     @discussion	Each entry in the dictionary representing the service contains the individual attributes.  Each
;                 attribute in the dict is keyed by a string that must begin with a hex number representing the
;                 attribute ID.  The key string may contain additional characters if desired as long as they 
;                 follow a space after the ID hex string.  The attribute value must follow the dictionary format 
;                 described by IOBluetoothSDPDataElement.  This dictionary format allows a service dict to be
;                 created as a plist file and then loaded into the system rather than built up in code.  See the
;                 example code for an example of how can be done.
;                 
;                 If the service record handle, L2CAP PSM or RFCOMM channel ID specified in the dictionary are in
;                 use, an alternate one will be assigned.
;                 
;                 In addition to attributes that represent the service itself, additional attributes may be specified
; 				that control the local behavior of the service.  To specify these local attributes, an additional
; 				property titled "LocalAttributes" may be added to the root of the service dict.  The value of this 
; 				property must be a dictionary that contains the individual local attributes.
; 				
; 				Currently, only two local attributes are supported: "Persistent" and "TargetApplication".
; 				
; 				The "Persistent" local attribute must be either a boolean or number representing whether the service
; 				should be persistent.  A persistent service will be saved off and restored any time the Bluetooth
; 				hardware is present.  It will persist through reboots and can only be removed by calling 
; 				IOBluetoothRemoveServiceWithRecordHandle().  This attribute is optional.  By default, if no 
; 				"Persistent" local property is present,	the service will only exist temporarily.  It will 
; 				be removed either when IOBluetoothRemoveServiceWithRecordHandle() is called or when the client 
; 				application exits.
; 				
; 				The "TargetApplication" local attribute is used to specify an application to be launched when a 
; 				remote device attempts to connect to the service (by opening either an L2CAP or RFCOMM channel of
; 				the type specified in the service).  This value must be a string representing the absolute path to
; 				the target executable (not just the .app wrapper - i.e. 
; 				/System/Library/CoreServices/OBEXAgent.app/Contents/MacOS/OBEXAgent).  This attribute is optional.
; 				If no "TargetApplication" local attribute is specified, no special action will take place when an
; 				incoming connection to the service is created.  It is up to the client to be monitoring for the
; 				connection and to do the right thing when one appears.
; 				
; 				The "LocalAttributes" property is optional.  If it is not specified, by default the created service
; 				is transient and will be removed when the client exits.
;                 
;                 Additional local attributes to further control incoming services will be added in the future.
;                 
; 	@param		serviceDict	A dictionary containing the attributes for the new service
; 	@param		outServiceRecord A pointer to the newly created IOBluetoothSDPServiceRecordRef.  The assigned RFCOMM
; 				channel ID can be retrieved from the service record (as can other assigned parameters.)  This value 
; 				only gets set if kIOReturnSuccess is returned.  The caller is responsible for releasing the 
; 				IOBluetoothSDPServiceRecordRef by calling IOBluetoothObjectRelease() when done.
; 	@result		Returns kIOReturnSuccess if successful.
; 

(deftrap-inline "_IOBluetoothAddServiceDict" 
   ((serviceDict (:pointer :__CFDictionary))
    (outServiceRecord (:pointer :IOBLUETOOTHSDPSERVICERECORDREF))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothRemoveServiceWithRecordHandle
; 	@abstract	Removes the given service from the local SDP server.
; 	@discussion	The service record handle passed to this function must match the handle in the service record returned by 
;                 IOBluetoothAddServiceDict.
; 	@param		serviceRecordHandle The handle of the service to be removed.
; 	@result		Returns kIOReturnSuccess if successful.
; 

(deftrap-inline "_IOBluetoothRemoveServiceWithRecordHandle" 
   ((serviceRecordHandle :UInt32)
   )
   :signed-long
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее IOBluetoothSDPUUID ее
 |#

; #endif

; !
;     @function IOBluetoothSDPUUIDCreateWithBytes
;     @abstract Creates a new IOBluetoothSDPUUIDRef  with the given bytes of the given length.
;     @discussion If the length is invalid for a UUID, NULL is returned.
;     @param bytes An array of bytes representing the UUID.
;     @param length The length of the array of bytes.
;     @result Returns the new IOBluetoothSDPUUIDRef or NULL on failure.  The caller MUST release the returned
;             IOBluetoothSDPUUIDRef by calling IOBluetoothObjectRelease().
; 

(deftrap-inline "_IOBluetoothSDPUUIDCreateWithBytes" 
   ((bytes :pointer)
    (length :UInt8)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPUUIDCreateWithData
;     @abstract Creates a new IOBluetoothSDPUUIDRef from the given CFDataRef.
;     @discussion If the length of the CFDataRef is invalid for a UUID, NULL is returned.
;     @param data The CFDataRef containing the UUID bytes.
;     @result Returns the new IOBluetoothSDPUUIDRef or NULL on failure.  The caller MUST release the returned
;             IOBluetoothSDPUUIDRef by calling IOBluetoothObjectRelease().
; 

(deftrap-inline "_IOBluetoothSDPUUIDCreateWithData" 
   ((data (:pointer :__CFData))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPUUIDCreateUUID16
;     @abstract Creates a new 16-bit IOBluetoothSDPUUIDRef with the given UUID16
;     @param uuid16 A scalar representing a 16-bit UUID
;     @result Returns the new IOBluetoothSDPUUIDRef or NULL on failure.  The caller MUST release the returned
;             IOBluetoothSDPUUIDRef by calling IOBluetoothObjectRelease().
; 

(deftrap-inline "_IOBluetoothSDPUUIDCreateUUID16" 
   ((uuid16 :UInt16)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPUUIDCreateUUID32
;     @abstract Creates a new 32-bit IOBluetoothSDPUUIDRef with the given UUID32
;     @param uuid32 A scalar representing a 32-bit UUID
;     @result Returns the new IOBluetoothSDPUUIDRef or NULL on failure.  The caller MUST release the returned
;             IOBluetoothSDPUUIDRef by calling IOBluetoothObjectRelease().
; 

(deftrap-inline "_IOBluetoothSDPUUIDCreateUUID32" 
   ((uuid32 :UInt32)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPUUIDGetBytes
;     @abstract Returns a pointer to the array of UUID bytes.
;     @param uuid The target IOBluetoothSDPUUIDRef
;     @result Returns a pointer to the array of UUID bytes.
; 

(deftrap-inline "_IOBluetoothSDPUUIDGetBytes" 
   ((uuid (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :void)
() )
; !
;     @function IOBluetoothSDPUUIDGetLength
;     @abstract Returns the length (in bytes) of the UUID.
;     @param uuid The target IOBluetoothSDPUUIDRef
;     @result Returns the length (in bytes) of the UUID.
; 

(deftrap-inline "_IOBluetoothSDPUUIDGetLength" 
   ((uuid (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; !
;     @function IOBluetoothSDPUUIDGetUUIDWithLength
;     @abstract Returns an IOBluetoothSDPUUIDRef matching the target UUID, but with the given number of bytes.
;     @discussion If the target IOBluetoothSDPUUIDRef is the same length as newLength, it returns the
;                 IOBluetoothSDPUUIDRef itself.  If newLength is greater it creates a new IOBluetoothSDPUUIDRef 
;                 with the correct value for the given length.  If newLength is smaller, it will attempt to create 
;                 a new IOBluetoothSDPUUIDRef that is smaller if the data matches the Bluetooth UUID base.  This 
;                 downconversion is currently unimplemented.
;                 
;                 Because this function creates a new IOBluetoothSDPUUIDRef to be returned, the caller is
;                 responsible for calling IOBluetoothObjectRelease() on the returned IOBluetoothSDPUUIDRef.
;     @param uuid The target IOBluetoothSDPUUIDRef
;     @param newLength The desired length for the UUID. 
;     @result Returns an IOBluetoothSDPUUIDRef with the same data as the target but with the given length if it
;             is possible to do so.  Otherwise, NULL is returned.
; 

(deftrap-inline "_IOBluetoothSDPUUIDGetUUIDWithLength" 
   ((uuid (:pointer :OpaqueIOBluetoothObjectRef))
    (newLength :UInt8)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPUUIDIsEqualToUUID
;     @abstract Compares the two IOBluetoothSDPUUIDRefs.
;     @discussion This function will compare the two UUID values independent of their length.
;     @param uuid1 The first IOBluetoothSDPUUIDRef to be compared.
;     @param uuid2 The second IOBluetoothSDPUUIDRef to be compared.
;     @result Returns TRUE if the UUID values of each IOBluetoothSDPUUIDRef are equal.  This includes the case 
;             where the sizes are different but the data itself is the same when the Bluetooth UUID base is applied.
; 

(deftrap-inline "_IOBluetoothSDPUUIDIsEqualToUUID" 
   ((uuid1 (:pointer :OpaqueIOBluetoothObjectRef))
    (uuid2 (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее IOBluetoothSDPDataElement ее
 |#

; #endif

; !
;     @function IOBluetoothSDPDataElementGetTypeDescriptor
;     @abstract Returns the SDP spec defined data element type descriptor for the target data element.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns the type descriptor for the target data element.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetTypeDescriptor" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; !
;     @function IOBluetoothSDPDataElementGetSizeDescriptor
;     @abstract Returns the SDP spec defined data element size descriptor for the target data element.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns the size descriptor for the target data element.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetSizeDescriptor" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt8
() )
; !
;     @function IOBluetoothSDPDataElementGetSize
;     @abstract Returns the size in bytes of the target data element.
;     @discussion The size is valid whether the data element has a fixed or variable size descriptor.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns the size in bytes of the target data element.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetSize" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :UInt32
() )
; !
;     @function IOBluetoothSDPDataElementGetNumberValue
;     @abstract If the data element is represented by a number, it returns the value as an CFNumberRef.
;     @discussion The data types represented by a number are 1 (unsigned int), 2 (signed int) and 5 (boolean) 
;                 except for 128-bit versions of 1 and 2.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns an CFNumberRef representation of the data element if it is a numeric type.  The caller is
;             NOT responsible for releasing the returned CFNumberRef.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetNumberValue" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFNumber)
() )
; !
;     @function IOBluetoothSDPDataElementGetDataValue
;     @abstract If the data element is represented by a data object, it returns the value as an CFDataRef.
;     @discussion The data types represented by a data object are 128-bit versions of 1 (unsigned int) and 
;                 2 (signed int).
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns an CFDataRef representation of the data element if it is a 128-bit number.  The caller is
;             NOT responsible for releasing the returned IOBluetoothSDPDataElementRef.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetDataValue" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFData)
() )
; !
;     @function IOBluetoothSDPDataElementGetStringValue
;     @abstract If the data element is represented by a string object, it returns the value as a CFStringRef.
;     @discussion The data types represented by a string object are 4 (text string) and 8 (URL).
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns a CFStringRef representation of the data element if it is a text or URL type.  The caller is
;             NOT responsible for releasing the returned CFStringRef.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetStringValue" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFString)
() )
; !
;     @function IOBluetoothSDPDataElementGetArrayValue
;     @abstract If the data element is represented by an array object, it returns the value as a CFArrayRef.
;     @discussion The data types represented by an array object are 6 (data element sequence) and 7 (data
;                 element alternative).
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns a CFArrayRef representation of the data element if it is a sequence type.  The caller is
;             NOT responsible for releasing the returned CFArrayRef.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetArrayValue" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFArray)
() )
; !
;     @function IOBluetoothSDPDataElementGetUUIDValue
;     @abstract If the data element is a UUID (type 3), it returns the value as an IOBluetoothSDPUUIDRef.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @result Returns an IOBluetoothSDPUUIDRef representation of the data element if it is a UUID.  The caller is
;             NOT responsible for releasing the returned IOBluetoothSDPUUIDRef.
; 

(deftrap-inline "_IOBluetoothSDPDataElementGetUUIDValue" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPDataElementContainsDataElement
;     @abstract Checks to see if the target data element is the same as the dataElement parameter or if it contains
;                 the dataElement parameter (if its a sequence type).
;     @discussion If the target data element is not a sequence type, this method simply compares the two data elements.  If
;                 it is a sequence type, it will search through the sequence (and sub-sequences) for the dataElement
;                 parameter.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @param	subDataElement The data element to compare with (and search for). 
;     @result Returns TRUE if the target either matches the given data element or if it contains the given data element.
; 

(deftrap-inline "_IOBluetoothSDPDataElementContainsDataElement" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
    (subDataElement (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )
; !
;     @function IOBluetoothSDPDataElementIsEqualToDataElement
;     @abstract Compares the target data element with the given object.
;     @discussion This method will compare a data element with either another data element or a data element value.
;     @param	dataElement The target IOBluetoothSDPDataElementRef.
;     @param	dataElement2 The IOBluetoothSDPDataElementRef to compare the target to.
;     @result Returns TRUE if the target data element is the same as the given object or if it's value matches the
;             given object.
; 

(deftrap-inline "_IOBluetoothSDPDataElementIsEqualToDataElement" 
   ((dataElement (:pointer :OpaqueIOBluetoothObjectRef))
    (dataElement2 (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :Boolean
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее IOBluetoothSDPServiceRecord ее
 |#

; #endif

; !
;     @function IOBluetoothSDPServiceRecordGetDevice
;     @abstract Returns the IOBluetoothDeviceRef that the target service belongs to.
;     @discussion If the service is a local service (i.e. one the current host is vending out), then NULL is returned.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @result Returns the IOBluetoothDeviceRef that the target service belongs to.  If the service is one the local host
;             is vending, then NULL is returned.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetDevice" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPServiceRecordGetAttributes
;     @abstract Returns a CFDictionaryRef containing the attributes for the service.
;     @discussion The attribute dictionary is keyed off of the attribute id represented as a CFNumberRef.  The values
;                 in the CFDictionaryRef are IOBluetoothSDPDataElementRefs representing the data element for the
;                 given attribute.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @result Returns a CFDictionaryRef containing the attributes for the target service.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetAttributes" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFDictionary)
() )
; !
;     @function IOBluetoothSDPServiceRecordGetAttributeDataElement
;     @abstract Returns the data element for the given attribute ID in the target service.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @param	attributeID The attribute ID of the desired attribute.	 
;     @result Returns the data element for the given attribute ID in the target service.  If the service does not
;             contain an attribute with the given ID, then NULL is returned.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetAttributeDataElement" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
    (attributeID :UInt16)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function IOBluetoothSDPServiceRecordGetServiceName
;     @abstract Returns the name of the service.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @discussion This is currently implemented to simply return the attribute with an id of 0x0100.  In
;                 the future, it will be extended to allow name localization based on the user's chosen
;                 language or other languages.
;     @result Returns the name of the target service.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetServiceName" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
   )
   (:pointer :__CFString)
() )
; !
;     @function IOBluetoothSDPServiceRecordGetRFCOMMChannelID
;     @abstract Allows the discovery of the RFCOMM channel ID assigned to the service.
;     @discussion This function will search through the ProtoclDescriptorList attribute to find an entry
;                 with the RFCOMM UUID (UUID16: 0x0003).  If one is found, it gets the second element of
;                 the data element sequence and sets the rfcommChannelID pointer to it.  The channel ID
;                 only gets set when kIOReturnSuccess is returned.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @param	rfcommChannelID A pointer to the location that will get the found RFCOMM channel ID.
;     @result Returns kIOReturnSuccess if the channel ID is found.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetRFCOMMChannelID" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
    (channelID (:pointer :BLUETOOTHRFCOMMCHANNELID))
   )
   :signed-long
() )
; !
;     @function IOBluetoothSDPServiceRecordGetL2CAPPSM
;     @abstract Allows the discovery of the L2CAP PSM assigned to the service.
;     @discussion This function will search through the ProtoclDescriptorList attribute to find an entry
;                 with the L2CAP UUID (UUID16: 0x0100).  If one is found, it gets the second element of
;                 the data element sequence and sets the outPSM pointer to it.  The PSM value
;                 only gets set when kIOReturnSuccess is returned.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @param	outPSM A pointer to the location that will get the found L2CAP PSM.
;     @result Returns kIOReturnSuccess if the PSM is found.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetL2CAPPSM" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
    (psm (:pointer :BLUETOOTHL2CAPPSM))
   )
   :signed-long
() )
; !
;     @function IOBluetoothSDPServiceRecordGetServiceRecordHandle
;     @abstract Allows the discovery of the service record handle assigned to the service.
;     @discussion This method will search through the attributes to find the one representing the 
;                 service record handle.  If one is found the outServiceRecordHandle param is set
;                 with the value.  The outServiceRecordHandle value only gets set when kIOReturnSuccess 
;                 is returned.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @param	outServiceRecordHandle A pointer to the location that will get the found service record handle.
;     @result	Returns kIOReturnSuccess if the service record handle is found.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordGetServiceRecordHandle" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
    (serviceRecordHandle (:pointer :BLUETOOTHSDPSERVICERECORDHANDLE))
   )
   :signed-long
() )
; !
;     @function IOBluetoothSDPServiceRecordHasServiceFromArray
;     @abstract Returns TRUE if any one of the UUIDs in the given array is found in the target service.
;     @discussion The given array should contain IOBluetoothSDPUUIDRefs.  It is currently implemented
;                 such that it returns TRUE if any of the UUIDs are found.  However in the future, it is likely
;                 that this will change to more closely match the functionality in the SDP spec so that it only
;                 returns TRUE if all of the given UUIDs are present.  That way, both AND and OR comparisons
;                 can be implemented.  Please make a note of this potential change.
;     @param	serviceRecord The target IOBluetoothSDPServiceRecordRef
;     @param array An NSArray of IOBluetoothSDPUUIDRefs to search for in the target service.	 
;     @result Returns TRUE if any of the given UUIDs are present in the service.
; 

(deftrap-inline "_IOBluetoothSDPServiceRecordHasServiceFromArray" 
   ((serviceRecord (:pointer :OpaqueIOBluetoothObjectRef))
    (array (:pointer :__CFArray))
   )
   :Boolean
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее Notifications ее
 |#

; #endif

(def-mactype :IOBluetoothUserNotificationChannelDirection (find-mactype ':sint32))

(defconstant $kIOBluetoothUserNotificationChannelDirectionAny 0)
(defconstant $kIOBluetoothUserNotificationChannelDirectionIncoming 1)
(defconstant $kIOBluetoothUserNotificationChannelDirectionOutgoing 2)
(def-mactype :IOBluetoothUserNotificationChannelDirection (find-mactype ':SINT32))
; !
;     @typedef IOBluetoothUserNotificationCallback
;     @abstract Callback function definition for user notifications.
;     @discussion This callback will be invoked when the notification for which it was registered is sent.
;     @param userRefCon	(void *) This user defined parameter was provided during the original call to register
; 						the notification.
;     @param inRef		(IOBluetoothUserNotificationRef) The notification responsible for sending the notification.
;     @param status		(IOBluetoothObjectRef) The object that originated the notification.
;     @result None.
; 

(def-mactype :IOBluetoothUserNotificationCallback (find-mactype ':pointer)); (void * userRefCon , IOBluetoothUserNotificationRef inRef , IOBluetoothObjectRef objectRef)
; !
;     @function IOBluetoothUserNotificationUnregister
;     @abstract Unregisters the target notification.
;     @discussion This function will unregister the notification.  Once the notification has been unregistered,
; 				it will no longer call the callback.  Additionally, once this function has been called the
; 				target IOBluetoothUserNotificationRef is no longer valid.
;     @param	notificationRef The target IOBluetoothUserNotificationRef to be unregistered
;     @result None.
; 

(deftrap-inline "_IOBluetoothUserNotificationUnregister" 
   ((notificationRef (:pointer :OpaqueIOBluetoothObjectRef))
   )
   :void
() )
; !
;     @function	IOBluetoothRegisterForDeviceConnectNotifications
; 	@abstract	Allows a client to register for device connect notifications for any connection.
; 	@discussion	The given callback will be called whenever any device connection is made.
; 	@param		callback	The callback to be called when a new connection is made
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding device connect notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothRegisterForDeviceConnectNotifications" 
   ((callback :pointer)
    (inRefCon :pointer)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothDeviceRegisterForDisconnectNotification
; 	@abstract	Allows a client to register for device disconnect notification.
; 	@discussion	The given callback will be called when the target device's connection is closed..
; 	@param		callback	The callback to be called when the target's connection is destroyed
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding device disconnect notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothDeviceRegisterForDisconnectNotification" 
   ((inDevice (:pointer :OpaqueIOBluetoothObjectRef))
    (callback :pointer)
    (inRefCon :pointer)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothRegisterForL2CAPChannelOpenNotifications
; 	@abstract	Allows a client to register for L2CAP channel open notifications for any L2CAP channel.
; 	@discussion	The given callback will be called whenever any L2CAP channel is opened.
; 	@param		callback	The callback to be called when a new L2CAP channel is opened.
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding L2CAP channel notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothRegisterForL2CAPChannelOpenNotifications" 
   ((callback :pointer)
    (inRefCon :pointer)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothRegisterForFilteredL2CAPChannelOpenNotifications
; 	@abstract	Allows a client to register for L2CAP channel open notifications for certain types of
; 				L2CAP channels.
; 	@discussion	The given callback will be called whenever any L2CAP channel is opened.
; 	@param		callback	The callback to be called when a new L2CAP channel is opened.
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@param		psm			PSM to match a new L2CAP channel.  If the PSM doesn't matter, 0 may be passed in.
; 	@param		inDirection	The desired direction of the L2CAP channel - kIOBluetoothUserNotificationChannelDirectionAny
; 				if the direction doesn't matter.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding L2CAP channel notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothRegisterForFilteredL2CAPChannelOpenNotifications" 
   ((callback :pointer)
    (inRefCon :pointer)
    (inPSM :UInt16)
    (inDirection :SInt32)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothL2CAPChannelRegisterForChannelCloseNotification
; 	@abstract	Allows a client to register for a channel close notification.
;     @discussion	The given callback will be called when the L2CAP channel is closed.
; 	@param		channel		The target L2CAP channel
; 	@param		callback	Callback to be called when the L2CAP channel is closed.
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding L2CAP channel close notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothL2CAPChannelRegisterForChannelCloseNotification" 
   ((channel (:pointer :OpaqueIOBluetoothObjectRef))
    (callback :pointer)
    (inRefCon :pointer)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothRegisterForRFCOMMChannelOpenNotifications
; 	@abstract	Allows a client to register for RFCOMM channel open notifications for any RFCOMM channel.
; 	@discussion	The given callback will be called whenever any RFCOMM channel is opened.
; 	@param		callback	The callback to be called when a new RFCOMM channel is opened.
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding RFCOMM channel notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothRegisterForRFCOMMChannelOpenNotifications" 
   ((callback :pointer)
    (inRefCon :pointer)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothRegisterForFilteredRFCOMMChannelOpenNotifications
; 	@abstract	Allows a client to register for RFCOMM channel open notifications for certain types of
; 				RFCOMM channels.
; 	@discussion	The given callback will be called whenever any RFCOMM channel is opened.
; 	@param		callback	The callback to be called when a new RFCOMM channel is opened.
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@param		channeLID	RFCOMM channel ID to match a new RFCOMM channel.  If the channel ID doesn't matter, 0 may be passed in.
; 	@param		inDirection	The desired direction of the RFCOMM channel - kIOBluetoothUserNotificationChannelDirectionAny
; 				if the direction doesn't matter.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding RFCOMM channel notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothRegisterForFilteredRFCOMMChannelOpenNotifications" 
   ((callback :pointer)
    (inRefCon :pointer)
    (channelID :UInt8)
    (inDirection :SInt32)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; !
;     @function	IOBluetoothRFCOMMChannelRegisterForChannelCloseNotification
; 	@abstract	Allows a client to register for a channel close notification.
;     @discussion	The given callback will be called when the RFCOMM channel is closed.
; 	@param		channel		The target RFCOMM channel
; 	@param		callback	Callback to be called when the RFCOMM channel is closed.
; 	@param		inRefCon	Client-supplied refCon to be passed to the callback.
; 	@result		Returns an IOBluetoothUserNotificationRef representing the outstanding RFCOMM channel close notification.
; 				To unregister the notification, call IOBluetoothUserNotificationUnregister() with the returned
; 				IOBluetoothUserNotificationRef.  If an error is encountered creating the notification, NULL is returned.  
; 				The returned IOBluetoothUserNotificationRef will be valid for as long as the notification is registered.
; 				It is not necessary to retain the result.  Once the notification is unregistered, it will no longer
; 				be valid.
; 

(deftrap-inline "_IOBluetoothRFCOMMChannelRegisterForChannelCloseNotification" 
   ((inChannel (:pointer :OpaqueIOBluetoothObjectRef))
    (callback :pointer)
    (inRefCon :pointer)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )

(provide-interface "IOBluetoothUserLib")