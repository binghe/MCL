(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOAccelTypes.h"
; at Sunday July 2,2006 7:28:14 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOACCEL_TYPES_H
; #define _IOACCEL_TYPES_H

(require-interface "IOKit/IOTypes")
(defconstant $IOACCEL_TYPES_REV 8)
; #define IOACCEL_TYPES_REV	8
;  Integer rectangle in device coordinates 
(defrecord IOAccelBounds
   (x :SInt16)
   (y :SInt16)
   (w :SInt16)
   (h :SInt16)
)
(defrecord IOAccelSize
   (w :SInt16)
   (h :SInt16)
)
;  Surface information 

(defconstant $kIOAccelVolatileSurface 1)
(defconstant $kIOAccelKeycolorSurface 2)
#|
; Warning: type-size: unknown type vm_address_t
|#
(defrecord IOAccelSurfaceInformation   (address (:array :vm_address_t 4))
   (rowBytes :UInt32)
   (width :UInt32)
   (height :UInt32)
   (pixelFormat :UInt32)
   (flags :UInt32)
   (colorTemperature (:array :SInt32 4))
   (typeDependent (:array :UInt32 4))
)
(defrecord IOAccelSurfaceReadData
   (x :signed-long)
   (y :signed-long)
   (w :signed-long)
   (h :signed-long)
   (client_addr :pointer)
   (client_row_bytes :UInt32)
)
(defrecord IOAccelSurfaceScaling
   (buffer :IOACCELBOUNDS)
   (source :IOACCELSIZE)
   (reserved (:array :UInt32 8))
)

; #endif /* _IOACCEL_TYPES_H */


(provide-interface "IOAccelTypes")