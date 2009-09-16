(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGGeometry.h"
; at Sunday July 2,2006 7:23:48 pm.
;  CoreGraphics - CGGeometry.h
;  * Copyright (c) 1998-2000 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGGEOMETRY_H_
; #define CGGEOMETRY_H_

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreFoundation/CFByteOrder")
;  Points. 
(defrecord CGPoint
   (x :single-float)
   (y :single-float)
)

;type name? (%define-record :CGPoint (find-record-descriptor ':CGPoint))
;  Sizes. 
(defrecord CGSize
   (width :single-float)
   (height :single-float)
)

;type name? (%define-record :CGSize (find-record-descriptor ':CGSize))
;  Rectangles. 
(defrecord CGRect
   (origin :CGPoint)
   (size :CGSize)
)

;type name? (%define-record :CGRect (find-record-descriptor ':CGRect))
;  Rectangle edges. 
(def-mactype :CGRectEdge (find-mactype ':sint32))

(defconstant $CGRectMinXEdge 0)
(defconstant $CGRectMinYEdge 1)
(defconstant $CGRectMaxXEdge 2)
(defconstant $CGRectMaxYEdge 3)

;type name? (def-mactype :CGRectEdge (find-mactype ':CGRectEdge))
;  The "zero" point -- equivalent to CGPointMake(0, 0). 
(%define-record :CGPointZero (find-record-descriptor ':CGPoint))
;  The "zero" size -- equivalent to CGSizeMake(0, 0). 
(%define-record :CGSizeZero (find-record-descriptor ':CGSize))
;  The "zero" rectangle -- equivalent to CGRectMake(0, 0, 0, 0). 
(%define-record :CGRectZero (find-record-descriptor ':CGRect))
;  The "empty" rect.  This is the rectangle returned when, for example, we
;  * intersect two disjoint rectangles.  Note that the null rect is not the
;  * same as the zero rect. 
(%define-record :CGRectNull (find-record-descriptor ':CGRect))
;  Make a point from `(x, y)'. 
#|
 confused about CG_INLINE CGPoint CGPointMake #\( float x #\, float y #\)
|#
;  Make a size from `(width, height)'. 
#|
 confused about CG_INLINE CGSize CGSizeMake #\( float width #\, float height #\)
|#
;  Make a rect from `(x, y; width, height)'. 
#|
 confused about CG_INLINE CGRect CGRectMake #\( float x #\, float y #\, float width #\, float height #\)
|#
;  Return the leftmost x-value of `rect'. 

(deftrap-inline "_CGRectGetMinX" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the midpoint x-value of `rect'. 

(deftrap-inline "_CGRectGetMidX" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the rightmost x-value of `rect'. 

(deftrap-inline "_CGRectGetMaxX" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the bottommost y-value of `rect'. 

(deftrap-inline "_CGRectGetMinY" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the midpoint y-value of `rect'. 

(deftrap-inline "_CGRectGetMidY" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the topmost y-value of `rect'. 

(deftrap-inline "_CGRectGetMaxY" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the width of `rect'. 

(deftrap-inline "_CGRectGetWidth" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return the height of `rect'. 

(deftrap-inline "_CGRectGetHeight" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :single-float
() )
;  Return 1 if `point1' and `point2' are the same, 0 otherwise. 

(deftrap-inline "_CGPointEqualToPoint" 
   ((x :single-float)
    (y :single-float)
    (x :single-float)
    (y :single-float)
   )
   :signed-long
() )
;  Return 1 if `size1' and `size2' are the same, 0 otherwise. 

(deftrap-inline "_CGSizeEqualToSize" 
   ((width :single-float)
    (height :single-float)
    (width :single-float)
    (height :single-float)
   )
   :signed-long
() )
;  Return 1 if `rect1' and `rect2' are the same, 0 otherwise. 

(deftrap-inline "_CGRectEqualToRect" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :signed-long
() )
;  Standardize `rect' -- i.e., convert it to an equivalent rect which has
;  * positive width and height. 

(deftrap-inline "_CGRectStandardize" 
   ((returnArg (:pointer :CGRect))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Return 1 if `rect' is empty -- i.e., if it has zero width or height.  A
;  * null rect is defined to be empty. 

(deftrap-inline "_CGRectIsEmpty" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :signed-long
() )
;  Return 1 if `rect' is null -- e.g., the result of intersecting two
;  * disjoint rectangles is a null rect. 

(deftrap-inline "_CGRectIsNull" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :signed-long
() )
;  Inset `rect' by `(dx, dy)' -- i.e., offset its origin by `(dx, dy)', and
;  * decrease its size by `(2*dx, 2*dy)'. 

(deftrap-inline "_CGRectInset" 
   ((returnArg (:pointer :CGRect))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (dx :single-float)
    (dy :single-float)
   )
   nil
() )
;  Expand `rect' to the smallest rect containing it with integral origin
;  * and size. 

(deftrap-inline "_CGRectIntegral" 
   ((returnArg (:pointer :CGRect))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Return the union of `r1' and `r2'. 

(deftrap-inline "_CGRectUnion" 
   ((returnArg (:pointer :CGRect))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Return the intersection of `r1' and `r2'.  This may return a null
;  * rect. 

(deftrap-inline "_CGRectIntersection" 
   ((returnArg (:pointer :CGRect))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   nil
() )
;  Offset `rect' by `(dx, dy)'. 

(deftrap-inline "_CGRectOffset" 
   ((returnArg (:pointer :CGRect))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (dx :single-float)
    (dy :single-float)
   )
   nil
() )
;  Make two new rectangles, `slice' and `remainder', by dividing `rect'
;  * with a line that's parallel to one of its sides, specified by `edge' --
;  * either `CGRectMinXEdge', `CGRectMinYEdge', `CGRectMaxXEdge', or
;  * `CGRectMaxYEdge'.  The size of `slice' is determined by `amount', which
;  * measures the distance from the specified edge. 

(deftrap-inline "_CGRectDivide" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (slice (:pointer :CGRect))
    (remainder (:pointer :CGRect))
    (amount :single-float)
    (edge :CGRectEdge)
   )
   nil
() )
;  Return 1 if `point' is contained in `rect', 0 otherwise. 

(deftrap-inline "_CGRectContainsPoint" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (x :single-float)
    (y :single-float)
   )
   :signed-long
() )
;  Return 1 if `rect2' is contained in `rect1', 0 otherwise.  `rect2' is
;  * contained in `rect1' if the union of `rect1' and `rect2' is equal to
;  * `rect1'. 

(deftrap-inline "_CGRectContainsRect" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :signed-long
() )
;  Return 1 if `rect1' intersects `rect2', 0 otherwise.  `rect1' intersects
;  * `rect2' if the intersection of `rect1' and `rect2' is not the null
;  * rect. 

(deftrap-inline "_CGRectIntersectsRect" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
   )
   :signed-long
() )
; ** Definitions of inline functions. **
#|
 confused about CG_INLINE CGPoint CGPointMake #\( float x #\, float y #\)
|#
#|
 confused about CG_INLINE CGSize CGSizeMake #\( float width #\, float height #\)
|#
#|
 confused about CG_INLINE CGRect CGRectMake #\( float x #\, float y #\, float width #\, float height #\)
|#

; #endif	/* CGGEOMETRY_H_ */


(provide-interface "CGGeometry")