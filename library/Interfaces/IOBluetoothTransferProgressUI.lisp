(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothTransferProgressUI.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;   IOBluetoothTransferProgressUI.h
;   IOBluetoothFamily
; 
;   Created by mat on Mon Mar 24 2003.
;   Copyright (c) 2003 Apple Computer, Inc. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <Cocoa/Cocoa.h>

; #import <IOBluetooth/objc/IOBluetoothTransferProgress.h>
#| @INTERFACE 
IOBluetoothTransferProgressUI : IOBluetoothTransferProgress {

	NSProgressIndicator * mProgressIndicator;
	NSTextField * mStatusField;
	NSTextField * mBytesTransferredField;
	NSTextField * mTimeRemainingField;
}


- (void) setProgressIndicator: (NSProgressIndicator*) inProgress;
- (void) setTransferedBytesField: (NSTextField*) inField;
- (void) setTimeRemainingField: (NSTextField*) inField;

- (void) transferStarted;
- (void) transferCancelled;

- (void) updateUI;

- (NSString*) getBytesTransferredAsString;
- (NSString *) getByteSizeString:(UInt32)numBytes;

- (NSString *)locString:(NSString *)keyString;

|#

(provide-interface "IOBluetoothTransferProgressUI")