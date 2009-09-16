(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOGraphicsEngine.h"
; at Sunday July 2,2006 7:29:14 pm.
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
;  * 10 Mar 99 sdouglas created.
;  
(defrecord IOGraphicsEngineContext
   (contextLock :signed-long)
   (state :UInt32)
   (owner :pointer)
   (version :UInt32)
   (structSize :UInt32)
   (reserved (:array :UInt32 8))
)
; #ifndef __cplusplus

;type name? (%define-record :IOGraphicsEngineContext (find-record-descriptor ':IOGraphicsEngineContext))

; #endif

;  memory type for IOMapMemory

(defconstant $kIOGraphicsEngineContext 100)
;  version

(defconstant $kIOGraphicsEngineContextVersion 1)

(provide-interface "IOGraphicsEngine")