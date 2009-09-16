(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:tube.h"
; at Sunday July 2,2006 7:31:53 pm.
;  
;  * tube.h
;  *
;  * FUNCTION:
;  * Tubing and Extrusion header file.
;  * This file provides protypes and defines for the extrusion 
;  * and tubing primitives.
;  *
;  * HISTORY:
;  * Linas Vepstas 1990, 1991
;  
; #ifndef __TUBE_H__
; #define __TUBE_H__
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; *
;  GLE API revision history:
;  
;  GLE_API_VERSION is updated to reflect GLE API changes (interface
;  changes, semantic changes, deletions, or additions).
;  
;  GLE_API_VERSION=228  GLUT 3.7 release of GLE.
; *
; #ifndef GLE_API_VERSION  /* allow this to be overriden */
(defconstant $GLE_API_VERSION 228)
; #define GLE_API_VERSION                228

; #endif

;  some types 
; #define gleDouble double
(defrecord gleAffine
   (contents (:array :gledouble 6))
)
#|
; Warning: type-size: unknown type gleDouble
|#                                              ;  ====================================================== 
;  defines for tubing join styles 
(defconstant $TUBE_JN_RAW 1)
; #define TUBE_JN_RAW          0x1
(defconstant $TUBE_JN_ANGLE 2)
; #define TUBE_JN_ANGLE        0x2
(defconstant $TUBE_JN_CUT 3)
; #define TUBE_JN_CUT          0x3
(defconstant $TUBE_JN_ROUND 4)
; #define TUBE_JN_ROUND        0x4
(defconstant $TUBE_JN_MASK 15)
; #define TUBE_JN_MASK         0xf    /* mask bits */
(defconstant $TUBE_JN_CAP 16)
; #define TUBE_JN_CAP          0x10
;  determine how normal vectors are to be handled 
(defconstant $TUBE_NORM_FACET 256)
; #define TUBE_NORM_FACET      0x100
(defconstant $TUBE_NORM_EDGE 512)
; #define TUBE_NORM_EDGE       0x200
(defconstant $TUBE_NORM_PATH_EDGE 1024)
; #define TUBE_NORM_PATH_EDGE  0x400 /* for spiral, lathe, helix primitives */
(defconstant $TUBE_NORM_MASK 3840)
; #define TUBE_NORM_MASK       0xf00    /* mask bits */
;  closed or open countours 
(defconstant $TUBE_CONTOUR_CLOSED 4096)
; #define TUBE_CONTOUR_CLOSED	0x1000
(defconstant $GLE_TEXTURE_ENABLE 65536)
; #define GLE_TEXTURE_ENABLE	0x10000
(defconstant $GLE_TEXTURE_STYLE_MASK 255)
; #define GLE_TEXTURE_STYLE_MASK	0xff
(defconstant $GLE_TEXTURE_VERTEX_FLAT 1)
; #define GLE_TEXTURE_VERTEX_FLAT		1
(defconstant $GLE_TEXTURE_NORMAL_FLAT 2)
; #define GLE_TEXTURE_NORMAL_FLAT		2
(defconstant $GLE_TEXTURE_VERTEX_CYL 3)
; #define GLE_TEXTURE_VERTEX_CYL		3
(defconstant $GLE_TEXTURE_NORMAL_CYL 4)
; #define GLE_TEXTURE_NORMAL_CYL		4
(defconstant $GLE_TEXTURE_VERTEX_SPH 5)
; #define GLE_TEXTURE_VERTEX_SPH		5
(defconstant $GLE_TEXTURE_NORMAL_SPH 6)
; #define GLE_TEXTURE_NORMAL_SPH		6
(defconstant $GLE_TEXTURE_VERTEX_MODEL_FLAT 7)
; #define GLE_TEXTURE_VERTEX_MODEL_FLAT	7
(defconstant $GLE_TEXTURE_NORMAL_MODEL_FLAT 8)
; #define GLE_TEXTURE_NORMAL_MODEL_FLAT	8
(defconstant $GLE_TEXTURE_VERTEX_MODEL_CYL 9)
; #define GLE_TEXTURE_VERTEX_MODEL_CYL	9
(defconstant $GLE_TEXTURE_NORMAL_MODEL_CYL 10)
; #define GLE_TEXTURE_NORMAL_MODEL_CYL	10
(defconstant $GLE_TEXTURE_VERTEX_MODEL_SPH 11)
; #define GLE_TEXTURE_VERTEX_MODEL_SPH	11
(defconstant $GLE_TEXTURE_NORMAL_MODEL_SPH 12)
; #define GLE_TEXTURE_NORMAL_MODEL_SPH	12
; #ifdef GL_32
#| #|

#define TUBE_LIGHTING_ON	0x80000000

#define gleExtrusion		extrusion
#define gleSetJoinStyle		setjoinstyle
#define gleGetJoinStyle		getjoinstyle
#define glePolyCone		polycone
#define glePolyCylinder		polycylinder
#define gleSuperExtrusion	super_extrusion
#define gleTwistExtrusion	twist_extrusion
#define gleSpiral		spiral
#define gleLathe		lathe
#define gleHelicoid		helicoid
#define gleToroid		toroid
#define gleScrew		screw

#endif
|#
 |#
;  GL_32 

(deftrap-inline "_gleGetJoinStyle" 
   (
   )
   :signed-long
() )

(deftrap-inline "_gleSetJoinStyle" 
   ((style :signed-long)
   )
   nil
() )
;  bitwise OR of flags 

(deftrap-inline "_gleGetNumSlices" 
   (
   )
   :signed-long
() )

(deftrap-inline "_gleSetNumSlices" 
   ((slices :signed-long)
   )
   nil
() )
;  draw polyclinder, specified as a polyline 

(deftrap-inline "_glePolyCylinder" 
   ((npoints :signed-long)
                                                ;  num points in polyline 
    (point_array (:pointer :gledouble))
                                                ;  polyline vertces 
    (color_array (:pointer :float))
                                                ;  colors at polyline verts 
    (radius :gledouble)
   )
   nil
() )
;  radius of polycylinder 
;  draw polycone, specified as a polyline with radii 

(deftrap-inline "_glePolyCone" 
   ((npoints :signed-long)
                                                ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))
                                                ;  polyline vertices 
    (color_array (:pointer :float))
                                                ;  colors at polyline verts 
    (radius_array (:pointer :gledouble))
   )
   nil
() )
;  cone radii at polyline verts 
;  extrude arbitrary 2D contour along arbitrary 3D path 

(deftrap-inline "_gleExtrusion" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normals 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))         ;  polyline vertices 
    (color_array (:pointer :float))
   )
   nil
() )
;  colors at polyline verts 
;  extrude 2D contour, specifying local rotations (twists) 

(deftrap-inline "_gleTwistExtrusion" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normals 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))         ;  polyline vertices 
    (color_array (:pointer :float))             ;  color at polyline verts 
    (twist_array (:pointer :gledouble))
   )
   nil
() )
;  countour twists (in degrees) 
;  extrude 2D contour, specifying local affine tranformations 

(deftrap-inline "_gleSuperExtrusion" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normals 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))         ;  polyline vertices 
    (color_array (:pointer :float))             ;  color at polyline verts 
    (xform_array (:pointer :gledouble))
   )
   nil
() )
;  2D contour xforms 
;  spiral moves contour along helical path by parallel transport 

(deftrap-inline "_gleSpiral" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normals 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (startRadius :gledouble)
                                                ;  spiral starts in x-y plane 
    (drdTheta :gledouble)                       ;  change in radius per revolution 
    (startZ :gledouble)
                                                ;  starting z value 
    (dzdTheta :gledouble)                       ;  change in Z per revolution 
    (startXform (:pointer :gledouble))          ;  starting contour affine xform 
    (dXformdTheta (:pointer :gledouble))        ;  tangent change xform per revoln 
    (startTheta :gledouble)
                                                ;  start angle in x-y plane 
    (sweepTheta :gledouble)
   )
   nil
() )
;  degrees to spiral around 
;  lathe moves contour along helical path by helically shearing 3D space 

(deftrap-inline "_gleLathe" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normals 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (startRadius :gledouble)
                                                ;  spiral starts in x-y plane 
    (drdTheta :gledouble)                       ;  change in radius per revolution 
    (startZ :gledouble)
                                                ;  starting z value 
    (dzdTheta :gledouble)                       ;  change in Z per revolution 
    (startXform (:pointer :gledouble))          ;  starting contour affine xform 
    (dXformdTheta (:pointer :gledouble))        ;  tangent change xform per revoln 
    (startTheta :gledouble)
                                                ;  start angle in x-y plane 
    (sweepTheta :gledouble)
   )
   nil
() )
;  degrees to spiral around 
;  similar to spiral, except contour is a circle 

(deftrap-inline "_gleHelicoid" 
   ((rToroid :gledouble)                        ;  circle contour (torus) radius 
    (startRadius :gledouble)
                                                ;  spiral starts in x-y plane 
    (drdTheta :gledouble)                       ;  change in radius per revolution 
    (startZ :gledouble)
                                                ;  starting z value 
    (dzdTheta :gledouble)                       ;  change in Z per revolution 
    (startXform (:pointer :gledouble))          ;  starting contour affine xform 
    (dXformdTheta (:pointer :gledouble))        ;  tangent change xform per revoln 
    (startTheta :gledouble)
                                                ;  start angle in x-y plane 
    (sweepTheta :gledouble)
   )
   nil
() )
;  degrees to spiral around 
;  similar to lathe, except contour is a circle 

(deftrap-inline "_gleToroid" 
   ((rToroid :gledouble)                        ;  circle contour (torus) radius 
    (startRadius :gledouble)
                                                ;  spiral starts in x-y plane 
    (drdTheta :gledouble)                       ;  change in radius per revolution 
    (startZ :gledouble)
                                                ;  starting z value 
    (dzdTheta :gledouble)                       ;  change in Z per revolution 
    (startXform (:pointer :gledouble))          ;  starting contour affine xform 
    (dXformdTheta (:pointer :gledouble))        ;  tangent change xform per revoln 
    (startTheta :gledouble)
                                                ;  start angle in x-y plane 
    (sweepTheta :gledouble)
   )
   nil
() )
;  degrees to spiral around 
;  draws a screw shape 

(deftrap-inline "_gleScrew" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normals 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (startz :gledouble)                         ;  start of segment 
    (endz :gledouble)                           ;  end of segment 
    (twist :gledouble)
   )
   nil
() )
;  number of rotations 

(deftrap-inline "_gleTextureMode" 
   ((mode :signed-long)
   )
   nil
() )
; #ifdef __cplusplus
#| #|
}

#endif
|#
 |#

; #endif /* __TUBE_H__ */

;  ================== END OF FILE ======================= 

(provide-interface "tube")