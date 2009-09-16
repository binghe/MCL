(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGAffineTransform.h"
; at Sunday July 2,2006 7:23:48 pm.
;  CoreGraphics - CGAffineTransform.h
;  * Copyright (c) 1998-2000 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGAFFINETRANSFORM_H_
; #define CGAFFINETRANSFORM_H_

;type name? (def-mactype :CGAffineTransform (find-mactype ':CGAffineTransform))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGGeometry")
(defrecord CGAffineTransform
   (a :single-float)
   (b :single-float)
   (c :single-float)
   (d :single-float)
   (tx :single-float)
   (ty :single-float))
;  The identity transform: [ 1 0 0 1 0 0 ]. 
(%define-record :CGAffineTransformIdentity (find-record-descriptor ':CGAffineTransform))
;  Return the transform [ a b c d tx ty ]. 

(deftrap-inline "_CGAffineTransformMake" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Return a transform which translates by `(tx, ty)':
;  *   t' = [ 1 0 0 1 tx ty ] 

(deftrap-inline "_CGAffineTransformMakeTranslation" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Return a transform which scales by `(sx, sy)':
;  *   t' = [ sx 0 0 sy 0 0 ] 

(deftrap-inline "_CGAffineTransformMakeScale" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (sx :single-float)
    (sy :single-float)
   )
   nil
() )
;  Return a transform which rotates by `angle' radians:
;  *   t' = [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] 

(deftrap-inline "_CGAffineTransformMakeRotation" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (angle :single-float)
   )
   nil
() )
;  Translate `t' by `(tx, ty)' and return the result:
;  *   t' = [ 1 0 0 1 tx ty ] * t 

(deftrap-inline "_CGAffineTransformTranslate" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Scale `t' by `(sx, sy)' and return the result:
;  *   t' = [ sx 0 0 sy 0 0 ] * t 

(deftrap-inline "_CGAffineTransformScale" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
    (sx :single-float)
    (sy :single-float)
   )
   nil
() )
;  Rotate `t' by `angle' radians and return the result:
;  *   t' =  [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] * t 

(deftrap-inline "_CGAffineTransformRotate" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
    (angle :single-float)
   )
   nil
() )
;  Invert `t' and return the result.  If `t' has zero determinant, then `t'
;  * is returned unchanged. 

(deftrap-inline "_CGAffineTransformInvert" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Concatenate `t2' to `t1' and returne the result:
;  *   t' = t1 * t2 

(deftrap-inline "_CGAffineTransformConcat" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Transform `point' by `t' and return the result:
;  *   p' = p * t
;  * where p = [ x y 1 ]. 

(deftrap-inline "_CGPointApplyAffineTransform" 
   ((returnArg (:pointer :CGPoint))
    (x :single-float)
    (y :single-float)
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
;  Transform `size' by `t' and return the result:
;  *   s' = s * t
;  * where s = [ width height 0 ]. 

(deftrap-inline "_CGSizeApplyAffineTransform" 
   ((returnArg (:pointer :CGSize))
    (width :single-float)
    (height :single-float)
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
   )
   nil
() )
; ** Definitions of inline functions. **
#|
 confused about CG_INLINE CGAffineTransform __CGAffineTransformMake #\( float a #\, float b #\, float c #\, float d #\, float tx #\, float ty #\)
|#
; #define CGAffineTransformMake __CGAffineTransformMake
#|
 confused about CG_INLINE CGPoint __CGPointApplyAffineTransform #\( CGPoint point #\, CGAffineTransform t #\)
|#
; #define CGPointApplyAffineTransform __CGPointApplyAffineTransform
#|
 confused about CG_INLINE CGSize __CGSizeApplyAffineTransform #\( CGSize size #\, CGAffineTransform t #\)
|#
; #define CGSizeApplyAffineTransform __CGSizeApplyAffineTransform

; #endif	/* CGAFFINETRANSFORM_H_ */


(provide-interface "CGAffineTransform")