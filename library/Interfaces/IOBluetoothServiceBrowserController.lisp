(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothServiceBrowserController.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;     File:		IOBluetoothServiceBrowserController.h
;     Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <Cocoa/Cocoa.h>

; #import <IOBluetooth/objc/IOBluetoothDevice.h>

; #import <IOBluetooth/objc/IOBluetoothSDPServiceRecord.h>

; #import <IOBluetoothUI/IOBluetoothUIUserLib.h>
; --------------------------------------------------------------------------------------------------------------------------
; !	@header		IOBluetoothServiceBrowserController.h
; 	@abstract	Public Interfaces for Apple's implementation of a service browser window for Bluetooth technology.
; 	@discussion	This implements a WindowController accessible from Cocoa applications to find a device, and
;                         initiate Service Discovery queries on devices.  The user can select a particular service which
;                         they want to use for the application.
; 
; !
;  	@class IOBluetoothServiceBrowserController
; 	@abstract A NSWindowController subclass to display a window to search for and perform SDP queries on bluetooth
;                     devices within range.
; 	@discussion This NSWindowController subclass will bring up a generic Bluetooth search and SDP browsing window
;                     allowing the user to find devices within range, perform SDP queries on a particular device, and
;                     select a SDP service to connect to.  The client application can provide NSArrays of valid service
;                     UUIDs to allow, and an NSArray of valid device types to allow.  The device type filter is not
;                     yet implemented.
; 
#| @INTERFACE 
IOBluetoothServiceBrowserController : NSWindowController
{
}


+(IOBluetoothServiceBrowserController *)serviceBrowserController:(IOBluetoothServiceBrowserControllerOptions)inOptions;


+(IOReturn)browseDevices:(IOBluetoothSDPServiceRecord**)outRecord options:(IOBluetoothServiceBrowserControllerOptions)inOptions;


+(IOReturn)browseDevicesAsSheetForWindow:(IOBluetoothSDPServiceRecord**)outRecord
								 options:(IOBluetoothServiceBrowserControllerOptions)inOptions
								  window:(NSWindow*)inWindow;



+ (IOBluetoothServiceBrowserController *)withServiceBrowserControllerRef:(IOBluetoothServiceBrowserControllerRef)serviceBrowserControllerRef;


- (IOBluetoothServiceBrowserControllerRef)getServiceBrowserControllerRef;


-(IOReturn)discover:(IOBluetoothSDPServiceRecord **)outRecord;


-(IOReturn)discoverAsSheetForWindow:(NSWindow *)sheetWindow withRecord:(IOBluetoothSDPServiceRecord **)outRecord;


-(IOReturn)discoverWithDeviceAttributes:(IOBluetoothDeviceSearchAttributes *)deviceAttributes serviceList:(NSArray *)serviceArray serviceRecord:(IOBluetoothSDPServiceRecord**)outRecord;


-(void)setOptions:(IOBluetoothServiceBrowserControllerOptions)inOptions;

#if BLUETOOTH_VERSION_MAX_ALLOWED >= BLUETOOTH_VERSION_1_1



- (int)runModal;



- (IOReturn)beginSheetModalForWindow:(NSWindow *)sheetWindow modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;



- (NSArray *)getResults;



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

(provide-interface "IOBluetoothServiceBrowserController")