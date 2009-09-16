(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOKitDebug.h"
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
; 
;  * Copyright (c) 1998 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_IOKITDEBUG_H
; #define _IOKIT_IOKITDEBUG_H

(require-interface "IOKit/IOTypes")
; #ifdef __cplusplus
#| #|

#include <libkernc++OSObject.h>
#include <libkernc++OSDictionary.h>
#include <libkernc++OSSerialize.h>

class IOKitDiagnostics : public OSObject
{
    OSDeclareDefaultStructors(IOKitDiagnostics)

public:
    static OSObject * diagnostics( void );
    virtual bool serialize(OSSerialize *s) const;
private:
    static void updateOffset( OSDictionary * dict,
			UInt32 value, const char * name );
};

#endif
|#
 |#
;  loggage

(defconstant $kIOLogAttach 0x00000001ull)
(defconstant $kIOLogProbe 0x00000002ull)
(defconstant $kIOLogStart 0x00000004ull)
(defconstant $kIOLogRegister 0x00000008ull)
(defconstant $kIOLogMatch 0x00000010ull)
(defconstant $kIOLogConfig 0x00000020ull)
(defconstant $kIOLogYield 0x00000040ull)
(defconstant $kIOLogPower 0x00000080ull)
(defconstant $kIOLogMapping 0x00000100ull)
(defconstant $kIOLogCatalogue 0x00000200ull)
(defconstant $kIOLogTracePower 0x00000400ull)
(defconstant $kIOLogServiceTree 0x00001000ull)
(defconstant $kIOLogDTree 0x00002000ull)
(defconstant $kIOLogMemory 0x00004000ull)       ;  debug aids - change behaviour

(defconstant $kIONoFreeObjects 0x00100000ull)
(defconstant $kIOLogSynchronous 0x00200000ull)  ;  IOLog completes synchrounsly
(%define-record :gIOKitDebug (find-record-descriptor ':SInt64))
(def-mactype :iokit_version (find-mactype '(:pointer :char)))
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_IOPrintPlane" 
   ((plane (:pointer :ioregistryplane))
   )
   nil
() )

(deftrap-inline "_OSPrintMemory" 
   (
   )
   nil
() )
; #define IOPrintMemory OSPrintMemory
; #ifdef __cplusplus
#| #|
} 
#endif
|#
 |#
;  __cplusplus 

; #endif /* ! _IOKIT_IOKITDEBUG_H */


(provide-interface "IOKitDebug")