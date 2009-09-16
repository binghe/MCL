(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:tube_gc.h"
; at Sunday July 2,2006 7:32:07 pm.
; 
;  * tube_gc.h
;  *
;  * FUNCTION:
;  * This file allows for easy changes to changes in the way the extrusion
;  * library handles state info (i.e. context).
;  *
;  * HISTORY:
;  * Linas Vepstas --- February 1993
;  * Added auto texture coord generation hacks, Linas April 1994
;  * Added tube.h include to define gleDouble, tad February 2002
;  

(require-interface "tube")

(require-interface "port")
(defrecord gleColor
   (contents (:array :single-float 3))
)
(defrecord gleTwoVec
   (contents (:array :double-float 2))
)
(defrecord gleGC                                                ;  public methods 
   (bgn_gen_texture (:pointer :callback))       ;(void (int , double))
   (n3f_gen_texture (:pointer :callback))       ;(void (float *))
   (n3d_gen_texture (:pointer :callback))       ;(void (double *))
   (v3f_gen_texture (:pointer :callback))       ;(void (float * , int , int))
   (v3d_gen_texture (:pointer :callback))       ;(void (double * , int , int))
   (end_gen_texture (:pointer :callback))       ;(void (void))
                                                ;  protected members -- "general knowledge" stuff 
   (join_style :signed-long)
                                                ;  arguments passed into extrusion code 
   (ncp :signed-long)                           ;  number of contour points 
   (contour (:pointer :GLETWOVEC))              ;  2D contour 
   (cont_normal (:pointer :GLETWOVEC))          ;  2D contour normals 
   (up (:pointer :gledouble))                   ;  up vector 
   (npoints :signed-long)                       ;  number of points in polyline 
   (point_array (:pointer :GLEVECTOR))          ;  path 
   (color_array (:pointer :GLECOLOR))           ;  path colors 
   (xform_array (:pointer :GLEAFFINE))          ;  contour xforms 
                                                ;  private members, used by texturing code 
   (num_vert :signed-long)
   (segment_number :signed-long)
   (segment_length :double-float)
   (accum_seg_len :double-float)
   (prev_x :double-float)
   (prev_y :double-float)
   (save_bgn_gen_texture (:pointer :callback))  ;(void (int , double))
   (save_n3f_gen_texture (:pointer :callback))  ;(void (float *))
   (save_n3d_gen_texture (:pointer :callback))  ;(void (double *))
   (save_v3f_gen_texture (:pointer :callback))  ;(void (float * , int , int))
   (save_v3d_gen_texture (:pointer :callback))  ;(void (double * , int , int))
   (save_end_gen_texture (:pointer :callback))  ;(void (void))
)
(def-mactype :_gle_gc (find-mactype '(:pointer :gleGC)))

(deftrap-inline "_gleCreateGC" 
   (
   )
   (:pointer :GLEGC)
() )
; #define INIT_GC() {if (!_gle_gc) _gle_gc = gleCreateGC(); }
; #define extrusion_join_style (_gle_gc->join_style)
; #define __TUBE_CLOSE_CONTOUR (extrusion_join_style & TUBE_CONTOUR_CLOSED)
; #define __TUBE_DRAW_CAP (extrusion_join_style & TUBE_JN_CAP)
; #define __TUBE_DRAW_FACET_NORMALS (extrusion_join_style & TUBE_NORM_FACET)
; #define __TUBE_DRAW_PATH_EDGE_NORMALS (extrusion_join_style & TUBE_NORM_PATH_EDGE)
; #define __TUBE_STYLE (extrusion_join_style & TUBE_JN_MASK)
; #define __TUBE_RAW_JOIN (extrusion_join_style & TUBE_JN_RAW)
; #define __TUBE_CUT_JOIN (extrusion_join_style & TUBE_JN_CUT)
; #define __TUBE_ANGLE_JOIN (extrusion_join_style & TUBE_JN_ANGLE)
; #define __TUBE_ROUND_JOIN (extrusion_join_style & TUBE_JN_ROUND)
;  ======================= END OF FILE ========================== 

(provide-interface "tube_gc")