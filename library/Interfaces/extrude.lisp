(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:extrude.h"
; at Sunday July 2,2006 7:27:50 pm.
; 
;  * extrude.h
;  *
;  * FUNCTION:
;  * prototypes for privately used subroutines for the tubing library
;  *
;  * HISTORY:
;  * Linas Vepstas 1991
;  

(require-interface "port")
; #ifndef M_PI
#| #|
#define M_PI  3.14159265358979323846
#endif
|#
 |#
;  ============================================================ 
;  
;  * Provides choice of calling subroutine, vs. invoking macro.
;  * Basically, inlines the source, or not.
;  * Trades performance for executable size.
;  
; #define INLINE_INTERSECT
; #ifdef INLINE_INTERSECT
; #define INNERSECT(sect,p,n,v1,v2) { INTERSECT(sect,p,n,v1,v2); }
#| 
; #else
; #define INNERSECT(sect,p,n,v1,v2) intersect(sect,p,n,v1,v2)
 |#

; #endif /* INLINE_INTERSECT */

;  ============================================================ 
;  The folowing defines give a kludgy way of accessing the qmesh primitive 
; 
; #define bgntmesh _emu_qmesh_bgnqmesh
; #define endtmesh _emu_qmesh_endqmesh
; #define c3f _emu_qmesh_c3f
; #define n3f _emu_qmesh_n3f
; #define v3f _emu_qmesh_v3f
; 
;  ============================================================ 

(deftrap-inline "_up_sanity_check" 
   ((up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))
   )
   nil
() )
;  polyline 

(deftrap-inline "_draw_raw_style_end_cap" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (zval :gledouble)                           ;  where to draw cap 
    (frontwards :signed-long)
   )
   nil
() )
;  front or back cap 

(deftrap-inline "_draw_round_style_cap_callback" 
   ((iloop :signed-long)
    (cap (:pointer :double))
    (face_color (:pointer :float))
    (cut_vector (:pointer :gledouble))
    (bisect_vector (:pointer :gledouble))
    (norms (:pointer :double))
    (frontwards :signed-long)
   )
   nil
() )

(deftrap-inline "_draw_angle_style_front_cap" 
   ((ncp :signed-long)
    (bi (:pointer :gledouble))
    (point_array (:pointer :gledouble))
   )
   nil
() )

(deftrap-inline "_extrusion_raw_join" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normal vecs 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))         ;  polyline 
    (color_array (:pointer :float))             ;  color of polyline 
    (xform_array (:pointer :gledouble))
   )
   nil
() )
;  2D contour xforms 

(deftrap-inline "_extrusion_round_or_cut_join" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normal vecs 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))         ;  polyline 
    (color_array (:pointer :float))             ;  color of polyline 
    (xform_array (:pointer :gledouble))
   )
   nil
() )
;  2D contour xforms 

(deftrap-inline "_extrusion_angle_join" 
   ((ncp :signed-long)                          ;  number of contour points 
    (contour (:pointer :gledouble))             ;  2D contour 
    (cont_normal (:pointer :gledouble))         ;  2D contour normal vecs 
    (up (:pointer :gledouble))                  ;  up vector for contour 
    (npoints :signed-long)                      ;  numpoints in poly-line 
    (point_array (:pointer :gledouble))         ;  polyline 
    (color_array (:pointer :float))             ;  color of polyline 
    (xform_array (:pointer :gledouble))
   )
   nil
() )
;  2D contour xforms 
;  -------------------------- end of file -------------------------------- 

(provide-interface "extrude")