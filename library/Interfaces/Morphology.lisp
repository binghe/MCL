(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Morphology.h"
; at Sunday July 2,2006 7:25:30 pm.
; 
;  *  Morphology.h
;  *  vImage_Framework
;  *
;  *  Copyright (c) 2002 Apple Computer. All rights reserved.
;  *
;  
; #ifndef VIMAGE_MORPHOLOGY_H
; #define VIMAGE_MORPHOLOGY_H

(require-interface "vImage/vImage_Types")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;   Morphology functions 
;     -------------------- 
;     Min is a special case for an Erode function with a kernel that contains all the same value. 
;     Max is a special case for a Dilate function with a kernel that contains all the same value.
;     
;     The Erode and Dilate functions do saturated clipping to prevent overflow for UInt8 and ARGB_8888 types.
;         No clipping is performed for floating point types. 
;     Erode and Dilate handle the edges (areas where the kernel extends beyond the edges of the input buffer)
;         by testing only those parts of the kernel that do overlay the input buffer. 
;         
;     An Open filter may be created by doing an Erode followed by a Dilate.
;     A Close filter may be created by doing a Dilate followed by an Erode.
;     
;     A kernel populated with only one value lets us make some significant algorithmic optimizations. The 
;     calculation time for the Dilate and Erode functions are proportional to M*N for a square kernel of 
;     dimensions M x N.  The calculation time for the Min and Max functions is roughly proportional to 
;     Log2(N) + Log2(M). The speed difference can be orders of magnitude for large kernels. We suggest 
;     you use Min/Max instead of Dilate/Erode when possible. 
;         
;     The temp buffers should be the size returned by vImageGetMinimumTempBufferSizeForMinMax() or larger.
;     
;     The source and destination buffers must not overlap. Exception: They may overlap if you pass in a temporary buffer
;     to Min or Max and you also pass the kvImageDoNotTile flag.
;     
;     In MacOS X.3, Panther, Min and Max do not respond to kvImageLeaveAlphaUnchanged for interleaved data formats. 
;     Due to the large difference in speed between Min/Max and Dilate/Erode for large kernels, developers who wish 
;     to do Min/Max with kvImageLeaveAlphaUnchanged should convert the data format to planar, then call Min/Max on the
;     appropriate color channels and then convert back to the desired interleaved format. 
; 

(deftrap-inline "_vImageDilate_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :UInt8))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageDilate_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :float))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageDilate_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :UInt8))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageDilate_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :float))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageErode_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :UInt8))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageErode_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :float))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageErode_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :UInt8))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageErode_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :float))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMax_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMax_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMax_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMax_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMin_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMin_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMin_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageMin_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageGetMinimumTempBufferSizeForMinMax" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (flags :UInt32)
    (bytesPerPixel :unsigned-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :unsigned-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* MORPHOLOGY_H */


(provide-interface "Morphology")