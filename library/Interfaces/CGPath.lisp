(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPath.h"
; at Sunday July 2,2006 7:23:53 pm.
;  CoreGraphics - CGPath.h
;  * Copyright (c) 2001-2002 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPATH_H_
; #define CGPATH_H_

(def-mactype :CGMutablePathRef (find-mactype '(:pointer :CGPath)))

(def-mactype :CGPathRef (find-mactype '(:pointer :CGPath)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGAffineTransform")

(require-interface "CoreFoundation/CFBase")
;  Return the CFTypeID for CGPathRefs. 

(deftrap-inline "_CGPathGetTypeID" 
   (
   )
   :UInt32
() )
;  Create a mutable path. 

(deftrap-inline "_CGPathCreateMutable" 
   (
   )
   (:pointer :CGPath)
() )
;  Create a copy of `path'. 

(deftrap-inline "_CGPathCreateCopy" 
   ((path (:pointer :CGPath))
   )
   (:pointer :CGPath)
() )
;  Create a mutable copy of `path'. 

(deftrap-inline "_CGPathCreateMutableCopy" 
   ((path (:pointer :CGPath))
   )
   (:pointer :CGPath)
() )
;  Equivalent to `CFRetain(path)', except it doesn't crash (as CFRetain
;  * does) if `path' is NULL. 

(deftrap-inline "_CGPathRetain" 
   ((path (:pointer :CGPath))
   )
   (:pointer :CGPath)
() )
;  Equivalent to `CFRelease(path)', except it doesn't crash (as CFRelease
;  * does) if `path' is NULL. 

(deftrap-inline "_CGPathRelease" 
   ((path (:pointer :CGPath))
   )
   nil
() )
;  Return true if `path1' is equal to `path2'; false otherwise. 

(deftrap-inline "_CGPathEqualToPath" 
   ((path1 (:pointer :CGPath))
    (path2 (:pointer :CGPath))
   )
   :Boolean
() )
; ** Path construction functions. **
;  Move the current point to `(x, y)' in `path' and begin a new subpath.
;  * If `m' is non-NULL, then transform `(x, y)' by `m' first. 

(deftrap-inline "_CGPathMoveToPoint" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a straight line segment from the current point to `(x, y)' in
;  * `path' and move the current point to `(x, y)'.  If `m' is non-NULL, then
;  * transform `(x, y)' by `m' first. 

(deftrap-inline "_CGPathAddLineToPoint" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a quadratic curve from the current point to `(x, y)' with control
;  * point `(cpx, cpy)' in `path' and move the current point to `(x, y)'.  If
;  * `m' is non-NULL, then transform all points by `m' first. 

(deftrap-inline "_CGPathAddQuadCurveToPoint" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (cpx :single-float)
    (cpy :single-float)
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a cubic Bezier curve from the current point to `(x,y)' with
;  * control points `(cp1x, cp1y)' and `(cp2x, cp2y)' in `path' and move the
;  * current point to `(x, y)'. If `m' is non-NULL, then transform all points
;  * by `m' first. 

(deftrap-inline "_CGPathAddCurveToPoint" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (cp1x :single-float)
    (cp1y :single-float)
    (cp2x :single-float)
    (cp2y :single-float)
    (x :single-float)
    (y :single-float)
   )
   nil
() )
;  Append a line from the current point to the starting point of the
;  * current subpath of `path' and end the subpath. 

(deftrap-inline "_CGPathCloseSubpath" 
   ((path (:pointer :CGPath))
   )
   nil
() )
; ** Path construction convenience functions. **
;  Add `rect' to `path'. If `m' is non-NULL, then first transform `rect' by
;  * `m' before adding it to `path'. 

(deftrap-inline "_CGPathAddRect" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Add each rectangle specified by `rects', an array of `count' CGRects, to
;  * `path'. If `m' is non-NULL, then first transform each rectangle by `m'
;  * before adding it to `path'. 

(deftrap-inline "_CGPathAddRects" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (rects (:pointer :CGRect))
    (count :unsigned-long)
   )
   nil
() )
;  Move to the first element of `points', an array of `count' CGPoints, and
;  * append a line from each point to the next point in `points'.  If `m' is
;  * non-NULL, then first transform each point by `m'. 

(deftrap-inline "_CGPathAddLines" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (points (:pointer :CGPoint))
    (count :unsigned-long)
   )
   nil
() )
;  Add an arc of a circle to `path', possibly preceded by a straight line
;  * segment. The arc is approximated by a sequence of cubic Bezier
;  * curves. `(x, y)' is the center of the arc; `radius' is its radius;
;  * `startAngle' is the angle to the first endpoint of the arc; `endAngle'
;  * is the angle to the second endpoint of the arc; and `clockwise' is true
;  * if the arc is to be drawn clockwise, false otherwise.  `startAngle' and
;  * `endAngle' are measured in radians.  If `m' is non-NULL, then the
;  * constructed Bezier curves representing the arc will be transformed by
;  * `m' before they are added to `path'. 

(deftrap-inline "_CGPathAddArc" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (x :single-float)
    (y :single-float)
    (radius :single-float)
    (startAngle :single-float)
    (endAngle :single-float)
    (clockwise :Boolean)
   )
   nil
() )
;  Add an arc of a circle to `path', possibly preceded by a straight line
;  * segment.  The arc is approximated by a sequence of cubic Bezier curves.
;  * `radius' is the radius of the arc.  The resulting arc is tangent to the
;  * line from the current point of `path' to `(x1, y1)', and the line from
;  * `(x1, y1)' to `(x2, y2)'.  If `m' is non-NULL, then the constructed
;  * Bezier curves representing the arc will be transformed by `m' before
;  * they are added to `path'. 

(deftrap-inline "_CGPathAddArcToPoint" 
   ((path (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (x1 :single-float)
    (y1 :single-float)
    (x2 :single-float)
    (y2 :single-float)
    (radius :single-float)
   )
   nil
() )
;  Add `path2' to `path1'. If `m' is non-NULL, then the points in `path2'
; * will be transformed by `m' before they are added to `path1'.

(deftrap-inline "_CGPathAddPath" 
   ((path1 (:pointer :CGPath))
    (m (:pointer :CGAFFINETRANSFORM))
    (path2 (:pointer :CGPath))
   )
   nil
() )
; ** Path information functions. **
;  Return true if `path' contains no elements, false otherwise. 

(deftrap-inline "_CGPathIsEmpty" 
   ((path (:pointer :CGPath))
   )
   :Boolean
() )
;  Return true if `path' represents a rectangle, false otherwise. 

(deftrap-inline "_CGPathIsRect" 
   ((path (:pointer :CGPath))
    (rect (:pointer :CGRect))
   )
   :Boolean
() )
;  Return the current point of the current subpath of `path'.  If there is
;  * no current point, then return CGPointZero. 

(deftrap-inline "_CGPathGetCurrentPoint" 
   ((returnArg (:pointer :CGPoint))
    (path (:pointer :CGPath))
   )
   nil
() )
;  Return the bounding box of `path'.  The bounding box is the smallest
;  * rectangle completely enclosing all points in the path, including control
;  * points for Bezier and quadratic curves. If the path is empty, then
;  * return CGRectNull. 

(deftrap-inline "_CGPathGetBoundingBox" 
   ((returnArg (:pointer :CGRect))
    (path (:pointer :CGPath))
   )
   nil
() )
(def-mactype :CGPathElementType (find-mactype ':sint32))

(defconstant $kCGPathElementMoveToPoint 0)
(defconstant $kCGPathElementAddLineToPoint 1)
(defconstant $kCGPathElementAddQuadCurveToPoint 2)
(defconstant $kCGPathElementAddCurveToPoint 3)
(defconstant $kCGPathElementCloseSubpath 4)

;type name? (def-mactype :CGPathElementType (find-mactype ':CGPathElementType))
(defrecord CGPathElement
   (type :CGPathElementType)
#|
; Warning: type-size: unknown type CGPATHELEMENTTYPE
|#
   (points (:pointer :CGPoint))
)

;type name? (%define-record :CGPathElement (find-record-descriptor ':CGPathElement))

(def-mactype :CGPathApplierFunction (find-mactype ':pointer)); (void * info , const CGPathElement * element)

(deftrap-inline "_CGPathApply" 
   ((path (:pointer :CGPath))
    (info :pointer)
    (function :pointer)
   )
   nil
() )

; #endif	/* CGPATH_H_ */


(provide-interface "CGPath")