(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOGraphicsInterfaceTypes.h"
; at Sunday July 2,2006 7:29:14 pm.
; 
;  * Copyright (c) 1999-2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_IOGRAPHICSINTERFACETYPES_H
; #define _IOKIT_IOGRAPHICSINTERFACETYPES_H

(require-interface "IOKit/graphics/IOAccelSurfaceConnect")
(defconstant $IO_FOUR_CHAR_CODE 0)
; #define IO_FOUR_CHAR_CODE(x)	(x)

(def-mactype :IOFourCharCode (find-mactype ':UInt32))
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
(defconstant $kCurrentGraphicsInterfaceVersion 1)
; #define kCurrentGraphicsInterfaceVersion	1
(defconstant $kCurrentGraphicsInterfaceRevision 2)
; #define kCurrentGraphicsInterfaceRevision	2
; #ifdef IOGA_COMPAT

(def-mactype :IOBlitCompletionToken (find-mactype ':SInt32))

; #endif


(def-mactype :IOBlitType (find-mactype ':UInt32))

(defconstant $kIOBlitTypeVerbMask #xFF)
(defconstant $kIOBlitTypeRects 0)
(defconstant $kIOBlitTypeCopyRects 1)
(defconstant $kIOBlitTypeLines 2)
(defconstant $kIOBlitTypeScanlines 3)
(defconstant $kIOBlitTypeCopyRegion 4)
(defconstant $kIOBlitTypeMoveCursor 5)
(defconstant $kIOBlitTypeShowCursor 6)
(defconstant $kIOBlitTypeHideCursor 7)
(defconstant $kIOBlitTypeMonoExpand #x100)
(defconstant $kIOBlitTypeColorSpaceConvert #x200)
(defconstant $kIOBlitTypeScale #x400)
(defconstant $kIOBlitTypeSourceKeyColorModeMask #x3000)
(defconstant $kIOBlitTypeDestKeyColorModeMask #xC000)
(defconstant $kIOBlitTypeSourceKeyColorEqual #x1000)
(defconstant $kIOBlitTypeSourceKeyColorNotEqual #x2000)
(defconstant $kIOBlitTypeDestKeyColorEqual #x4000)
(defconstant $kIOBlitTypeDestKeyColorNotEqual #x8000)
(defconstant $kIOBlitTypeOperationMask #xFFF0000)
(defconstant $kIOBlitTypeOperationShift 16)
(defconstant $kIOBlitTypeOperationTypeMask #xF000000)
(defconstant $kIOBlitTypeOperationType0 0)
(defconstant $kIOBlitCopyOperation 0)
(defconstant $kIOBlitOrOperation #x10000)
(defconstant $kIOBlitXorOperation #x20000)
(defconstant $kIOBlitBlendOperation #x30000)
(defconstant $kIOBlitHighlightOperation #x40000)

(def-mactype :IOBlitSourceType (find-mactype ':UInt32))

(defconstant $kIOBlitSourceDefault 0)
(defconstant $kIOBlitSourceFramebuffer #x1000)
(defconstant $kIOBlitSourceMemory #x2000)
(defconstant $kIOBlitSourceOOLMemory #x3000)
(defconstant $kIOBlitSourcePattern #x4000)
(defconstant $kIOBlitSourceOOLPattern #x5000)
(defconstant $kIOBlitSourceSolid #x6000)
(defconstant $kIOBlitSourceCGSSurface #x7000)
(defconstant $kIOBlitSourceIsSame #x80000000)
; #ifdef IOGA_COMPAT

(def-mactype :IOBlitSourceDestType (find-mactype ':UInt32))

(defconstant $kIOBlitDestFramebuffer 1)

; #endif

(defrecord IOBlitOperationStruct
   (color0 :UInt32)
   (color1 :UInt32)
   (offsetX :SInt32)
   (offsetY :SInt32)
   (sourceKeyColor :UInt32)
   (destKeyColor :UInt32)
   (specific (:array :UInt32 16))
)
(%define-record :IOBlitOperation (find-record-descriptor :IOBLITOPERATIONSTRUCT))
(defrecord IOBlitRectangleStruct
   (x :SInt32)
   (y :SInt32)
   (width :SInt32)
   (height :SInt32)
)
(%define-record :IOBlitRectangle (find-record-descriptor :IOBLITRECTANGLESTRUCT))
(defrecord IOBlitRectanglesStruct
   (operation :IOBLITOPERATIONSTRUCT)
   (count :UInt32)
   (rects (:array :IOBLITRECTANGLESTRUCT 1))
)
(%define-record :IOBlitRectangles (find-record-descriptor :IOBLITRECTANGLESSTRUCT))
(defrecord IOBlitCopyRectangleStruct
   (sourceX :SInt32)
   (sourceY :SInt32)
   (x :SInt32)
   (y :SInt32)
   (width :SInt32)
   (height :SInt32)
)
(%define-record :IOBlitCopyRectangle (find-record-descriptor :IOBLITCOPYRECTANGLESTRUCT))
(defrecord IOBlitCopyRectanglesStruct
   (operation :IOBLITOPERATIONSTRUCT)
   (count :UInt32)
   (rects (:array :IOBLITCOPYRECTANGLESTRUCT 1))
)
(%define-record :IOBlitCopyRectangles (find-record-descriptor :IOBLITCOPYRECTANGLESSTRUCT))
(defrecord IOBlitCopyRegionStruct
   (operation :IOBLITOPERATIONSTRUCT)
   (deltaX :SInt32)
   (deltaY :SInt32)
   (region (:pointer :IOACCELDEVICEREGION))
)
(%define-record :IOBlitCopyRegion (find-record-descriptor :IOBLITCOPYREGIONSTRUCT))
(defrecord IOBlitVertexStruct
   (x :SInt32)
   (y :SInt32)
)
(%define-record :IOBlitVertex (find-record-descriptor :IOBLITVERTEXSTRUCT))
(defrecord IOBlitVerticesStruct
   (operation :IOBLITOPERATIONSTRUCT)
   (count :UInt32)
   (vertices (:array :IOBLITVERTEXSTRUCT 2))
)
(%define-record :IOBlitVertices (find-record-descriptor :IOBLITVERTICESSTRUCT))
(defrecord IOBlitScanlinesStruct
   (operation :IOBLITOPERATIONSTRUCT)
   (count :UInt32)
   (y :SInt32)
   (height :SInt32)
   (x (:array :SInt32 2))
)
(%define-record :IOBlitScanlines (find-record-descriptor :IOBLITSCANLINESSTRUCT))
(defrecord IOBlitCursorStruct
   (operation :IOBLITOPERATIONSTRUCT)
   (rect :IOBLITRECTANGLESTRUCT)
)
(%define-record :IOBlitCursor (find-record-descriptor :IOBLITCURSORSTRUCT))

(def-mactype :IOBlitMemoryRef (find-mactype '(:pointer :_IOBlitMemory)))
;  Quickdraw.h pixel formats

(defconstant $kIO1MonochromePixelFormat 1)      ;  1 bit indexed

(defconstant $kIO2IndexedPixelFormat 2)         ;  2 bit indexed

(defconstant $kIO4IndexedPixelFormat 4)         ;  4 bit indexed

(defconstant $kIO8IndexedPixelFormat 8)         ;  8 bit indexed

(defconstant $kIO16BE555PixelFormat 16)         ;  16 bit BE rgb 555 (Mac)

(defconstant $kIO24RGBPixelFormat 24)           ;  24 bit rgb 

(defconstant $kIO32ARGBPixelFormat 32)          ;  32 bit argb	(Mac)

(defconstant $kIO1IndexedGrayPixelFormat 33)    ;  1 bit indexed gray

(defconstant $kIO2IndexedGrayPixelFormat 34)    ;  2 bit indexed gray

(defconstant $kIO4IndexedGrayPixelFormat 36)    ;  4 bit indexed gray

(defconstant $kIO8IndexedGrayPixelFormat 40)    ;  8 bit indexed gray


(defconstant $kIO16LE555PixelFormat :|L555|)    ;  16 bit LE rgb 555 (PC)

(defconstant $kIO16LE5551PixelFormat :|5551|)   ;  16 bit LE rgb 5551

(defconstant $kIO16BE565PixelFormat :|B565|)    ;  16 bit BE rgb 565

(defconstant $kIO16LE565PixelFormat :|L565|)    ;  16 bit LE rgb 565

(defconstant $kIO24BGRPixelFormat :|24BG|)      ;  24 bit bgr 

(defconstant $kIO32BGRAPixelFormat :|BGRA|)     ;  32 bit bgra	(Matrox)

(defconstant $kIO32ABGRPixelFormat :|ABGR|)     ;  32 bit abgr	

(defconstant $kIO32RGBAPixelFormat :|RGBA|)     ;  32 bit rgba	

(defconstant $kIOYUVSPixelFormat :|yuvs|)       ;  YUV 4:2:2 byte ordering 16-unsigned = 'YUY2'

(defconstant $kIOYUVUPixelFormat :|yuvu|)       ;  YUV 4:2:2 byte ordering 16-signed

(defconstant $kIOYVU9PixelFormat :|YVU9|)       ;  YVU9 Planar	9

(defconstant $kIOYUV411PixelFormat :|Y411|)     ;  YUV 4:1:1 Interleaved 16

(defconstant $kIOYVYU422PixelFormat :|YVYU|)    ;  YVYU 4:2:2 byte ordering 16

(defconstant $kIOUYVY422PixelFormat :|UYVY|)    ;  UYVY 4:2:2 byte ordering 16

(defconstant $kIOYUV211PixelFormat :|Y211|)     ;  YUV 2:1:1 Packed	8
;  UYVY 4:2:2 byte ordering   16

(defconstant $kIO2vuyPixelFormat :|2vuy|)
;  Non Quickdraw.h pixel formats

(defconstant $kIO16LE4444PixelFormat :|L444|)   ;  16 bit LE argb 4444
;  16 bit BE argb 4444

(defconstant $kIO16BE4444PixelFormat :|B444|)

(defconstant $kIOBlitMemoryRequiresHostFlush 1)
(defrecord IOBlitSurfaceStruct
   (:variant
   (
   (bytes (:pointer :UInt8))
   )
   (
   (ref (:pointer :_IOBlitMemory))
   )
   )
   (pixelFormat :UInt32)
   (size :IOBLITRECTANGLESTRUCT)
   (rowBytes :UInt32)
   (byteOffset :UInt32)
   (palette (:pointer :UInt32))
   (accessFlags :UInt32)
   (interfaceRef (:pointer :_IOBlitMemory))
   (more (:array :UInt32 14))
)
(%define-record :IOBlitSurface (find-record-descriptor :IOBLITSURFACESTRUCT))

(%define-record :IOBlitMemory (find-record-descriptor ':IOBLITSURFACESTRUCT))
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
;  options for Synchronize

(defconstant $kIOBlitSynchronizeWaitBeamExit 1)
(defconstant $kIOBlitSynchronizeFlushHostWrites 2)
;  options for WaitComplete & Flush

(defconstant $kIOBlitWaitContext 0)
(defconstant $kIOBlitWaitAll2D 1)
(defconstant $kIOBlitWaitGlobal 1)
(defconstant $kIOBlitWaitAll 2)
(defconstant $kIOBlitWaitCheck #x80)
(defconstant $kIOBlitFlushWithSwap #x10000)
;  options for AllocateSurface

(defconstant $kIOBlitHasCGSSurface 1)
(defconstant $kIOBlitFixedSource 2)
(defconstant $kIOBlitBeamSyncSwaps 4)
(defconstant $kIOBlitReferenceSource 8)
;  options for UnlockSurface

(defconstant $kIOBlitUnlockWithSwap #x80000000)
;  options for SetDestination

(defconstant $kIOBlitFramebufferDestination 0)
(defconstant $kIOBlitSurfaceDestination 1)
;  options for blit procs

(defconstant $kIOBlitBeamSync 1)
(defconstant $kIOBlitBeamSyncAlways 2)
(defconstant $kIOBlitBeamSyncSpin 4)
(defconstant $kIOBlitAllOptions #xFFFFFFFF)
;  capabilities

(defconstant $kIOBlitColorSpaceTypes :|cspc|)
;  keys for IOAccelFindAccelerator()
(defconstant $kIOAccelTypesKey "IOAccelTypes")
; #define kIOAccelTypesKey			"IOAccelTypes"
(defconstant $kIOAccelIndexKey "IOAccelIndex")
; #define kIOAccelIndexKey			"IOAccelIndex"
(defconstant $kIOAccelRevisionKey "IOAccelRevision")
; #define kIOAccelRevisionKey			"IOAccelRevision"
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

; #endif /* !_IOKIT_IOGRAPHICSINTERFACETYPES_H */


(provide-interface "IOGraphicsInterfaceTypes")