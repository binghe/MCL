(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vImage_Types.h"
; at Sunday July 2,2006 7:25:27 pm.
; 
;  *  vImage_Types.h
;  *  vImage_Framework
;  *
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef VIMAGE_TYPES_H
; #define VIMAGE_TYPES_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "sys/types")

(require-interface "stddef")

(require-interface "AvailabilityMacros")
;  Please see vImage.h and vImage documentation for the meaning of these types. 
(defrecord vImage_Buffer
   (data :pointer)
                                                ;  Pointer to the top left pixel of the buffer.	
   (height :UInt32)
                                                ;  The height (in pixels) of the buffer		
   (width :UInt32)
                                                ;  The width (in pixels) of the buffer 		
   (rowBytes :UInt32)
                                                ;  The number of bytes in a pixel row		
)
; 
;  * This 3x2 matrix is defined to be the same as the CGAffineTransform.
;  * Some handy functions for creating and manipulating that may be found in CoreGraphics/CGAffineTransform.h.
;  
(defrecord vImage_AffineTransform
   (a :single-float)
   (b :single-float)
   (c :single-float)
   (d :single-float)
   (tx :single-float)
   (ty :single-float))

(def-mactype :vImage_Error (find-mactype ':SInt32))

(def-mactype :vImage_Flags (find-mactype ':UInt32))
;  You must set all undefined flags bits to 0 
;  Pixel data types 

(def-mactype :Pixel_8 (find-mactype ':UInt8))
;  8 bit planar pixel value										

(def-mactype :Pixel_F (find-mactype ':single-float))
;  floating point planar pixel value									
(defrecord Pixel_8888
   (contents (:array :UInt8 4))
)                                               ;  ARGB interleaved (8 bit/channel) pixel value. u_int8_t[4] = { alpha, red, green, blue } 	
(defrecord Pixel_FFFF
   (contents (:array :single-float 4))
)                                               ;  ARGB interleaved (floating point) pixel value. float[4] = { alpha, red, green, blue }		

(def-mactype :ResamplingFilter (find-mactype '(:pointer :void)))
;  vImage Errors 

(defconstant $kvImageNoError 0)
(defconstant $kvImageRoiLargerThanInputBuffer -21766)
(defconstant $kvImageInvalidKernelSize -21767)
(defconstant $kvImageInvalidEdgeStyle -21768)
(defconstant $kvImageInvalidOffset_X -21769)
(defconstant $kvImageInvalidOffset_Y -21770)
(defconstant $kvImageMemoryAllocationError -21771)
(defconstant $kvImageNullPointerArgument -21772)
(defconstant $kvImageInvalidParameter -21773)
(defconstant $kvImageBufferSizeMismatch -21774)
(defconstant $kvImageUnknownFlagsBit -21775)
;  vImage Flags 

(defconstant $kvImageNoFlags 0)
(defconstant $kvImageLeaveAlphaUnchanged 1)     ;  Operate on red, green and blue channels only. Alpha is copied from source to destination. For Interleaved formats only. 

(defconstant $kvImageCopyInPlace 2)             ;  Copy edge pixels 

(defconstant $kvImageBackgroundColorFill 4)     ;  Use the background color for missing pixels 

(defconstant $kvImageEdgeExtend 8)              ;  Extend border data elements 

(defconstant $kvImageDoNotTile 16)              ;  Pass to turn off internal tiling. Use this if you want to do your own tiling, or to use the Min/Max filters in place. 

(defconstant $kvImageHighQualityResampling 32)  ;  Use a higher quality, slower resampling filter for Geometry operations (shear, scale, rotate, affine transform, etc.) 

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* vImage_TYPES_H */


(provide-interface "vImage_Types")