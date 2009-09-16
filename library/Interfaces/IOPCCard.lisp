(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPCCard.h"
; at Sunday July 2,2006 7:29:35 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_IOPCCARD_H
; #define _IOKIT_IOPCCARD_H

(require-interface "IOKit/IOService")

(require-interface "sys/cdefs")

(require-interface "IOKit/pccard/version")

(require-interface "IOKit/pccard/config")
; #define IOPCCARD_IN_IOKIT_CODE

(require-interface "IOKit/pccard/k_compat")

(require-interface "IOKit/pccard/cs_types")

(require-interface "IOKit/pccard/cs")

(require-interface "IOKit/pccard/cistpl")

(require-interface "IOKit/pccard/cisreg")

(require-interface "IOKit/pci/IOPCIDevice")

(require-interface "IOKit/pccard/IOCardBusDevice")

(require-interface "IOKit/pccard/IOPCCardBridge")

(require-interface "IOKit/pccard/IOPCCard16Device")

(require-interface "IOKit/pccard/IOPCCard16Enabler")

(require-interface "IOKit/pccard/IOPCCardEjectController")

; #endif /* ! _IOKIT_IOPCCARD_H */


(provide-interface "IOPCCard")