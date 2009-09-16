(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothObject.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
;   IOBluetoothObject.h
;   IOBluetoothFamily
; 
;   Created by Eric Brown on Tue Jun 11 2002.
;   Copyright (c) 2002 __MyCompanyName__. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <IOKit/IOKitLib.h>
#| @INTERFACE 
IOBluetoothObject : NSObject
{
    io_service_t		mIOService;
    io_connect_t		mIOConnection;
    
    io_iterator_t		mIONotification;
}

|#
; #define kBluetoothTargetDoesNotRespondToCallbackExceptionName	@"BluetoothTargetDoesNotRespondToCallbackException"

(provide-interface "IOBluetoothObject")