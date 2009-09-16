(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOUSBUserClient.h"
; at Sunday July 2,2006 7:30:06 pm.
; 
;  * Copyright (c) 1998-2003 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef __OPEN_SOURCE__
; 
;  *
;  *	$Id: IOUSBUserClient.h,v 1.20 2003/08/20 19:41:45 nano Exp $
;  *
;  *	$Log: IOUSBUserClient.h,v $
;  *	Revision 1.20  2003/08/20 19:41:45  nano
;  *	
;  *	Bug #:
;  *	New version's of Nima's USB Prober (2.2b17)
;  *	3382540  Panther: Ejecting a USB CardBus card can freeze a machine
;  *	3358482  Device Busy message with Modems and IOUSBFamily 201.2.14 after sleep
;  *	3385948  Need to implement device recovery on High Speed Transaction errors to full speed devices
;  *	3377037  USB EHCI: returnTransactions can cause unstable queue if transactions are aborted
;  *	
;  *	Also, updated most files to use the id/log functions of cvs
;  *	
;  *	Submitted by: nano
;  *	Reviewed by: rhoads/barryt/nano
;  *	
;  

; #endif

; #ifndef _IOKIT_IOUSBUSERCLIENT_H
; #define _IOKIT_IOUSBUSERCLIENT_H
;  these are the new User Client method names    

(defconstant $kUSBDeviceUserClientOpen 0)
(defconstant $kUSBDeviceUserClientClose 1)
(defconstant $kUSBDeviceUserClientSetConfig 2)
(defconstant $kUSBDeviceUserClientGetConfig 3)
(defconstant $kUSBDeviceUserClientGetConfigDescriptor 4)
(defconstant $kUSBDeviceUserClientGetFrameNumber 5)
(defconstant $kUSBDeviceUserClientDeviceRequestOut 6)
(defconstant $kUSBDeviceUserClientDeviceRequestIn 7)
(defconstant $kUSBDeviceUserClientDeviceRequestOutOOL 8)
(defconstant $kUSBDeviceUserClientDeviceRequestInOOL 9)
(defconstant $kUSBDeviceUserClientCreateInterfaceIterator 10)
(defconstant $kUSBDeviceUserClientResetDevice 11);  new with 1.8.2

(defconstant $kUSBDeviceUserClientSuspend 12)
(defconstant $kUSBDeviceUserClientAbortPipeZero 13);  new with 1.8.7

(defconstant $kUSBDeviceUserClientReEnumerateDevice 14);  new with 1.9.7

(defconstant $kUSBDeviceUserClientGetMicroFrameNumber 15)
(defconstant $kNumUSBDeviceMethods 16)

(defconstant $kUSBDeviceUserClientSetAsyncPort 0)
(defconstant $kUSBDeviceUserClientDeviceAsyncRequestOut 1)
(defconstant $kUSBDeviceUserClientDeviceAsyncRequestIn 2)
(defconstant $kNumUSBDeviceAsyncMethods 3)

(defconstant $kUSBInterfaceUserClientOpen 0)
(defconstant $kUSBInterfaceUserClientClose 1)
(defconstant $kUSBInterfaceUserClientGetDevice 2)
(defconstant $kUSBInterfaceUserClientSetAlternateInterface 3)
(defconstant $kUSBInterfaceUserClientGetFrameNumber 4)
(defconstant $kUSBInterfaceUserClientGetPipeProperties 5)
(defconstant $kUSBInterfaceUserClientReadPipe 6)
(defconstant $kUSBInterfaceUserClientReadPipeOOL 7)
(defconstant $kUSBInterfaceUserClientWritePipe 8)
(defconstant $kUSBInterfaceUserClientWritePipeOOL 9)
(defconstant $kUSBInterfaceUserClientGetPipeStatus 10)
(defconstant $kUSBInterfaceUserClientAbortPipe 11)
(defconstant $kUSBInterfaceUserClientResetPipe 12)
(defconstant $kUSBInterfaceUserClientSetPipeIdle 13)
(defconstant $kUSBInterfaceUserClientSetPipeActive 14)
(defconstant $kUSBInterfaceUserClientClearPipeStall 15)
(defconstant $kUSBInterfaceUserClientControlRequestOut 16)
(defconstant $kUSBInterfaceUserClientControlRequestIn 17)
(defconstant $kUSBInterfaceUserClientControlRequestOutOOL 18)
(defconstant $kUSBInterfaceUserClientControlRequestInOOL 19);  new with 1.9.0

(defconstant $kUSBInterfaceUserClientSetPipePolicy 20)
(defconstant $kUSBInterfaceUserClientGetBandwidthAvailable 21)
(defconstant $kUSBInterfaceUserClientGetEndpointProperties 22);  new with 1.9.2

(defconstant $kUSBInterfaceUserClientLowLatencyPrepareBuffer 23)
(defconstant $kUSBInterfaceUserClientLowLatencyReleaseBuffer 24);  new with 1.9.7

(defconstant $kUSBInterfaceUserClientGetMicroFrameNumber 25)
(defconstant $kUSBInterfaceUserClientGetFrameListTime 26)
(defconstant $kNumUSBInterfaceMethods 27)

(defconstant $kUSBInterfaceUserClientSetAsyncPort 0)
(defconstant $kUSBInterfaceUserClientControlAsyncRequestOut 1)
(defconstant $kUSBInterfaceUserClientControlAsyncRequestIn 2)
(defconstant $kUSBInterfaceUserClientAsyncReadPipe 3)
(defconstant $kUSBInterfaceUserClientAsyncWritePipe 4)
(defconstant $kUSBInterfaceUserClientReadIsochPipe 5)
(defconstant $kUSBInterfaceUserClientWriteIsochPipe 6);  new with 1.9.2

(defconstant $kUSBInterfaceUserClientLowLatencyReadIsochPipe 7)
(defconstant $kUSBInterfaceUserClientLowLatencyWriteIsochPipe 8)
(defconstant $kNumUSBInterfaceAsyncMethods 9)

; #if KERNEL
#| |#

(require-interface "IOKit/IOService")

#|                                              ; 
;  This class is used to add an IOCFPlugInTypes dictionary entry to a provider's
;  property list, thus providing a tie between hardware and a CFBundle at hardware
;  load time
; 
#|
 confused about CLASS IOUSBUserClientInit #\: public IOService #\{ OSDeclareDefaultStructors #\( IOUSBUserClientInit #\) #\; public #\: virtual IOService * probe #\( IOService * provider #\, SInt32 * score #\) #\; virtual bool start #\( IOService * provider #\) #\; virtual bool init #\( OSDictionary * propTable #\) #\; virtual void stop #\( IOService * provider #\) #\; protected #\: virtual void mergeProperties #\( OSObject * dest #\, OSObject * src #\) #\;
|#
 |#

; #endif // KERNEL


; #endif /* ! _IOKIT_IOUSBUSERCLIENT_H */


(provide-interface "IOUSBUserClient")