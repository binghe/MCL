(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Histogram.h"
; at Sunday July 2,2006 7:25:29 pm.
; 
;  *  Histogram.h
;  *  vImage_Framework
;  *
;  *  Copyright (c) 2003 Apple Computer. All rights reserved.
;  *
;  
; #ifndef VIMAGE_HISTOGRAM_H
; #define VIMAGE_HISTOGRAM_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "vImage/vImage_Types")

(deftrap-inline "_vImageHistogramCalculation_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (histogram (:pointer :UInt32))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramCalculation_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (histogram (:pointer :UInt32))
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramCalculation_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (histogram (:pointer :UInt32))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramCalculation_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (histogram (:pointer :UInt32))
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEqualization_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEqualization_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEqualization_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEqualization_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramSpecification_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (desired_histogram (:pointer :UInt32))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramSpecification_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (desired_histogram (:pointer :UInt32))
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramSpecification_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (desired_histogram (:pointer :UInt32))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageHistogramSpecification_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (desired_histogram (:pointer :UInt32))
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageContrastStretch_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageContrastStretch_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageContrastStretch_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageContrastStretch_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEndsInContrastStretch_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (percent_low :UInt32)
    (percent_high :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEndsInContrastStretch_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (percent_low :UInt32)
    (percent_high :UInt32)
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEndsInContrastStretch_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (percent_low (:pointer :UInt32))
    (percent_high (:pointer :UInt32))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageEndsInContrastStretch_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (tempBuffer :pointer)
    (percent_low (:pointer :UInt32))
    (percent_high (:pointer :UInt32))
    (histogram_entries :UInt32)
    (minVal :single-float)
    (maxVal :single-float)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageGetMinimumTempBufferSizeForHistogram" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (histogram_entries :UInt32)
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


(provide-interface "Histogram")