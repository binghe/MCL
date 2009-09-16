(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothL2CAPChannel.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothL2CAPChannel.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <IOKit/IOKitLib.h>

; #import <IOKit/IODataQueueShared.h>

; #import <IOBluetooth/Bluetooth.h>

; #import <IOBluetooth/IOBluetoothUserLib.h>

; #import <IOBluetooth/objc/IOBluetoothDevice.h>

; #import <IOBluetooth/objc/IOBluetoothObject.h>
; --------------------------------------------------------------------------------------------------------------------------
; !
;  	@class IOBluetoothL2CAPChannel
; 	@abstract An instance of IOBluetoothL2CAPChannel represents a single open L2CAP channel.
; 	@discussion	A client won't create IOBluetoothL2CAPChannel objects directly.  Instead, the IOBluetoothDevice's 
;                 L2CAP channel open API is responsible for opening a new L2CAP channel and returning an
;                 IOBluetoothL2CAPChannel instance representing that newly opened channel.  Additionally, the IOBluetooth
;                 notification system will send notifications when new L2CAP channels are open (if requested).
;                 
;                 After a new L2CAP channel is opened, the L2CAP configuration process will not be completed until an
;                 incoming data listener is registered with the IOBluetoothL2CAPChannel object.  The reason for this is
;                 to due to the limited buffering done of incoming L2CAP data.  This way, we avoid the situation where 
;                 incoming data is received before the client is ready for it.  Once a client is done with an
;                 IOBluetoothL2CAPChannel that it opened, it should call -closeChannel.  Additionally, if the client
;                 does not intend to use the connection to the remote device any further, it should call -closeConnection
;                 on the IOBluetoothDevice object.
; 
#| @INTERFACE 
IOBluetoothL2CAPChannel : IOBluetoothObject
{
    NSPort										*mDataAvailablePort;
    IODataQueueMemory							*mIncomingDataQueue;
    IOBluetoothDevice							*mDevice;
    
	BOOL										mIncomingChannel;
	
	id											mL2CAPChannelConnectionHandler;

    IOBluetoothL2CAPChannelIncomingDataListener	mIncomingDataListener;
    void										*mIncomingDataListenerRefCon;

    IOBluetoothL2CAPChannelIncomingEventListener	mEventDataListener;
    void											*mEventDataListenerRefCon;
	
    BluetoothL2CAPPSM							mChannelPSM;
    
	BluetoothL2CAPChannelID						mLocalChannelID;
    BluetoothL2CAPChannelID						mRemoteChannelID;
    
	BOOL										mIsClosed;
    IOBluetoothObjectID							mObjectID;
    
    void										*_mReserved;
}



+ (IOBluetoothUserNotification *)registerForChannelOpenNotifications:(id)object selector:(SEL)selector;



+ (IOBluetoothUserNotification *)registerForChannelOpenNotifications:(id)object selector:(SEL)selector withPSM:(BluetoothL2CAPPSM)psm direction:(IOBluetoothUserNotificationChannelDirection)inDirection;



+ (IOBluetoothL2CAPChannel *)withL2CAPChannelRef:(IOBluetoothL2CAPChannelRef)l2capChannelRef;



- (IOBluetoothL2CAPChannelRef)getL2CAPChannelRef;



+ (IOBluetoothL2CAPChannel *)withObjectID:(IOBluetoothObjectID)objectID;



- (IOReturn)closeChannel;



- (BluetoothL2CAPMTU)getOutgoingMTU;



- (BluetoothL2CAPMTU)getIncomingMTU;



- (IOReturn)requestRemoteMTU:(BluetoothL2CAPMTU)remoteMTU;



- (IOReturn)write:(void *)data length:(UInt16)length;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



- (IOReturn)writeAsync:(void *)data length:(UInt16)length refcon:(void*)refcon;



- (IOReturn)writeSync:(void *)data length:(UInt16)length;

#endif 



- (IOReturn)registerIncomingDataListener:(IOBluetoothL2CAPChannelIncomingDataListener)listener refCon:(void *)refCon;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2



- (IOReturn)setDelegate:(id)channelDelegate;

#endif 



- (IOBluetoothDevice *)getDevice;



- (IOBluetoothObjectID)getObjectID;



- (BluetoothL2CAPPSM)getPSM;



- (BluetoothL2CAPChannelID)getLocalChannelID;



- (BluetoothL2CAPChannelID)getRemoteChannelID;



- (BOOL)isIncoming;



- (IOBluetoothUserNotification *)registerForChannelCloseNotification:(id)observer selector:(SEL)inSelector;

- (NSString *)description;

|#

; #if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2
;  Informal protocol to describe the L2CAP channel delegate methods:
;  If the developer wishes to take advantage of the asynchronous API in Objective C
;  these are the methods that may be implemented:
#| @PROTOCOL 
IOBluetoothL2CAPChannelDelegate
- (void)l2capChannelData:(IOBluetoothL2CAPChannel*)l2capChannel data:(void *)dataPointer length:(size_t)dataLength;
- (void)l2capChannelOpenComplete:(IOBluetoothL2CAPChannel*)l2capChannel status:(IOReturn)error;
- (void)l2capChannelClosed:(IOBluetoothL2CAPChannel*)l2capChannel;
- (void)l2capChannelReconfigured:(IOBluetoothL2CAPChannel*)l2capChannel;
- (void)l2capChannelWriteComplete:(IOBluetoothL2CAPChannel*)l2capChannel refcon:(void*)refcon status:(IOReturn)error;
- (void)l2capChannelQueueSpaceAvailable:(IOBluetoothL2CAPChannel*)l2capChannel;
|#

; #endif /* BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_2 */


(provide-interface "IOBluetoothL2CAPChannel")