(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glu.h"
; at Sunday July 2,2006 7:27:54 pm.
; 
;     Copyright:  (c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef __glu_h__
; #define __glu_h__

(require-interface "OpenGL/gl")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; ***********************************************************
;  Extensions 
(defconstant $GLU_EXT_object_space_tess 1)
; #define GLU_EXT_object_space_tess            1
(defconstant $GLU_EXT_nurbs_tessellator 1)
; #define GLU_EXT_nurbs_tessellator            1
;  Boolean 
(defconstant $GLU_FALSE 0)
; #define GLU_FALSE                            0
(defconstant $GLU_TRUE 1)
; #define GLU_TRUE                             1
;  Version 
(defconstant $GLU_VERSION_1_1 1)
; #define GLU_VERSION_1_1                      1
(defconstant $GLU_VERSION_1_2 1)
; #define GLU_VERSION_1_2                      1
(defconstant $GLU_VERSION_1_3 1)
; #define GLU_VERSION_1_3                      1
;  StringName 
(defconstant $GLU_VERSION 100800)
; #define GLU_VERSION                          100800
(defconstant $GLU_EXTENSIONS 100801)
; #define GLU_EXTENSIONS                       100801
;  ErrorCode 
(defconstant $GLU_INVALID_ENUM 100900)
; #define GLU_INVALID_ENUM                     100900
(defconstant $GLU_INVALID_VALUE 100901)
; #define GLU_INVALID_VALUE                    100901
(defconstant $GLU_OUT_OF_MEMORY 100902)
; #define GLU_OUT_OF_MEMORY                    100902
(defconstant $GLU_INCOMPATIBLE_GL_VERSION 100903)
; #define GLU_INCOMPATIBLE_GL_VERSION          100903
(defconstant $GLU_INVALID_OPERATION 100904)
; #define GLU_INVALID_OPERATION                100904
;  NurbsDisplay 
;       GLU_FILL 
(defconstant $GLU_OUTLINE_POLYGON 100240)
; #define GLU_OUTLINE_POLYGON                  100240
(defconstant $GLU_OUTLINE_PATCH 100241)
; #define GLU_OUTLINE_PATCH                    100241
;  NurbsCallback 
(defconstant $GLU_NURBS_ERROR 100103)
; #define GLU_NURBS_ERROR                      100103
(defconstant $GLU_ERROR 100103)
; #define GLU_ERROR                            100103
(defconstant $GLU_NURBS_BEGIN 100164)
; #define GLU_NURBS_BEGIN                      100164
(defconstant $GLU_NURBS_BEGIN_EXT 100164)
; #define GLU_NURBS_BEGIN_EXT                  100164
(defconstant $GLU_NURBS_VERTEX 100165)
; #define GLU_NURBS_VERTEX                     100165
(defconstant $GLU_NURBS_VERTEX_EXT 100165)
; #define GLU_NURBS_VERTEX_EXT                 100165
(defconstant $GLU_NURBS_NORMAL 100166)
; #define GLU_NURBS_NORMAL                     100166
(defconstant $GLU_NURBS_NORMAL_EXT 100166)
; #define GLU_NURBS_NORMAL_EXT                 100166
(defconstant $GLU_NURBS_COLOR 100167)
; #define GLU_NURBS_COLOR                      100167
(defconstant $GLU_NURBS_COLOR_EXT 100167)
; #define GLU_NURBS_COLOR_EXT                  100167
(defconstant $GLU_NURBS_TEXTURE_COORD 100168)
; #define GLU_NURBS_TEXTURE_COORD              100168
(defconstant $GLU_NURBS_TEX_COORD_EXT 100168)
; #define GLU_NURBS_TEX_COORD_EXT              100168
(defconstant $GLU_NURBS_END 100169)
; #define GLU_NURBS_END                        100169
(defconstant $GLU_NURBS_END_EXT 100169)
; #define GLU_NURBS_END_EXT                    100169
(defconstant $GLU_NURBS_BEGIN_DATA 100170)
; #define GLU_NURBS_BEGIN_DATA                 100170
(defconstant $GLU_NURBS_BEGIN_DATA_EXT 100170)
; #define GLU_NURBS_BEGIN_DATA_EXT             100170
(defconstant $GLU_NURBS_VERTEX_DATA 100171)
; #define GLU_NURBS_VERTEX_DATA                100171
(defconstant $GLU_NURBS_VERTEX_DATA_EXT 100171)
; #define GLU_NURBS_VERTEX_DATA_EXT            100171
(defconstant $GLU_NURBS_NORMAL_DATA 100172)
; #define GLU_NURBS_NORMAL_DATA                100172
(defconstant $GLU_NURBS_NORMAL_DATA_EXT 100172)
; #define GLU_NURBS_NORMAL_DATA_EXT            100172
(defconstant $GLU_NURBS_COLOR_DATA 100173)
; #define GLU_NURBS_COLOR_DATA                 100173
(defconstant $GLU_NURBS_COLOR_DATA_EXT 100173)
; #define GLU_NURBS_COLOR_DATA_EXT             100173
(defconstant $GLU_NURBS_TEXTURE_COORD_DATA 100174)
; #define GLU_NURBS_TEXTURE_COORD_DATA         100174
(defconstant $GLU_NURBS_TEX_COORD_DATA_EXT 100174)
; #define GLU_NURBS_TEX_COORD_DATA_EXT         100174
(defconstant $GLU_NURBS_END_DATA 100175)
; #define GLU_NURBS_END_DATA                   100175
(defconstant $GLU_NURBS_END_DATA_EXT 100175)
; #define GLU_NURBS_END_DATA_EXT               100175
;  NurbsError 
(defconstant $GLU_NURBS_ERROR1 100251)
; #define GLU_NURBS_ERROR1                     100251   /* spline order un-supported */
(defconstant $GLU_NURBS_ERROR2 100252)
; #define GLU_NURBS_ERROR2                     100252   /* too few knots */
(defconstant $GLU_NURBS_ERROR3 100253)
; #define GLU_NURBS_ERROR3                     100253   /* valid knot range is empty */
(defconstant $GLU_NURBS_ERROR4 100254)
; #define GLU_NURBS_ERROR4                     100254   /* decreasing knot sequence */
(defconstant $GLU_NURBS_ERROR5 100255)
; #define GLU_NURBS_ERROR5                     100255   /* knot multiplicity > spline order */
(defconstant $GLU_NURBS_ERROR6 100256)
; #define GLU_NURBS_ERROR6                     100256   /* endcurve() must follow bgncurve() */
(defconstant $GLU_NURBS_ERROR7 100257)
; #define GLU_NURBS_ERROR7                     100257   /* bgncurve() must precede endcurve() */
(defconstant $GLU_NURBS_ERROR8 100258)
; #define GLU_NURBS_ERROR8                     100258   /* ctrlarray or knot vector is NULL */
(defconstant $GLU_NURBS_ERROR9 100259)
; #define GLU_NURBS_ERROR9                     100259   /* can't draw pwlcurves */
(defconstant $GLU_NURBS_ERROR10 100260)
; #define GLU_NURBS_ERROR10                    100260   /* missing gluNurbsCurve() */
(defconstant $GLU_NURBS_ERROR11 100261)
; #define GLU_NURBS_ERROR11                    100261   /* missing gluNurbsSurface() */
(defconstant $GLU_NURBS_ERROR12 100262)
; #define GLU_NURBS_ERROR12                    100262   /* endtrim() must precede endsurface() */
(defconstant $GLU_NURBS_ERROR13 100263)
; #define GLU_NURBS_ERROR13                    100263   /* bgnsurface() must precede endsurface() */
(defconstant $GLU_NURBS_ERROR14 100264)
; #define GLU_NURBS_ERROR14                    100264   /* curve of improper type passed as trim curve */
(defconstant $GLU_NURBS_ERROR15 100265)
; #define GLU_NURBS_ERROR15                    100265   /* bgnsurface() must precede bgntrim() */
(defconstant $GLU_NURBS_ERROR16 100266)
; #define GLU_NURBS_ERROR16                    100266   /* endtrim() must follow bgntrim() */
(defconstant $GLU_NURBS_ERROR17 100267)
; #define GLU_NURBS_ERROR17                    100267   /* bgntrim() must precede endtrim()*/
(defconstant $GLU_NURBS_ERROR18 100268)
; #define GLU_NURBS_ERROR18                    100268   /* invalid or missing trim curve*/
(defconstant $GLU_NURBS_ERROR19 100269)
; #define GLU_NURBS_ERROR19                    100269   /* bgntrim() must precede pwlcurve() */
(defconstant $GLU_NURBS_ERROR20 100270)
; #define GLU_NURBS_ERROR20                    100270   /* pwlcurve referenced twice*/
(defconstant $GLU_NURBS_ERROR21 100271)
; #define GLU_NURBS_ERROR21                    100271   /* pwlcurve and nurbscurve mixed */
(defconstant $GLU_NURBS_ERROR22 100272)
; #define GLU_NURBS_ERROR22                    100272   /* improper usage of trim data type */
(defconstant $GLU_NURBS_ERROR23 100273)
; #define GLU_NURBS_ERROR23                    100273   /* nurbscurve referenced twice */
(defconstant $GLU_NURBS_ERROR24 100274)
; #define GLU_NURBS_ERROR24                    100274   /* nurbscurve and pwlcurve mixed */
(defconstant $GLU_NURBS_ERROR25 100275)
; #define GLU_NURBS_ERROR25                    100275   /* nurbssurface referenced twice */
(defconstant $GLU_NURBS_ERROR26 100276)
; #define GLU_NURBS_ERROR26                    100276   /* invalid property */
(defconstant $GLU_NURBS_ERROR27 100277)
; #define GLU_NURBS_ERROR27                    100277   /* endsurface() must follow bgnsurface() */
(defconstant $GLU_NURBS_ERROR28 100278)
; #define GLU_NURBS_ERROR28                    100278   /* intersecting or misoriented trim curves */
(defconstant $GLU_NURBS_ERROR29 100279)
; #define GLU_NURBS_ERROR29                    100279   /* intersecting trim curves */
(defconstant $GLU_NURBS_ERROR30 100280)
; #define GLU_NURBS_ERROR30                    100280   /* UNUSED */
(defconstant $GLU_NURBS_ERROR31 100281)
; #define GLU_NURBS_ERROR31                    100281   /* unconnected trim curves */
(defconstant $GLU_NURBS_ERROR32 100282)
; #define GLU_NURBS_ERROR32                    100282   /* unknown knot error */
(defconstant $GLU_NURBS_ERROR33 100283)
; #define GLU_NURBS_ERROR33                    100283   /* negative vertex count encountered */
(defconstant $GLU_NURBS_ERROR34 100284)
; #define GLU_NURBS_ERROR34                    100284   /* negative byte-stride */
(defconstant $GLU_NURBS_ERROR35 100285)
; #define GLU_NURBS_ERROR35                    100285   /* unknown type descriptor */
(defconstant $GLU_NURBS_ERROR36 100286)
; #define GLU_NURBS_ERROR36                    100286   /* null control point reference */
(defconstant $GLU_NURBS_ERROR37 100287)
; #define GLU_NURBS_ERROR37                    100287   /* duplicate point on pwlcurve */
;  NurbsProperty 
(defconstant $GLU_AUTO_LOAD_MATRIX 100200)
; #define GLU_AUTO_LOAD_MATRIX                 100200
(defconstant $GLU_CULLING 100201)
; #define GLU_CULLING                          100201
(defconstant $GLU_SAMPLING_TOLERANCE 100203)
; #define GLU_SAMPLING_TOLERANCE               100203
(defconstant $GLU_DISPLAY_MODE 100204)
; #define GLU_DISPLAY_MODE                     100204
(defconstant $GLU_PARAMETRIC_TOLERANCE 100202)
; #define GLU_PARAMETRIC_TOLERANCE             100202
(defconstant $GLU_SAMPLING_METHOD 100205)
; #define GLU_SAMPLING_METHOD                  100205
(defconstant $GLU_U_STEP 100206)
; #define GLU_U_STEP                           100206
(defconstant $GLU_V_STEP 100207)
; #define GLU_V_STEP                           100207
(defconstant $GLU_NURBS_MODE 100160)
; #define GLU_NURBS_MODE                       100160
(defconstant $GLU_NURBS_MODE_EXT 100160)
; #define GLU_NURBS_MODE_EXT                   100160
(defconstant $GLU_NURBS_TESSELLATOR 100161)
; #define GLU_NURBS_TESSELLATOR                100161
(defconstant $GLU_NURBS_TESSELLATOR_EXT 100161)
; #define GLU_NURBS_TESSELLATOR_EXT            100161
(defconstant $GLU_NURBS_RENDERER 100162)
; #define GLU_NURBS_RENDERER                   100162
(defconstant $GLU_NURBS_RENDERER_EXT 100162)
; #define GLU_NURBS_RENDERER_EXT               100162
;  NurbsSampling 
(defconstant $GLU_OBJECT_PARAMETRIC_ERROR 100208)
; #define GLU_OBJECT_PARAMETRIC_ERROR          100208
(defconstant $GLU_OBJECT_PARAMETRIC_ERROR_EXT 100208)
; #define GLU_OBJECT_PARAMETRIC_ERROR_EXT      100208
(defconstant $GLU_OBJECT_PATH_LENGTH 100209)
; #define GLU_OBJECT_PATH_LENGTH               100209
(defconstant $GLU_OBJECT_PATH_LENGTH_EXT 100209)
; #define GLU_OBJECT_PATH_LENGTH_EXT           100209
(defconstant $GLU_PATH_LENGTH 100215)
; #define GLU_PATH_LENGTH                      100215
(defconstant $GLU_PARAMETRIC_ERROR 100216)
; #define GLU_PARAMETRIC_ERROR                 100216
(defconstant $GLU_DOMAIN_DISTANCE 100217)
; #define GLU_DOMAIN_DISTANCE                  100217
;  NurbsTrim 
(defconstant $GLU_MAP1_TRIM_2 100210)
; #define GLU_MAP1_TRIM_2                      100210
(defconstant $GLU_MAP1_TRIM_3 100211)
; #define GLU_MAP1_TRIM_3                      100211
;  QuadricDrawStyle 
(defconstant $GLU_POINT 100010)
; #define GLU_POINT                            100010
(defconstant $GLU_LINE 100011)
; #define GLU_LINE                             100011
(defconstant $GLU_FILL 100012)
; #define GLU_FILL                             100012
(defconstant $GLU_SILHOUETTE 100013)
; #define GLU_SILHOUETTE                       100013
;  QuadricCallback 
;       GLU_ERROR 
;  QuadricNormal 
(defconstant $GLU_SMOOTH 100000)
; #define GLU_SMOOTH                           100000
(defconstant $GLU_FLAT 100001)
; #define GLU_FLAT                             100001
(defconstant $GLU_NONE 100002)
; #define GLU_NONE                             100002
;  QuadricOrientation 
(defconstant $GLU_OUTSIDE 100020)
; #define GLU_OUTSIDE                          100020
(defconstant $GLU_INSIDE 100021)
; #define GLU_INSIDE                           100021
;  TessCallback 
(defconstant $GLU_TESS_BEGIN 100100)
; #define GLU_TESS_BEGIN                       100100
(defconstant $GLU_BEGIN 100100)
; #define GLU_BEGIN                            100100
(defconstant $GLU_TESS_VERTEX 100101)
; #define GLU_TESS_VERTEX                      100101
(defconstant $GLU_VERTEX 100101)
; #define GLU_VERTEX                           100101
(defconstant $GLU_TESS_END 100102)
; #define GLU_TESS_END                         100102
(defconstant $GLU_END 100102)
; #define GLU_END                              100102
(defconstant $GLU_TESS_ERROR 100103)
; #define GLU_TESS_ERROR                       100103
(defconstant $GLU_TESS_EDGE_FLAG 100104)
; #define GLU_TESS_EDGE_FLAG                   100104
(defconstant $GLU_EDGE_FLAG 100104)
; #define GLU_EDGE_FLAG                        100104
(defconstant $GLU_TESS_COMBINE 100105)
; #define GLU_TESS_COMBINE                     100105
(defconstant $GLU_TESS_BEGIN_DATA 100106)
; #define GLU_TESS_BEGIN_DATA                  100106
(defconstant $GLU_TESS_VERTEX_DATA 100107)
; #define GLU_TESS_VERTEX_DATA                 100107
(defconstant $GLU_TESS_END_DATA 100108)
; #define GLU_TESS_END_DATA                    100108
(defconstant $GLU_TESS_ERROR_DATA 100109)
; #define GLU_TESS_ERROR_DATA                  100109
(defconstant $GLU_TESS_EDGE_FLAG_DATA 100110)
; #define GLU_TESS_EDGE_FLAG_DATA              100110
(defconstant $GLU_TESS_COMBINE_DATA 100111)
; #define GLU_TESS_COMBINE_DATA                100111
;  TessContour 
(defconstant $GLU_CW 100120)
; #define GLU_CW                               100120
(defconstant $GLU_CCW 100121)
; #define GLU_CCW                              100121
(defconstant $GLU_INTERIOR 100122)
; #define GLU_INTERIOR                         100122
(defconstant $GLU_EXTERIOR 100123)
; #define GLU_EXTERIOR                         100123
(defconstant $GLU_UNKNOWN 100124)
; #define GLU_UNKNOWN                          100124
;  TessProperty 
(defconstant $GLU_TESS_WINDING_RULE 100140)
; #define GLU_TESS_WINDING_RULE                100140
(defconstant $GLU_TESS_BOUNDARY_ONLY 100141)
; #define GLU_TESS_BOUNDARY_ONLY               100141
(defconstant $GLU_TESS_TOLERANCE 100142)
; #define GLU_TESS_TOLERANCE                   100142
;  TessError 
(defconstant $GLU_TESS_ERROR1 100151)
; #define GLU_TESS_ERROR1                      100151
(defconstant $GLU_TESS_ERROR2 100152)
; #define GLU_TESS_ERROR2                      100152
(defconstant $GLU_TESS_ERROR3 100153)
; #define GLU_TESS_ERROR3                      100153
(defconstant $GLU_TESS_ERROR4 100154)
; #define GLU_TESS_ERROR4                      100154
(defconstant $GLU_TESS_ERROR5 100155)
; #define GLU_TESS_ERROR5                      100155
(defconstant $GLU_TESS_ERROR6 100156)
; #define GLU_TESS_ERROR6                      100156
(defconstant $GLU_TESS_ERROR7 100157)
; #define GLU_TESS_ERROR7                      100157
(defconstant $GLU_TESS_ERROR8 100158)
; #define GLU_TESS_ERROR8                      100158
(defconstant $GLU_TESS_MISSING_BEGIN_POLYGON 100151)
; #define GLU_TESS_MISSING_BEGIN_POLYGON       100151
(defconstant $GLU_TESS_MISSING_BEGIN_CONTOUR 100152)
; #define GLU_TESS_MISSING_BEGIN_CONTOUR       100152
(defconstant $GLU_TESS_MISSING_END_POLYGON 100153)
; #define GLU_TESS_MISSING_END_POLYGON         100153
(defconstant $GLU_TESS_MISSING_END_CONTOUR 100154)
; #define GLU_TESS_MISSING_END_CONTOUR         100154
(defconstant $GLU_TESS_COORD_TOO_LARGE 100155)
; #define GLU_TESS_COORD_TOO_LARGE             100155
(defconstant $GLU_TESS_NEED_COMBINE_CALLBACK 100156)
; #define GLU_TESS_NEED_COMBINE_CALLBACK       100156
;  TessWinding 
(defconstant $GLU_TESS_WINDING_ODD 100130)
; #define GLU_TESS_WINDING_ODD                 100130
(defconstant $GLU_TESS_WINDING_NONZERO 100131)
; #define GLU_TESS_WINDING_NONZERO             100131
(defconstant $GLU_TESS_WINDING_POSITIVE 100132)
; #define GLU_TESS_WINDING_POSITIVE            100132
(defconstant $GLU_TESS_WINDING_NEGATIVE 100133)
; #define GLU_TESS_WINDING_NEGATIVE            100133
(defconstant $GLU_TESS_WINDING_ABS_GEQ_TWO 100134)
; #define GLU_TESS_WINDING_ABS_GEQ_TWO         100134
; ***********************************************************
; #ifdef __cplusplus
#| #|
class GLUnurbs;
class GLUquadric;
class GLUtesselator;

typedef class GLUnurbs GLUnurbsObj;
typedef class GLUquadric GLUquadricObj;
typedef class GLUtesselator GLUtesselatorObj;
typedef class GLUtesselator GLUtriangulatorObj;
|#
 |#

; #else

;type name? (def-mactype :GLUnurbs (find-mactype ':GLUnurbs))

;type name? (def-mactype :GLUquadric (find-mactype ':GLUquadric))

;type name? (def-mactype :GLUtesselator (find-mactype ':GLUtesselator))

(def-mactype :GLUnurbsObj (find-mactype ':GLUnurbs))

(def-mactype :GLUquadricObj (find-mactype ':GLUquadric))

(def-mactype :GLUtesselatorObj (find-mactype ':GLUtesselator))

(def-mactype :GLUtriangulatorObj (find-mactype ':GLUtesselator))

; #endif

(defconstant $GLU_TESS_MAX_COORD 1.0E+150)
; #define GLU_TESS_MAX_COORD 1.0e150

(deftrap-inline "_gluBeginCurve" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluBeginPolygon" 
   ((tess (:pointer :GLUtesselator))
   )
   nil
() )

(deftrap-inline "_gluBeginSurface" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluBeginTrim" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluBuild1DMipmapLevels" 
   ((target :UInt32)
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

(deftrap-inline "_gluBuild1DMipmaps" 
   ((target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (format :UInt32)
    (type :UInt32)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild2DMipmapLevels" 
   ((target :UInt32)
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

(deftrap-inline "_gluBuild2DMipmaps" 
   ((target :UInt32)
    (internalFormat :signed-long)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (data :pointer)
   )
   :signed-long
() )

(deftrap-inline "_gluBuild3DMipmapLevels" 
   ((target :UInt32)
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

(deftrap-inline "_gluBuild3DMipmaps" 
   ((target :UInt32)
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

(deftrap-inline "_gluCheckExtension" 
   ((extName (:pointer :GLUBYTE))
    (extString (:pointer :GLUBYTE))
   )
   :UInt8
() )

(deftrap-inline "_gluCylinder" 
   ((quad (:pointer :GLUquadric))
    (base :double-float)
    (top :double-float)
    (height :double-float)
    (slices :signed-long)
    (stacks :signed-long)
   )
   nil
() )

(deftrap-inline "_gluDeleteNurbsRenderer" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluDeleteQuadric" 
   ((quad (:pointer :GLUquadric))
   )
   nil
() )

(deftrap-inline "_gluDeleteTess" 
   ((tess (:pointer :GLUtesselator))
   )
   nil
() )

(deftrap-inline "_gluDisk" 
   ((quad (:pointer :GLUquadric))
    (inner :double-float)
    (outer :double-float)
    (slices :signed-long)
    (loops :signed-long)
   )
   nil
() )

(deftrap-inline "_gluEndCurve" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluEndPolygon" 
   ((tess (:pointer :GLUtesselator))
   )
   nil
() )

(deftrap-inline "_gluEndSurface" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluEndTrim" 
   ((nurb (:pointer :GLUnurbs))
   )
   nil
() )

(deftrap-inline "_gluErrorString" 
   ((error :UInt32)
   )
   (:pointer :UInt8)
() )

(deftrap-inline "_gluGetNurbsProperty" 
   ((nurb (:pointer :GLUnurbs))
    (property :UInt32)
    (data (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_gluGetString" 
   ((name :UInt32)
   )
   (:pointer :UInt8)
() )

(deftrap-inline "_gluGetTessProperty" 
   ((tess (:pointer :GLUtesselator))
    (which :UInt32)
    (data (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_gluLoadSamplingMatrices" 
   ((nurb (:pointer :GLUnurbs))
    (model (:pointer :GLFLOAT))
    (perspective (:pointer :GLFLOAT))
    (view (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_gluLookAt" 
   ((eyeX :double-float)
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

(deftrap-inline "_gluNewNurbsRenderer" 
   (
   )
   (:pointer :GLUnurbs)
() )

(deftrap-inline "_gluNewQuadric" 
   (
   )
   (:pointer :GLUquadric)
() )

(deftrap-inline "_gluNewTess" 
   (
   )
   (:pointer :GLUtesselator)
() )

(deftrap-inline "_gluNextContour" 
   ((tess (:pointer :GLUtesselator))
    (type :UInt32)
   )
   nil
() )

(deftrap-inline "_gluNurbsCallback" 
   ((nurb (:pointer :GLUnurbs))
    (which :UInt32)
    (ARG2 :GLVOID)
   )
   nil
() )

(deftrap-inline "_gluNurbsCallbackData" 
   ((nurb (:pointer :GLUnurbs))
    (userData (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_gluNurbsCallbackDataEXT" 
   ((nurb (:pointer :GLUnurbs))
    (userData (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_gluNurbsCurve" 
   ((nurb (:pointer :GLUnurbs))
    (knotCount :signed-long)
    (knots (:pointer :GLFLOAT))
    (stride :signed-long)
    (control (:pointer :GLFLOAT))
    (order :signed-long)
    (type :UInt32)
   )
   nil
() )

(deftrap-inline "_gluNurbsProperty" 
   ((nurb (:pointer :GLUnurbs))
    (property :UInt32)
    (value :single-float)
   )
   nil
() )

(deftrap-inline "_gluNurbsSurface" 
   ((nurb (:pointer :GLUnurbs))
    (sKnotCount :signed-long)
    (sKnots (:pointer :GLFLOAT))
    (tKnotCount :signed-long)
    (tKnots (:pointer :GLFLOAT))
    (sStride :signed-long)
    (tStride :signed-long)
    (control (:pointer :GLFLOAT))
    (sOrder :signed-long)
    (tOrder :signed-long)
    (type :UInt32)
   )
   nil
() )

(deftrap-inline "_gluOrtho2D" 
   ((left :double-float)
    (right :double-float)
    (bottom :double-float)
    (top :double-float)
   )
   nil
() )

(deftrap-inline "_gluPartialDisk" 
   ((quad (:pointer :GLUquadric))
    (inner :double-float)
    (outer :double-float)
    (slices :signed-long)
    (loops :signed-long)
    (start :double-float)
    (sweep :double-float)
   )
   nil
() )

(deftrap-inline "_gluPerspective" 
   ((fovy :double-float)
    (aspect :double-float)
    (zNear :double-float)
    (zFar :double-float)
   )
   nil
() )

(deftrap-inline "_gluPickMatrix" 
   ((x :double-float)
    (y :double-float)
    (delX :double-float)
    (delY :double-float)
    (viewport (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_gluProject" 
   ((objX :double-float)
    (objY :double-float)
    (objZ :double-float)
    (model (:pointer :GLDOUBLE))
    (proj (:pointer :GLDOUBLE))
    (view (:pointer :GLINT))
    (winX (:pointer :GLDOUBLE))
    (winY (:pointer :GLDOUBLE))
    (winZ (:pointer :GLDOUBLE))
   )
   :signed-long
() )

(deftrap-inline "_gluPwlCurve" 
   ((nurb (:pointer :GLUnurbs))
    (count :signed-long)
    (data (:pointer :GLFLOAT))
    (stride :signed-long)
    (type :UInt32)
   )
   nil
() )

(deftrap-inline "_gluQuadricCallback" 
   ((quad (:pointer :GLUquadric))
    (which :UInt32)
    (ARG2 :GLVOID)
   )
   nil
() )

(deftrap-inline "_gluQuadricDrawStyle" 
   ((quad (:pointer :GLUquadric))
    (draw :UInt32)
   )
   nil
() )

(deftrap-inline "_gluQuadricNormals" 
   ((quad (:pointer :GLUquadric))
    (normal :UInt32)
   )
   nil
() )

(deftrap-inline "_gluQuadricOrientation" 
   ((quad (:pointer :GLUquadric))
    (orientation :UInt32)
   )
   nil
() )

(deftrap-inline "_gluQuadricTexture" 
   ((quad (:pointer :GLUquadric))
    (texture :UInt8)
   )
   nil
() )

(deftrap-inline "_gluScaleImage" 
   ((format :UInt32)
    (wIn :signed-long)
    (hIn :signed-long)
    (typeIn :UInt32)
    (dataIn :pointer)
    (wOut :signed-long)
    (hOut :signed-long)
    (typeOut :UInt32)
    (dataOut (:pointer :GLVOID))
   )
   :signed-long
() )

(deftrap-inline "_gluSphere" 
   ((quad (:pointer :GLUquadric))
    (radius :double-float)
    (slices :signed-long)
    (stacks :signed-long)
   )
   nil
() )

(deftrap-inline "_gluTessBeginContour" 
   ((tess (:pointer :GLUtesselator))
   )
   nil
() )

(deftrap-inline "_gluTessBeginPolygon" 
   ((tess (:pointer :GLUtesselator))
    (data (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_gluTessCallback" 
   ((tess (:pointer :GLUtesselator))
    (which :UInt32)
    (ARG2 :GLVOID)
   )
   nil
() )

(deftrap-inline "_gluTessEndContour" 
   ((tess (:pointer :GLUtesselator))
   )
   nil
() )

(deftrap-inline "_gluTessEndPolygon" 
   ((tess (:pointer :GLUtesselator))
   )
   nil
() )

(deftrap-inline "_gluTessNormal" 
   ((tess (:pointer :GLUtesselator))
    (valueX :double-float)
    (valueY :double-float)
    (valueZ :double-float)
   )
   nil
() )

(deftrap-inline "_gluTessProperty" 
   ((tess (:pointer :GLUtesselator))
    (which :UInt32)
    (data :double-float)
   )
   nil
() )

(deftrap-inline "_gluTessVertex" 
   ((tess (:pointer :GLUtesselator))
    (location (:pointer :GLDOUBLE))
    (data (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_gluUnProject" 
   ((winX :double-float)
    (winY :double-float)
    (winZ :double-float)
    (model (:pointer :GLDOUBLE))
    (proj (:pointer :GLDOUBLE))
    (view (:pointer :GLINT))
    (objX (:pointer :GLDOUBLE))
    (objY (:pointer :GLDOUBLE))
    (objZ (:pointer :GLDOUBLE))
   )
   :signed-long
() )

(deftrap-inline "_gluUnProject4" 
   ((winX :double-float)
    (winY :double-float)
    (winZ :double-float)
    (clipW :double-float)
    (model (:pointer :GLDOUBLE))
    (proj (:pointer :GLDOUBLE))
    (view (:pointer :GLINT))
    (near :double-float)
    (far :double-float)
    (objX (:pointer :GLDOUBLE))
    (objY (:pointer :GLDOUBLE))
    (objZ (:pointer :GLDOUBLE))
    (objW (:pointer :GLDOUBLE))
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __glu_h__ */


(provide-interface "glu")