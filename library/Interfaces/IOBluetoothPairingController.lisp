(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothPairingController.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothPairingController.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <Cocoa/Cocoa.h>

; #import <IOBluetooth/objc/IOBluetoothDevice.h>

; #import <IOBluetooth/objc/IOBluetoothSDPServiceRecord.h>

; #import <IOBluetoothUI/IOBluetoothUIUserLib.h>
; --------------------------------------------------------------------------------------------------------------------------
; !	@header		IOBluetoothPairingController.h
; 	@abstract	Public Interfaces for Apple's implementation of a pairing window for Bluetooth technology.
; 	@discussion	This implements a WindowController accessible from Cocoa applications to select a device, and
;                         initiate pairing.
; 
; !
;  	@class IOBluetoothPairingController
; 	@abstract A NSWindowController subclass to display a window to initiate pairing to other bluetooth devices.
; 	@discussion Implementation of a window controller to handle pairing with a bluetooth device.  This
;         class will handle connecting to the Bluetooth Daemon for the purposes of searches, and displaying the results.
;         When necessary this class will display a sheet asking the user for a PIN code.  This window will not return
;         anything to the caller if it is canceled or if pairing occurs.
; 
#| @INTERFACE 
IOBluetoothPairingController : NSWindowController
{
}


+ (IOBluetoothPairingController *)pairingController;


+ (IOBluetoothPairingController *)withPairingControllerRef:(IOBluetoothPairingControllerRef)pairingControllerRef;


- (IOBluetoothPairingControllerRef)getPairingControllerRef;


- (void)runPanelWithAttributes:(IOBluetoothDeviceSearchAttributes *)attributes;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_1



- (int)runModal;



- (NSArray *)getResults;



- (void)setOptions:(IOBluetoothServiceBrowserControllerOptions)options;



- (IOBluetoothServiceBrowserControllerOptions)getOptions;



- (void)setSearchAttributes:(const IOBluetoothDeviceSearchAttributes *)searchAttributes;



- (const IOBluetoothDeviceSearchAttributes *)getSearchAttributes;



- (void)addAllowedUUID:(IOBluetoothSDPUUID *)allowedUUID;



- (void)addAllowedUUIDArray:(NSArray *)allowedUUIDArray;



- (void)clearAllowedUUIDs;



- (void)setTitle:(NSString *)windowTitle;


- (NSString *)getTitle;



- (void)setDescriptionText:(NSString *)descriptionText;



- (NSString *)getDescriptionText;



- (void)setPrompt:(NSString *)prompt;



- (NSString *)getPrompt;

#endif 

|#

(provide-interface "IOBluetoothPairingController")