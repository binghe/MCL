(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPMpowerState.h"
; at Sunday July 2,2006 7:26:35 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
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

(require-interface "IOKit/pwr_mgt/IOPM")
(defrecord IOPMPowerState
   (version :UInt32)
                                                ;  version number of this struct
   (capabilityFlags :UInt32)
                                                ;  bits that describe (to interested drivers) the capability of the device in this state 
   (outputPowerCharacter :UInt32)
                                                ;  description (to power domain children) of the power provided in this state 
   (inputPowerRequirement :UInt32)
                                                ;  description (to power domain parent) of input power required in this state
   (staticPower :UInt32)
                                                ;  average consumption in milliwatts
   (unbudgetedPower :UInt32)
                                                ;  additional consumption from separate power supply (mw)
   (powerToAttain :UInt32)
                                                ;  additional power to attain this state from next lower state (in mw)
   (timeToAttain :UInt32)
                                                ;  time required to enter this state from next lower state (in microseconds)
   (settleUpTime :UInt32)
                                                ;  settle time required after entering this state from next lower state (microseconds)
   (timeToLower :UInt32)
                                                ;  time required to enter next lower state from this one (in microseconds)
   (settleDownTime :UInt32)
                                                ;  settle time required after entering next lower state from this state (microseconds)
   (powerDomainBudget :UInt32)
                                                ;  power in mw a domain in this state can deliver to its children
)

;type name? (%define-record :IOPMPowerState (find-record-descriptor ':IOPMPowerState))

(defconstant $kIOPMPowerStateVersion1 1)

(provide-interface "IOPMpowerState")