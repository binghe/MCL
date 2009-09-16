(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGShading.h"
; at Sunday July 2,2006 7:23:56 pm.
;  CoreGraphics - CGShading.h
;  * Copyright (c) 2001-2002 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGSHADING_H_
; #define CGSHADING_H_

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGColorSpace")

(require-interface "CoreGraphics/CGFunction")

(require-interface "CoreGraphics/CGGeometry")

(require-interface "CoreFoundation/CFBase")

(def-mactype :CGShadingRef (find-mactype '(:pointer :CGShading)))
; ! @function CGShadingGetTypeID
;  *   Return the CFTypeID for CGShadingRefs.
;  

(deftrap-inline "_CGShadingGetTypeID" 
   (
   )
   :UInt32
() )
; ! @function CGShadingCreateAxial
;  *
;  * Create a shading defining a color blend which varies along a linear axis
;  * between two endpoints and extends indefinitely perpendicular to that
;  * axis. The shading may optionally extend beyond either endpoint by
;  * continuing the boundary colors indefinitely.
;  *
;  * @param colorspace
;  *   The colorspace in which color values are expressed.
;  * @param start
;  *   The starting point of the axis, in the shading's target coordinate space.
;  * @param end
;  *   The ending point of the axis, in the shading's target coordinate space.
;  * @param function
;  *   A 1-in, N-out function, where N is one more (for alpha) than the
;  *   number of color components in the shading's colorspace.  The input
;  *   value 0 corresponds to the color at the starting point of the shading;
;  *   the input value 1 corresponds to the color at the ending point of the
;  *   shading.
;  * @param extendStart
;  *   A boolean specifying whether to extend the shading beyond the starting
;  *   point of the axis.
;  * @param extendEnd
;  *   A boolean specifying whether to extend the shading beyond the ending
;  *   point of the axis.
;  

(deftrap-inline "_CGShadingCreateAxial" 
   ((colorspace (:pointer :CGColorSpace))
    (x :single-float)
    (y :single-float)
    (x :single-float)
    (y :single-float)
    (function (:pointer :CGFunction))
    (extendStart :Boolean)
    (extendEnd :Boolean)
   )
   (:pointer :CGShading)
() )
; ! @function CGShadingCreateRadial
;  *
;  * Create a shading defining a color blend which varies between two
;  * circles.  The shading may optionally extend beyond either circle by
;  * continuing the boundary colors.
;  *
;  * @param colorspace
;  *   The colorspace in which color values are expressed.
;  * @param start
;  *   The center of the starting circle, in the shading's target coordinate
;  *   space.
;  * @param startRadius
;  *   The radius of the starting circle, in the shading's target coordinate
;  *   space.
;  * @param end
;  *   The center of the ending circle, in the shading's target coordinate
;  *   space.
;  * @param endRadius
;  *   The radius of the ending circle, in the shading's target coordinate
;  *   space.
;  * @param function
;  *   A 1-in, N-out function, where N is one more (for alpha) than the
;  *   number of color components in the shading's colorspace.  The input
;  *   value 0 corresponds to the color of the starting circle; the input
;  *   value 1 corresponds to the color of the ending circle.
;  * @param extendStart
;  *   A boolean specifying whether to extend the shading beyond the starting
;  *   circle.
;  * @param extendEnd
;  *   A boolean specifying whether to extend the shading beyond the ending
;  *   circle.
;  

(deftrap-inline "_CGShadingCreateRadial" 
   ((colorspace (:pointer :CGColorSpace))
    (x :single-float)
    (y :single-float)
    (startRadius :single-float)
    (x :single-float)
    (y :single-float)
    (endRadius :single-float)
    (function (:pointer :CGFunction))
    (extendStart :Boolean)
    (extendEnd :Boolean)
   )
   (:pointer :CGShading)
() )
; ! @function CGShadingRetain
;  *
;  * Equivalent to <tt>CFRetain(shading)</tt>.
;  

(deftrap-inline "_CGShadingRetain" 
   ((shading (:pointer :CGShading))
   )
   (:pointer :CGShading)
() )
; ! @function CGShadingRelease
;  *
;  * Equivalent to <tt>CFRelease(shading)</tt>.
;  

(deftrap-inline "_CGShadingRelease" 
   ((shading (:pointer :CGShading))
   )
   nil
() )

; #endif	/* CGSHADING_H_ */


(provide-interface "CGShading")