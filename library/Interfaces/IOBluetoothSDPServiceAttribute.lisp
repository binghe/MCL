(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothSDPServiceAttribute.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothSDPServiceAttribute.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <IOBluetooth/Bluetooth.h>
; !
;     @class IOBluetoothSDPServiceAttribute
;     @abstract IOBluetoothSDPServiceAttribute represents a single SDP service attribute.
;     @discussion A service attribute contains two components: an attribute ID and a data element.
; 
#| @INTERFACE 
IOBluetoothSDPServiceAttribute : NSObject {
    BluetoothSDPServiceAttributeID	mAttributeID;
    IOBluetoothSDPDataElement		*mAttributeDataElement;
    IOBluetoothSDPDataElement		*mAttributeIDDataElement;
    
    void							*_mReserved;
}



+ (IOBluetoothSDPServiceAttribute *)withID:(BluetoothSDPServiceAttributeID)newAttributeID attributeElementValue:(NSObject *)attributeElementValue;



+ (IOBluetoothSDPServiceAttribute *)withID:(BluetoothSDPServiceAttributeID)newAttributeID attributeElement:(IOBluetoothSDPDataElement *)attributeElement;



- (id)initWithID:(BluetoothSDPServiceAttributeID)newAttributeID attributeElementValue:(NSObject *)attributeElementValue;



- (id)initWithID:(BluetoothSDPServiceAttributeID)newAttributeID attributeElement:(IOBluetoothSDPDataElement *)attributeElement;



- (BluetoothSDPServiceAttributeID)getAttributeID;



- (IOBluetoothSDPDataElement *)getDataElement;



- (IOBluetoothSDPDataElement *)getIDDataElement;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

|#

(provide-interface "IOBluetoothSDPServiceAttribute")