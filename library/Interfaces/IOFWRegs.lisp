(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFWRegs.h"
; at Sunday July 2,2006 7:29:01 pm.
; 
; 
; * Copyright (c) 1998-2002 Apple Computer, Inc. All rights reserved.
; 
; *
; 
; * @APPLE_LICENSE_HEADER_START@
; 
; * 
; 
; * The contents of this file constitute Original Code as defined in and
; 
; * are subject to the Apple Public Source License Version 1.1 (the
; 
; * "License").  You may not use this file except in compliance with the
; 
; * License.  Please obtain a copy of the License at
; 
; * http://www.apple.com/publicsource and read it before using this file.
; 
; * 
; 
; * This Original Code and all software distributed under the License are
; 
; * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
; 
; * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
; 
; * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
; 
; * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
; 
; * License for the specific language governing rights and limitations
; 
; * under the License.
; 
; * 
; 
; * @APPLE_LICENSE_HEADER_END@
; 
; 
; 
; 
; 	File:		IOFWRegs.h
; 
; 
; 
; 	Copyright:	© 1996-1999 by Apple Computer, Inc., all rights reserved.
; 
; 
; 
; 
; #ifndef __IOFWREGS_H__
; #define __IOFWREGS_H__

(require-interface "IOKit/firewire/IOFireWireFamilyCommon")
; #ifndef NEW_ERROR_CODES
; 	 
;  (!)	The following error codes are obsolete...
; 		Please use the error codes defined in IOFireWireFamilyCommon.h
; 

(defconstant $inUseErr -4160)                   ;  Item already in use

(defconstant $notFoundErr -4161)                ;  Item not found

(defconstant $timeoutErr -4162)                 ;  Something timed out

(defconstant $busReconfiguredErr -4163)         ;  Bus was reconfigured

(defconstant $invalidIDTypeErr -4166)           ;  Given ID is of an invalid type for the requested operation.

(defconstant $alreadyRegisteredErr -4168)       ;  Item has already been registered.

(defconstant $disconnectedErr -4169)            ;  Target of request has been disconnected.

(defconstant $retryExceededErr -4170)           ;  Retry limit was exceeded.

(defconstant $addressRangeErr -4171)            ;  Address is not in range.

(defconstant $addressAlignmentErr -4172)        ;  Address is not of proper alignment.

(defconstant $multipleTalkerErr -4180)          ;  Tried to install multiple talkers

(defconstant $channelActiveErr -4181)           ;  Operation not permitted when channel is active

(defconstant $noListenerOrTalkerErr -4182)      ;  Every isochronous channel must have one talker and at least
;  one listener

(defconstant $noChannelsAvailableErr -4183)     ;  No supported isochronous channels are available

(defconstant $channelNotAvailableErr -4184)     ;  Required channel was not available.

(defconstant $invalidIsochPortIDErr -4185)      ;  An isochronous port ID is invalid.

(defconstant $invalidFWReferenceTypeErr -4186)  ;  Operation does not support type of given reference ID

(defconstant $separateBusErr -4187)             ;  Two or more entities are on two or more busses and cannot be associated with eachother.

(defconstant $badSelfIDsErr -4188)              ;  Received self IDs are bad.
; zzz Do we own these next ID numbers?

(defconstant $cableVoltageTooLowErr -4190)      ;  Cable power below device's minimum voltage
;  Can't grant power request at this time

(defconstant $cablePowerInsufficientErr -4191)

; #endif //NEW_ERROR_CODES


; #endif /* __IOFWREGS_H */


(provide-interface "IOFWRegs")