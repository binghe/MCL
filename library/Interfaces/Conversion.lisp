(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Conversion.h"
; at Sunday July 2,2006 7:25:29 pm.
; 
;  *  Conversion.h
;  *  vImage_Framework
;  *
;  *  Copyright (c) 2003 Apple Computer. All rights reserved.
;  *
;  
; #ifndef VIMAGE_CONVERSION_H
; #define VIMAGE_CONVERSION_H

(require-interface "vImage/vImage_Types")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_vImageClip_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (maxFloat :single-float)
    (minFloat :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_Planar8toPlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (maxFloat :single-float)
    (minFloat :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_PlanarFtoPlanar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (maxFloat :single-float)
    (minFloat :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_Planar8toARGB8888" 
   ((srcA (:pointer :VIMAGE_BUFFER))
    (srcR (:pointer :VIMAGE_BUFFER))
    (srcG (:pointer :VIMAGE_BUFFER))
    (srcB (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_ARGB8888toPlanar8" 
   ((srcARGB (:pointer :VIMAGE_BUFFER))
    (destA (:pointer :VIMAGE_BUFFER))
    (destR (:pointer :VIMAGE_BUFFER))
    (destG (:pointer :VIMAGE_BUFFER))
    (destB (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_ChunkyToPlanar8" 
   ((srcChannels :pointer)
    (destPlanarBuffers (:pointer :VIMAGE_BUFFER))
    (channelCount :UInt32)
    (srcStrideBytes :unsigned-long)
    (srcWidth :UInt32)
    (srcHeight :UInt32)
    (srcRowBytes :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_PlanarToChunky8" 
   ((srcPlanarBuffers (:pointer :VIMAGE_BUFFER))
    (destChannels :pointer)
    (channelCount :UInt32)
    (destStrideBytes :unsigned-long)
    (destWidth :UInt32)
    (destHeight :UInt32)
    (destRowBytes :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_ChunkyToPlanarF" 
   ((srcChannels :pointer)
    (destPlanarBuffers (:pointer :VIMAGE_BUFFER))
    (channelCount :UInt32)
    (srcStrideBytes :unsigned-long)
    (srcWidth :UInt32)
    (srcHeight :UInt32)
    (srcRowBytes :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_PlanarToChunkyF" 
   ((srcPlanarBuffers (:pointer :VIMAGE_BUFFER))
    (destChannels :pointer)
    (channelCount :UInt32)
    (destStrideBytes :unsigned-long)
    (destWidth :UInt32)
    (destHeight :UInt32)
    (destRowBytes :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_16SToF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (offset :single-float)
    (scale :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_16UToF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (offset :single-float)
    (scale :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_FTo16S" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (offset :single-float)
    (scale :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_FTo16U" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (offset :single-float)
    (scale :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_PlanarFtoARGBFFFF" 
   ((srcA (:pointer :VIMAGE_BUFFER))
    (srcR (:pointer :VIMAGE_BUFFER))
    (srcG (:pointer :VIMAGE_BUFFER))
    (srcB (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageConvert_ARGBFFFFtoPlanarF" 
   ((srcARGB (:pointer :VIMAGE_BUFFER))
    (destA (:pointer :VIMAGE_BUFFER))
    (destR (:pointer :VIMAGE_BUFFER))
    (destG (:pointer :VIMAGE_BUFFER))
    (destB (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageTableLookUp_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (alphaTable (:pointer :PIXEL_8))
    (redTable (:pointer :PIXEL_8))
    (greenTable (:pointer :PIXEL_8))
    (blueTable (:pointer :PIXEL_8))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageTableLookUp_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (table (:pointer :PIXEL_8))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "Conversion")