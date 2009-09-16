(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:gutil.h"
; at Sunday July 2,2006 7:27:55 pm.
; 
;  * gutil.h
;  *
;  * FUNCTION:
;  * Provide utilities that allow rotation to occur 
;  * around any axis.
;  * 
;  * HISTORY:
;  * created by Linas Vepstas  1990
;  * added single & double precision, June 1991, Linas Vepstas
;  
; #ifndef __GUTIL_H__
; #define __GUTIL_H__
; #ifdef __GUTIL_DOUBLE
#| #|
#define gutDouble double
|#
 |#

; #else
; #define gutDouble float  

; #endif

; #ifdef _NO_PROTO		/* NO ANSI C PROTOTYPING */
#| #|


extern void rot_axis_f ();
extern void rot_about_axis_f ();
extern void rot_omega_f ();
extern void urot_axis_f ();
extern void urot_about_axis_f ();
extern void urot_omega_f ();


extern void rot_axis_d ();
extern void rot_about_axis_d ();
extern void rot_omega_d ();
extern void urot_axis_d ();
extern void urot_about_axis_d ();
extern void urot_omega_d ();


extern void uview_direction_d ();
extern void uview_direction_f ();
extern void uviewpoint_d ();
extern void uviewpoint_f ();

|#
 |#

; #else /* _NO_PROTO */		/* ANSI C PROTOTYPING */
;  Rotation Utilities 

(deftrap-inline "_rot_axis_f" 
   ((omega :single-float)
    (axis (:pointer :float))
   )
   nil
() )

(deftrap-inline "_rot_about_axis_f" 
   ((angle :single-float)
    (axis (:pointer :float))
   )
   nil
() )

(deftrap-inline "_rot_omega_f" 
   ((axis (:pointer :float))
   )
   nil
() )

(deftrap-inline "_urot_axis_f" 
   ((m (:pointer :float))
    (omega :single-float)
    (axis (:pointer :float))
   )
   nil
() )

(deftrap-inline "_urot_about_axis_f" 
   ((m (:pointer :float))
    (angle :single-float)
    (axis (:pointer :float))
   )
   nil
() )

(deftrap-inline "_urot_omega_f" 
   ((m (:pointer :float))
    (axis (:pointer :float))
   )
   nil
() )
;  double-precision versions 

(deftrap-inline "_rot_axis_d" 
   ((omega :double-float)
    (axis (:pointer :double))
   )
   nil
() )

(deftrap-inline "_rot_about_axis_d" 
   ((angle :double-float)
    (axis (:pointer :double))
   )
   nil
() )

(deftrap-inline "_rot_omega_d" 
   ((axis (:pointer :double))
   )
   nil
() )

(deftrap-inline "_urot_axis_d" 
   ((m (:pointer :double))
    (omega :double-float)
    (axis (:pointer :double))
   )
   nil
() )

(deftrap-inline "_urot_about_axis_d" 
   ((m (:pointer :double))
    (angle :double-float)
    (axis (:pointer :double))
   )
   nil
() )

(deftrap-inline "_urot_omega_d" 
   ((m (:pointer :double))
    (axis (:pointer :double))
   )
   nil
() )
;  viewpoint functions 

(deftrap-inline "_uview_direction_d" 
   ((m (:pointer :double))
                                                ;  returned 
    (v21 (:pointer :double))
                                                ;  input 
    (up (:pointer :double))
   )
   nil
() )
;  input 

(deftrap-inline "_uview_direction_f" 
   ((m (:pointer :float))
                                                ;  returned 
    (v21 (:pointer :float))
                                                ;  input 
    (up (:pointer :float))
   )
   nil
() )
;  input 

(deftrap-inline "_uviewpoint_d" 
   ((m (:pointer :double))
                                                ;  returned 
    (v1 (:pointer :double))
                                                ;  input 
    (v2 (:pointer :double))
                                                ;  input 
    (up (:pointer :double))
   )
   nil
() )
;  input 

(deftrap-inline "_uviewpoint_f" 
   ((m (:pointer :float))
                                                ;  returned 
    (v1 (:pointer :float))
                                                ;  input 
    (v2 (:pointer :float))
                                                ;  input 
    (up (:pointer :float))
   )
   nil
() )
;  input 

; #endif /* _NO_PROTO */


; #endif /* _GUTIL_H__ */

;  ------------------- end of file ---------------------- 

(provide-interface "gutil")