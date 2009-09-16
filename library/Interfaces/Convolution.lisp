(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Convolution.h"
; at Sunday July 2,2006 7:25:28 pm.
; 
;  *  Convolution.h
;  *  vImage_Framework
;  *
;  *  Copyright (c) 2002 Apple Computer. All rights reserved.
;  *
;  
; 
;  *  For 8 bit integer calculations, kernel values may not sum in any combination
;  *  to be greater than 2**23 or less than or equal to -2**23, to avoid exceeding the 32 bit
;  *  internal precision of the calculation. 
;  *
;  *  For floating point calculations, the kernel must be normalized properly (sum to 1.0). 
;  *  Otherwise lightening or darkening of the image will occur.  
;  
; #ifndef VIMAGE_CONVOLUTION_H
; #define VIMAGE_CONVOLUTION_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "vImage/vImage_Types")

(defconstant $dataIs8Bits 1)
(defconstant $dataIs1Channel 2)
(defconstant $printImageData 4)
;   8 bit planar data  

(deftrap-inline "_vImageConvolve_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :short))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (divisor :signed-long)
    (backgroundColor :UInt8)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
;   32 bit floating point planar data  

(deftrap-inline "_vImageConvolve_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :float))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (backgroundColor :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
;   ARGB (8 bits per channel) interleaved data 	

(deftrap-inline "_vImageConvolve_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :short))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (divisor :signed-long)
    (backgroundColor (:pointer :PIXEL_8888))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
;   ARGB (32 bit float per channel) interleaved data  

(deftrap-inline "_vImageConvolve_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (srcOffsetToROI_X :UInt32)
    (srcOffsetToROI_Y :UInt32)
    (kernel (:pointer :float))
    (kernel_height :UInt32)
    (kernel_width :UInt32)
    (backgroundColor (:pointer :PIXEL_FFFF))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 	Temporary buffer size  

(deftrap-inline "_vImageGetMinimumTempBufferSizeForConvolution" 
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

; #endif


(provide-interface "Convolution")