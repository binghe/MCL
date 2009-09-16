(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGColorSpace.h"
; at Sunday July 2,2006 7:23:50 pm.
;  CoreGraphics - CGColorSpace.h
;  * Copyright (c) 1999-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGCOLORSPACE_H_
; #define CGCOLORSPACE_H_

(def-mactype :CGColorSpaceRef (find-mactype '(:pointer :CGColorSpace)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGDataProvider")

(require-interface "stddef")
(def-mactype :CGColorRenderingIntent (find-mactype ':sint32))

(defconstant $kCGRenderingIntentDefault 0)
(defconstant $kCGRenderingIntentAbsoluteColorimetric 1)
(defconstant $kCGRenderingIntentRelativeColorimetric 2)
(defconstant $kCGRenderingIntentPerceptual 3)
(defconstant $kCGRenderingIntentSaturation 4)

;type name? (def-mactype :CGColorRenderingIntent (find-mactype ':CGColorRenderingIntent))
; #define kCGColorSpaceUserGray CFSTR("kCGColorSpaceUserGray")
; #define kCGColorSpaceUserRGB  CFSTR("kCGColorSpaceUserRGB")
; #define kCGColorSpaceUserCMYK CFSTR("kCGColorSpaceUserCMYK")
;  Return the CFTypeID for CGColorSpaces. 

(deftrap-inline "_CGColorSpaceGetTypeID" 
   (
   )
   :UInt32
() )
; * Device-dependent color spaces.  *
;  Create a DeviceGray colorspace. 

(deftrap-inline "_CGColorSpaceCreateDeviceGray" 
   (
   )
   (:pointer :CGColorSpace)
() )
;  Create a DeviceRGB colorspace. 

(deftrap-inline "_CGColorSpaceCreateDeviceRGB" 
   (
   )
   (:pointer :CGColorSpace)
() )
;  Create a DeviceCMYK colorspace. 

(deftrap-inline "_CGColorSpaceCreateDeviceCMYK" 
   (
   )
   (:pointer :CGColorSpace)
() )
; * Device-independent color spaces. *
;  Create a calibrated gray colorspace.  `whitePoint' is an array of 3
;  * numbers specifying the tristimulus value, in the CIE 1931 XYZ-space, of
;  * the diffuse white point.  `blackPoint' is an array of 3 numbers
;  * specifying the tristimulus value, in CIE 1931 XYZ-space, of the diffuse
;  * black point. `gamma' defines the gamma for the gray component. 

(deftrap-inline "_CGColorSpaceCreateCalibratedGray" 
   ((whitePoint (:pointer :float))
    (blackPoint (:pointer :float))
    (gamma :single-float)
   )
   (:pointer :CGColorSpace)
() )
;  Create a calibrated RGB colorspace.  `whitePoint' is an array of 3
;  * numbers specifying the tristimulus value, in the CIE 1931 XYZ-space, of
;  * the diffuse white point.  `blackPoint' is an array of 3 numbers
;  * specifying the tristimulus value, in CIE 1931 XYZ-space, of the diffuse
;  * black point. `gamma' is an array of 3 numbers specifying the gamma for
;  * the red, green, and blue components of the color space. `matrix' is an
;  * array of 9 numbers specifying the linear interpretation of the
;  * gamma-modified RGB values of the colorspace with respect to the final
;  * XYZ representation. 

(deftrap-inline "_CGColorSpaceCreateCalibratedRGB" 
   ((whitePoint (:pointer :float))
    (blackPoint (:pointer :float))
    (gamma (:pointer :float))
    (matrix (:pointer :float))
   )
   (:pointer :CGColorSpace)
() )
;  Create an L*a*b* colorspace.  `whitePoint' is an array of 3 numbers
;  * specifying the tristimulus value, in the CIE 1931 XYZ-space, of the
;  * diffuse white point.  `blackPoint' is an array of 3 numbers specifying
;  * the tristimulus value, in CIE 1931 XYZ-space, of the diffuse black
;  * point. `range' is an array of four numbers specifying the range of valid
;  * values for the a* and b* components of the color space. 

(deftrap-inline "_CGColorSpaceCreateLab" 
   ((whitePoint (:pointer :float))
    (blackPoint (:pointer :float))
    (range (:pointer :float))
   )
   (:pointer :CGColorSpace)
() )
;  Create an ICC-based colorspace.  `nComponents' specifies the number of
;  * color components in the color space defined by the ICC profile data.
;  * This must match the number of components actually in the ICC profile,
;  * and must be 1, 3, or 4.  `range' is an array of 2*nComponents numbers
;  * specifying the minimum and maximum valid values of the corresponding
;  * color components, so that for color component k, range[2*k] <= c[k] <=
;  * range[2*k+1], where c[k] is the k'th color component.  `profile' is a
;  * data provider specifying the ICC profile.  `alternate' specifies an
;  * alternate colorspace to be used in case the ICC profile is not
;  * supported.  It must have `nComponents' color components. If `alternate'
;  * is NULL, then the color space used will be DeviceGray, DeviceRGB, or
;  * DeviceCMYK, depending on whether `nComponents' is 1, 3, or 4,
;  * respectively. 

(deftrap-inline "_CGColorSpaceCreateICCBased" 
   ((nComponents :unsigned-long)
    (range (:pointer :float))
    (profile (:pointer :CGDataProvider))
    (alternate (:pointer :CGColorSpace))
   )
   (:pointer :CGColorSpace)
() )
; * Special colorspaces. *
;  Create an indexed colorspace.  A sample value in an indexed color space
;  * is treated as an index into the color table of the color space.  `base'
;  * specifies the base color space in which the values in the color table
;  * are to be interpreted. `lastIndex' is an integer which specifies the
;  * maximum valid index value; it must be less than or equal to 255.
;  * `colorTable' is an array of m * (lastIndex + 1) bytes, where m is
;  * the number of color components in the base color space.  Each byte
;  * is an unsigned integer in the range 0 to 255 that is scaled to the
;  * range of the corresponding color component in the base color space. 

(deftrap-inline "_CGColorSpaceCreateIndexed" 
   ((baseSpace (:pointer :CGColorSpace))
    (lastIndex :unsigned-long)
    (colorTable (:pointer :UInt8))
   )
   (:pointer :CGColorSpace)
() )
;  Create a pattern colorspace. `baseSpace' is the underlying colorspace of
;  * the pattern colorspace.  For colored patterns, `baseSpace' should be
;  * NULL; for uncolored patterns, `baseSpace' specifies the colorspace of
;  * colors which will be painted through the pattern. 

(deftrap-inline "_CGColorSpaceCreatePattern" 
   ((baseSpace (:pointer :CGColorSpace))
   )
   (:pointer :CGColorSpace)
() )
;  Create a CGColorSpace using `platformColorSpaceReference', a
;  * platform-specific color space reference. For MacOS X,
;  * `platformColorSpaceReference' should be a CMProfileRef. 

(deftrap-inline "_CGColorSpaceCreateWithPlatformColorSpace" 
   ((platformColorSpaceReference :pointer)
   )
   (:pointer :CGColorSpace)
() )
;  Create a colorspace using `name' as the identifier for the colorspace. 

(deftrap-inline "_CGColorSpaceCreateWithName" 
   ((name (:pointer :__CFString))
   )
   (:pointer :CGColorSpace)
() )
; * Colorspace information. *
;  Return the number of color components in the colorspace `cs'. 

(deftrap-inline "_CGColorSpaceGetNumberOfComponents" 
   ((cs (:pointer :CGColorSpace))
   )
   :unsigned-long
() )
; * Retaining & releasing colorspaces. *
;  Equivalent to `CFRetain(cs)'. 

(deftrap-inline "_CGColorSpaceRetain" 
   ((cs (:pointer :CGColorSpace))
   )
   (:pointer :CGColorSpace)
() )
;  Equivalent to `CFRelease(cs)'. 

(deftrap-inline "_CGColorSpaceRelease" 
   ((cs (:pointer :CGColorSpace))
   )
   nil
() )

; #endif	/* CGCOLORSPACE_H_ */


(provide-interface "CGColorSpace")