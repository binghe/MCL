(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothSDPDataElement.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothSDPDataElement.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 	Writers:	Eric Brown
; 

; #import <Foundation/Foundation.h>

; #import <IOBluetooth/Bluetooth.h>

; #import <IOBluetooth/IOBluetoothUserLib.h>
; !
;     @class IOBluetoothSDPDataElement
;     @abstract An instance of this class represents a single SDP data element as defined by the Bluetooth SDP spec.
;     @discussion The data types described by the spec have been mapped onto the base Foundation classes NSNumber, 
;                 NSArray, NSData as well as IOBluetoothSDPUUID.  The number and boolean types (type descriptor 1, 2 
;                 and 5) are represented as NSNumber objects with the exception of 128-bit numbers which are 
;                 represented as NSData objects in their raw format.  The UUID type (type descriptor 3) is 
;                 represented by IOBluetoothSDPUUID.  The string and URL types (type descriptor 4 and 8) are 
;                 represented by NSString.  The sequence types (type descriptor 6 and 7) are represented by NSArray.
;                 
;                 Typically, you will not need to create an IOBluetoothSDPDataElement directly, the system will
;                 do that automatically for both client and server operations.  However, the current API for adding 
;                 SDP services to the system does allow the use of an NSDictionary based format for creating new 
;                 services.  The purpose for that is to allow a service to be built up completely in a text file
;                 (a plist for example) and then easily imported into an app and added to the system without a 
;                 lot of tedious code to build up the entire SDP service record.
;                 
;                 The basis for that NSDictionary structure comes from the IOBluetoothSDPDataElement.  At its
;                 simplest, a data element is made up of three parts: the type descriptor, the size (from which
;                 the size descriptor is generated) and the actual value.  To provide a complete representation
;                 of a data element, an NSDictionary with three entries can be used.  Each of the three entries
;                 has a key/value pair representing one of the three attributes of a data element.  The first
;                 key/value pair has a key 'DataElementType' that contains a number value with the actual
;                 type descriptor for the data element.  The second pair has a key 'DataElementSize' that
;                 contains the actual size of the element in bytes.  The size descriptor will be calculated
;                 based on the size and type of the element.  The third pair is the value itself whose key is
;                 'DataElementValue' and whose type corresponds to the type mapping above.
;                 
;                 In addition to this complete description of a data element, their are some shortcuts that
;                 can be used for some of the common types and sizes.
;                 
;                 If the 'DataElementType' value is one of the numeric types (1, 2), the 'DataElementValue' 
;                 can be an NSData instead of an NSNumber.  In that case, the numeric data is taken in network 
;                 byte order (MSB first).  Additionally, the 'DataElementSize' parameter may be omitted and the 
;                 size will be taken from the length of the data object.
;                 
;                 If the 'DataElementType' value is the nil type (0), no 'DataElementSize' or 'DataElementValue'
;                 entries are needed.
;                 
;                 If the 'DataElementType' value is any of the other types, the 'DataElementSize' entry is not
;                 needed since the size will be taken directly from the value (data, array, string).
;                 
;                 In the case where the element is an unsigned, 32-bit integer (type descriptor 1, size descriptor
;                 2), the value itself may simply be a number (instead of a dictionary as in the previous examples).
;                 
;                 In the case where the element is a UUID (type descriptor 3), the value itself may be a data object.  
;                 The UUID type will be inferred and the size taken from the length of the data object.
;                 
;                 In the case where the element is a text string (type descriptor 4), the value may be a string object.
;                 The text string type will be inferred and the size taken from the length of the string.
;                 
;                 In the case where the element is a data element sequence, the value may be an array object.  The
;                 type will be inferred and the size taken from the length of the array.  Additionally, the array
;                 must contain sub-elements that will be parsed out individually.
; 
#| @INTERFACE 
IOBluetoothSDPDataElement : NSObject {
    BluetoothSDPDataElementTypeDescriptor	mTypeDescriptor;
    BluetoothSDPDataElementSizeDescriptor	mSizeDescriptor;
    UInt32									mSize;
    NSObject								*mValue;
    
    void									*_mReserved;
}



+ (IOBluetoothSDPDataElement *)withElementValue:(NSObject *)element;



+ (IOBluetoothSDPDataElement *)withType:(BluetoothSDPDataElementTypeDescriptor)type sizeDescriptor:(BluetoothSDPDataElementSizeDescriptor)newSizeDescriptor size:(UInt32)newSize value:(NSObject *)newValue;



+ (IOBluetoothSDPDataElement *)withSDPDataElementRef:(IOBluetoothSDPDataElementRef)sdpDataElementRef;



- (id)initWithElementValue:(NSObject *)element;



- (id)initWithType:(BluetoothSDPDataElementTypeDescriptor)newType sizeDescriptor:(BluetoothSDPDataElementSizeDescriptor)newSizeDescriptor size:(UInt32)newSize value:(NSObject *)newValue;



- (IOBluetoothSDPDataElementRef)getSDPDataElementRef;



- (BluetoothSDPDataElementTypeDescriptor)getTypeDescriptor;



- (BluetoothSDPDataElementSizeDescriptor)getSizeDescriptor;



- (UInt32)getSize;



- (NSNumber *)getNumberValue;



- (NSData *)getDataValue;



- (NSString *)getStringValue;



- (NSArray *)getArrayValue;



- (IOBluetoothSDPUUID *)getUUIDValue;



- (NSObject *)getValue;



- (BOOL)containsDataElement:(IOBluetoothSDPDataElement *)dataElement;



- (BOOL)containsValue:(NSObject *)cmpValue;



- (BOOL)isEqual:(id)cmpObject;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

|#

(provide-interface "IOBluetoothSDPDataElement")