(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOKitServer.h"
; at Sunday July 2,2006 7:28:37 pm.
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
;  * Copyright (c) 1998 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; 
;  * Internal definitions used between the iokit user library and
;  * server routines.
;  
; #ifndef _IOKIT_IOKITSERVER_H
; #define _IOKIT_IOKITSERVER_H

(require-interface "IOKit/IOTypes")

(require-interface "IOKit/IOKitKeys")

(require-interface "IOKit/OSMessageNotification")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "mach/kmod")
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#
;  IOMakeMatching
; !
;     @enum IOMakeMatching
;     @constant kIOServiceMatching
;     @constant kIOBSDNameMatching
;     @constant kIOOFPathMatching
; 

(defconstant $kIOServiceMatching 100)
(defconstant $kIOBSDNameMatching 101)
(defconstant $kIOOFPathMatching 102)
;  IOCatalogueSendData
; !
;     @enum IOCatalogueSendData user-client flags.
;     @constant kIOCatalogAddDrivers  Signals a call to the addDrivers function in IOCatalogue.
;     @constant kIOCatalogAddDriversNoMatch  Signals a call to the addDrivers function in IOCatalogue but does not start a matching thread.
;     @constant kIOCatalogRemoveDrivers  Signals a call to the removeDrivers function in IOCatalogue.
;     @constant kIOCatalogRemoveDriversNoMatch  Signals a call to the removedrivers function in IOCatalogue but does not start a matching thread. 
;     @constant kIOCatalogStartMatching  Signals the IOCatalogue to start an IOService matching thread.
; 

(defconstant $kIOCatalogAddDrivers 1)
(defconstant $kIOCatalogAddDriversNoMatch 2)
(defconstant $kIOCatalogRemoveDrivers 3)
(defconstant $kIOCatalogRemoveDriversNoMatch 4)
(defconstant $kIOCatalogStartMatching 5)
(defconstant $kIOCatalogRemoveKernelLinker 6)
;  IOCatalogueGetData
; !
;     @enum IOCatalogueGetData user-client flags
;     @constant kIOCatalogGetContents  Returns a snapshot of the database to the caller.
; 

(defconstant $kIOCatalogGetContents 1)
(defconstant $kIOCatalogGetModuleDemandList 2)
(defconstant $kIOCatalogGetCacheMissList 3)
(defconstant $kIOCatalogGetROMMkextList 4)
;  IOCatalogueReset
; !
;     @enum IOCatalogueReset user-client flag
;     @constant kIOCatalogResetDefault  Removes all entries from IOCatalogue except those used for booting the system.
; 

(defconstant $kIOCatalogResetDefault 1)
;  IOCatalogueTerminate
; !
;     @enum IOCatalogueTerminate user-client flags.
;     @constant kIOCatalogModuleUnload Terminates all services which depend on a particular module and unloads the module.
;     @constant kIOCatalogModuleTerminate Terminates all services which depend on a particular module but does not unload the module.
;     @constant kIOCatalogServiceTerminate Terminates a particular service by name.
; 

(defconstant $kIOCatalogModuleUnload 1)
(defconstant $kIOCatalogModuleTerminate 2)
(defconstant $kIOCatalogServiceTerminate 3)

(defconstant $kIOCatalogMatchIdle (- $KMOD_IOKIT_END_RANGE_PACKET 16))

; #endif /* ! _IOKIT_IOKITSERVER_H */


(provide-interface "IOKitServer")