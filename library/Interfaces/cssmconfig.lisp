(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cssmconfig.h"
; at Sunday July 2,2006 7:27:27 pm.
; 
;  * Copyright (c) 2000-2001 Apple Computer, Inc. All Rights Reserved.
;  * 
;  * The contents of this file constitute Original Code as defined in and are
;  * subject to the Apple Public Source License Version 1.2 (the 'License').
;  * You may not use this file except in compliance with the License. Please obtain
;  * a copy of the License at http://www.apple.com/publicsource and read it before
;  * using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
;  * OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
;  * LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
;  * PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
;  * specific language governing rights and limitations under the License.
;  
; 
;    File:      cssmconfig.h
; 
;    Contains:  Platform specific defines and typedefs for cdsa.
; 
;    Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; #ifndef _CSSMCONFIG_H_
(defconstant $_CSSMCONFIG_H_ 1)
; #define _CSSMCONFIG_H_  1

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/ConditionalMacros")
;  #if defined(TARGET_API_MAC_OS8) || defined(TARGET_API_MAC_CARBON) || defined(TARGET_API_MAC_OSX) 

; #if defined(TARGET_OS_MAC)

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/MacTypes")
#| 
; #else

; #error Unknown API architecture.
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

;type name? (%define-record :sint64 (find-record-descriptor ':SInt64))

;type name? (%define-record :uint64 (find-record-descriptor ':UInt64))

;type name? (def-mactype :sint32 (find-mactype ':SInt32))

;type name? (def-mactype :sint16 (find-mactype ':SInt16))

;type name? (def-mactype :sint8 (find-mactype ':SInt8))

;type name? (def-mactype :uint32 (find-mactype ':UInt32))

;type name? (def-mactype :uint16 (find-mactype ':UInt16))

;type name? (def-mactype :uint8 (find-mactype ':UInt8))
; #define CSSMACI
; #define CSSMAPI
; #define CSSMCLI
; #define CSSMCSPI
; #define CSSMDLI
; #define CSSMKRI
; #define CSSMSPI
; #define CSSMTPI
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _CSSMCONFIG_H_ */


(provide-interface "cssmconfig")