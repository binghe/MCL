(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothDevice.h"
; at Sunday July 2,2006 7:28:31 pm.
; 
;     File:		IOBluetoothDevice.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <IOBluetooth/objc/IOBluetoothObject.h>

; #import <IOKit/IOKitLib.h>

; #import <IOBluetooth/Bluetooth.h>

; #import <IOBluetooth/IOBluetoothUserLib.h>

; #import <IOBluetooth/objc/IOBluetoothUserNotification.h>
; !	@header		IOBluetoothDevice.h
; 	@abstract	An instance of IOBluetoothDevice represents a single remote Bluetooth device.
; 	@discussion	An IOBluetoothDevice object may exist independent of the existence of a baseband connection
;                 with the target device.  Through this object you can request baseband connections to be made, 
;                 request opening and closing of L2CAP and RFCOMM channels.
; 
; ====================================================================================================================
; 	Defines
; ====================================================================================================================
;  These are the names of the notifications the device sends using NSNotificationCenter when it is connected
;  and disconnected
; #define	kIOBluetoothDeviceNotificationNameConnected			@"IOBluetoothDeviceConnected"
; #define	kIOBluetoothDeviceNotificationNameDisconnected		@"IOBluetoothDeviceDisconnected"
; #define kIOBluetoothDeviceNameChangedNotification			@"IOBluetoothDeviceNameChanged"
; #define kIOBluetoothDeviceInquiryInfoChangedNotification	@"IOBluetoothDeviceInquiryInfoChanged"
; #define kIOBluetoothDeviceServicesChangedNotification		@"IOBluetoothDeviceServicesChanged"
; ====================================================================================================================
; 	Forward declarations
; ====================================================================================================================
; ====================================================================================================================
; 	Async callbacks informal protocol
; ====================================================================================================================
#| @PROTOCOL 
IOBluetoothDeviceAsyncCallbacks

- (void)remoteNameRequestComplete:(IOBluetoothDevice *)device status:(IOReturn)status;
- (void)connectionComplete:(IOBluetoothDevice *)device status:(IOReturn)status;
- (void)sdpQueryComplete:(IOBluetoothDevice *)device status:(IOReturn)status;

|#
; --------------------------------------------------------------------------------------------------------------------------
; !
;  	@class IOBluetoothDevice
; 	@abstract An instance of IOBluetoothDevice represents a single remote Bluetooth device.
; 	@discussion	An IOBluetoothDevice object may exist independent of the existence of a baseband connection
;                 with the target device.  Using this object, a client can request creation and destruction of baseband
;                 connections, and request the opening of L2CAP and RFCOMM channels on the remote device.  Many of the other
;                 APIs in the IOBluetooth framework will return this object, or it's C counterpart (IOBluetoothDeviceRef).
; 
; ====================================================================================================================
; 	IOBluetoothDevice
; ====================================================================================================================
#| @INTERFACE 
IOBluetoothDevice : IOBluetoothObject
{
    id									mServerDevice;
    
    io_iterator_t						mDeviceConnectNotification;
    
		
	BluetoothDeviceAddress				mAddress;				    
	NSString							*mName;						NSDate								*mLastNameUpdate;		    
    BluetoothClassOfDevice				mClassOfDevice;
	
		
	BluetoothPageScanRepetitionMode		mPageScanRepetitionMode;
	BluetoothHCIPageScanPeriodMode		mPageScanPeriodMode;
	BluetoothHCIPageScanMode			mPageScanMode;
	BluetoothClockOffset				mClockOffset;
    
    NSDate								*mLastInquiryUpdate;	                                                                	
		
	BluetoothConnectionHandle			mConnectionHandle;			BluetoothLinkType					mLinkType;					BluetoothHCIEncryptionMode			mEncryptionMode;		    
    NSArray								*mServiceArray;
    NSDate								*mLastServicesUpdate;
    
        
    IOBluetoothRFCOMMConnection			*mRFCOMMConnection;
    
    void								*_mReserved;
}




+ (IOBluetoothUserNotification *)registerForConnectNotifications:(id)observer selector:(SEL)inSelector;



- (IOBluetoothUserNotification *)registerForDisconnectNotification:(id)observer selector:(SEL)inSelector;



+ (IOBluetoothDevice *)withAddress:(const BluetoothDeviceAddress *)address;



+ (IOBluetoothDevice *)withDeviceRef:(IOBluetoothDeviceRef)deviceRef;



- (IOBluetoothDeviceRef)getDeviceRef;



- (BOOL)isEqual:(id)cmpObject;


#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



- (IOReturn)openL2CAPChannelSync:(IOBluetoothL2CAPChannel **)newChannel withPSM:(BluetoothL2CAPPSM)psm delegate:(id)channelDelegate;



- (IOReturn)openL2CAPChannelAsync:(IOBluetoothL2CAPChannel **)newChannel withPSM:(BluetoothL2CAPPSM)psm delegate:(id)channelDelegate;

#endif 



- (IOReturn)openL2CAPChannel:(BluetoothL2CAPPSM)psm findExisting:(BOOL)findExisting newChannel:(IOBluetoothL2CAPChannel **)newChannel;



- (IOReturn)sendL2CAPEchoRequest:(void *)data length:(UInt16)length;



- (IOReturn)openRFCOMMChannel:(BluetoothRFCOMMChannelID)channelID channel:(IOBluetoothRFCOMMChannel **)rfcommChannel;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



- (IOReturn)openRFCOMMChannelSync:(IOBluetoothRFCOMMChannel **)rfcommChannel withChannelID:(BluetoothRFCOMMChannelID)channelID delegate:(id)channelDelegate;



- (IOReturn)openRFCOMMChannelAsync:(IOBluetoothRFCOMMChannel **)rfcommChannel withChannelID:(BluetoothRFCOMMChannelID)channelID delegate:(id)channelDelegate;

#endif 




- (BluetoothClassOfDevice)getClassOfDevice;



- (BluetoothServiceClassMajor)getServiceClassMajor;



- (BluetoothDeviceClassMajor)getDeviceClassMajor;



- (BluetoothDeviceClassMinor)getDeviceClassMinor;



- (NSString *)getName;



- (NSString *)getNameOrAddress;



- (NSDate *)getLastNameUpdate;



- (const BluetoothDeviceAddress *)getAddress;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_1



- (NSString *)getAddressString;

#endif 




- (BluetoothPageScanRepetitionMode)getPageScanRepetitionMode;



- (BluetoothPageScanPeriodMode)getPageScanPeriodMode;



- (BluetoothPageScanMode)getPageScanMode;



- (BluetoothClockOffset)getClockOffset;



- (NSDate *)getLastInquiryUpdate;




- (BOOL)isConnected;



- (IOReturn)openConnection;



- (IOReturn)openConnection:(id)target;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_3


- (IOReturn)openConnection:(id)target withPageTimeout:(BluetoothHCIPageTimeout)pageTimeoutValue authenticationRequired:(BOOL)authenticationRequired;

#endif 



- (IOReturn)closeConnection;



- (IOReturn)remoteNameRequest:(id)target;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_3



- (IOReturn)remoteNameRequest:(id)target withPageTimeout:(BluetoothHCIPageTimeout)pageTimeoutValue;

#endif 



- (IOReturn)requestAuthentication;



- (BluetoothConnectionHandle)getConnectionHandle;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_3



- (BOOL)isIncoming;

#endif 



- (BluetoothLinkType)getLinkType;



- (BluetoothHCIEncryptionMode)getEncryptionMode;



- (IOReturn)performSDPQuery:(id)target;



- (NSArray *)getServices;



- (NSDate *)getLastServicesUpdate;



- (IOBluetoothSDPServiceRecord *)getServiceRecordForUUID:(IOBluetoothSDPUUID *)sdpUUID;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_1



+ (NSArray *)favoriteDevices;



- (BOOL)isFavorite;



- (IOReturn)addToFavorites;



- (IOReturn)removeFromFavorites;



+ (NSArray *)recentDevices:(UInt32)numDevices;



- (NSDate *)recentAccessDate;

#endif 

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



+ (NSArray *)pairedDevices;



- (BOOL)isPaired;

#endif 

- (NSString *)description;
- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
- (id)awakeAfterUsingCoder:(NSCoder *)coder;

|#

(provide-interface "IOBluetoothDevice")