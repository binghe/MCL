(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ApplePlatformExpert.h"
; at Sunday July 2,2006 7:26:38 pm.
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
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_APPLEPLATFORM_H
; #define _IOKIT_APPLEPLATFORM_H

(require-interface "IOKit/IOPlatformExpert")

(defconstant $kBootROMTypeOldWorld 0)
(defconstant $kBootROMTypeNewWorld 1)

(defconstant $kChipSetTypePowerSurge 0)
(defconstant $kChipSetTypePowerStar 1)
(defconstant $kChipSetTypeGossamer 2)
(defconstant $kChipSetTypePowerExpress 3)
(defconstant $kChipSetTypeCore99 4)
(defconstant $kChipSetTypeCore2001 5)

(defconstant $kMachineTypeUnknown 0)
(def-mactype :gGetDefaultBusSpeedsKey (find-mactype '(:pointer :OSSymbol)))
#|
 confused about CLASS ApplePlatformExpert #\: public IODTPlatformExpert #\{ OSDeclareAbstractStructors #\( ApplePlatformExpert #\) #\; private #\: SInt32 _timeToGMT #\; struct ExpansionData #\{ #\} #\; ExpansionData * reserved #\; public #\: virtual bool start #\( IOService * provider #\) #\; virtual bool configure #\( IOService * provider #\) #\; virtual const char * deleteList #\( void #\) #\; virtual const char * excludeList #\( void #\) #\; virtual void registerNVRAMController #\( IONVRAMController * nvram #\) #\; virtual long getGMTTimeOfDay #\( void #\) #\; virtual void setGMTTimeOfDay #\( long secs #\) #\; virtual bool getMachineName #\( char * name #\, int maxLength #\) #\; OSMetaClassDeclareReservedUnused #\( ApplePlatformExpert #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( ApplePlatformExpert #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( ApplePlatformExpert #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( ApplePlatformExpert #\, 3 #\) #\;
|#

; #endif /* ! _IOKIT_APPLEPLATFORM_H */


(provide-interface "ApplePlatformExpert")