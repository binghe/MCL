(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGImage.h"
; at Sunday July 2,2006 7:23:52 pm.
;  CoreGraphics - CGImage.h
;  * Copyright (c) 2000 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGIMAGE_H_
; #define CGIMAGE_H_

(def-mactype :CGImageRef (find-mactype '(:pointer :CGImage)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGColorSpace")

(require-interface "CoreGraphics/CGDataProvider")

(require-interface "CoreFoundation/CFBase")

(require-interface "AvailabilityMacros")
(def-mactype :CGImageAlphaInfo (find-mactype ':sint32))

(defconstant $kCGImageAlphaNone 0)
(defconstant $kCGImageAlphaPremultipliedLast 1) ;  For example, premultiplied RGBA 

(defconstant $kCGImageAlphaPremultipliedFirst 2);  For example, premultiplied ARGB 

(defconstant $kCGImageAlphaLast 3)              ;  For example, non-premultiplied RGBA 

(defconstant $kCGImageAlphaFirst 4)             ;  For example, non-premultiplied ARGB 

(defconstant $kCGImageAlphaNoneSkipLast 5)      ;  Equivalent to kCGImageAlphaNone. 

(defconstant $kCGImageAlphaNoneSkipFirst 6)     ;  No color data, alpha data only 

(defconstant $kCGImageAlphaOnly 7)

;type name? (def-mactype :CGImageAlphaInfo (find-mactype ':CGImageAlphaInfo))
;  Return the CFTypeID for CGImageRefs. 

(deftrap-inline "_CGImageGetTypeID" 
   (
   )
   :UInt32
() )
;  Create an image. 

(deftrap-inline "_CGImageCreate" 
   ((width :unsigned-long)
    (height :unsigned-long)
    (bitsPerComponent :unsigned-long)
    (bitsPerPixel :unsigned-long)
    (bytesPerRow :unsigned-long)
    (colorspace (:pointer :CGColorSpace))
    (alphaInfo :CGImageAlphaInfo)
    (provider (:pointer :CGDataProvider))
    (decode (:pointer :float))
    (shouldInterpolate :Boolean)
    (intent :CGColorRenderingIntent)
   )
   (:pointer :CGImage)
() )
;  Create an image mask. 

(deftrap-inline "_CGImageMaskCreate" 
   ((width :unsigned-long)
    (height :unsigned-long)
    (bitsPerComponent :unsigned-long)
    (bitsPerPixel :unsigned-long)
    (bytesPerRow :unsigned-long)
    (provider (:pointer :CGDataProvider))
    (decode (:pointer :float))
    (shouldInterpolate :Boolean)
   )
   (:pointer :CGImage)
() )
;  Create an image from `source', a data provider of JPEG-encoded data. 

(deftrap-inline "_CGImageCreateWithJPEGDataProvider" 
   ((source (:pointer :CGDataProvider))
    (decode (:pointer :float))
    (shouldInterpolate :Boolean)
    (intent :CGColorRenderingIntent)
   )
   (:pointer :CGImage)
() )
;  Create an image using `source', a data provider for PNG-encoded data. 

(deftrap-inline "_CGImageCreateWithPNGDataProvider" 
   ((source (:pointer :CGDataProvider))
    (decode (:pointer :float))
    (shouldInterpolate :Boolean)
    (intent :CGColorRenderingIntent)
   )
   (:pointer :CGImage)
() )
;  Create a copy of `image', replacing the image's colorspace with
;  * `colorspace'.  Returns NULL if `image' is an image mask, or if the
;  * number of components of `colorspace' isn't the same as the number of
;  * components of the colorspace of `image'. 

(deftrap-inline "_CGImageCreateCopyWithColorSpace" 
   ((image (:pointer :CGImage))
    (colorspace (:pointer :CGColorSpace))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGImage)
() )
;  Equivalent to `CFRetain(image)'. 

(deftrap-inline "_CGImageRetain" 
   ((image (:pointer :CGImage))
   )
   (:pointer :CGImage)
() )
;  Equivalent to `CFRelease(image)'. 

(deftrap-inline "_CGImageRelease" 
   ((image (:pointer :CGImage))
   )
   nil
() )
;  Return true if `image' is an image mask, false otherwise. 

(deftrap-inline "_CGImageIsMask" 
   ((image (:pointer :CGImage))
   )
   :Boolean
() )
;  Return the width of `image'. 

(deftrap-inline "_CGImageGetWidth" 
   ((image (:pointer :CGImage))
   )
   :unsigned-long
() )
;  Return the height of `image'. 

(deftrap-inline "_CGImageGetHeight" 
   ((image (:pointer :CGImage))
   )
   :unsigned-long
() )
;  Return the number of bits/component of `image'. 

(deftrap-inline "_CGImageGetBitsPerComponent" 
   ((image (:pointer :CGImage))
   )
   :unsigned-long
() )
;  Return the number of bits/pixel of `image'. 

(deftrap-inline "_CGImageGetBitsPerPixel" 
   ((image (:pointer :CGImage))
   )
   :unsigned-long
() )
;  Return the number of bytes/row of `image'. 

(deftrap-inline "_CGImageGetBytesPerRow" 
   ((image (:pointer :CGImage))
   )
   :unsigned-long
() )
;  Return the colorspace of `image', or NULL if `image' is an image
;  * mask. 

(deftrap-inline "_CGImageGetColorSpace" 
   ((image (:pointer :CGImage))
   )
   (:pointer :CGColorSpace)
() )
;  Return the alpha info of `image'. 

(deftrap-inline "_CGImageGetAlphaInfo" 
   ((image (:pointer :CGImage))
   )
   :CGImageAlphaInfo
() )
;  Return the data provider of `image'. 

(deftrap-inline "_CGImageGetDataProvider" 
   ((image (:pointer :CGImage))
   )
   (:pointer :CGDataProvider)
() )
;  Return the decode array of `image'. 

(deftrap-inline "_CGImageGetDecode" 
   ((image (:pointer :CGImage))
   )
   (:pointer :single-float)
() )
;  Return the interpolation parameter of `image'. 

(deftrap-inline "_CGImageGetShouldInterpolate" 
   ((image (:pointer :CGImage))
   )
   :Boolean
() )
;  Return the rendering intent of `image'. 

(deftrap-inline "_CGImageGetRenderingIntent" 
   ((image (:pointer :CGImage))
   )
   :CGColorRenderingIntent
() )

; #endif	/* CGIMAGE_H_ */


(provide-interface "CGImage")