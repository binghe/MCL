(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOAccelSurfaceConnect.h"
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
; #ifndef _IOACCEL_SURFACE_CONNECT_H
; #define _IOACCEL_SURFACE_CONNECT_H

(require-interface "IOKit/graphics/IOAccelTypes")

(require-interface "IOKit/graphics/IOAccelClientConnect")
; 
; ** Surface visible region in device coordinates.
; **
; ** num_rects:	The number of rectangles in the rect array.  If num_rects
; **		is zero the bounds rectangle is used for the visible rectangle.
; **		If num_rects is zero the surface must be completely contained
; **		by the device.
; **
; ** bounds:	The unclipped surface rectangle in device coords.  Extends
; **		beyond the device bounds if the surface is not totally on
; **		the device.
; **
; ** rect[]:	An array of visible rectangles in device coords.  If num_rects
; **		is non-zero only the region described by these rectangles is
; **		copied to the frame buffer during a flush operation.
; 
(defrecord IOAccelDeviceRegion
   (num_rects :UInt32)
   (bounds :IOACCELBOUNDS)
   (rect (:array :IOACCELBOUNDS 0))
)
; 
; ** Determine the size of a region.
; 
; #define IOACCEL_SIZEOF_DEVICE_REGION(_rgn_) (sizeof(IOAccelDeviceRegion) + (_rgn_)->num_rects * sizeof(IOAccelBounds))
; 
; ** Surface client public memory types.  Private memory types start with
; ** kIOAccelNumSurfaceMemoryTypes.
; 
(def-mactype :eIOAccelSurfaceMemoryTypes (find-mactype ':sint32))

(defconstant $kIOAccelNumSurfaceMemoryTypes 0)
; 
; ** Surface client public methods.  Private methods start with
; ** kIOAccelNumSurfaceMethods.
; 
(def-mactype :eIOAccelSurfaceMethods (find-mactype ':sint32))

(defconstant $kIOAccelSurfaceReadLockOptions 0)
(defconstant $kIOAccelSurfaceReadUnlockOptions 1)
(defconstant $kIOAccelSurfaceGetState 2)
(defconstant $kIOAccelSurfaceWriteLockOptions 3)
(defconstant $kIOAccelSurfaceWriteUnlockOptions 4)
(defconstant $kIOAccelSurfaceRead 5)
(defconstant $kIOAccelSurfaceSetShapeBacking 6)
(defconstant $kIOAccelSurfaceSetIDMode 7)
(defconstant $kIOAccelSurfaceSetScale 8)
(defconstant $kIOAccelSurfaceSetShape 9)
(defconstant $kIOAccelSurfaceFlush 10)
(defconstant $kIOAccelSurfaceQueryLock 11)
(defconstant $kIOAccelSurfaceReadLock 12)
(defconstant $kIOAccelSurfaceReadUnlock 13)
(defconstant $kIOAccelSurfaceWriteLock 14)
(defconstant $kIOAccelSurfaceWriteUnlock 15)
(defconstant $kIOAccelNumSurfaceMethods 16)
; 
; ** Option bits for IOAccelCreateSurface and the kIOAccelSurfaceSetIDMode method.
; ** The color depth field can take any value of the _CGSDepth enumeration.
; 

(defconstant $kIOAccelSurfaceModeColorDepth1555 3)
(defconstant $kIOAccelSurfaceModeColorDepth8888 4)
(defconstant $kIOAccelSurfaceModeColorDepthYUV 6)
(defconstant $kIOAccelSurfaceModeColorDepthYUV9 7)
(defconstant $kIOAccelSurfaceModeColorDepthYUV12 8)
(defconstant $kIOAccelSurfaceModeColorDepthYUV2 9)
(defconstant $kIOAccelSurfaceModeColorDepthBGRA32 10)
(defconstant $kIOAccelSurfaceModeColorDepthBits 15)
(defconstant $kIOAccelSurfaceModeStereoBit 16)
(defconstant $kIOAccelSurfaceModeWindowedBit 32)
(defconstant $kIOAccelSurfaceModeBeamSync #x8000)
(def-mactype :eIOAccelSurfaceModeBits (find-mactype ':SINT32))
; 
; ** Options bits for IOAccelSetSurfaceShape and the kIOAccelSurfaceSetShape method.
; 

(defconstant $kIOAccelSurfaceShapeNone 0)
(defconstant $kIOAccelSurfaceShapeNonBlockingBit 1)
(defconstant $kIOAccelSurfaceShapeNonSimpleBit 2)
(defconstant $kIOAccelSurfaceShapeIdentityScaleBit 4)
(defconstant $kIOAccelSurfaceShapeFrameSyncBit 8)
(defconstant $kIOAccelSurfaceShapeBeamSyncBit 16);  wrong name, use kIOAccelSurfaceShapeNonBlockingBit 

(defconstant $kIOAccelSurfaceShapeBlockingBit 1)
(def-mactype :eIOAccelSurfaceShapeBits (find-mactype ':SINT32))
; 
; ** Return bits for the kIOAccelSurfaceGetState method.
; 

(defconstant $kIOAccelSurfaceStateNone 0)
(defconstant $kIOAccelSurfaceStateIdleBit 1)
(def-mactype :eIOAccelSurfaceStateBits (find-mactype ':SINT32))
; 
; ** Option bits for the kIOAccelSurfaceSetScale method.
; 

(defconstant $kIOAccelSurfaceBeamSyncSwaps 1)
(defconstant $kIOAccelSurfaceFixedSource 2)
(defconstant $kIOAccelSurfaceFiltering #xF0)
(defconstant $kIOAccelSurfaceFilterDefault 0)
(defconstant $kIOAccelSurfaceFilterNone 16)
(defconstant $kIOAccelSurfaceFilterLinear 32)
(def-mactype :eIOAccelSurfaceScaleBits (find-mactype ':SINT32))
; 
; ** Option bits for the kIOAccelSurfaceLock methods.
; 

(defconstant $kIOAccelSurfaceLockInBacking 0)
(defconstant $kIOAccelSurfaceLockInAccel 1)
(defconstant $kIOAccelSurfaceLockInDontCare 2)
(defconstant $kIOAccelSurfaceLockInMask 3)
(def-mactype :eIOAccelSurfaceLockBits (find-mactype ':SINT32))

; #endif /* _IOACCEL_SURFACE_CONNECT_H */


(provide-interface "IOAccelSurfaceConnect")