(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGBitmapContext.h"
; at Sunday July 2,2006 7:23:49 pm.
;  CoreGraphics - CGBitmapContext.h
;  * Copyright (c) 2000 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGBITMAPCONTEXT_H_
; #define CGBITMAPCONTEXT_H_

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGContext")
;  Create a bitmap context.  The context draws into a bitmap which is
;  * `width' pixels wide and `height' pixels high.  The number of components
;  * for each pixel is specified by `colorspace', which also may specify a
;  * destination color profile. The number of bits for each component of a
;  * pixel is specified by `bitsPerComponent', which must be 1, 2, 4, or 8.
;  * Each row of the bitmap consists of `bytesPerRow' bytes, which must be at
;  * least `(width * bitsPerComponent * number of components + 7)/8' bytes.
;  * `data' points a block of memory at least `bytesPerRow * height' bytes.
;  * `alphaInfo' specifies whether the bitmap should contain an alpha
;  * channel, and how it's to be generated. 

(deftrap-inline "_CGBitmapContextCreate" 
   ((data :pointer)
    (width :unsigned-long)
    (height :unsigned-long)
    (bitsPerComponent :unsigned-long)
    (bytesPerRow :unsigned-long)
    (colorspace (:pointer :CGColorSpace))
    (alphaInfo :CGImageAlphaInfo)
   )
   (:pointer :CGContext)
() )
;  Return the data associated with the bitmap context `c', or NULL if `c'
;  * is not a bitmap context. 

(deftrap-inline "_CGBitmapContextGetData" 
   ((c (:pointer :CGContext))
   )
   (:pointer :void)
() )
;  Return the width of the bitmap context `c', or 0 if `c' is not a bitmap
;  * context. 

(deftrap-inline "_CGBitmapContextGetWidth" 
   ((c (:pointer :CGContext))
   )
   :unsigned-long
() )
;  Return the height of the bitmap context `c', or 0 if `c' is not a bitmap
;  * context. 

(deftrap-inline "_CGBitmapContextGetHeight" 
   ((c (:pointer :CGContext))
   )
   :unsigned-long
() )
;  Return the bits per component of the bitmap context `c', or 0 if `c' is
;  * not a bitmap context. 

(deftrap-inline "_CGBitmapContextGetBitsPerComponent" 
   ((c (:pointer :CGContext))
   )
   :unsigned-long
() )
;  Return the bits per pixel of the bitmap context `c', or 0 if `c' is not
;  * a bitmap context. 

(deftrap-inline "_CGBitmapContextGetBitsPerPixel" 
   ((c (:pointer :CGContext))
   )
   :unsigned-long
() )
;  Return the bytes per row of the bitmap context `c', or 0 if `c' is not a
;  * bitmap context. 

(deftrap-inline "_CGBitmapContextGetBytesPerRow" 
   ((c (:pointer :CGContext))
   )
   :unsigned-long
() )
;  Return the colorspace of the bitmap context `c', or NULL if `c' is not a
;  * bitmap context. 

(deftrap-inline "_CGBitmapContextGetColorSpace" 
   ((c (:pointer :CGContext))
   )
   (:pointer :CGColorSpace)
() )
;  Return the alpha info of the bitmap context `c', or kCGImageAlphaNone if
;  * `c' is not a bitmap context. 

(deftrap-inline "_CGBitmapContextGetAlphaInfo" 
   ((c (:pointer :CGContext))
   )
   :CGImageAlphaInfo
() )

; #endif	/* CGBITMAPCONTEXT_H_ */


(provide-interface "CGBitmapContext")