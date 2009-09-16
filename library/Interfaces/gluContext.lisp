(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:gluContext.h"
; at Sunday July 2,2006 7:27:54 pm.
; 
; 	Copyright:	(c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _GLUCONTEXT_H
; #define _GLUCONTEXT_H

(require-interface "OpenGL/glu")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** GLU Context routines
; 

(deftrap-inline "_gluBuild1DMipmapsCTX" 
   ((ctx (:pointer :struct))
    (target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (format :UInt32)
    (type :UInt32)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild2DMipmapsCTX" 
   ((ctx (:pointer :struct))
    (target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild3DMipmapsCTX" 
   ((ctx (:pointer :struct))
    (target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (height :signed-long)
    (depth :signed-long)
    (format :UInt32)
    (type :UInt32)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild1DMipmapLevelsCTX" 
   ((ctx (:pointer :struct))
    (target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (format :UInt32)
    (type :UInt32)
    (level :signed-long)
    (base :signed-long)
    (max :signed-long)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild2DMipmapLevelsCTX" 
   ((ctx (:pointer :struct))
    (target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (level :signed-long)
    (base :signed-long)
    (max :signed-long)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild3DMipmapLevelsCTX" 
   ((ctx (:pointer :struct))
    (target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (height :signed-long)
    (depth :signed-long)
    (format :UInt32)
    (type :UInt32)
    (level :signed-long)
    (base :signed-long)
    (max :signed-long)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluLookAtCTX" 
   ((ctx (:pointer :struct))
    (eyeX :double-float)
    (eyeY :double-float)
    (eyeZ :double-float)
    (centerX :double-float)
    (centerY :double-float)
    (centerZ :double-float)
    (upX :double-float)
    (upY :double-float)
    (upZ :double-float)
   )
   nil
() )

(deftrap-inline "_gluNewNurbsRendererCTX" 
   ((ctx (:pointer :struct))
   )
   (:pointer :GLUnurbs)
() )

(deftrap-inline "_gluNewQuadricCTX" 
   ((ctx (:pointer :struct))
   )
   (:pointer :GLUquadric)
() )

(deftrap-inline "_gluNewTessCTX" 
   ((ctx (:pointer :struct))
   )
   (:pointer :GLUtesselator)
() )

(deftrap-inline "_gluOrtho2DCTX" 
   ((ctx (:pointer :struct))
    (left :double-float)
    (right :double-float)
    (bottom :double-float)
    (top :double-float)
   )
   nil
() )

(deftrap-inline "_gluPerspectiveCTX" 
   ((ctx (:pointer :struct))
    (fovy :double-float)
    (aspect :double-float)
    (zNear :double-float)
    (zFar :double-float)
   )
   nil
() )

(deftrap-inline "_gluPickMatrixCTX" 
   ((ctx (:pointer :struct))
    (x :double-float)
    (y :double-float)
    (delX :double-float)
    (delY :double-float)
    (viewport (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_gluScaleImageCTX" 
   ((ctx (:pointer :struct))
    (format :UInt32)
    (wIn :signed-long)
    (hIn :signed-long)
    (typeIn :UInt32)
    (dataIn :pointer)
    (wOut :signed-long)
    (hOut :signed-long)
    (typeOut :UInt32)
    (dataOut :pointer)
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _GLUCONTEXT_H */


(provide-interface "gluContext")