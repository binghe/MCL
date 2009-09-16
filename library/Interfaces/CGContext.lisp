(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGContext.h"
; at Sunday July 2,2006 7:23:49 pm.
;  CoreGraphics - CGContext.h
;  * Copyright (c) 2000-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGCONTEXT_H_
; #define CGCONTEXT_H_

(def-mactype :CGContextRef (find-mactype '(:pointer :CGContext)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGAffineTransform")

(require-interface "CoreGraphics/CGColor")

(require-interface "CoreGraphics/CGColorSpace")

(require-interface "CoreGraphics/CGFont")

(require-interface "CoreGraphics/CGImage")

(require-interface "CoreGraphics/CGPath")

(require-interface "CoreGraphics/CGPattern")

(require-interface "CoreGraphics/CGPDFDocument")

(require-interface "CoreGraphics/CGShading")

(require-interface "CoreFoundation/CFBase")

(require-interface "limits")

(require-interface "stddef")

(require-interface "AvailabilityMacros")
;  Line join styles. 
(def-mactype :CGLineJoin (find-mactype ':sint32))

(defconstant $kCGLineJoinMiter 0)
(defconstant $kCGLineJoinRound 1)
(defconstant $kCGLineJoinBevel 2)

;type name? (def-mactype :CGLineJoin (find-mactype ':CGLineJoin))
;  Line cap styles. 
(def-mactype :CGLineCap (find-mactype ':sint32))

(defconstant $kCGLineCapButt 0)
(defconstant $kCGLineCapRound 1)
(defconstant $kCGLineCapSquare 2)

;type name? (def-mactype :CGLineCap (find-mactype ':CGLineCap))
;  Drawing modes for paths. 
(def-mactype :CGPathDrawingMode (find-mactype ':sint32))

(defconstant $kCGPathFill 0)
(defconstant $kCGPathEOFill 1)
(defconstant $kCGPathStroke 2)
(defconstant $kCGPathFillStroke 3)
(defconstant $kCGPathEOFillStroke 4)

;type name? (def-mactype :CGPathDrawingMode (find-mactype ':CGPathDrawingMode))
;  Drawing modes for text. 
(def-mactype :CGTextDrawingMode (find-mactype ':sint32))

(defconstant $kCGTextFill 0)
(defconstant $kCGTextStroke 1)
(defconstant $kCGTextFillStroke 2)
(defconstant $kCGTextInvisible 3)
(defconstant $kCGTextFillClip 4)
(defconstant $kCGTextStrokeClip 5)
(defconstant $kCGTextFillStrokeClip 6)
(defconstant $kCGTextClip 7)

;type name? (def-mactype :CGTextDrawingMode (find-mactype ':CGTextDrawingMode))
;  Text encodings. 
(def-mactype :CGTextEncoding (find-mactype ':sint32))

(defconstant $kCGEncodingFontSpecific 0)
(defconstant $kCGEncodingMacRoman 1)

;type name? (def-mactype :CGTextEncoding (find-mactype ':CGTextEncoding))
(def-mactype :CGInterpolationQuality (find-mactype ':sint32))

(defconstant $kCGInterpolationDefault 0)        ;  Let the context decide. 

(defconstant $kCGInterpolationNone 1)           ;  Never interpolate. 

(defconstant $kCGInterpolationLow 2)            ;  Fast, low quality. 
;  Slow, high quality. 

(defconstant $kCGInterpolationHigh 3)

;type name? (def-mactype :CGInterpolationQuality (find-mactype ':CGInterpolationQuality))
;  Return the CFTypeID for CGContextRefs. 

(deftrap-inline "_CGContextGetTypeID" 
   (
   )
   :UInt32
() )
; * Graphics state functions. *
;  Push a copy of the current graphics state onto the graphics state
;  * stack. Note that the path is not considered part of the gstate, and is
;  * not saved. 

(deftrap-inline "_CGContextSaveGState" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Restore the current graphics state from the one on the top of the
;  * graphics state stack, popping the graphics state stack in the
;  * process. 

(deftrap-inline "_CGContextRestoreGState" 
   ((c (:pointer :CGContext))
   )
   nil
() )
; * Coordinate space transformations. *
;  Scale the current graphics state's transformation matrix (the CTM) by
;  * `(sx, sy)'. 

(deftrap-inline "_CGContextScaleCTM" 
   ((c (:pointer :CGContext))
    (sx :single-float)
    (sy :single-float)
   )
   nil
() )
;  Translate the current graphics state's transformation matrix (the CTM)
;  * by `(tx, ty)'. 

(deftrap-inline "_CGContextTranslateCTM" 
   ((c (:pointer :CGContext))
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Rotate the current graphics state's transformation matrix (the CTM) by
;  * `angle' radians. 

(deftrap-inline "_CGContextRotateCTM" 
   ((c (:pointer :CGContext))
    (angle :single-float)
   )
   nil
() )
;  Concatenate the current graphics state's transformation matrix (the CTM)
;  * with the affine transform `transform'. 

(deftrap-inline "_CGContextConcatCTM" 
   ((c (:pointer :CGContext))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Return the current graphics state's transformation matrix. 

(deftrap-inline "_CGContextGetCTM" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (c (:pointer :CGContext))
   )
   nil
() )
; * Drawing attribute functions. *
;  Set the line width in the current graphics state to `width'. 

(deftrap-inline "_CGContextSetLineWidth" 
   ((c (:pointer :CGContext))
    (width :single-float)
   )
   nil
() )
;  Set the line cap in the current graphics state to `cap'. 

(deftrap-inline "_CGContextSetLineCap" 
   ((c (:pointer :CGContext))
    (cap :CGLineCap)
   )
   nil
() )
;  Set the line join in the current graphics state to `join'. 

(deftrap-inline "_CGContextSetLineJoin" 
   ((c (:pointer :CGContext))
    (join :CGLineJoin)
   )
   nil
() )
;  Set the miter limit in the current graphics state to `limit'. 

(deftrap-inline "_CGContextSetMiterLimit" 
   ((c (:pointer :CGContext))
    (limit :single-float)
   )
   nil
() )
;  Set the line dash patttern in the current graphics state. 

(deftrap-inline "_CGContextSetLineDash" 
   ((c (:pointer :CGContext))
    (phase :single-float)
    (lengths (:pointer :float))
    (count :unsigned-long)
   )
   nil
() )
;  Set the path flatness parameter in the current graphics state to
;  * `flatness'. 

(deftrap-inline "_CGContextSetFlatness" 
   ((c (:pointer :CGContext))
    (flatness :single-float)
   )
   nil
() )
;  Set the alpha value in the current graphics state to `alpha'. 

(deftrap-inline "_CGContextSetAlpha" 
   ((c (:pointer :CGContext))
    (alpha :single-float)
   )
   nil
() )
; * Path construction functions. *
;  Note that a context has a single path in use at any time: a path is not
;  * part of the graphics state. 
;  Begin a new path.  The old path is discarded. 

(deftrap-inline "_CGContextBeginPath" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Start a new subpath at point `(x, y)' in the context's path. 

(deftrap-inline "_CGContextMoveToPoint" 
   ((c (:pointer :CGContext))
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a straight line segment from the current point to `(x, y)'. 

(deftrap-inline "_CGContextAddLineToPoint" 
   ((c (:pointer :CGContext))
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a cubic Bezier curve from the current point to `(x,y)', with
;  * control points `(cp1x, cp1y)' and `(cp2x, cp2y)'. 

(deftrap-inline "_CGContextAddCurveToPoint" 
   ((c (:pointer :CGContext))
    (cp1x :single-float)
    (cp1y :single-float)
    (cp2x :single-float)
    (cp2y :single-float)
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a quadratic curve from the current point to `(x, y)', with
;  * control point `(cpx, cpy)'. 

(deftrap-inline "_CGContextAddQuadCurveToPoint" 
   ((c (:pointer :CGContext))
    (cpx :single-float)
    (cpy :single-float)
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Close the current subpath of the context's path. 

(deftrap-inline "_CGContextClosePath" 
   ((c (:pointer :CGContext))
   )
   nil
() )
; * Path construction convenience functions. *
;  Add a single rect to the context's path. 

(deftrap-inline "_CGContextAddRect" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Add a set of rects to the context's path. 

(deftrap-inline "_CGContextAddRects" 
   ((c (:pointer :CGContext))
    (rects (:pointer :CGRect))
    (count :unsigned-long)
   )
   nil
() )
;  Add a set of lines to the context's path. 

(deftrap-inline "_CGContextAddLines" 
   ((c (:pointer :CGContext))
    (points (:pointer :CGPoint))
    (count :unsigned-long)
   )
   nil
() )
;  Add an arc of a circle to the context's path, possibly preceded by a
;  * straight line segment.  `(x, y)' is the center of the arc; `radius' is
;  * its radius; `startAngle' is the angle to the first endpoint of the arc;
;  * `endAngle' is the angle to the second endpoint of the arc; and
;  * `clockwise' is 1 if the arc is to be drawn clockwise, 0 otherwise.
;  * `startAngle' and `endAngle' are measured in radians. 

(deftrap-inline "_CGContextAddArc" 
   ((c (:pointer :CGContext))
    (x :single-float)
    (y :single-float)
    (radius :single-float)
    (startAngle :single-float)
    (endAngle :single-float)
    (clockwise :signed-long)
   )
   nil
() )
;  Add an arc of a circle to the context's path, possibly preceded by a
;  * straight line segment.  `radius' is the radius of the arc.  The arc is
;  * tangent to the line from the current point to `(x1, y1)', and the line
;  * from `(x1, y1)' to `(x2, y2)'. 

(deftrap-inline "_CGContextAddArcToPoint" 
   ((c (:pointer :CGContext))
    (x1 :single-float)
    (y1 :single-float)
    (x2 :single-float)
    (y2 :single-float)
    (radius :single-float)
   )
   nil
() )
;  Add `path' to the path of context.  The points in `path' are transformed
;  * by the CTM of context before they are added. 

(deftrap-inline "_CGContextAddPath" 
   ((context (:pointer :CGContext))
    (path (:pointer :CGPath))
   )
   nil
() )
; * Path information functions. *
;  Return 1 if the context's path contains no elements, 0 otherwise. 

(deftrap-inline "_CGContextIsPathEmpty" 
   ((c (:pointer :CGContext))
   )
   :signed-long
() )
;  Return the current point of the current subpath of the context's
;  * path. 

(deftrap-inline "_CGContextGetPathCurrentPoint" 
   ((returnArg (:pointer :CGPoint))
    (c (:pointer :CGContext))
   )
   nil
() )
;  Return the bounding box of the context's path.  The bounding box is the
;  * smallest rectangle completely enclosing all points in the path,
;  * including control points for Bezier and quadratic curves. 

(deftrap-inline "_CGContextGetPathBoundingBox" 
   ((returnArg (:pointer :CGRect))
    (c (:pointer :CGContext))
   )
   nil
() )
; * Path drawing functions. *
;  Draw the context's path using drawing mode `mode'. 

(deftrap-inline "_CGContextDrawPath" 
   ((c (:pointer :CGContext))
    (mode :CGPathDrawingMode)
   )
   nil
() )
; * Path drawing convenience functions. *
;  Fill the context's path using the winding-number fill rule.  Any open
;  * subpath of the path is implicitly closed. 

(deftrap-inline "_CGContextFillPath" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Fill the context's path using the even-odd fill rule.  Any open subpath
;  * of the path is implicitly closed. 

(deftrap-inline "_CGContextEOFillPath" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Stroke the context's path. 

(deftrap-inline "_CGContextStrokePath" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Fill `rect' with the current fill color. 

(deftrap-inline "_CGContextFillRect" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Fill `rects', an array of `count' CGRects, with the current fill
;  * color. 

(deftrap-inline "_CGContextFillRects" 
   ((c (:pointer :CGContext))
    (rects (:pointer :CGRect))
    (count :unsigned-long)
   )
   nil
() )
;  Stroke `rect' with the current stroke color and the current linewidth. 

(deftrap-inline "_CGContextStrokeRect" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Stroke `rect' with the current stroke color, using `width' as the the
;  * line width. 

(deftrap-inline "_CGContextStrokeRectWithWidth" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (width :single-float)
   )
   nil
() )
;  Clear `rect' (that is, set the region within the rect to
;  * transparent). 

(deftrap-inline "_CGContextClearRect" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
; * Clipping functions. *
;  Intersect the context's path with the current clip path and use the
;  * resulting path as the clip path for subsequent rendering operations.
;  * Use the winding-number fill rule for deciding what's inside the path. 

(deftrap-inline "_CGContextClip" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Intersect the context's path with the current clip path and use the
;  * resulting path as the clip path for subsequent rendering operations.
;  * Use the even-odd fill rule for deciding what's inside the path. 

(deftrap-inline "_CGContextEOClip" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Return the bounding box of the clip path of `c' in user space.  The
;  * bounding box is the smallest rectangle completely enclosing all points
;  * in the clip. 

(deftrap-inline "_CGContextGetClipBoundingBox" 
   ((returnArg (:pointer :CGRect))
    (c (:pointer :CGContext))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; * Clipping convenience functions. *
;  Intersect the current clipping path with `rect'.  Note that this
;  * function resets the context's path to the empty path. 

(deftrap-inline "_CGContextClipToRect" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Intersect the current clipping path with the clipping region formed by
;  * creating a path consisting of all rects in `rects'.  Note that this
;  * function resets the context's path to the empty path. 

(deftrap-inline "_CGContextClipToRects" 
   ((c (:pointer :CGContext))
    (rects (:pointer :CGRect))
    (count :unsigned-long)
   )
   nil
() )
; * Primitive color functions. *
;  Set the current fill color in the context `c' to `color'. 

(deftrap-inline "_CGContextSetFillColorWithColor" 
   ((c (:pointer :CGContext))
    (color (:pointer :CGColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Set the current stroke color in the context `c' to `color'. 

(deftrap-inline "_CGContextSetStrokeColorWithColor" 
   ((c (:pointer :CGContext))
    (color (:pointer :CGColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; * Colorspace functions. *
;  Set the current fill colorspace in the context `c' to `colorspace'.  As
;  * a side-effect, set the fill color to a default value appropriate for the
;  * colorspace. 

(deftrap-inline "_CGContextSetFillColorSpace" 
   ((c (:pointer :CGContext))
    (colorspace (:pointer :CGColorSpace))
   )
   nil
() )
;  Set the current stroke colorspace in the context `c' to `colorspace'.
;  * As a side-effect, set the stroke color to a default value appropriate
;  * for the colorspace. 

(deftrap-inline "_CGContextSetStrokeColorSpace" 
   ((c (:pointer :CGContext))
    (colorspace (:pointer :CGColorSpace))
   )
   nil
() )
; * Color functions. *
;  Set the components of the current fill color in the context `c' to the
;  * values specifed by `components'.  The number of elements in `components'
;  * must be one greater than the number of components in the current fill
;  * colorspace (N color components + 1 alpha component).  The current fill
;  * colorspace must not be a pattern colorspace. 

(deftrap-inline "_CGContextSetFillColor" 
   ((c (:pointer :CGContext))
    (components (:pointer :float))
   )
   nil
() )
;  Set the components of the current stroke color in the context `c' to the
;  * values specifed by `components'.  The number of elements in `components'
;  * must be one greater than the number of components in the current stroke
;  * colorspace (N color components + 1 alpha component).  The current stroke
;  * colorspace must not be a pattern colorspace. 

(deftrap-inline "_CGContextSetStrokeColor" 
   ((c (:pointer :CGContext))
    (components (:pointer :float))
   )
   nil
() )
; * Pattern functions. *
;  Set the components of the current fill color in the context `c' to the
;  * values specifed by `components', and set the current fill pattern to
;  * `pattern'.  The number of elements in `components' must be one greater
;  * than the number of components in the current fill colorspace (N color
;  * components + 1 alpha component).  The current fill colorspace must be a
;  * pattern colorspace. 

(deftrap-inline "_CGContextSetFillPattern" 
   ((c (:pointer :CGContext))
    (pattern (:pointer :CGPattern))
    (components (:pointer :float))
   )
   nil
() )
;  Set the components of the current stroke color in the context `c' to the
;  * values specifed by `components', and set the current stroke pattern to
;  * `pattern'.  The number of elements in `components' must be one greater
;  * than the number of components in the current stroke colorspace (N color
;  * components + 1 alpha component).  The current stroke colorspace must be
;  * a pattern colorspace. 

(deftrap-inline "_CGContextSetStrokePattern" 
   ((c (:pointer :CGContext))
    (pattern (:pointer :CGPattern))
    (components (:pointer :float))
   )
   nil
() )
;  Set the pattern phase of context `c' to `phase'. 

(deftrap-inline "_CGContextSetPatternPhase" 
   ((c (:pointer :CGContext))
    (width :single-float)
    (height :single-float)
   )
   nil
() )
; * Color convenience functions. *
;  Set the current fill colorspace in the context `c' to `DeviceGray' and
;  * set the components of the current fill color to `(gray, alpha)'. 

(deftrap-inline "_CGContextSetGrayFillColor" 
   ((c (:pointer :CGContext))
    (gray :single-float)
    (alpha :single-float)
   )
   nil
() )
;  Set the current stroke colorspace in the context `c' to `DeviceGray' and
;  * set the components of the current stroke color to `(gray, alpha)'. 

(deftrap-inline "_CGContextSetGrayStrokeColor" 
   ((c (:pointer :CGContext))
    (gray :single-float)
    (alpha :single-float)
   )
   nil
() )
;  Set the current fill colorspace in the context `c' to `DeviceRGB' and
;  * set the components of the current fill color to `(red, green, blue,
;  * alpha)'. 

(deftrap-inline "_CGContextSetRGBFillColor" 
   ((c (:pointer :CGContext))
    (red :single-float)
    (green :single-float)
    (blue :single-float)
    (alpha :single-float)
   )
   nil
() )
;  Set the current stroke colorspace in the context `c' to `DeviceRGB' and
;  * set the components of the current stroke color to `(red, green, blue,
;  * alpha)'. 

(deftrap-inline "_CGContextSetRGBStrokeColor" 
   ((c (:pointer :CGContext))
    (red :single-float)
    (green :single-float)
    (blue :single-float)
    (alpha :single-float)
   )
   nil
() )
;  Set the current fill colorspace in the context `c' to `DeviceCMYK' and
;  * set the components of the current fill color to `(cyan, magenta, yellow,
;  * black, alpha)'. 

(deftrap-inline "_CGContextSetCMYKFillColor" 
   ((c (:pointer :CGContext))
    (cyan :single-float)
    (magenta :single-float)
    (yellow :single-float)
    (black :single-float)
    (alpha :single-float)
   )
   nil
() )
;  Set the current stroke colorspace in the context `c' to `DeviceCMYK' and
;  * set the components of the current stroke color to `(cyan, magenta,
;  * yellow, black, alpha)'. 

(deftrap-inline "_CGContextSetCMYKStrokeColor" 
   ((c (:pointer :CGContext))
    (cyan :single-float)
    (magenta :single-float)
    (yellow :single-float)
    (black :single-float)
    (alpha :single-float)
   )
   nil
() )
; * Rendering intent. *
;  Set the current rendering intent in the context `c' to `intent'. 

(deftrap-inline "_CGContextSetRenderingIntent" 
   ((c (:pointer :CGContext))
    (intent :CGColorRenderingIntent)
   )
   nil
() )
; * Image functions. *
;  Draw `image' in the rectangular area specified by `rect' in the context
;  * `c'.  The image is scaled, if necessary, to fit into `rect'. 

(deftrap-inline "_CGContextDrawImage" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (image (:pointer :CGImage))
   )
   nil
() )
;  Return the interpolation quality for image rendering of the context `c'.
;  * The interpolation quality is a gstate-parameter which controls the level
;  * of interpolation performed when an image is interpolated (for example,
;  * when scaling the image). Note that it is merely a hint to the context:
;  * not all contexts support all interpolation quality levels. 

(deftrap-inline "_CGContextGetInterpolationQuality" 
   ((c (:pointer :CGContext))
   )
   :CGInterpolationQuality
() )
;  Set the interpolation quality of the context `c' to `quality'. 

(deftrap-inline "_CGContextSetInterpolationQuality" 
   ((c (:pointer :CGContext))
    (quality :CGInterpolationQuality)
   )
   nil
() )
; * Shadow support. *
;  Set the shadow parameters in `context'.  `offset' specifies a
;  * translation in base-space; `blur' is a non-negative number specifying
;  * the amount of blur; `color' specifies the color of the shadow, which may
;  * contain a non-opaque alpha value.  If `color' is NULL, it's equivalent
;  * to specifying a fully transparent color.  The shadow is a gstate
;  * parameter. After a shadow is specified, all objects drawn subsequently
;  * will be shadowed.  To turn off shadowing, set the shadow color to a
;  * fully transparent color (or pass NULL as the color), or use the standard
;  * gsave/grestore mechanism. 

(deftrap-inline "_CGContextSetShadowWithColor" 
   ((context (:pointer :CGContext))
    (width :single-float)
    (height :single-float)
    (blur :single-float)
    (color (:pointer :CGColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Equivalent to calling
;  *   CGContextSetShadowWithColor(context, offset, blur, color)
;  * where color is black with 1/3 alpha (i.e., RGBA = {0, 0, 0, 1.0/3.0}) in
;  * the DeviceRGB colorspace. 

(deftrap-inline "_CGContextSetShadow" 
   ((context (:pointer :CGContext))
    (width :single-float)
    (height :single-float)
    (blur :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; * Shading functions. *
;  Fill the current clipping region of `c' with `shading'. 

(deftrap-inline "_CGContextDrawShading" 
   ((c (:pointer :CGContext))
    (shading (:pointer :CGShading))
   )
   nil
() )
; * Text functions. *
;  Set the current character spacing in the context `c' to `spacing'.  The
;  * character spacing is added to the displacement between the origin of one
;  * character and the origin of the next. 

(deftrap-inline "_CGContextSetCharacterSpacing" 
   ((c (:pointer :CGContext))
    (spacing :single-float)
   )
   nil
() )
;  Set the user-space point at which text will be drawn in the context `c'
;  * to `(x, y)'. 

(deftrap-inline "_CGContextSetTextPosition" 
   ((c (:pointer :CGContext))
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Return the user-space point at which text will be drawn in the context
;  * `c'. 

(deftrap-inline "_CGContextGetTextPosition" 
   ((returnArg (:pointer :CGPoint))
    (c (:pointer :CGContext))
   )
   nil
() )
;  Set the text matrix in the context `c' to `t'. 

(deftrap-inline "_CGContextSetTextMatrix" 
   ((c (:pointer :CGContext))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Return the text matrix in the context `c'. 

(deftrap-inline "_CGContextGetTextMatrix" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (c (:pointer :CGContext))
   )
   nil
() )
;  Set the current text drawing mode in the context `c' to `mode'. 

(deftrap-inline "_CGContextSetTextDrawingMode" 
   ((c (:pointer :CGContext))
    (mode :CGTextDrawingMode)
   )
   nil
() )
;  Set the current font in the context `c' to `font'. 

(deftrap-inline "_CGContextSetFont" 
   ((c (:pointer :CGContext))
    (font (:pointer :CGFont))
   )
   nil
() )
;  Set the current font size in the context `c' to `size'. 

(deftrap-inline "_CGContextSetFontSize" 
   ((c (:pointer :CGContext))
    (size :single-float)
   )
   nil
() )
;  Attempts to find the font named `name' for the context `c'.  If
;  * successful, scales it to `size' units in text space.  `textEncoding'
;  * specifies how to translate from bytes to glyphs. 

(deftrap-inline "_CGContextSelectFont" 
   ((c (:pointer :CGContext))
    (name (:pointer :char))
    (size :single-float)
    (textEncoding :CGTextEncoding)
   )
   nil
() )
;  Draw `string', a string of `length' bytes, at the point specified by the
;  * text matrix in the context `c'.  Each byte of the string is mapped
;  * through the encoding vector of the current font to obtain the glyph to
;  * display. 

(deftrap-inline "_CGContextShowText" 
   ((c (:pointer :CGContext))
    (string (:pointer :char))
    (length :unsigned-long)
   )
   nil
() )
;  Draw the glyphs pointed to by `g', an array of `count' glyphs, at the
;  * point specified by the text matrix in the context `c'. 

(deftrap-inline "_CGContextShowGlyphs" 
   ((c (:pointer :CGContext))
    (g (:pointer :CGGLYPH))
    (count :unsigned-long)
   )
   nil
() )
;  Draw `glyphs', an array of `count' CGGlyphs, at the current point
;  * specified by the text matrix.  Each element of `advances' specifies the
;  * offset from the previous glyph's origin to the origin of the associated
;  * glyph; the advances are specified in user space. 

(deftrap-inline "_CGContextShowGlyphsWithAdvances" 
   ((c (:pointer :CGContext))
    (glyphs (:pointer :CGGLYPH))
    (advances (:pointer :CGSize))
    (count :unsigned-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; * Text convenience functions. *
;  Draw `string', a string of `length' bytes, at the point `(x, y)',
;  * specified in user space, in the context `c'.  Each byte of the string is
;  * mapped through the encoding vector of the current font to obtain the
;  * glyph to display. 

(deftrap-inline "_CGContextShowTextAtPoint" 
   ((c (:pointer :CGContext))
    (x :single-float)
    (y :single-float)
    (string (:pointer :char))
    (length :unsigned-long)
   )
   nil
() )
;  Display the glyphs pointed to by `glyphs', an array of `count' glyphs,
;  * at at the point `(x, y)', specified in user space, in the context
;  * `c'. 

(deftrap-inline "_CGContextShowGlyphsAtPoint" 
   ((c (:pointer :CGContext))
    (x :single-float)
    (y :single-float)
    (glyphs (:pointer :CGGLYPH))
    (count :unsigned-long)
   )
   nil
() )
; * PDF functions. *
;  Draw `page' in the current user space of the context `c'. 

(deftrap-inline "_CGContextDrawPDFPage" 
   ((c (:pointer :CGContext))
    (page (:pointer :CGPDFPage))
   )
   nil
() )
;  DEPRECATED; use the CGPDFPage API instead.
;  * Draw `page' in `document' in the rectangular area specified by `rect' in
;  * the context `c'.  The media box of the page is scaled, if necessary, to
;  * fit into `rect'. 

(deftrap-inline "_CGContextDrawPDFDocument" 
   ((c (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   nil
() )
; * Output page functions. *
;  Begin a new page. 

(deftrap-inline "_CGContextBeginPage" 
   ((c (:pointer :CGContext))
    (mediaBox (:pointer :CGRect))
   )
   nil
() )
;  End the current page. 

(deftrap-inline "_CGContextEndPage" 
   ((c (:pointer :CGContext))
   )
   nil
() )
; * Context functions. *
;  Equivalent to `CFRetain(c)'. 

(deftrap-inline "_CGContextRetain" 
   ((c (:pointer :CGContext))
   )
   (:pointer :CGContext)
() )
;  Equivalent to `CFRelease(c)'. 

(deftrap-inline "_CGContextRelease" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Flush all drawing to the destination. 

(deftrap-inline "_CGContextFlush" 
   ((c (:pointer :CGContext))
   )
   nil
() )
;  Synchronized drawing. 

(deftrap-inline "_CGContextSynchronize" 
   ((c (:pointer :CGContext))
   )
   nil
() )
; * Antialiasing functions. *
;  Turn on antialiasing if `shouldAntialias' is true; turn it off
;  * otherwise.  This parameter is part of the graphics state. 

(deftrap-inline "_CGContextSetShouldAntialias" 
   ((c (:pointer :CGContext))
    (shouldAntialias :Boolean)
   )
   nil
() )
; * Font smoothing functions. *
;  Turn on font smoothing if `shouldSmoothFonts' is true; turn it off
;  * otherwise.  This parameter is part of the graphics state. Note that this
;  * doesn't guarantee that font smoothing will occur: not all destination
;  * contexts support font smoothing. 

(deftrap-inline "_CGContextSetShouldSmoothFonts" 
   ((c (:pointer :CGContext))
    (shouldSmoothFonts :Boolean)
   )
   nil
() )
; * Transparency layer support. *
;  Begin a transparency layer.  All subsequent drawing operations until a
;  * corresponding CGContextEndTransparencyLayer are composited into a fully
;  * transparent backdrop (which is treated as a separate destination buffer
;  * from the context); after a call to CGContextEndTransparencyLayer, the
;  * result is composited into the context using the global alpha and shadow
;  * state of the context.  This operation respects the clipping region of
;  * the context.  After a call to this function, all of the parameters in
;  * the graphics state remain unchanged with the exception of the following:
;  *   The global alpha is set to 1.
;  *   The shadow is turned off.
;  * Ending the transparency layer restores these parameters to the values
;  * they had before CGContextBeginTransparencyLayer was called.
;  * Transparency layers may be nested. 

(deftrap-inline "_CGContextBeginTransparencyLayer" 
   ((context (:pointer :CGContext))
    (auxiliaryInfo (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  End a tranparency layer. 

(deftrap-inline "_CGContextEndTransparencyLayer" 
   ((context (:pointer :CGContext))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

; #endif	/* CGCONTEXT_H_ */


(provide-interface "CGContext")