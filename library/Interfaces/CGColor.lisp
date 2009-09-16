(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGColor.h"
; at Sunday July 2,2006 7:23:49 pm.
;  CoreGraphics - CGColor.h
;  * Copyright (c) 2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGCOLOR_H_
; #define CGCOLOR_H_

(def-mactype :CGColorRef (find-mactype '(:pointer :CGColor)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGColorSpace")

(require-interface "CoreGraphics/CGPattern")

(require-interface "AvailabilityMacros")
;  Return the CFTypeID for CGColors. 

(deftrap-inline "_CGColorGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
;  Create a color in colorspace `colorspace' with color components
;  * (including alpha) specified by `components'.  `colorspace' may be any
;  * colorspace expect a pattern colorspace. 

(deftrap-inline "_CGColorCreate" 
   ((colorspace (:pointer :CGColorSpace))
    (components (:pointer :float))
   )
   (:pointer :CGColor)
() )
;  Create a color in colorspace `colorspace' with pattern `pattern' and
;  * components `components'.  `colorspace' must be a pattern colorspace. 

(deftrap-inline "_CGColorCreateWithPattern" 
   ((colorspace (:pointer :CGColorSpace))
    (pattern (:pointer :CGPattern))
    (components (:pointer :float))
   )
   (:pointer :CGColor)
() )
;  Create a copy of `color'. 

(deftrap-inline "_CGColorCreateCopy" 
   ((color (:pointer :CGColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGColor)
() )
;  Create a copy of `color' with alpha set to `alpha'. 

(deftrap-inline "_CGColorCreateCopyWithAlpha" 
   ((color (:pointer :CGColor))
    (alpha :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGColor)
() )
;  Equivalent to `CFRetain(color)', except it doesn't crash (as CFRetain
;  * does) if `color' is NULL. 

(deftrap-inline "_CGColorRetain" 
   ((color (:pointer :CGColor))
   )
   (:pointer :CGColor)
() )
;  Equivalent to `CFRelease(color)', except it doesn't crash (as CFRelease
;  * does) if `color' is NULL. 

(deftrap-inline "_CGColorRelease" 
   ((color (:pointer :CGColor))
   )
   nil
() )
;  Return true if `color1' is equal to `color2'; false otherwise. 

(deftrap-inline "_CGColorEqualToColor" 
   ((color1 (:pointer :CGColor))
    (color2 (:pointer :CGColor))
   )
   :Boolean
() )
;  Return the number of color components (including alpha) associated with
;  * `color'. 

(deftrap-inline "_CGColorGetNumberOfComponents" 
   ((color (:pointer :CGColor))
   )
   :unsigned-long
() )
;  Return the color components (including alpha) associated with
;  * `color'. 

(deftrap-inline "_CGColorGetComponents" 
   ((color (:pointer :CGColor))
   )
   (:pointer :single-float)
() )
;  Return the alpha component associated with `color'. 

(deftrap-inline "_CGColorGetAlpha" 
   ((color (:pointer :CGColor))
   )
   :single-float
() )
;  Return the colorspace associated with `color'. 

(deftrap-inline "_CGColorGetColorSpace" 
   ((color (:pointer :CGColor))
   )
   (:pointer :CGColorSpace)
() )
;  Return the pattern associated with `color', if it's a color in a pattern
;  * colorspace; NULL otherwise. 

(deftrap-inline "_CGColorGetPattern" 
   ((color (:pointer :CGColor))
   )
   (:pointer :CGPattern)
() )

; #endif	/* CGCOLOR_H_ */


(provide-interface "CGColor")