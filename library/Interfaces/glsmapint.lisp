(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glsmapint.h"
; at Sunday July 2,2006 7:27:54 pm.
; #ifndef __glsmapint_h__
; #define __glsmapint_h__
;  Copyright (c) Mark J. Kilgard, 1998. 
;  This program is freely distributable without licensing fees 
;    and is provided without guarantee or warrantee expressed or 
;    implied. This program is -not- in the public domain. 

(require-interface "glsmap")

(defconstant $X 0)
(defconstant $Y 1)
(defconstant $Z 2)
; #define INITFACE(mesh) 	int steps = mesh->steps; 	int sqsteps = mesh->steps * mesh->steps
; #define FACE(side,y,x) 	mesh->face[(side)*sqsteps + (y)*steps + (x)]
; #define FACExy(side,i,j) 	(&FACE(side,i,j).x)
; #define FACEst(side,i,j) 	(&FACE(side,i,j).s)
; #define INITBACK(mesh) 	int allrings = mesh->rings + mesh->edgeExtend; 	int ringedspokes = allrings * mesh->steps
; #define BACK(edge,ring,spoke) 	mesh->back[(edge)*ringedspokes + (ring)*mesh->steps + (spoke)]
; #define BACKxy(edge,ring,spoke) 	(&BACK(edge,ring,spoke).x)
; #define BACKst(edge,ring,spoke) 	(&BACK(edge,ring,spoke).s)
(defrecord _STXY
   (s :single-float)
   (t :single-float)
   (x :single-float)
   (y :single-float))
(%define-record :STXY (find-record-descriptor :_STXY))
(defrecord _SphereMapMesh
   (refcnt :signed-long)
   (steps :signed-long)
   (rings :signed-long)
   (edgeExtend :signed-long)
   (face (:pointer :STXY))
   (back (:pointer :STXY))
)
(%define-record :SphereMapMesh (find-record-descriptor :_SPHEREMAPMESH))
(defrecord _SphereMap
                                                ;  Shared sphere map mesh vertex data. 
   (mesh (:pointer :SPHEREMAPMESH))
                                                ;  Texture object ids. 
   (smapTexObj :UInt32)
   (viewTexObjs (:array :UInt32 6))
   (viewTexObj :UInt32)
                                                ;  Flags 
   (flags :SInt32)
                                                ;  Texture dimensions must be a power of two. 
   (viewTexDim :signed-long)                    ;  view texture dimension 
   (smapTexDim :signed-long)                    ;  sphere map texture dimension 
                                                ;  Viewport origins for view and sphere map rendering. 
   (viewOrigin (:array :signed-long 2))
   (smapOrigin (:array :signed-long 2))
                                                ;  Viewing vectors. 
   (eye (:array :single-float 3))
   (up (:array :single-float 3))
   (obj (:array :single-float 3))
                                                ;  Projection parameters. 
   (viewNear :single-float)
   (viewFar :single-float)
                                                ;  Rendering callbacks. 
   (positionLights (:pointer :callback))        ;(void (int view , void * context))
   (drawView (:pointer :callback))              ;(void (int view , void * context))
                                                ;  Application specified callback data. 
   (context :pointer)
)
;  Library internal routines. 

(deftrap-inline "___smapDrawSphereMapMeshSide" 
   ((mesh (:pointer :SPHEREMAPMESH))
    (side :signed-long)
   )
   nil
() )

(deftrap-inline "___smapDrawSphereMapMeshBack" 
   ((mesh (:pointer :SPHEREMAPMESH))
   )
   nil
() )

(deftrap-inline "___smapValidateSphereMapMesh" 
   ((mesh (:pointer :SPHEREMAPMESH))
   )
   nil
() )

; #endif /* __glsmapint_h__ */


(provide-interface "glsmapint")