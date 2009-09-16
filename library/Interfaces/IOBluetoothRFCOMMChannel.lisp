(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothRFCOMMChannel.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothRFCOMMChannel.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <IOKit/IOKitLib.h>

; #import <IOKit/IODataQueueShared.h>

; #import <IOBluetooth/Bluetooth.h>

; #import <IOBluetooth/IOBluetoothUserLib.h>

; #import <IOBluetooth/objc/IOBluetoothObject.h>

; #import <IOBluetooth/objc/IOBluetoothUserNotification.h>
; !
;     @class IOBluetoothRFCOMMChannel
;     @abstract An instance of this class represents an rfcomm channel as defined by the Bluetooth SDP spec..
;     @discussion An RFCOMM channel object can be obtained by opening an rfcomm channel in a device, or
;     by requesting a notification when a channel is created (this is commonly used to provide services).
; 
#| @INTERFACE 
IOBluetoothRFCOMMChannel : IOBluetoothObject
{
    BOOL											mChannelIsOpen;
    UInt16											mMTU;
    BOOL											mIsIncoming;

    IOBluetoothDevice								*mDevice;
    IOBluetoothL2CAPChannel							*mL2Channel;

    NSPort											*mDataAvailablePort;
    IODataQueueMemory								*mIncomingDataQueue;

	id												mRFCOMMChannelConnectionHandler;
	
    IOBluetoothRFCOMMChannelIncomingDataListener	mIncomingDataListener;
    void											*mIncomingDataListenerRefCon;

    IOBluetoothRFCOMMChannelIncomingEventListener	mEventDataListener;
    void											*mEventDataListenerRefCon;
    
    IOBluetoothObjectID								mObjectID;
    
    void											*_mReserved;
}



+ (IOBluetoothUserNotification *)registerForChannelOpenNotifications:(id)object selector:(SEL)selector;



+ (IOBluetoothUserNotification *)registerForChannelOpenNotifications:(id)object selector:(SEL)selector withChannelID:(BluetoothRFCOMMChannelID)channelID direction:(IOBluetoothUserNotificationChannelDirection)inDirection;


+ (IOBluetoothRFCOMMChannel *)withRFCOMMChannelRef:(IOBluetoothRFCOMMChannelRef)rfcommChannelRef;



+ (IOBluetoothRFCOMMChannel *)withObjectID:(IOBluetoothObjectID)objectID;


- (IOBluetoothRFCOMMChannelRef)getRFCOMMChannelRef;



- (IOReturn)closeChannel;



- (BOOL)isOpen;



- (BluetoothRFCOMMMTU)getMTU;



- (BOOL)isTransmissionPaused;



- (IOReturn)write:(void *)data length:(UInt16)length sleep:(BOOL)sleep;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



- (IOReturn)writeAsync:(void *)data length:(UInt16)length refcon:(void*)refcon;



- (IOReturn)writeSync:(void *)data length:(UInt16)length;

#endif 



- (IOReturn)writeSimple:(void *)data length:(UInt16)length sleep:(BOOL)sleep bytesSent:(UInt32 *)numBytesSent;



- (IOReturn)setSerialParameters:(UInt32)speed dataBits:(UInt8)nBits parity:(BluetoothRFCOMMParityType)parity stopBits:(UInt8)bitStop;



- (IOReturn)sendRemoteLineStatus:(BluetoothRFCOMMLineStatus)lineStatus;



- (IOReturn)registerIncomingDataListener:(IOBluetoothRFCOMMChannelIncomingDataListener)listener refCon:(void *)refCon;



- (IOReturn)registerIncomingEventListener:(IOBluetoothRFCOMMChannelIncomingEventListener)listener refCon:(void *)refCon;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



- (IOReturn)setDelegate:(id)delegate;

#endif 



- (BluetoothRFCOMMChannelID)getChannelID;



- (BOOL)isIncoming;



- (IOBluetoothDevice *)getDevice;



- (IOBluetoothObjectID)getObjectID;



- (IOBluetoothUserNotification *)registerForChannelCloseNotification:(id)observer selector:(SEL)inSelector;

|#

; #if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2
;  Informal protocol to describe the RFCOMM channel delegate methods:
;  If the developer wishes to take advantage of the asynchronous API in Objective C
;  these are the methods that may be implemented:
#| @PROTOCOL 
IOBluetoothRFCOMMChannelDelegate
- (void)rfcommChannelData:(IOBluetoothRFCOMMChannel*)rfcommChannel data:(void *)dataPointer length:(size_t)dataLength;
- (void)rfcommChannelOpenComplete:(IOBluetoothRFCOMMChannel*)rfcommChannel status:(IOReturn)error;
- (void)rfcommChannelClosed:(IOBluetoothRFCOMMChannel*)rfcommChannel;
- (void)rfcommChannelControlSignalsChanged:(IOBluetoothRFCOMMChannel*)rfcommChannel;
- (void)rfcommChannelFlowControlChanged:(IOBluetoothRFCOMMChannel*)rfcommChannel;
- (void)rfcommChannelWriteComplete:(IOBluetoothRFCOMMChannel*)rfcommChannel refcon:(void*)refcon status:(IOReturn)error;
- (void)rfcommChannelQueueSpaceAvailable:(IOBluetoothRFCOMMChannel*)rfcommChannel;

|#

; #endif /* BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2 */


(provide-interface "IOBluetoothRFCOMMChannel")