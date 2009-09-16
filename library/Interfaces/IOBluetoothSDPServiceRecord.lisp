(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothSDPServiceRecord.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothSDPServiceRecord.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 	Writers:	Eric Brown
; 

; #import <Foundation/Foundation.h>

; #import <IOBluetooth/Bluetooth.h>

; #import <IOBluetooth/IOBluetoothUserLib.h>
; !
;     @class IOBluetoothSDPServiceRecord
;     @abstract An instance of this class represents a single SDP service record.
;     @discussion As a service record, an instance of this class has an NSDictionary of service attributes.
;                 It also has a link to the IOBluetoothDevice that the service belongs to.  The service
;                 dictionary is keyed off of the attribute ID of each attribute represented as an NSNumber.
; 
#| @INTERFACE 
IOBluetoothSDPServiceRecord : NSObject {
    NSDictionary		*mAttributeDictionary;
    IOBluetoothDevice	*mDeviceForService;
    
    void				*_mReserved;
}



+ (IOBluetoothSDPServiceRecord *)withSDPServiceRecordRef:(IOBluetoothSDPServiceRecordRef)sdpServiceRecordRef;



- (IOBluetoothSDPServiceRecordRef)getSDPServiceRecordRef;



- (IOBluetoothDevice *)getDevice;



- (NSDictionary *)getAttributes;



- (IOBluetoothSDPDataElement *)getAttributeDataElement:(BluetoothSDPServiceAttributeID)attributeID;



- (NSString *)getServiceName;



- (IOReturn)getRFCOMMChannelID:(BluetoothRFCOMMChannelID *)rfcommChannelID;



- (IOReturn)getL2CAPPSM:(BluetoothL2CAPPSM *)outPSM;



- (IOReturn)getServiceRecordHandle:(BluetoothSDPServiceRecordHandle *)outServiceRecordHandle;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_1


- (BOOL)matchesUUIDArray:(NSArray *)uuidArray;


- (BOOL)matchesSearchArray:(NSArray *)searchArray;

#endif 



- (BOOL)hasServiceFromArray:(NSArray *)array;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

|#

(provide-interface "IOBluetoothSDPServiceRecord")