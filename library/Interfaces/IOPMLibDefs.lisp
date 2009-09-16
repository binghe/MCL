(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPMLibDefs.h"
; at Sunday July 2,2006 7:29:41 pm.
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
(defconstant $kPMSetAggressiveness 0)
; #define	kPMSetAggressiveness		0
(defconstant $kPMGetAggressiveness 1)
; #define	kPMGetAggressiveness		1
(defconstant $kPMSleepSystem 2)
; #define	kPMSleepSystem			2
(defconstant $kPMAllowPowerChange 3)
; #define	kPMAllowPowerChange		3
(defconstant $kPMCancelPowerChange 4)
; #define	kPMCancelPowerChange		4
(defconstant $kPMShutdownSystem 5)
; #define	kPMShutdownSystem		5
(defconstant $kPMRestartSystem 6)
; #define	kPMRestartSystem		6
(defconstant $kNumPMMethods 7)
; #define kNumPMMethods 7

(provide-interface "IOPMLibDefs")