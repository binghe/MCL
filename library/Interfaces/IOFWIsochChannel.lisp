(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFWIsochChannel.h"
; at Sunday July 2,2006 7:28:58 pm.
; 
;  * Copyright (c) 1998-2002 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; 
;  * Copyright (c) 1999-2002 Apple Computer, Inc.  All rights reserved.
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_IOFWISOCHCHANNEL_H
; #define _IOKIT_IOFWISOCHCHANNEL_H

(require-interface "libkern/c++/OSObject")

(require-interface "IOKit/firewire/IOFireWireFamilyCommon")

(defconstant $kFWIsochChannelUnknownCondition 0)
(defconstant $kFWIsochChannelNotEnoughBandwidth 1)
(defconstant $kFWIsochChannelChannelNotAvailable 2)

#|class IOFireWireController;
|#

#|class IOFWIsochChannel;
|#

#|class IOFWIsochPort;
|#

#|class OSSet;
|#

#|class IOFWReadQuadCommand;
|#

#|class IOFWCompareAndSwapCommand;
|#
; ! @class IOFWIsochChannel
; 
#|
 confused about CLASS IOFWIsochChannel #\: public OSObject #\{ OSDeclareDefaultStructors #\( IOFWIsochChannel #\) public #\: typedef IOReturn #\( ForceStopNotificationProc #\) #\( void * refCon #\, IOFWIsochChannel * channel #\, UInt32 stopCondition #\) #\; protected #\: IOFireWireController * fControl #\; ForceStopNotificationProc * fStopProc #\; void * fStopRefCon #\; IOFWIsochPort * fTalker #\; OSSet * fListeners #\; bool fDoIRM #\; UInt32 fBandwidth #\;;  Allocation units used
 UInt32 fPacketSize #\; IOFWSpeed fPrefSpeed #\; IOFWSpeed fSpeed #\;;  Actual speed used
 UInt32 fChannel #\;                            ;  Actual channel used
 IOFWReadQuadCommand * fReadCmd #\; IOFWCompareAndSwapCommand * fLockCmd #\; UInt32 fGeneration #\;;  When bandwidth was allocated
 IOLock * fLock #\;
; ! @struct ExpansionData
;     @discussion This structure will be used to expand the capablilties of the class in the future.
;     
 struct ExpansionData #\{ #\} #\;
; ! @var reserved
;     Reserved for future use.  (Internal use only)  
 ExpansionData * reserved #\; static void threadFunc #\( void * arg #\) #\; virtual IOReturn updateBandwidth #\( bool claim #\) #\; virtual void reallocBandwidth #\( UInt32 generation #\) #\; virtual void free #\( #\) #\; public #\:;  Called from IOFireWireController
 virtual bool init #\( IOFireWireController * control #\, bool doIRM #\, UInt32 packetSize #\, IOFWSpeed prefSpeed #\, ForceStopNotificationProc * stopProc #\, void * stopRefCon #\) #\; virtual void handleBusReset #\( #\) #\;;  Called by clients
 virtual IOReturn setTalker #\( IOFWIsochPort * talker #\) #\; virtual IOReturn addListener #\( IOFWIsochPort * listener #\) #\; virtual IOReturn allocateChannel #\( #\) #\; virtual IOReturn releaseChannel #\( #\) #\; virtual IOReturn start #\( #\) #\; virtual IOReturn stop #\( #\) #\; protected #\:;  handles IRM and channel determination and allocation.
;  called by both user and kernel isoch channels
 IOReturn allocateChannelBegin #\( IOFWSpeed speed #\, UInt64 allowedChans #\, UInt32& channel #\) #\;;  handles IRM and channel allocation.
;  called by both user and kernel isoch channels
 IOReturn releaseChannelComplete #\( #\) #\; private #\: OSMetaClassDeclareReservedUnused #\( IOFWIsochChannel #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFWIsochChannel #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFWIsochChannel #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOFWIsochChannel #\, 3 #\) #\;
|#

;type name? (def-mactype :: (find-mactype ':IOFWIsochChannel)); :

;type name? (def-mactype :: (find-mactype ':IOFWIsochChannel)); :

; #endif /* ! _IOKIT_IOFWISOCHCHANNEL_H */


(provide-interface "IOFWIsochChannel")