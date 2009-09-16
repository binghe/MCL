(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:segment.h"
; at Sunday July 2,2006 7:31:53 pm.
; 
;  * MODULE: segment.h
;  *
;  * FUNCTION:
;  * Contains function prototypes for segment drawing subroutines.
;  * These are used only internally, and are not to be exported to
;  * the user.
;  *
;  * HISTORY:
;  * Create by Linas Vepstas
;  * Added tube.h include to define gleDouble, tad February 2002
;  
;  ============================================================ 

(require-interface "tube")

(deftrap-inline "_draw_segment_plain" 
   ((ncp :signed-long)                          ;  number of contour points 
    (front_contour (:pointer :gledouble))
    (back_contour (:pointer :gledouble))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_segment_color" 
   ((ncp :signed-long)                          ;  number of contour points 
    (front_contour (:pointer :gledouble))
    (back_contour (:pointer :gledouble))
    (color_last (:pointer :float))
    (color_next (:pointer :float))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_segment_edge_n" 
   ((ncp :signed-long)                          ;  number of contour points 
    (front_contour (:pointer :gledouble))
    (back_contour (:pointer :gledouble))
    (norm_cont (:pointer :double))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_segment_c_and_edge_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :gledouble))
    (back_contour (:pointer :gledouble))
    (norm_cont (:pointer :double))
    (color_last (:pointer :float))
    (color_next (:pointer :float))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_segment_facet_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :gledouble))
    (back_contour (:pointer :gledouble))
    (norm_cont (:pointer :double))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_segment_c_and_facet_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :gledouble))
    (back_contour (:pointer :gledouble))
    (norm_cont (:pointer :double))
    (color_last (:pointer :float))
    (color_next (:pointer :float))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )
;  ============================================================ 

(deftrap-inline "_draw_binorm_segment_edge_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :double))
    (back_contour (:pointer :double))
    (front_norm (:pointer :double))
    (back_norm (:pointer :double))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_binorm_segment_c_and_edge_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :double))
    (back_contour (:pointer :double))
    (front_norm (:pointer :double))
    (back_norm (:pointer :double))
    (color_last (:pointer :float))
    (color_next (:pointer :float))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_binorm_segment_facet_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :double))
    (back_contour (:pointer :double))
    (front_norm (:pointer :double))
    (back_norm (:pointer :double))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_binorm_segment_c_and_facet_n" 
   ((ncp :signed-long)
    (front_contour (:pointer :double))
    (back_contour (:pointer :double))
    (front_norm (:pointer :double))
    (back_norm (:pointer :double))
    (color_last (:pointer :float))
    (color_next (:pointer :float))
    (inext :signed-long)
    (len :double-float)
   )
   nil
() )

(deftrap-inline "_draw_angle_style_back_cap" 
   ((ncp :signed-long)                          ;  number of contour points 
    (bi (:pointer :gledouble))                  ;  biscetor 
    (point_array (:pointer :gledouble))
   )
   nil
() )
;  polyline 
;  -------------------------- end of file -------------------------------- 

(provide-interface "segment")