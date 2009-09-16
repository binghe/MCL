(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Alpha.h"
; at Sunday July 2,2006 7:25:28 pm.
; 
;  *  vImageAlpha.h
;  *  vImage Framework
;  *
;  *  Copyright (c) 2003 Apple Computer. All rights reserved.
;  *
;  
; #ifndef VIMAGE_ALPHA_H
; #define VIMAGE_ALPHA_H	

(require-interface "vImage/vImage_Types")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
;  *
;  *	These alpha compositing functions assume that the floating point range is 0.0 (black) to 1.0 (full intensity color).
;  *	While values outside these ranges do function correctly (you can have 110% intensity color or -50% color, for example), 
;  *	the calculation is done assuming 1.0 represents full intensity color, and 0.0 represents the absence of color. If these 
;  *	assumptions are not correct, then the calculation will produce incorrect results. Apple does not currently provide 
;  *	alpha compositing functions that work with any floating point range in vImage.  
;  *
;  *	8 bit functionality assumes that 0 is no color, and 255 is full color. 8 bit functions do saturated clipping before
;  *	converting from internal precision back to 8 bits. The internal calculation is done with higher precision.
;  *
;  

(deftrap-inline "_vImageAlphaBlend_Planar8" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcTopAlpha (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (srcBottomAlpha (:pointer :VIMAGE_BUFFER))
    (alpha (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageAlphaBlend_PlanarF" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcTopAlpha (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (srcBottomAlpha (:pointer :VIMAGE_BUFFER))
    (alpha (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageAlphaBlend_ARGB8888" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageAlphaBlend_ARGBFFFF" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultipliedAlphaBlend_Planar8" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcTopAlpha (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultipliedAlphaBlend_PlanarF" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcTopAlpha (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultipliedAlphaBlend_ARGB8888" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultipliedAlphaBlend_ARGBFFFF" 
   ((srcTop (:pointer :VIMAGE_BUFFER))
    (srcBottom (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultiplyData_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (alpha (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultiplyData_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (alpha (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultiplyData_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImagePremultiplyData_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageUnpremultiplyData_Planar8" 
   ((src (:pointer :VIMAGE_BUFFER))
    (alpha (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageUnpremultiplyData_PlanarF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (alpha (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageUnpremultiplyData_ARGB8888" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_vImageUnpremultiplyData_ARGBFFFF" 
   ((src (:pointer :VIMAGE_BUFFER))
    (dest (:pointer :VIMAGE_BUFFER))
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

; #endif /* vImage_ALPHA_H */


(provide-interface "Alpha")