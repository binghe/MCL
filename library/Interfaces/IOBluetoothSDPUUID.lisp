(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothSDPUUID.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothSDPUUID.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 	Writers:	Eric Brown
; 

; #import <Foundation/Foundation.h>

; #import <IOBluetooth/Bluetooth.h>

; #import <IOBluetooth/IOBluetoothUserLib.h>
; !
;     @class IOBluetoothSDPUUID
;     @abstract An NSData subclass that represents a UUID as defined in the Bluetooth SDP spec.
;     @discussion The IOBluetoothSDPUUID class can represent a UUID of any valid size (16, 32 or 128 bits).
;             It provides the ability to compare two UUIDs no matter what their size as well as the ability
;             to promote the size of a UUID to a larger one.
; 
#| @INTERFACE 
IOBluetoothSDPUUID : NSData {
    NSData	*mUUIDData;
    
    void	*_mReserved;
}



+ (IOBluetoothSDPUUID *)uuidWithBytes:(const void *)bytes length:(unsigned)length;



+ (IOBluetoothSDPUUID *)uuidWithData:(NSData *)data;



+ (IOBluetoothSDPUUID *)uuid16:(BluetoothSDPUUID16)uuid16;



+ (IOBluetoothSDPUUID *)uuid32:(BluetoothSDPUUID32)uuid32;


+ (IOBluetoothSDPUUID *)withSDPUUIDRef:(IOBluetoothSDPUUIDRef)sdpUUIDRef;



- (id)initWithBytes:(const void *)bytes length:(unsigned)length;



- (id)initWithData:(NSData *)data;



- (id)initWithUUID16:(BluetoothSDPUUID16)uuid16;



- (id)initWithUUID32:(BluetoothSDPUUID32)uuid32;


- (IOBluetoothSDPUUIDRef)getSDPUUIDRef;




- (const void *)bytes;



- (unsigned)length;



- (IOBluetoothSDPUUID *)getUUIDWithLength:(unsigned)newLength;



- (BOOL)isEqualToData:(NSData *)otherData;



- (BOOL)isEqualToUUID:(IOBluetoothSDPUUID *)otherUUID;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
- (Class)classForCoder;
- (Class)classForArchiver;
- (Class)classForPortCoder;

|#

(provide-interface "IOBluetoothSDPUUID")