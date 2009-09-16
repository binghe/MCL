(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:gl.h"
; at Sunday July 2,2006 7:25:32 pm.
; #ifndef __gl_h_
; #define __gl_h_
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** License Applicability. Except to the extent portions of this file are
; ** made subject to an alternative license as permitted in the SGI Free
; ** Software License B, Version 1.1 (the "License"), the contents of this
; ** file are subject only to the provisions of the License. You may not use
; ** this file except in compliance with the License. You may obtain a copy
; ** of the License at Silicon Graphics, Inc., attn: Legal Services, 1600
; ** Amphitheatre Parkway, Mountain View, CA 94043-1351, or at:
; ** 
; ** http://oss.sgi.com/projects/FreeB
; ** 
; ** Note that, as provided in the License, the Software is distributed on an
; ** "AS IS" basis, with ALL EXPRESS AND IMPLIED WARRANTIES AND CONDITIONS
; ** DISCLAIMED, INCLUDING, WITHOUT LIMITATION, ANY IMPLIED WARRANTIES AND
; ** CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A
; ** PARTICULAR PURPOSE, AND NON-INFRINGEMENT.
; ** 
; ** Original Code. The Original Code is: OpenGL Sample Implementation,
; ** Version 1.2.1, released January 26, 2000, developed by Silicon Graphics,
; ** Inc. The Original Code is Copyright (c) 1991-2000 Silicon Graphics, Inc.
; ** Copyright in any portions created by third parties is as indicated
; ** elsewhere herein. All Rights Reserved.
; ** 
; ** Additional Notice Provisions: This software was created using the
; ** OpenGL(R) version 1.2.1 Sample Implementation published by SGI, but has
; ** not been independently verified as being compliant with the OpenGL(R)
; ** version 1.2.1 Specification.
; 
;  switches to providing function pointers
; #define GL_GLEXT_FUNCTION_POINTERS 1

(def-mactype :GLenum (find-mactype ':UInt32))

(def-mactype :GLboolean (find-mactype ':UInt8))

(def-mactype :GLbitfield (find-mactype ':UInt32))

(def-mactype :GLbyte (find-mactype ':SInt8))

(def-mactype :GLshort (find-mactype ':SInt16))

(def-mactype :GLint (find-mactype ':signed-long))

(def-mactype :GLsizei (find-mactype ':signed-long))

(def-mactype :GLubyte (find-mactype ':UInt8))

(def-mactype :GLushort (find-mactype ':UInt16))

(def-mactype :GLuint (find-mactype ':UInt32))

(def-mactype :GLfloat (find-mactype ':single-float))

(def-mactype :GLclampf (find-mactype ':single-float))

(def-mactype :GLdouble (find-mactype ':double-float))

(def-mactype :GLclampd (find-mactype ':double-float))

(def-mactype :GLvoid (find-mactype ':void))
;  For compatibility with OpenGL v1.0 
; #define GL_LOGIC_OP GL_INDEX_LOGIC_OP
; #define GL_TEXTURE_COMPONENTS GL_TEXTURE_INTERNAL_FORMAT
; ***********************************************************
;  Version 
(defconstant $GL_VERSION_1_1 1)
; #define GL_VERSION_1_1                    1
(defconstant $GL_VERSION_1_2 1)
; #define GL_VERSION_1_2                    1
(defconstant $GL_VERSION_1_3 1)
; #define GL_VERSION_1_3                    1
(defconstant $GL_VERSION_1_4 1)
; #define GL_VERSION_1_4                    1
;  AccumOp 
(defconstant $GL_ACCUM 256)
; #define GL_ACCUM                          0x0100
(defconstant $GL_LOAD 257)
; #define GL_LOAD                           0x0101
(defconstant $GL_RETURN 258)
; #define GL_RETURN                         0x0102
(defconstant $GL_MULT 259)
; #define GL_MULT                           0x0103
(defconstant $GL_ADD 260)
; #define GL_ADD                            0x0104
;  AlphaFunction 
(defconstant $GL_NEVER 512)
; #define GL_NEVER                          0x0200
(defconstant $GL_LESS 513)
; #define GL_LESS                           0x0201
(defconstant $GL_EQUAL 514)
; #define GL_EQUAL                          0x0202
(defconstant $GL_LEQUAL 515)
; #define GL_LEQUAL                         0x0203
(defconstant $GL_GREATER 516)
; #define GL_GREATER                        0x0204
(defconstant $GL_NOTEQUAL 517)
; #define GL_NOTEQUAL                       0x0205
(defconstant $GL_GEQUAL 518)
; #define GL_GEQUAL                         0x0206
(defconstant $GL_ALWAYS 519)
; #define GL_ALWAYS                         0x0207
;  AttribMask 
(defconstant $GL_CURRENT_BIT 1)
; #define GL_CURRENT_BIT                    0x00000001
(defconstant $GL_POINT_BIT 2)
; #define GL_POINT_BIT                      0x00000002
(defconstant $GL_LINE_BIT 4)
; #define GL_LINE_BIT                       0x00000004
(defconstant $GL_POLYGON_BIT 8)
; #define GL_POLYGON_BIT                    0x00000008
(defconstant $GL_POLYGON_STIPPLE_BIT 16)
; #define GL_POLYGON_STIPPLE_BIT            0x00000010
(defconstant $GL_PIXEL_MODE_BIT 32)
; #define GL_PIXEL_MODE_BIT                 0x00000020
(defconstant $GL_LIGHTING_BIT 64)
; #define GL_LIGHTING_BIT                   0x00000040
(defconstant $GL_FOG_BIT 128)
; #define GL_FOG_BIT                        0x00000080
(defconstant $GL_DEPTH_BUFFER_BIT 256)
; #define GL_DEPTH_BUFFER_BIT               0x00000100
(defconstant $GL_ACCUM_BUFFER_BIT 512)
; #define GL_ACCUM_BUFFER_BIT               0x00000200
(defconstant $GL_STENCIL_BUFFER_BIT 1024)
; #define GL_STENCIL_BUFFER_BIT             0x00000400
(defconstant $GL_VIEWPORT_BIT 2048)
; #define GL_VIEWPORT_BIT                   0x00000800
(defconstant $GL_TRANSFORM_BIT 4096)
; #define GL_TRANSFORM_BIT                  0x00001000
(defconstant $GL_ENABLE_BIT 8192)
; #define GL_ENABLE_BIT                     0x00002000
(defconstant $GL_COLOR_BUFFER_BIT 16384)
; #define GL_COLOR_BUFFER_BIT               0x00004000
(defconstant $GL_HINT_BIT 32768)
; #define GL_HINT_BIT                       0x00008000
(defconstant $GL_EVAL_BIT 65536)
; #define GL_EVAL_BIT                       0x00010000
(defconstant $GL_LIST_BIT 131072)
; #define GL_LIST_BIT                       0x00020000
(defconstant $GL_TEXTURE_BIT 262144)
; #define GL_TEXTURE_BIT                    0x00040000
(defconstant $GL_SCISSOR_BIT 524288)
; #define GL_SCISSOR_BIT                    0x00080000
(defconstant $GL_ALL_ATTRIB_BITS 1048575)
; #define GL_ALL_ATTRIB_BITS                0x000fffff
;  BeginMode 
(defconstant $GL_POINTS 0)
; #define GL_POINTS                         0x0000
(defconstant $GL_LINES 1)
; #define GL_LINES                          0x0001
(defconstant $GL_LINE_LOOP 2)
; #define GL_LINE_LOOP                      0x0002
(defconstant $GL_LINE_STRIP 3)
; #define GL_LINE_STRIP                     0x0003
(defconstant $GL_TRIANGLES 4)
; #define GL_TRIANGLES                      0x0004
(defconstant $GL_TRIANGLE_STRIP 5)
; #define GL_TRIANGLE_STRIP                 0x0005
(defconstant $GL_TRIANGLE_FAN 6)
; #define GL_TRIANGLE_FAN                   0x0006
(defconstant $GL_QUADS 7)
; #define GL_QUADS                          0x0007
(defconstant $GL_QUAD_STRIP 8)
; #define GL_QUAD_STRIP                     0x0008
(defconstant $GL_POLYGON 9)
; #define GL_POLYGON                        0x0009
;  BlendEquationMode 
;       GL_LOGIC_OP 
;       GL_FUNC_ADD 
;       GL_MIN 
;       GL_MAX 
;       GL_FUNC_SUBTRACT 
;       GL_FUNC_REVERSE_SUBTRACT 
;  BlendingFactorDest 
(defconstant $GL_ZERO 0)
; #define GL_ZERO                           0
(defconstant $GL_ONE 1)
; #define GL_ONE                            1
(defconstant $GL_SRC_COLOR 768)
; #define GL_SRC_COLOR                      0x0300
(defconstant $GL_ONE_MINUS_SRC_COLOR 769)
; #define GL_ONE_MINUS_SRC_COLOR            0x0301
(defconstant $GL_SRC_ALPHA 770)
; #define GL_SRC_ALPHA                      0x0302
(defconstant $GL_ONE_MINUS_SRC_ALPHA 771)
; #define GL_ONE_MINUS_SRC_ALPHA            0x0303
(defconstant $GL_DST_ALPHA 772)
; #define GL_DST_ALPHA                      0x0304
(defconstant $GL_ONE_MINUS_DST_ALPHA 773)
; #define GL_ONE_MINUS_DST_ALPHA            0x0305
;       GL_CONSTANT_COLOR 
;       GL_ONE_MINUS_CONSTANT_COLOR 
;       GL_CONSTANT_ALPHA 
;       GL_ONE_MINUS_CONSTANT_ALPHA 
;  BlendingFactorSrc 
;       GL_ZERO 
;       GL_ONE 
(defconstant $GL_DST_COLOR 774)
; #define GL_DST_COLOR                      0x0306
(defconstant $GL_ONE_MINUS_DST_COLOR 775)
; #define GL_ONE_MINUS_DST_COLOR            0x0307
(defconstant $GL_SRC_ALPHA_SATURATE 776)
; #define GL_SRC_ALPHA_SATURATE             0x0308
;       GL_SRC_ALPHA 
;       GL_ONE_MINUS_SRC_ALPHA 
;       GL_DST_ALPHA 
;       GL_ONE_MINUS_DST_ALPHA 
;       GL_CONSTANT_COLOR 
;       GL_ONE_MINUS_CONSTANT_COLOR 
;       GL_CONSTANT_ALPHA 
;       GL_ONE_MINUS_CONSTANT_ALPHA 
;  Boolean 
(defconstant $GL_TRUE 1)
; #define GL_TRUE                           1
(defconstant $GL_FALSE 0)
; #define GL_FALSE                          0
;  ClearBufferMask 
;       GL_COLOR_BUFFER_BIT 
;       GL_ACCUM_BUFFER_BIT 
;       GL_STENCIL_BUFFER_BIT 
;       GL_DEPTH_BUFFER_BIT 
;  ClientArrayType 
;       GL_VERTEX_ARRAY 
;       GL_NORMAL_ARRAY 
;       GL_COLOR_ARRAY 
;       GL_INDEX_ARRAY 
;       GL_TEXTURE_COORD_ARRAY 
;       GL_EDGE_FLAG_ARRAY 
;  ClipPlaneName 
(defconstant $GL_CLIP_PLANE0 12288)
; #define GL_CLIP_PLANE0                    0x3000
(defconstant $GL_CLIP_PLANE1 12289)
; #define GL_CLIP_PLANE1                    0x3001
(defconstant $GL_CLIP_PLANE2 12290)
; #define GL_CLIP_PLANE2                    0x3002
(defconstant $GL_CLIP_PLANE3 12291)
; #define GL_CLIP_PLANE3                    0x3003
(defconstant $GL_CLIP_PLANE4 12292)
; #define GL_CLIP_PLANE4                    0x3004
(defconstant $GL_CLIP_PLANE5 12293)
; #define GL_CLIP_PLANE5                    0x3005
;  ColorMaterialFace 
;       GL_FRONT 
;       GL_BACK 
;       GL_FRONT_AND_BACK 
;  ColorMaterialParameter 
;       GL_AMBIENT 
;       GL_DIFFUSE 
;       GL_SPECULAR 
;       GL_EMISSION 
;       GL_AMBIENT_AND_DIFFUSE 
;  ColorPointerType 
;       GL_BYTE 
;       GL_UNSIGNED_BYTE 
;       GL_SHORT 
;       GL_UNSIGNED_SHORT 
;       GL_INT 
;       GL_UNSIGNED_INT 
;       GL_FLOAT 
;       GL_DOUBLE 
;  ColorTableParameterPName 
;       GL_COLOR_TABLE_SCALE 
;       GL_COLOR_TABLE_BIAS 
;  ColorTableTarget 
;       GL_COLOR_TABLE 
;       GL_POST_CONVOLUTION_COLOR_TABLE 
;       GL_POST_COLOR_MATRIX_COLOR_TABLE 
;       GL_PROXY_COLOR_TABLE 
;       GL_PROXY_POST_CONVOLUTION_COLOR_TABLE 
;       GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE 
;  ConvolutionBorderMode 
;       GL_REDUCE 
;       GL_IGNORE_BORDER 
;       GL_CONSTANT_BORDER 
;  ConvolutionParameter 
;       GL_CONVOLUTION_BORDER_MODE 
;       GL_CONVOLUTION_FILTER_SCALE 
;       GL_CONVOLUTION_FILTER_BIAS 
;  ConvolutionTarget 
;       GL_CONVOLUTION_1D 
;       GL_CONVOLUTION_2D 
;  CullFaceMode 
;       GL_FRONT 
;       GL_BACK 
;       GL_FRONT_AND_BACK 
;  DataType 
(defconstant $GL_BYTE 5120)
; #define GL_BYTE                           0x1400
(defconstant $GL_UNSIGNED_BYTE 5121)
; #define GL_UNSIGNED_BYTE                  0x1401
(defconstant $GL_SHORT 5122)
; #define GL_SHORT                          0x1402
(defconstant $GL_UNSIGNED_SHORT 5123)
; #define GL_UNSIGNED_SHORT                 0x1403
(defconstant $GL_INT 5124)
; #define GL_INT                            0x1404
(defconstant $GL_UNSIGNED_INT 5125)
; #define GL_UNSIGNED_INT                   0x1405
(defconstant $GL_FLOAT 5126)
; #define GL_FLOAT                          0x1406
(defconstant $GL_2_BYTES 5127)
; #define GL_2_BYTES                        0x1407
(defconstant $GL_3_BYTES 5128)
; #define GL_3_BYTES                        0x1408
(defconstant $GL_4_BYTES 5129)
; #define GL_4_BYTES                        0x1409
(defconstant $GL_DOUBLE 5130)
; #define GL_DOUBLE                         0x140A
;  DepthFunction 
;       GL_NEVER 
;       GL_LESS 
;       GL_EQUAL 
;       GL_LEQUAL 
;       GL_GREATER 
;       GL_NOTEQUAL 
;       GL_GEQUAL 
;       GL_ALWAYS 
;  DrawBufferMode 
(defconstant $GL_NONE 0)
; #define GL_NONE                           0
(defconstant $GL_FRONT_LEFT 1024)
; #define GL_FRONT_LEFT                     0x0400
(defconstant $GL_FRONT_RIGHT 1025)
; #define GL_FRONT_RIGHT                    0x0401
(defconstant $GL_BACK_LEFT 1026)
; #define GL_BACK_LEFT                      0x0402
(defconstant $GL_BACK_RIGHT 1027)
; #define GL_BACK_RIGHT                     0x0403
(defconstant $GL_FRONT 1028)
; #define GL_FRONT                          0x0404
(defconstant $GL_BACK 1029)
; #define GL_BACK                           0x0405
(defconstant $GL_LEFT 1030)
; #define GL_LEFT                           0x0406
(defconstant $GL_RIGHT 1031)
; #define GL_RIGHT                          0x0407
(defconstant $GL_FRONT_AND_BACK 1032)
; #define GL_FRONT_AND_BACK                 0x0408
(defconstant $GL_AUX0 1033)
; #define GL_AUX0                           0x0409
(defconstant $GL_AUX1 1034)
; #define GL_AUX1                           0x040A
(defconstant $GL_AUX2 1035)
; #define GL_AUX2                           0x040B
(defconstant $GL_AUX3 1036)
; #define GL_AUX3                           0x040C
;  Enable 
;       GL_FOG 
;       GL_LIGHTING 
;       GL_TEXTURE_1D 
;       GL_TEXTURE_2D 
;       GL_LINE_STIPPLE 
;       GL_POLYGON_STIPPLE 
;       GL_CULL_FACE 
;       GL_ALPHA_TEST 
;       GL_BLEND 
;       GL_INDEX_LOGIC_OP 
;       GL_COLOR_LOGIC_OP 
;       GL_DITHER 
;       GL_STENCIL_TEST 
;       GL_DEPTH_TEST 
;       GL_CLIP_PLANE0 
;       GL_CLIP_PLANE1 
;       GL_CLIP_PLANE2 
;       GL_CLIP_PLANE3 
;       GL_CLIP_PLANE4 
;       GL_CLIP_PLANE5 
;       GL_LIGHT0 
;       GL_LIGHT1 
;       GL_LIGHT2 
;       GL_LIGHT3 
;       GL_LIGHT4 
;       GL_LIGHT5 
;       GL_LIGHT6 
;       GL_LIGHT7 
;       GL_TEXTURE_GEN_S 
;       GL_TEXTURE_GEN_T 
;       GL_TEXTURE_GEN_R 
;       GL_TEXTURE_GEN_Q 
;       GL_MAP1_VERTEX_3 
;       GL_MAP1_VERTEX_4 
;       GL_MAP1_COLOR_4 
;       GL_MAP1_INDEX 
;       GL_MAP1_NORMAL 
;       GL_MAP1_TEXTURE_COORD_1 
;       GL_MAP1_TEXTURE_COORD_2 
;       GL_MAP1_TEXTURE_COORD_3 
;       GL_MAP1_TEXTURE_COORD_4 
;       GL_MAP2_VERTEX_3 
;       GL_MAP2_VERTEX_4 
;       GL_MAP2_COLOR_4 
;       GL_MAP2_INDEX 
;       GL_MAP2_NORMAL 
;       GL_MAP2_TEXTURE_COORD_1 
;       GL_MAP2_TEXTURE_COORD_2 
;       GL_MAP2_TEXTURE_COORD_3 
;       GL_MAP2_TEXTURE_COORD_4 
;       GL_POINT_SMOOTH 
;       GL_LINE_SMOOTH 
;       GL_POLYGON_SMOOTH 
;       GL_SCISSOR_TEST 
;       GL_COLOR_MATERIAL 
;       GL_NORMALIZE 
;       GL_AUTO_NORMAL 
;       GL_VERTEX_ARRAY 
;       GL_NORMAL_ARRAY 
;       GL_COLOR_ARRAY 
;       GL_INDEX_ARRAY 
;       GL_TEXTURE_COORD_ARRAY 
;       GL_EDGE_FLAG_ARRAY 
;       GL_POLYGON_OFFSET_POINT 
;       GL_POLYGON_OFFSET_LINE 
;       GL_POLYGON_OFFSET_FILL 
;       GL_COLOR_TABLE 
;       GL_POST_CONVOLUTION_COLOR_TABLE 
;       GL_POST_COLOR_MATRIX_COLOR_TABLE 
;       GL_CONVOLUTION_1D 
;       GL_CONVOLUTION_2D 
;       GL_SEPARABLE_2D 
;       GL_HISTOGRAM 
;       GL_MINMAX 
;       GL_RESCALE_NORMAL 
;       GL_TEXTURE_3D 
;  ErrorCode 
(defconstant $GL_NO_ERROR 0)
; #define GL_NO_ERROR                       0
(defconstant $GL_INVALID_ENUM 1280)
; #define GL_INVALID_ENUM                   0x0500
(defconstant $GL_INVALID_VALUE 1281)
; #define GL_INVALID_VALUE                  0x0501
(defconstant $GL_INVALID_OPERATION 1282)
; #define GL_INVALID_OPERATION              0x0502
(defconstant $GL_STACK_OVERFLOW 1283)
; #define GL_STACK_OVERFLOW                 0x0503
(defconstant $GL_STACK_UNDERFLOW 1284)
; #define GL_STACK_UNDERFLOW                0x0504
(defconstant $GL_OUT_OF_MEMORY 1285)
; #define GL_OUT_OF_MEMORY                  0x0505
;       GL_TABLE_TOO_LARGE 
;  FeedBackMode 
(defconstant $GL_2D 1536)
; #define GL_2D                             0x0600
(defconstant $GL_3D 1537)
; #define GL_3D                             0x0601
(defconstant $GL_3D_COLOR 1538)
; #define GL_3D_COLOR                       0x0602
(defconstant $GL_3D_COLOR_TEXTURE 1539)
; #define GL_3D_COLOR_TEXTURE               0x0603
(defconstant $GL_4D_COLOR_TEXTURE 1540)
; #define GL_4D_COLOR_TEXTURE               0x0604
;  FeedBackToken 
(defconstant $GL_PASS_THROUGH_TOKEN 1792)
; #define GL_PASS_THROUGH_TOKEN             0x0700
(defconstant $GL_POINT_TOKEN 1793)
; #define GL_POINT_TOKEN                    0x0701
(defconstant $GL_LINE_TOKEN 1794)
; #define GL_LINE_TOKEN                     0x0702
(defconstant $GL_POLYGON_TOKEN 1795)
; #define GL_POLYGON_TOKEN                  0x0703
(defconstant $GL_BITMAP_TOKEN 1796)
; #define GL_BITMAP_TOKEN                   0x0704
(defconstant $GL_DRAW_PIXEL_TOKEN 1797)
; #define GL_DRAW_PIXEL_TOKEN               0x0705
(defconstant $GL_COPY_PIXEL_TOKEN 1798)
; #define GL_COPY_PIXEL_TOKEN               0x0706
(defconstant $GL_LINE_RESET_TOKEN 1799)
; #define GL_LINE_RESET_TOKEN               0x0707
;  FogMode 
;       GL_LINEAR 
(defconstant $GL_EXP 2048)
; #define GL_EXP                            0x0800
(defconstant $GL_EXP2 2049)
; #define GL_EXP2                           0x0801
;  FogParameter 
;       GL_FOG_COLOR 
;       GL_FOG_DENSITY 
;       GL_FOG_END 
;       GL_FOG_INDEX 
;       GL_FOG_MODE 
;       GL_FOG_START 
;  FrontFaceDirection 
(defconstant $GL_CW 2304)
; #define GL_CW                             0x0900
(defconstant $GL_CCW 2305)
; #define GL_CCW                            0x0901
;  GetColorTableParameterPName 
;       GL_COLOR_TABLE_SCALE 
;       GL_COLOR_TABLE_BIAS 
;       GL_COLOR_TABLE_FORMAT 
;       GL_COLOR_TABLE_WIDTH 
;       GL_COLOR_TABLE_RED_SIZE 
;       GL_COLOR_TABLE_GREEN_SIZE 
;       GL_COLOR_TABLE_BLUE_SIZE 
;       GL_COLOR_TABLE_ALPHA_SIZE 
;       GL_COLOR_TABLE_LUMINANCE_SIZE 
;       GL_COLOR_TABLE_INTENSITY_SIZE 
;  GetConvolutionParameterPName 
;       GL_CONVOLUTION_BORDER_COLOR 
;       GL_CONVOLUTION_BORDER_MODE 
;       GL_CONVOLUTION_FILTER_SCALE 
;       GL_CONVOLUTION_FILTER_BIAS 
;       GL_CONVOLUTION_FORMAT 
;       GL_CONVOLUTION_WIDTH 
;       GL_CONVOLUTION_HEIGHT 
;       GL_MAX_CONVOLUTION_WIDTH 
;       GL_MAX_CONVOLUTION_HEIGHT 
;  GetHistogramParameterPName 
;       GL_HISTOGRAM_WIDTH 
;       GL_HISTOGRAM_FORMAT 
;       GL_HISTOGRAM_RED_SIZE 
;       GL_HISTOGRAM_GREEN_SIZE 
;       GL_HISTOGRAM_BLUE_SIZE 
;       GL_HISTOGRAM_ALPHA_SIZE 
;       GL_HISTOGRAM_LUMINANCE_SIZE 
;       GL_HISTOGRAM_SINK 
;  GetMapTarget 
(defconstant $GL_COEFF 2560)
; #define GL_COEFF                          0x0A00
(defconstant $GL_ORDER 2561)
; #define GL_ORDER                          0x0A01
(defconstant $GL_DOMAIN 2562)
; #define GL_DOMAIN                         0x0A02
;  GetMinmaxParameterPName 
;       GL_MINMAX_FORMAT 
;       GL_MINMAX_SINK 
;  GetPixelMap 
;       GL_PIXEL_MAP_I_TO_I 
;       GL_PIXEL_MAP_S_TO_S 
;       GL_PIXEL_MAP_I_TO_R 
;       GL_PIXEL_MAP_I_TO_G 
;       GL_PIXEL_MAP_I_TO_B 
;       GL_PIXEL_MAP_I_TO_A 
;       GL_PIXEL_MAP_R_TO_R 
;       GL_PIXEL_MAP_G_TO_G 
;       GL_PIXEL_MAP_B_TO_B 
;       GL_PIXEL_MAP_A_TO_A 
;  GetPointerTarget 
;       GL_VERTEX_ARRAY_POINTER 
;       GL_NORMAL_ARRAY_POINTER 
;       GL_COLOR_ARRAY_POINTER 
;       GL_INDEX_ARRAY_POINTER 
;       GL_TEXTURE_COORD_ARRAY_POINTER 
;       GL_EDGE_FLAG_ARRAY_POINTER 
;  GetTarget 
(defconstant $GL_CURRENT_COLOR 2816)
; #define GL_CURRENT_COLOR                  0x0B00
(defconstant $GL_CURRENT_INDEX 2817)
; #define GL_CURRENT_INDEX                  0x0B01
(defconstant $GL_CURRENT_NORMAL 2818)
; #define GL_CURRENT_NORMAL                 0x0B02
(defconstant $GL_CURRENT_TEXTURE_COORDS 2819)
; #define GL_CURRENT_TEXTURE_COORDS         0x0B03
(defconstant $GL_CURRENT_RASTER_COLOR 2820)
; #define GL_CURRENT_RASTER_COLOR           0x0B04
(defconstant $GL_CURRENT_RASTER_INDEX 2821)
; #define GL_CURRENT_RASTER_INDEX           0x0B05
(defconstant $GL_CURRENT_RASTER_TEXTURE_COORDS 2822)
; #define GL_CURRENT_RASTER_TEXTURE_COORDS  0x0B06
(defconstant $GL_CURRENT_RASTER_POSITION 2823)
; #define GL_CURRENT_RASTER_POSITION        0x0B07
(defconstant $GL_CURRENT_RASTER_POSITION_VALID 2824)
; #define GL_CURRENT_RASTER_POSITION_VALID  0x0B08
(defconstant $GL_CURRENT_RASTER_DISTANCE 2825)
; #define GL_CURRENT_RASTER_DISTANCE        0x0B09
(defconstant $GL_POINT_SMOOTH 2832)
; #define GL_POINT_SMOOTH                   0x0B10
(defconstant $GL_POINT_SIZE 2833)
; #define GL_POINT_SIZE                     0x0B11
(defconstant $GL_POINT_SIZE_RANGE 2834)
; #define GL_POINT_SIZE_RANGE               0x0B12
(defconstant $GL_POINT_SIZE_GRANULARITY 2835)
; #define GL_POINT_SIZE_GRANULARITY         0x0B13
(defconstant $GL_LINE_SMOOTH 2848)
; #define GL_LINE_SMOOTH                    0x0B20
(defconstant $GL_LINE_WIDTH 2849)
; #define GL_LINE_WIDTH                     0x0B21
(defconstant $GL_LINE_WIDTH_RANGE 2850)
; #define GL_LINE_WIDTH_RANGE               0x0B22
(defconstant $GL_LINE_WIDTH_GRANULARITY 2851)
; #define GL_LINE_WIDTH_GRANULARITY         0x0B23
(defconstant $GL_LINE_STIPPLE 2852)
; #define GL_LINE_STIPPLE                   0x0B24
(defconstant $GL_LINE_STIPPLE_PATTERN 2853)
; #define GL_LINE_STIPPLE_PATTERN           0x0B25
(defconstant $GL_LINE_STIPPLE_REPEAT 2854)
; #define GL_LINE_STIPPLE_REPEAT            0x0B26
;       GL_SMOOTH_POINT_SIZE_RANGE 
;       GL_SMOOTH_POINT_SIZE_GRANULARITY 
;       GL_SMOOTH_LINE_WIDTH_RANGE 
;       GL_SMOOTH_LINE_WIDTH_GRANULARITY 
;       GL_ALIASED_POINT_SIZE_RANGE 
;       GL_ALIASED_LINE_WIDTH_RANGE 
(defconstant $GL_LIST_MODE 2864)
; #define GL_LIST_MODE                      0x0B30
(defconstant $GL_MAX_LIST_NESTING 2865)
; #define GL_MAX_LIST_NESTING               0x0B31
(defconstant $GL_LIST_BASE 2866)
; #define GL_LIST_BASE                      0x0B32
(defconstant $GL_LIST_INDEX 2867)
; #define GL_LIST_INDEX                     0x0B33
(defconstant $GL_POLYGON_MODE 2880)
; #define GL_POLYGON_MODE                   0x0B40
(defconstant $GL_POLYGON_SMOOTH 2881)
; #define GL_POLYGON_SMOOTH                 0x0B41
(defconstant $GL_POLYGON_STIPPLE 2882)
; #define GL_POLYGON_STIPPLE                0x0B42
(defconstant $GL_EDGE_FLAG 2883)
; #define GL_EDGE_FLAG                      0x0B43
(defconstant $GL_CULL_FACE 2884)
; #define GL_CULL_FACE                      0x0B44
(defconstant $GL_CULL_FACE_MODE 2885)
; #define GL_CULL_FACE_MODE                 0x0B45
(defconstant $GL_FRONT_FACE 2886)
; #define GL_FRONT_FACE                     0x0B46
(defconstant $GL_LIGHTING 2896)
; #define GL_LIGHTING                       0x0B50
(defconstant $GL_LIGHT_MODEL_LOCAL_VIEWER 2897)
; #define GL_LIGHT_MODEL_LOCAL_VIEWER       0x0B51
(defconstant $GL_LIGHT_MODEL_TWO_SIDE 2898)
; #define GL_LIGHT_MODEL_TWO_SIDE           0x0B52
(defconstant $GL_LIGHT_MODEL_AMBIENT 2899)
; #define GL_LIGHT_MODEL_AMBIENT            0x0B53
(defconstant $GL_SHADE_MODEL 2900)
; #define GL_SHADE_MODEL                    0x0B54
(defconstant $GL_COLOR_MATERIAL_FACE 2901)
; #define GL_COLOR_MATERIAL_FACE            0x0B55
(defconstant $GL_COLOR_MATERIAL_PARAMETER 2902)
; #define GL_COLOR_MATERIAL_PARAMETER       0x0B56
(defconstant $GL_COLOR_MATERIAL 2903)
; #define GL_COLOR_MATERIAL                 0x0B57
(defconstant $GL_FOG 2912)
; #define GL_FOG                            0x0B60
(defconstant $GL_FOG_INDEX 2913)
; #define GL_FOG_INDEX                      0x0B61
(defconstant $GL_FOG_DENSITY 2914)
; #define GL_FOG_DENSITY                    0x0B62
(defconstant $GL_FOG_START 2915)
; #define GL_FOG_START                      0x0B63
(defconstant $GL_FOG_END 2916)
; #define GL_FOG_END                        0x0B64
(defconstant $GL_FOG_MODE 2917)
; #define GL_FOG_MODE                       0x0B65
(defconstant $GL_FOG_COLOR 2918)
; #define GL_FOG_COLOR                      0x0B66
(defconstant $GL_DEPTH_RANGE 2928)
; #define GL_DEPTH_RANGE                    0x0B70
(defconstant $GL_DEPTH_TEST 2929)
; #define GL_DEPTH_TEST                     0x0B71
(defconstant $GL_DEPTH_WRITEMASK 2930)
; #define GL_DEPTH_WRITEMASK                0x0B72
(defconstant $GL_DEPTH_CLEAR_VALUE 2931)
; #define GL_DEPTH_CLEAR_VALUE              0x0B73
(defconstant $GL_DEPTH_FUNC 2932)
; #define GL_DEPTH_FUNC                     0x0B74
(defconstant $GL_ACCUM_CLEAR_VALUE 2944)
; #define GL_ACCUM_CLEAR_VALUE              0x0B80
(defconstant $GL_STENCIL_TEST 2960)
; #define GL_STENCIL_TEST                   0x0B90
(defconstant $GL_STENCIL_CLEAR_VALUE 2961)
; #define GL_STENCIL_CLEAR_VALUE            0x0B91
(defconstant $GL_STENCIL_FUNC 2962)
; #define GL_STENCIL_FUNC                   0x0B92
(defconstant $GL_STENCIL_VALUE_MASK 2963)
; #define GL_STENCIL_VALUE_MASK             0x0B93
(defconstant $GL_STENCIL_FAIL 2964)
; #define GL_STENCIL_FAIL                   0x0B94
(defconstant $GL_STENCIL_PASS_DEPTH_FAIL 2965)
; #define GL_STENCIL_PASS_DEPTH_FAIL        0x0B95
(defconstant $GL_STENCIL_PASS_DEPTH_PASS 2966)
; #define GL_STENCIL_PASS_DEPTH_PASS        0x0B96
(defconstant $GL_STENCIL_REF 2967)
; #define GL_STENCIL_REF                    0x0B97
(defconstant $GL_STENCIL_WRITEMASK 2968)
; #define GL_STENCIL_WRITEMASK              0x0B98
(defconstant $GL_MATRIX_MODE 2976)
; #define GL_MATRIX_MODE                    0x0BA0
(defconstant $GL_NORMALIZE 2977)
; #define GL_NORMALIZE                      0x0BA1
(defconstant $GL_VIEWPORT 2978)
; #define GL_VIEWPORT                       0x0BA2
(defconstant $GL_MODELVIEW_STACK_DEPTH 2979)
; #define GL_MODELVIEW_STACK_DEPTH          0x0BA3
(defconstant $GL_PROJECTION_STACK_DEPTH 2980)
; #define GL_PROJECTION_STACK_DEPTH         0x0BA4
(defconstant $GL_TEXTURE_STACK_DEPTH 2981)
; #define GL_TEXTURE_STACK_DEPTH            0x0BA5
(defconstant $GL_MODELVIEW_MATRIX 2982)
; #define GL_MODELVIEW_MATRIX               0x0BA6
(defconstant $GL_PROJECTION_MATRIX 2983)
; #define GL_PROJECTION_MATRIX              0x0BA7
(defconstant $GL_TEXTURE_MATRIX 2984)
; #define GL_TEXTURE_MATRIX                 0x0BA8
(defconstant $GL_ATTRIB_STACK_DEPTH 2992)
; #define GL_ATTRIB_STACK_DEPTH             0x0BB0
(defconstant $GL_CLIENT_ATTRIB_STACK_DEPTH 2993)
; #define GL_CLIENT_ATTRIB_STACK_DEPTH      0x0BB1
(defconstant $GL_ALPHA_TEST 3008)
; #define GL_ALPHA_TEST                     0x0BC0
(defconstant $GL_ALPHA_TEST_FUNC 3009)
; #define GL_ALPHA_TEST_FUNC                0x0BC1
(defconstant $GL_ALPHA_TEST_REF 3010)
; #define GL_ALPHA_TEST_REF                 0x0BC2
(defconstant $GL_DITHER 3024)
; #define GL_DITHER                         0x0BD0
(defconstant $GL_BLEND_DST 3040)
; #define GL_BLEND_DST                      0x0BE0
(defconstant $GL_BLEND_SRC 3041)
; #define GL_BLEND_SRC                      0x0BE1
(defconstant $GL_BLEND 3042)
; #define GL_BLEND                          0x0BE2
(defconstant $GL_LOGIC_OP_MODE 3056)
; #define GL_LOGIC_OP_MODE                  0x0BF0
(defconstant $GL_INDEX_LOGIC_OP 3057)
; #define GL_INDEX_LOGIC_OP                 0x0BF1
(defconstant $GL_COLOR_LOGIC_OP 3058)
; #define GL_COLOR_LOGIC_OP                 0x0BF2
(defconstant $GL_AUX_BUFFERS 3072)
; #define GL_AUX_BUFFERS                    0x0C00
(defconstant $GL_DRAW_BUFFER 3073)
; #define GL_DRAW_BUFFER                    0x0C01
(defconstant $GL_READ_BUFFER 3074)
; #define GL_READ_BUFFER                    0x0C02
(defconstant $GL_SCISSOR_BOX 3088)
; #define GL_SCISSOR_BOX                    0x0C10
(defconstant $GL_SCISSOR_TEST 3089)
; #define GL_SCISSOR_TEST                   0x0C11
(defconstant $GL_INDEX_CLEAR_VALUE 3104)
; #define GL_INDEX_CLEAR_VALUE              0x0C20
(defconstant $GL_INDEX_WRITEMASK 3105)
; #define GL_INDEX_WRITEMASK                0x0C21
(defconstant $GL_COLOR_CLEAR_VALUE 3106)
; #define GL_COLOR_CLEAR_VALUE              0x0C22
(defconstant $GL_COLOR_WRITEMASK 3107)
; #define GL_COLOR_WRITEMASK                0x0C23
(defconstant $GL_INDEX_MODE 3120)
; #define GL_INDEX_MODE                     0x0C30
(defconstant $GL_RGBA_MODE 3121)
; #define GL_RGBA_MODE                      0x0C31
(defconstant $GL_DOUBLEBUFFER 3122)
; #define GL_DOUBLEBUFFER                   0x0C32
(defconstant $GL_STEREO 3123)
; #define GL_STEREO                         0x0C33
(defconstant $GL_RENDER_MODE 3136)
; #define GL_RENDER_MODE                    0x0C40
(defconstant $GL_PERSPECTIVE_CORRECTION_HINT 3152)
; #define GL_PERSPECTIVE_CORRECTION_HINT    0x0C50
(defconstant $GL_POINT_SMOOTH_HINT 3153)
; #define GL_POINT_SMOOTH_HINT              0x0C51
(defconstant $GL_LINE_SMOOTH_HINT 3154)
; #define GL_LINE_SMOOTH_HINT               0x0C52
(defconstant $GL_POLYGON_SMOOTH_HINT 3155)
; #define GL_POLYGON_SMOOTH_HINT            0x0C53
(defconstant $GL_FOG_HINT 3156)
; #define GL_FOG_HINT                       0x0C54
(defconstant $GL_TEXTURE_GEN_S 3168)
; #define GL_TEXTURE_GEN_S                  0x0C60
(defconstant $GL_TEXTURE_GEN_T 3169)
; #define GL_TEXTURE_GEN_T                  0x0C61
(defconstant $GL_TEXTURE_GEN_R 3170)
; #define GL_TEXTURE_GEN_R                  0x0C62
(defconstant $GL_TEXTURE_GEN_Q 3171)
; #define GL_TEXTURE_GEN_Q                  0x0C63
(defconstant $GL_PIXEL_MAP_I_TO_I 3184)
; #define GL_PIXEL_MAP_I_TO_I               0x0C70
(defconstant $GL_PIXEL_MAP_S_TO_S 3185)
; #define GL_PIXEL_MAP_S_TO_S               0x0C71
(defconstant $GL_PIXEL_MAP_I_TO_R 3186)
; #define GL_PIXEL_MAP_I_TO_R               0x0C72
(defconstant $GL_PIXEL_MAP_I_TO_G 3187)
; #define GL_PIXEL_MAP_I_TO_G               0x0C73
(defconstant $GL_PIXEL_MAP_I_TO_B 3188)
; #define GL_PIXEL_MAP_I_TO_B               0x0C74
(defconstant $GL_PIXEL_MAP_I_TO_A 3189)
; #define GL_PIXEL_MAP_I_TO_A               0x0C75
(defconstant $GL_PIXEL_MAP_R_TO_R 3190)
; #define GL_PIXEL_MAP_R_TO_R               0x0C76
(defconstant $GL_PIXEL_MAP_G_TO_G 3191)
; #define GL_PIXEL_MAP_G_TO_G               0x0C77
(defconstant $GL_PIXEL_MAP_B_TO_B 3192)
; #define GL_PIXEL_MAP_B_TO_B               0x0C78
(defconstant $GL_PIXEL_MAP_A_TO_A 3193)
; #define GL_PIXEL_MAP_A_TO_A               0x0C79
(defconstant $GL_PIXEL_MAP_I_TO_I_SIZE 3248)
; #define GL_PIXEL_MAP_I_TO_I_SIZE          0x0CB0
(defconstant $GL_PIXEL_MAP_S_TO_S_SIZE 3249)
; #define GL_PIXEL_MAP_S_TO_S_SIZE          0x0CB1
(defconstant $GL_PIXEL_MAP_I_TO_R_SIZE 3250)
; #define GL_PIXEL_MAP_I_TO_R_SIZE          0x0CB2
(defconstant $GL_PIXEL_MAP_I_TO_G_SIZE 3251)
; #define GL_PIXEL_MAP_I_TO_G_SIZE          0x0CB3
(defconstant $GL_PIXEL_MAP_I_TO_B_SIZE 3252)
; #define GL_PIXEL_MAP_I_TO_B_SIZE          0x0CB4
(defconstant $GL_PIXEL_MAP_I_TO_A_SIZE 3253)
; #define GL_PIXEL_MAP_I_TO_A_SIZE          0x0CB5
(defconstant $GL_PIXEL_MAP_R_TO_R_SIZE 3254)
; #define GL_PIXEL_MAP_R_TO_R_SIZE          0x0CB6
(defconstant $GL_PIXEL_MAP_G_TO_G_SIZE 3255)
; #define GL_PIXEL_MAP_G_TO_G_SIZE          0x0CB7
(defconstant $GL_PIXEL_MAP_B_TO_B_SIZE 3256)
; #define GL_PIXEL_MAP_B_TO_B_SIZE          0x0CB8
(defconstant $GL_PIXEL_MAP_A_TO_A_SIZE 3257)
; #define GL_PIXEL_MAP_A_TO_A_SIZE          0x0CB9
(defconstant $GL_UNPACK_SWAP_BYTES 3312)
; #define GL_UNPACK_SWAP_BYTES              0x0CF0
(defconstant $GL_UNPACK_LSB_FIRST 3313)
; #define GL_UNPACK_LSB_FIRST               0x0CF1
(defconstant $GL_UNPACK_ROW_LENGTH 3314)
; #define GL_UNPACK_ROW_LENGTH              0x0CF2
(defconstant $GL_UNPACK_SKIP_ROWS 3315)
; #define GL_UNPACK_SKIP_ROWS               0x0CF3
(defconstant $GL_UNPACK_SKIP_PIXELS 3316)
; #define GL_UNPACK_SKIP_PIXELS             0x0CF4
(defconstant $GL_UNPACK_ALIGNMENT 3317)
; #define GL_UNPACK_ALIGNMENT               0x0CF5
(defconstant $GL_PACK_SWAP_BYTES 3328)
; #define GL_PACK_SWAP_BYTES                0x0D00
(defconstant $GL_PACK_LSB_FIRST 3329)
; #define GL_PACK_LSB_FIRST                 0x0D01
(defconstant $GL_PACK_ROW_LENGTH 3330)
; #define GL_PACK_ROW_LENGTH                0x0D02
(defconstant $GL_PACK_SKIP_ROWS 3331)
; #define GL_PACK_SKIP_ROWS                 0x0D03
(defconstant $GL_PACK_SKIP_PIXELS 3332)
; #define GL_PACK_SKIP_PIXELS               0x0D04
(defconstant $GL_PACK_ALIGNMENT 3333)
; #define GL_PACK_ALIGNMENT                 0x0D05
(defconstant $GL_MAP_COLOR 3344)
; #define GL_MAP_COLOR                      0x0D10
(defconstant $GL_MAP_STENCIL 3345)
; #define GL_MAP_STENCIL                    0x0D11
(defconstant $GL_INDEX_SHIFT 3346)
; #define GL_INDEX_SHIFT                    0x0D12
(defconstant $GL_INDEX_OFFSET 3347)
; #define GL_INDEX_OFFSET                   0x0D13
(defconstant $GL_RED_SCALE 3348)
; #define GL_RED_SCALE                      0x0D14
(defconstant $GL_RED_BIAS 3349)
; #define GL_RED_BIAS                       0x0D15
(defconstant $GL_ZOOM_X 3350)
; #define GL_ZOOM_X                         0x0D16
(defconstant $GL_ZOOM_Y 3351)
; #define GL_ZOOM_Y                         0x0D17
(defconstant $GL_GREEN_SCALE 3352)
; #define GL_GREEN_SCALE                    0x0D18
(defconstant $GL_GREEN_BIAS 3353)
; #define GL_GREEN_BIAS                     0x0D19
(defconstant $GL_BLUE_SCALE 3354)
; #define GL_BLUE_SCALE                     0x0D1A
(defconstant $GL_BLUE_BIAS 3355)
; #define GL_BLUE_BIAS                      0x0D1B
(defconstant $GL_ALPHA_SCALE 3356)
; #define GL_ALPHA_SCALE                    0x0D1C
(defconstant $GL_ALPHA_BIAS 3357)
; #define GL_ALPHA_BIAS                     0x0D1D
(defconstant $GL_DEPTH_SCALE 3358)
; #define GL_DEPTH_SCALE                    0x0D1E
(defconstant $GL_DEPTH_BIAS 3359)
; #define GL_DEPTH_BIAS                     0x0D1F
(defconstant $GL_MAX_EVAL_ORDER 3376)
; #define GL_MAX_EVAL_ORDER                 0x0D30
(defconstant $GL_MAX_LIGHTS 3377)
; #define GL_MAX_LIGHTS                     0x0D31
(defconstant $GL_MAX_CLIP_PLANES 3378)
; #define GL_MAX_CLIP_PLANES                0x0D32
(defconstant $GL_MAX_TEXTURE_SIZE 3379)
; #define GL_MAX_TEXTURE_SIZE               0x0D33
(defconstant $GL_MAX_PIXEL_MAP_TABLE 3380)
; #define GL_MAX_PIXEL_MAP_TABLE            0x0D34
(defconstant $GL_MAX_ATTRIB_STACK_DEPTH 3381)
; #define GL_MAX_ATTRIB_STACK_DEPTH         0x0D35
(defconstant $GL_MAX_MODELVIEW_STACK_DEPTH 3382)
; #define GL_MAX_MODELVIEW_STACK_DEPTH      0x0D36
(defconstant $GL_MAX_NAME_STACK_DEPTH 3383)
; #define GL_MAX_NAME_STACK_DEPTH           0x0D37
(defconstant $GL_MAX_PROJECTION_STACK_DEPTH 3384)
; #define GL_MAX_PROJECTION_STACK_DEPTH     0x0D38
(defconstant $GL_MAX_TEXTURE_STACK_DEPTH 3385)
; #define GL_MAX_TEXTURE_STACK_DEPTH        0x0D39
(defconstant $GL_MAX_VIEWPORT_DIMS 3386)
; #define GL_MAX_VIEWPORT_DIMS              0x0D3A
(defconstant $GL_MAX_CLIENT_ATTRIB_STACK_DEPTH 3387)
; #define GL_MAX_CLIENT_ATTRIB_STACK_DEPTH  0x0D3B
(defconstant $GL_SUBPIXEL_BITS 3408)
; #define GL_SUBPIXEL_BITS                  0x0D50
(defconstant $GL_INDEX_BITS 3409)
; #define GL_INDEX_BITS                     0x0D51
(defconstant $GL_RED_BITS 3410)
; #define GL_RED_BITS                       0x0D52
(defconstant $GL_GREEN_BITS 3411)
; #define GL_GREEN_BITS                     0x0D53
(defconstant $GL_BLUE_BITS 3412)
; #define GL_BLUE_BITS                      0x0D54
(defconstant $GL_ALPHA_BITS 3413)
; #define GL_ALPHA_BITS                     0x0D55
(defconstant $GL_DEPTH_BITS 3414)
; #define GL_DEPTH_BITS                     0x0D56
(defconstant $GL_STENCIL_BITS 3415)
; #define GL_STENCIL_BITS                   0x0D57
(defconstant $GL_ACCUM_RED_BITS 3416)
; #define GL_ACCUM_RED_BITS                 0x0D58
(defconstant $GL_ACCUM_GREEN_BITS 3417)
; #define GL_ACCUM_GREEN_BITS               0x0D59
(defconstant $GL_ACCUM_BLUE_BITS 3418)
; #define GL_ACCUM_BLUE_BITS                0x0D5A
(defconstant $GL_ACCUM_ALPHA_BITS 3419)
; #define GL_ACCUM_ALPHA_BITS               0x0D5B
(defconstant $GL_NAME_STACK_DEPTH 3440)
; #define GL_NAME_STACK_DEPTH               0x0D70
(defconstant $GL_AUTO_NORMAL 3456)
; #define GL_AUTO_NORMAL                    0x0D80
(defconstant $GL_MAP1_COLOR_4 3472)
; #define GL_MAP1_COLOR_4                   0x0D90
(defconstant $GL_MAP1_INDEX 3473)
; #define GL_MAP1_INDEX                     0x0D91
(defconstant $GL_MAP1_NORMAL 3474)
; #define GL_MAP1_NORMAL                    0x0D92
(defconstant $GL_MAP1_TEXTURE_COORD_1 3475)
; #define GL_MAP1_TEXTURE_COORD_1           0x0D93
(defconstant $GL_MAP1_TEXTURE_COORD_2 3476)
; #define GL_MAP1_TEXTURE_COORD_2           0x0D94
(defconstant $GL_MAP1_TEXTURE_COORD_3 3477)
; #define GL_MAP1_TEXTURE_COORD_3           0x0D95
(defconstant $GL_MAP1_TEXTURE_COORD_4 3478)
; #define GL_MAP1_TEXTURE_COORD_4           0x0D96
(defconstant $GL_MAP1_VERTEX_3 3479)
; #define GL_MAP1_VERTEX_3                  0x0D97
(defconstant $GL_MAP1_VERTEX_4 3480)
; #define GL_MAP1_VERTEX_4                  0x0D98
(defconstant $GL_MAP2_COLOR_4 3504)
; #define GL_MAP2_COLOR_4                   0x0DB0
(defconstant $GL_MAP2_INDEX 3505)
; #define GL_MAP2_INDEX                     0x0DB1
(defconstant $GL_MAP2_NORMAL 3506)
; #define GL_MAP2_NORMAL                    0x0DB2
(defconstant $GL_MAP2_TEXTURE_COORD_1 3507)
; #define GL_MAP2_TEXTURE_COORD_1           0x0DB3
(defconstant $GL_MAP2_TEXTURE_COORD_2 3508)
; #define GL_MAP2_TEXTURE_COORD_2           0x0DB4
(defconstant $GL_MAP2_TEXTURE_COORD_3 3509)
; #define GL_MAP2_TEXTURE_COORD_3           0x0DB5
(defconstant $GL_MAP2_TEXTURE_COORD_4 3510)
; #define GL_MAP2_TEXTURE_COORD_4           0x0DB6
(defconstant $GL_MAP2_VERTEX_3 3511)
; #define GL_MAP2_VERTEX_3                  0x0DB7
(defconstant $GL_MAP2_VERTEX_4 3512)
; #define GL_MAP2_VERTEX_4                  0x0DB8
(defconstant $GL_MAP1_GRID_DOMAIN 3536)
; #define GL_MAP1_GRID_DOMAIN               0x0DD0
(defconstant $GL_MAP1_GRID_SEGMENTS 3537)
; #define GL_MAP1_GRID_SEGMENTS             0x0DD1
(defconstant $GL_MAP2_GRID_DOMAIN 3538)
; #define GL_MAP2_GRID_DOMAIN               0x0DD2
(defconstant $GL_MAP2_GRID_SEGMENTS 3539)
; #define GL_MAP2_GRID_SEGMENTS             0x0DD3
(defconstant $GL_TEXTURE_1D 3552)
; #define GL_TEXTURE_1D                     0x0DE0
(defconstant $GL_TEXTURE_2D 3553)
; #define GL_TEXTURE_2D                     0x0DE1
(defconstant $GL_FEEDBACK_BUFFER_POINTER 3568)
; #define GL_FEEDBACK_BUFFER_POINTER        0x0DF0
(defconstant $GL_FEEDBACK_BUFFER_SIZE 3569)
; #define GL_FEEDBACK_BUFFER_SIZE           0x0DF1
(defconstant $GL_FEEDBACK_BUFFER_TYPE 3570)
; #define GL_FEEDBACK_BUFFER_TYPE           0x0DF2
(defconstant $GL_SELECTION_BUFFER_POINTER 3571)
; #define GL_SELECTION_BUFFER_POINTER       0x0DF3
(defconstant $GL_SELECTION_BUFFER_SIZE 3572)
; #define GL_SELECTION_BUFFER_SIZE          0x0DF4
;       GL_TEXTURE_BINDING_1D 
;       GL_TEXTURE_BINDING_2D 
;       GL_TEXTURE_BINDING_3D 
;       GL_VERTEX_ARRAY 
;       GL_NORMAL_ARRAY 
;       GL_COLOR_ARRAY 
;       GL_INDEX_ARRAY 
;       GL_TEXTURE_COORD_ARRAY 
;       GL_EDGE_FLAG_ARRAY 
;       GL_VERTEX_ARRAY_SIZE 
;       GL_VERTEX_ARRAY_TYPE 
;       GL_VERTEX_ARRAY_STRIDE 
;       GL_NORMAL_ARRAY_TYPE 
;       GL_NORMAL_ARRAY_STRIDE 
;       GL_COLOR_ARRAY_SIZE 
;       GL_COLOR_ARRAY_TYPE 
;       GL_COLOR_ARRAY_STRIDE 
;       GL_INDEX_ARRAY_TYPE 
;       GL_INDEX_ARRAY_STRIDE 
;       GL_TEXTURE_COORD_ARRAY_SIZE 
;       GL_TEXTURE_COORD_ARRAY_TYPE 
;       GL_TEXTURE_COORD_ARRAY_STRIDE 
;       GL_EDGE_FLAG_ARRAY_STRIDE 
;       GL_POLYGON_OFFSET_FACTOR 
;       GL_POLYGON_OFFSET_UNITS 
;       GL_COLOR_TABLE 
;       GL_POST_CONVOLUTION_COLOR_TABLE 
;       GL_POST_COLOR_MATRIX_COLOR_TABLE 
;       GL_CONVOLUTION_1D 
;       GL_CONVOLUTION_2D 
;       GL_SEPARABLE_2D 
;       GL_POST_CONVOLUTION_RED_SCALE 
;       GL_POST_CONVOLUTION_GREEN_SCALE 
;       GL_POST_CONVOLUTION_BLUE_SCALE 
;       GL_POST_CONVOLUTION_ALPHA_SCALE 
;       GL_POST_CONVOLUTION_RED_BIAS 
;       GL_POST_CONVOLUTION_GREEN_BIAS 
;       GL_POST_CONVOLUTION_BLUE_BIAS 
;       GL_POST_CONVOLUTION_ALPHA_BIAS 
;       GL_COLOR_MATRIX 
;       GL_COLOR_MATRIX_STACK_DEPTH 
;       GL_MAX_COLOR_MATRIX_STACK_DEPTH 
;       GL_POST_COLOR_MATRIX_RED_SCALE 
;       GL_POST_COLOR_MATRIX_GREEN_SCALE 
;       GL_POST_COLOR_MATRIX_BLUE_SCALE 
;       GL_POST_COLOR_MATRIX_ALPHA_SCALE 
;       GL_POST_COLOR_MATRIX_RED_BIAS 
;       GL_POST_COLOR_MATRIX_GREEN_BIAS 
;       GL_POST_COLOR_MATRIX_BLUE_BIAS 
;       GL_POST_COLOR_MATRIX_ALPHA_BIAS 
;       GL_HISTOGRAM 
;       GL_MINMAX 
;       GL_MAX_ELEMENTS_VERTICES 
;       GL_MAX_ELEMENTS_INDICES 
;       GL_RESCALE_NORMAL 
;       GL_LIGHT_MODEL_COLOR_CONTROL 
;       GL_PACK_SKIP_IMAGES 
;       GL_PACK_IMAGE_HEIGHT 
;       GL_UNPACK_SKIP_IMAGES 
;       GL_UNPACK_IMAGE_HEIGHT 
;       GL_TEXTURE_3D 
;       GL_MAX_3D_TEXTURE_SIZE 
;       GL_BLEND_COLOR 
;       GL_BLEND_EQUATION 
;  GetTextureParameter 
;       GL_TEXTURE_MAG_FILTER 
;       GL_TEXTURE_MIN_FILTER 
;       GL_TEXTURE_WRAP_S 
;       GL_TEXTURE_WRAP_T 
(defconstant $GL_TEXTURE_WIDTH 4096)
; #define GL_TEXTURE_WIDTH                  0x1000
(defconstant $GL_TEXTURE_HEIGHT 4097)
; #define GL_TEXTURE_HEIGHT                 0x1001
(defconstant $GL_TEXTURE_INTERNAL_FORMAT 4099)
; #define GL_TEXTURE_INTERNAL_FORMAT        0x1003
(defconstant $GL_TEXTURE_BORDER_COLOR 4100)
; #define GL_TEXTURE_BORDER_COLOR           0x1004
(defconstant $GL_TEXTURE_BORDER 4101)
; #define GL_TEXTURE_BORDER                 0x1005
;       GL_TEXTURE_RED_SIZE 
;       GL_TEXTURE_GREEN_SIZE 
;       GL_TEXTURE_BLUE_SIZE 
;       GL_TEXTURE_ALPHA_SIZE 
;       GL_TEXTURE_LUMINANCE_SIZE 
;       GL_TEXTURE_INTENSITY_SIZE 
;       GL_TEXTURE_PRIORITY 
;       GL_TEXTURE_RESIDENT 
;       GL_TEXTURE_DEPTH 
;       GL_TEXTURE_WRAP_R 
;       GL_TEXTURE_MIN_LOD 
;       GL_TEXTURE_MAX_LOD 
;       GL_TEXTURE_BASE_LEVEL 
;       GL_TEXTURE_MAX_LEVEL 
;  HintMode 
(defconstant $GL_DONT_CARE 4352)
; #define GL_DONT_CARE                      0x1100
(defconstant $GL_FASTEST 4353)
; #define GL_FASTEST                        0x1101
(defconstant $GL_NICEST 4354)
; #define GL_NICEST                         0x1102
;  HintTarget 
;       GL_PERSPECTIVE_CORRECTION_HINT 
;       GL_POINT_SMOOTH_HINT 
;       GL_LINE_SMOOTH_HINT 
;       GL_POLYGON_SMOOTH_HINT 
;       GL_FOG_HINT 
;  HistogramTarget 
;       GL_HISTOGRAM 
;       GL_PROXY_HISTOGRAM 
;  IndexPointerType 
;       GL_SHORT 
;       GL_INT 
;       GL_FLOAT 
;       GL_DOUBLE 
;  LightModelColorControl 
;       GL_SINGLE_COLOR 
;       GL_SEPARATE_SPECULAR_COLOR 
;  LightModelParameter 
;       GL_LIGHT_MODEL_AMBIENT 
;       GL_LIGHT_MODEL_LOCAL_VIEWER 
;       GL_LIGHT_MODEL_TWO_SIDE 
;       GL_LIGHT_MODEL_COLOR_CONTROL 
;  LightName 
(defconstant $GL_LIGHT0 16384)
; #define GL_LIGHT0                         0x4000
(defconstant $GL_LIGHT1 16385)
; #define GL_LIGHT1                         0x4001
(defconstant $GL_LIGHT2 16386)
; #define GL_LIGHT2                         0x4002
(defconstant $GL_LIGHT3 16387)
; #define GL_LIGHT3                         0x4003
(defconstant $GL_LIGHT4 16388)
; #define GL_LIGHT4                         0x4004
(defconstant $GL_LIGHT5 16389)
; #define GL_LIGHT5                         0x4005
(defconstant $GL_LIGHT6 16390)
; #define GL_LIGHT6                         0x4006
(defconstant $GL_LIGHT7 16391)
; #define GL_LIGHT7                         0x4007
;  LightParameter 
(defconstant $GL_AMBIENT 4608)
; #define GL_AMBIENT                        0x1200
(defconstant $GL_DIFFUSE 4609)
; #define GL_DIFFUSE                        0x1201
(defconstant $GL_SPECULAR 4610)
; #define GL_SPECULAR                       0x1202
(defconstant $GL_POSITION 4611)
; #define GL_POSITION                       0x1203
(defconstant $GL_SPOT_DIRECTION 4612)
; #define GL_SPOT_DIRECTION                 0x1204
(defconstant $GL_SPOT_EXPONENT 4613)
; #define GL_SPOT_EXPONENT                  0x1205
(defconstant $GL_SPOT_CUTOFF 4614)
; #define GL_SPOT_CUTOFF                    0x1206
(defconstant $GL_CONSTANT_ATTENUATION 4615)
; #define GL_CONSTANT_ATTENUATION           0x1207
(defconstant $GL_LINEAR_ATTENUATION 4616)
; #define GL_LINEAR_ATTENUATION             0x1208
(defconstant $GL_QUADRATIC_ATTENUATION 4617)
; #define GL_QUADRATIC_ATTENUATION          0x1209
;  InterleavedArrays 
;       GL_V2F 
;       GL_V3F 
;       GL_C4UB_V2F 
;       GL_C4UB_V3F 
;       GL_C3F_V3F 
;       GL_N3F_V3F 
;       GL_C4F_N3F_V3F 
;       GL_T2F_V3F 
;       GL_T4F_V4F 
;       GL_T2F_C4UB_V3F 
;       GL_T2F_C3F_V3F 
;       GL_T2F_N3F_V3F 
;       GL_T2F_C4F_N3F_V3F 
;       GL_T4F_C4F_N3F_V4F 
;  ListMode 
(defconstant $GL_COMPILE 4864)
; #define GL_COMPILE                        0x1300
(defconstant $GL_COMPILE_AND_EXECUTE 4865)
; #define GL_COMPILE_AND_EXECUTE            0x1301
;  ListNameType 
;       GL_BYTE 
;       GL_UNSIGNED_BYTE 
;       GL_SHORT 
;       GL_UNSIGNED_SHORT 
;       GL_INT 
;       GL_UNSIGNED_INT 
;       GL_FLOAT 
;       GL_2_BYTES 
;       GL_3_BYTES 
;       GL_4_BYTES 
;  LogicOp 
(defconstant $GL_CLEAR 5376)
; #define GL_CLEAR                          0x1500
(defconstant $GL_AND 5377)
; #define GL_AND                            0x1501
(defconstant $GL_AND_REVERSE 5378)
; #define GL_AND_REVERSE                    0x1502
(defconstant $GL_COPY 5379)
; #define GL_COPY                           0x1503
(defconstant $GL_AND_INVERTED 5380)
; #define GL_AND_INVERTED                   0x1504
(defconstant $GL_NOOP 5381)
; #define GL_NOOP                           0x1505
(defconstant $GL_XOR 5382)
; #define GL_XOR                            0x1506
(defconstant $GL_OR 5383)
; #define GL_OR                             0x1507
(defconstant $GL_NOR 5384)
; #define GL_NOR                            0x1508
(defconstant $GL_EQUIV 5385)
; #define GL_EQUIV                          0x1509
(defconstant $GL_INVERT 5386)
; #define GL_INVERT                         0x150A
(defconstant $GL_OR_REVERSE 5387)
; #define GL_OR_REVERSE                     0x150B
(defconstant $GL_COPY_INVERTED 5388)
; #define GL_COPY_INVERTED                  0x150C
(defconstant $GL_OR_INVERTED 5389)
; #define GL_OR_INVERTED                    0x150D
(defconstant $GL_NAND 5390)
; #define GL_NAND                           0x150E
(defconstant $GL_SET 5391)
; #define GL_SET                            0x150F
;  MapTarget 
;       GL_MAP1_COLOR_4 
;       GL_MAP1_INDEX 
;       GL_MAP1_NORMAL 
;       GL_MAP1_TEXTURE_COORD_1 
;       GL_MAP1_TEXTURE_COORD_2 
;       GL_MAP1_TEXTURE_COORD_3 
;       GL_MAP1_TEXTURE_COORD_4 
;       GL_MAP1_VERTEX_3 
;       GL_MAP1_VERTEX_4 
;       GL_MAP2_COLOR_4 
;       GL_MAP2_INDEX 
;       GL_MAP2_NORMAL 
;       GL_MAP2_TEXTURE_COORD_1 
;       GL_MAP2_TEXTURE_COORD_2 
;       GL_MAP2_TEXTURE_COORD_3 
;       GL_MAP2_TEXTURE_COORD_4 
;       GL_MAP2_VERTEX_3 
;       GL_MAP2_VERTEX_4 
;  MaterialFace 
;       GL_FRONT 
;       GL_BACK 
;       GL_FRONT_AND_BACK 
;  MaterialParameter 
(defconstant $GL_EMISSION 5632)
; #define GL_EMISSION                       0x1600
(defconstant $GL_SHININESS 5633)
; #define GL_SHININESS                      0x1601
(defconstant $GL_AMBIENT_AND_DIFFUSE 5634)
; #define GL_AMBIENT_AND_DIFFUSE            0x1602
(defconstant $GL_COLOR_INDEXES 5635)
; #define GL_COLOR_INDEXES                  0x1603
;       GL_AMBIENT 
;       GL_DIFFUSE 
;       GL_SPECULAR 
;  MatrixMode 
(defconstant $GL_MODELVIEW 5888)
; #define GL_MODELVIEW                      0x1700
(defconstant $GL_PROJECTION 5889)
; #define GL_PROJECTION                     0x1701
(defconstant $GL_TEXTURE 5890)
; #define GL_TEXTURE                        0x1702
;  MeshMode1 
;       GL_POINT 
;       GL_LINE 
;  MeshMode2 
;       GL_POINT 
;       GL_LINE 
;       GL_FILL 
;  MinmaxTarget 
;       GL_MINMAX 
;  NormalPointerType 
;       GL_BYTE 
;       GL_SHORT 
;       GL_INT 
;       GL_FLOAT 
;       GL_DOUBLE 
;  PixelCopyType 
(defconstant $GL_COLOR 6144)
; #define GL_COLOR                          0x1800
(defconstant $GL_DEPTH 6145)
; #define GL_DEPTH                          0x1801
(defconstant $GL_STENCIL 6146)
; #define GL_STENCIL                        0x1802
;  PixelFormat 
(defconstant $GL_COLOR_INDEX 6400)
; #define GL_COLOR_INDEX                    0x1900
(defconstant $GL_STENCIL_INDEX 6401)
; #define GL_STENCIL_INDEX                  0x1901
(defconstant $GL_DEPTH_COMPONENT 6402)
; #define GL_DEPTH_COMPONENT                0x1902
(defconstant $GL_RED 6403)
; #define GL_RED                            0x1903
(defconstant $GL_GREEN 6404)
; #define GL_GREEN                          0x1904
(defconstant $GL_BLUE 6405)
; #define GL_BLUE                           0x1905
(defconstant $GL_ALPHA 6406)
; #define GL_ALPHA                          0x1906
(defconstant $GL_RGB 6407)
; #define GL_RGB                            0x1907
(defconstant $GL_RGBA 6408)
; #define GL_RGBA                           0x1908
(defconstant $GL_LUMINANCE 6409)
; #define GL_LUMINANCE                      0x1909
(defconstant $GL_LUMINANCE_ALPHA 6410)
; #define GL_LUMINANCE_ALPHA                0x190A
;       GL_ABGR 
;  PixelInternalFormat 
;       GL_ALPHA4 
;       GL_ALPHA8 
;       GL_ALPHA12 
;       GL_ALPHA16 
;       GL_LUMINANCE4 
;       GL_LUMINANCE8 
;       GL_LUMINANCE12 
;       GL_LUMINANCE16 
;       GL_LUMINANCE4_ALPHA4 
;       GL_LUMINANCE6_ALPHA2 
;       GL_LUMINANCE8_ALPHA8 
;       GL_LUMINANCE12_ALPHA4 
;       GL_LUMINANCE12_ALPHA12 
;       GL_LUMINANCE16_ALPHA16 
;       GL_INTENSITY 
;       GL_INTENSITY4 
;       GL_INTENSITY8 
;       GL_INTENSITY12 
;       GL_INTENSITY16 
;       GL_R3_G3_B2 
;       GL_RGB4 
;       GL_RGB5 
;       GL_RGB8 
;       GL_RGB10 
;       GL_RGB12 
;       GL_RGB16 
;       GL_RGBA2 
;       GL_RGBA4 
;       GL_RGB5_A1 
;       GL_RGBA8 
;       GL_RGB10_A2 
;       GL_RGBA12 
;       GL_RGBA16 
;  PixelMap 
;       GL_PIXEL_MAP_I_TO_I 
;       GL_PIXEL_MAP_S_TO_S 
;       GL_PIXEL_MAP_I_TO_R 
;       GL_PIXEL_MAP_I_TO_G 
;       GL_PIXEL_MAP_I_TO_B 
;       GL_PIXEL_MAP_I_TO_A 
;       GL_PIXEL_MAP_R_TO_R 
;       GL_PIXEL_MAP_G_TO_G 
;       GL_PIXEL_MAP_B_TO_B 
;       GL_PIXEL_MAP_A_TO_A 
;  PixelStore 
;       GL_UNPACK_SWAP_BYTES 
;       GL_UNPACK_LSB_FIRST 
;       GL_UNPACK_ROW_LENGTH 
;       GL_UNPACK_SKIP_ROWS 
;       GL_UNPACK_SKIP_PIXELS 
;       GL_UNPACK_ALIGNMENT 
;       GL_PACK_SWAP_BYTES 
;       GL_PACK_LSB_FIRST 
;       GL_PACK_ROW_LENGTH 
;       GL_PACK_SKIP_ROWS 
;       GL_PACK_SKIP_PIXELS 
;       GL_PACK_ALIGNMENT 
;       GL_PACK_SKIP_IMAGES 
;       GL_PACK_IMAGE_HEIGHT 
;       GL_UNPACK_SKIP_IMAGES 
;       GL_UNPACK_IMAGE_HEIGHT 
;  PixelTransfer 
;       GL_MAP_COLOR 
;       GL_MAP_STENCIL 
;       GL_INDEX_SHIFT 
;       GL_INDEX_OFFSET 
;       GL_RED_SCALE 
;       GL_RED_BIAS 
;       GL_GREEN_SCALE 
;       GL_GREEN_BIAS 
;       GL_BLUE_SCALE 
;       GL_BLUE_BIAS 
;       GL_ALPHA_SCALE 
;       GL_ALPHA_BIAS 
;       GL_DEPTH_SCALE 
;       GL_DEPTH_BIAS 
;       GL_POST_CONVOLUTION_RED_SCALE 
;       GL_POST_CONVOLUTION_GREEN_SCALE 
;       GL_POST_CONVOLUTION_BLUE_SCALE 
;       GL_POST_CONVOLUTION_ALPHA_SCALE 
;       GL_POST_CONVOLUTION_RED_BIAS 
;       GL_POST_CONVOLUTION_GREEN_BIAS 
;       GL_POST_CONVOLUTION_BLUE_BIAS 
;       GL_POST_CONVOLUTION_ALPHA_BIAS 
;       GL_POST_COLOR_MATRIX_RED_SCALE 
;       GL_POST_COLOR_MATRIX_GREEN_SCALE 
;       GL_POST_COLOR_MATRIX_BLUE_SCALE 
;       GL_POST_COLOR_MATRIX_ALPHA_SCALE 
;       GL_POST_COLOR_MATRIX_RED_BIAS 
;       GL_POST_COLOR_MATRIX_GREEN_BIAS 
;       GL_POST_COLOR_MATRIX_BLUE_BIAS 
;       GL_POST_COLOR_MATRIX_ALPHA_BIAS 
;  PixelType 
(defconstant $GL_BITMAP 6656)
; #define GL_BITMAP                         0x1A00
;       GL_BYTE 
;       GL_UNSIGNED_BYTE 
;       GL_SHORT 
;       GL_UNSIGNED_SHORT 
;       GL_INT 
;       GL_UNSIGNED_INT 
;       GL_FLOAT 
;       GL_BGR 
;       GL_BGRA 
;       GL_UNSIGNED_BYTE_3_3_2 
;       GL_UNSIGNED_SHORT_4_4_4_4 
;       GL_UNSIGNED_SHORT_5_5_5_1 
;       GL_UNSIGNED_INT_8_8_8_8 
;       GL_UNSIGNED_INT_10_10_10_2 
;       GL_UNSIGNED_SHORT_5_6_5 
;       GL_UNSIGNED_BYTE_2_3_3_REV 
;       GL_UNSIGNED_SHORT_5_6_5_REV 
;       GL_UNSIGNED_SHORT_4_4_4_4_REV 
;       GL_UNSIGNED_SHORT_1_5_5_5_REV 
;       GL_UNSIGNED_INT_8_8_8_8_REV 
;       GL_UNSIGNED_INT_2_10_10_10_REV 
;  PolygonMode 
(defconstant $GL_POINT 6912)
; #define GL_POINT                          0x1B00
(defconstant $GL_LINE 6913)
; #define GL_LINE                           0x1B01
(defconstant $GL_FILL 6914)
; #define GL_FILL                           0x1B02
;  ReadBufferMode 
;       GL_FRONT_LEFT 
;       GL_FRONT_RIGHT 
;       GL_BACK_LEFT 
;       GL_BACK_RIGHT 
;       GL_FRONT 
;       GL_BACK 
;       GL_LEFT 
;       GL_RIGHT 
;       GL_AUX0 
;       GL_AUX1 
;       GL_AUX2 
;       GL_AUX3 
;  RenderingMode 
(defconstant $GL_RENDER 7168)
; #define GL_RENDER                         0x1C00
(defconstant $GL_FEEDBACK 7169)
; #define GL_FEEDBACK                       0x1C01
(defconstant $GL_SELECT 7170)
; #define GL_SELECT                         0x1C02
;  SeparableTarget 
;       GL_SEPARABLE_2D 
;  ShadingModel 
(defconstant $GL_FLAT 7424)
; #define GL_FLAT                           0x1D00
(defconstant $GL_SMOOTH 7425)
; #define GL_SMOOTH                         0x1D01
;  StencilFunction 
;       GL_NEVER 
;       GL_LESS 
;       GL_EQUAL 
;       GL_LEQUAL 
;       GL_GREATER 
;       GL_NOTEQUAL 
;       GL_GEQUAL 
;       GL_ALWAYS 
;  StencilOp 
;       GL_ZERO 
(defconstant $GL_KEEP 7680)
; #define GL_KEEP                           0x1E00
(defconstant $GL_REPLACE 7681)
; #define GL_REPLACE                        0x1E01
(defconstant $GL_INCR 7682)
; #define GL_INCR                           0x1E02
(defconstant $GL_DECR 7683)
; #define GL_DECR                           0x1E03
;       GL_INVERT 
;  StringName 
(defconstant $GL_VENDOR 7936)
; #define GL_VENDOR                         0x1F00
(defconstant $GL_RENDERER 7937)
; #define GL_RENDERER                       0x1F01
(defconstant $GL_VERSION 7938)
; #define GL_VERSION                        0x1F02
(defconstant $GL_EXTENSIONS 7939)
; #define GL_EXTENSIONS                     0x1F03
;  TextureCoordName 
(defconstant $GL_S 8192)
; #define GL_S                              0x2000
(defconstant $GL_T 8193)
; #define GL_T                              0x2001
(defconstant $GL_R 8194)
; #define GL_R                              0x2002
(defconstant $GL_Q 8195)
; #define GL_Q                              0x2003
;  TexCoordPointerType 
;       GL_SHORT 
;       GL_INT 
;       GL_FLOAT 
;       GL_DOUBLE 
;  TextureEnvMode 
(defconstant $GL_MODULATE 8448)
; #define GL_MODULATE                       0x2100
(defconstant $GL_DECAL 8449)
; #define GL_DECAL                          0x2101
;       GL_BLEND 
;       GL_REPLACE 
;  TextureEnvParameter 
(defconstant $GL_TEXTURE_ENV_MODE 8704)
; #define GL_TEXTURE_ENV_MODE               0x2200
(defconstant $GL_TEXTURE_ENV_COLOR 8705)
; #define GL_TEXTURE_ENV_COLOR              0x2201
;  TextureEnvTarget 
(defconstant $GL_TEXTURE_ENV 8960)
; #define GL_TEXTURE_ENV                    0x2300
;  TextureGenMode 
(defconstant $GL_EYE_LINEAR 9216)
; #define GL_EYE_LINEAR                     0x2400
(defconstant $GL_OBJECT_LINEAR 9217)
; #define GL_OBJECT_LINEAR                  0x2401
(defconstant $GL_SPHERE_MAP 9218)
; #define GL_SPHERE_MAP                     0x2402
;  TextureGenParameter 
(defconstant $GL_TEXTURE_GEN_MODE 9472)
; #define GL_TEXTURE_GEN_MODE               0x2500
(defconstant $GL_OBJECT_PLANE 9473)
; #define GL_OBJECT_PLANE                   0x2501
(defconstant $GL_EYE_PLANE 9474)
; #define GL_EYE_PLANE                      0x2502
;  TextureMagFilter 
(defconstant $GL_NEAREST 9728)
; #define GL_NEAREST                        0x2600
(defconstant $GL_LINEAR 9729)
; #define GL_LINEAR                         0x2601
;  TextureMinFilter 
;       GL_NEAREST 
;       GL_LINEAR 
(defconstant $GL_NEAREST_MIPMAP_NEAREST 9984)
; #define GL_NEAREST_MIPMAP_NEAREST         0x2700
(defconstant $GL_LINEAR_MIPMAP_NEAREST 9985)
; #define GL_LINEAR_MIPMAP_NEAREST          0x2701
(defconstant $GL_NEAREST_MIPMAP_LINEAR 9986)
; #define GL_NEAREST_MIPMAP_LINEAR          0x2702
(defconstant $GL_LINEAR_MIPMAP_LINEAR 9987)
; #define GL_LINEAR_MIPMAP_LINEAR           0x2703
;  TextureParameterName 
(defconstant $GL_TEXTURE_MAG_FILTER 10240)
; #define GL_TEXTURE_MAG_FILTER             0x2800
(defconstant $GL_TEXTURE_MIN_FILTER 10241)
; #define GL_TEXTURE_MIN_FILTER             0x2801
(defconstant $GL_TEXTURE_WRAP_S 10242)
; #define GL_TEXTURE_WRAP_S                 0x2802
(defconstant $GL_TEXTURE_WRAP_T 10243)
; #define GL_TEXTURE_WRAP_T                 0x2803
;       GL_TEXTURE_BORDER_COLOR 
;       GL_TEXTURE_PRIORITY 
;       GL_TEXTURE_WRAP_R 
;       GL_TEXTURE_MIN_LOD 
;       GL_TEXTURE_MAX_LOD 
;       GL_TEXTURE_BASE_LEVEL 
;       GL_TEXTURE_MAX_LEVEL 
;  TextureTarget 
;       GL_TEXTURE_1D 
;       GL_TEXTURE_2D 
;       GL_PROXY_TEXTURE_1D 
;       GL_PROXY_TEXTURE_2D 
;       GL_TEXTURE_3D 
;       GL_PROXY_TEXTURE_3D 
;  TextureWrapMode 
(defconstant $GL_CLAMP 10496)
; #define GL_CLAMP                          0x2900
(defconstant $GL_REPEAT 10497)
; #define GL_REPEAT                         0x2901
;       GL_CLAMP_TO_EDGE 
;  VertexPointerType 
;       GL_SHORT 
;       GL_INT 
;       GL_FLOAT 
;       GL_DOUBLE 
;  ClientAttribMask 
(defconstant $GL_CLIENT_PIXEL_STORE_BIT 1)
; #define GL_CLIENT_PIXEL_STORE_BIT         0x00000001
(defconstant $GL_CLIENT_VERTEX_ARRAY_BIT 2)
; #define GL_CLIENT_VERTEX_ARRAY_BIT        0x00000002
(defconstant $GL_CLIENT_ALL_ATTRIB_BITS 4294967295)
; #define GL_CLIENT_ALL_ATTRIB_BITS         0xffffffff
;  polygon_offset 
(defconstant $GL_POLYGON_OFFSET_FACTOR 32824)
; #define GL_POLYGON_OFFSET_FACTOR          0x8038
(defconstant $GL_POLYGON_OFFSET_UNITS 10752)
; #define GL_POLYGON_OFFSET_UNITS           0x2A00
(defconstant $GL_POLYGON_OFFSET_POINT 10753)
; #define GL_POLYGON_OFFSET_POINT           0x2A01
(defconstant $GL_POLYGON_OFFSET_LINE 10754)
; #define GL_POLYGON_OFFSET_LINE            0x2A02
(defconstant $GL_POLYGON_OFFSET_FILL 32823)
; #define GL_POLYGON_OFFSET_FILL            0x8037
;  texture 
(defconstant $GL_ALPHA4 32827)
; #define GL_ALPHA4                         0x803B
(defconstant $GL_ALPHA8 32828)
; #define GL_ALPHA8                         0x803C
(defconstant $GL_ALPHA12 32829)
; #define GL_ALPHA12                        0x803D
(defconstant $GL_ALPHA16 32830)
; #define GL_ALPHA16                        0x803E
(defconstant $GL_LUMINANCE4 32831)
; #define GL_LUMINANCE4                     0x803F
(defconstant $GL_LUMINANCE8 32832)
; #define GL_LUMINANCE8                     0x8040
(defconstant $GL_LUMINANCE12 32833)
; #define GL_LUMINANCE12                    0x8041
(defconstant $GL_LUMINANCE16 32834)
; #define GL_LUMINANCE16                    0x8042
(defconstant $GL_LUMINANCE4_ALPHA4 32835)
; #define GL_LUMINANCE4_ALPHA4              0x8043
(defconstant $GL_LUMINANCE6_ALPHA2 32836)
; #define GL_LUMINANCE6_ALPHA2              0x8044
(defconstant $GL_LUMINANCE8_ALPHA8 32837)
; #define GL_LUMINANCE8_ALPHA8              0x8045
(defconstant $GL_LUMINANCE12_ALPHA4 32838)
; #define GL_LUMINANCE12_ALPHA4             0x8046
(defconstant $GL_LUMINANCE12_ALPHA12 32839)
; #define GL_LUMINANCE12_ALPHA12            0x8047
(defconstant $GL_LUMINANCE16_ALPHA16 32840)
; #define GL_LUMINANCE16_ALPHA16            0x8048
(defconstant $GL_INTENSITY 32841)
; #define GL_INTENSITY                      0x8049
(defconstant $GL_INTENSITY4 32842)
; #define GL_INTENSITY4                     0x804A
(defconstant $GL_INTENSITY8 32843)
; #define GL_INTENSITY8                     0x804B
(defconstant $GL_INTENSITY12 32844)
; #define GL_INTENSITY12                    0x804C
(defconstant $GL_INTENSITY16 32845)
; #define GL_INTENSITY16                    0x804D
(defconstant $GL_R3_G3_B2 10768)
; #define GL_R3_G3_B2                       0x2A10
(defconstant $GL_RGB4 32847)
; #define GL_RGB4                           0x804F
(defconstant $GL_RGB5 32848)
; #define GL_RGB5                           0x8050
(defconstant $GL_RGB8 32849)
; #define GL_RGB8                           0x8051
(defconstant $GL_RGB10 32850)
; #define GL_RGB10                          0x8052
(defconstant $GL_RGB12 32851)
; #define GL_RGB12                          0x8053
(defconstant $GL_RGB16 32852)
; #define GL_RGB16                          0x8054
(defconstant $GL_RGBA2 32853)
; #define GL_RGBA2                          0x8055
(defconstant $GL_RGBA4 32854)
; #define GL_RGBA4                          0x8056
(defconstant $GL_RGB5_A1 32855)
; #define GL_RGB5_A1                        0x8057
(defconstant $GL_RGBA8 32856)
; #define GL_RGBA8                          0x8058
(defconstant $GL_RGB10_A2 32857)
; #define GL_RGB10_A2                       0x8059
(defconstant $GL_RGBA12 32858)
; #define GL_RGBA12                         0x805A
(defconstant $GL_RGBA16 32859)
; #define GL_RGBA16                         0x805B
(defconstant $GL_TEXTURE_RED_SIZE 32860)
; #define GL_TEXTURE_RED_SIZE               0x805C
(defconstant $GL_TEXTURE_GREEN_SIZE 32861)
; #define GL_TEXTURE_GREEN_SIZE             0x805D
(defconstant $GL_TEXTURE_BLUE_SIZE 32862)
; #define GL_TEXTURE_BLUE_SIZE              0x805E
(defconstant $GL_TEXTURE_ALPHA_SIZE 32863)
; #define GL_TEXTURE_ALPHA_SIZE             0x805F
(defconstant $GL_TEXTURE_LUMINANCE_SIZE 32864)
; #define GL_TEXTURE_LUMINANCE_SIZE         0x8060
(defconstant $GL_TEXTURE_INTENSITY_SIZE 32865)
; #define GL_TEXTURE_INTENSITY_SIZE         0x8061
(defconstant $GL_PROXY_TEXTURE_1D 32867)
; #define GL_PROXY_TEXTURE_1D               0x8063
(defconstant $GL_PROXY_TEXTURE_2D 32868)
; #define GL_PROXY_TEXTURE_2D               0x8064
;  texture_object 
(defconstant $GL_TEXTURE_PRIORITY 32870)
; #define GL_TEXTURE_PRIORITY               0x8066
(defconstant $GL_TEXTURE_RESIDENT 32871)
; #define GL_TEXTURE_RESIDENT               0x8067
(defconstant $GL_TEXTURE_BINDING_1D 32872)
; #define GL_TEXTURE_BINDING_1D             0x8068
(defconstant $GL_TEXTURE_BINDING_2D 32873)
; #define GL_TEXTURE_BINDING_2D             0x8069
(defconstant $GL_TEXTURE_BINDING_3D 32874)
; #define GL_TEXTURE_BINDING_3D             0x806A
;  vertex_array 
(defconstant $GL_VERTEX_ARRAY 32884)
; #define GL_VERTEX_ARRAY                   0x8074
(defconstant $GL_NORMAL_ARRAY 32885)
; #define GL_NORMAL_ARRAY                   0x8075
(defconstant $GL_COLOR_ARRAY 32886)
; #define GL_COLOR_ARRAY                    0x8076
(defconstant $GL_INDEX_ARRAY 32887)
; #define GL_INDEX_ARRAY                    0x8077
(defconstant $GL_TEXTURE_COORD_ARRAY 32888)
; #define GL_TEXTURE_COORD_ARRAY            0x8078
(defconstant $GL_EDGE_FLAG_ARRAY 32889)
; #define GL_EDGE_FLAG_ARRAY                0x8079
(defconstant $GL_VERTEX_ARRAY_SIZE 32890)
; #define GL_VERTEX_ARRAY_SIZE              0x807A
(defconstant $GL_VERTEX_ARRAY_TYPE 32891)
; #define GL_VERTEX_ARRAY_TYPE              0x807B
(defconstant $GL_VERTEX_ARRAY_STRIDE 32892)
; #define GL_VERTEX_ARRAY_STRIDE            0x807C
(defconstant $GL_NORMAL_ARRAY_TYPE 32894)
; #define GL_NORMAL_ARRAY_TYPE              0x807E
(defconstant $GL_NORMAL_ARRAY_STRIDE 32895)
; #define GL_NORMAL_ARRAY_STRIDE            0x807F
(defconstant $GL_COLOR_ARRAY_SIZE 32897)
; #define GL_COLOR_ARRAY_SIZE               0x8081
(defconstant $GL_COLOR_ARRAY_TYPE 32898)
; #define GL_COLOR_ARRAY_TYPE               0x8082
(defconstant $GL_COLOR_ARRAY_STRIDE 32899)
; #define GL_COLOR_ARRAY_STRIDE             0x8083
(defconstant $GL_INDEX_ARRAY_TYPE 32901)
; #define GL_INDEX_ARRAY_TYPE               0x8085
(defconstant $GL_INDEX_ARRAY_STRIDE 32902)
; #define GL_INDEX_ARRAY_STRIDE             0x8086
(defconstant $GL_TEXTURE_COORD_ARRAY_SIZE 32904)
; #define GL_TEXTURE_COORD_ARRAY_SIZE       0x8088
(defconstant $GL_TEXTURE_COORD_ARRAY_TYPE 32905)
; #define GL_TEXTURE_COORD_ARRAY_TYPE       0x8089
(defconstant $GL_TEXTURE_COORD_ARRAY_STRIDE 32906)
; #define GL_TEXTURE_COORD_ARRAY_STRIDE     0x808A
(defconstant $GL_EDGE_FLAG_ARRAY_STRIDE 32908)
; #define GL_EDGE_FLAG_ARRAY_STRIDE         0x808C
(defconstant $GL_VERTEX_ARRAY_POINTER 32910)
; #define GL_VERTEX_ARRAY_POINTER           0x808E
(defconstant $GL_NORMAL_ARRAY_POINTER 32911)
; #define GL_NORMAL_ARRAY_POINTER           0x808F
(defconstant $GL_COLOR_ARRAY_POINTER 32912)
; #define GL_COLOR_ARRAY_POINTER            0x8090
(defconstant $GL_INDEX_ARRAY_POINTER 32913)
; #define GL_INDEX_ARRAY_POINTER            0x8091
(defconstant $GL_TEXTURE_COORD_ARRAY_POINTER 32914)
; #define GL_TEXTURE_COORD_ARRAY_POINTER    0x8092
(defconstant $GL_EDGE_FLAG_ARRAY_POINTER 32915)
; #define GL_EDGE_FLAG_ARRAY_POINTER        0x8093
(defconstant $GL_V2F 10784)
; #define GL_V2F                            0x2A20
(defconstant $GL_V3F 10785)
; #define GL_V3F                            0x2A21
(defconstant $GL_C4UB_V2F 10786)
; #define GL_C4UB_V2F                       0x2A22
(defconstant $GL_C4UB_V3F 10787)
; #define GL_C4UB_V3F                       0x2A23
(defconstant $GL_C3F_V3F 10788)
; #define GL_C3F_V3F                        0x2A24
(defconstant $GL_N3F_V3F 10789)
; #define GL_N3F_V3F                        0x2A25
(defconstant $GL_C4F_N3F_V3F 10790)
; #define GL_C4F_N3F_V3F                    0x2A26
(defconstant $GL_T2F_V3F 10791)
; #define GL_T2F_V3F                        0x2A27
(defconstant $GL_T4F_V4F 10792)
; #define GL_T4F_V4F                        0x2A28
(defconstant $GL_T2F_C4UB_V3F 10793)
; #define GL_T2F_C4UB_V3F                   0x2A29
(defconstant $GL_T2F_C3F_V3F 10794)
; #define GL_T2F_C3F_V3F                    0x2A2A
(defconstant $GL_T2F_N3F_V3F 10795)
; #define GL_T2F_N3F_V3F                    0x2A2B
(defconstant $GL_T2F_C4F_N3F_V3F 10796)
; #define GL_T2F_C4F_N3F_V3F                0x2A2C
(defconstant $GL_T4F_C4F_N3F_V4F 10797)
; #define GL_T4F_C4F_N3F_V4F                0x2A2D
;  bgra 
(defconstant $GL_BGR 32992)
; #define GL_BGR                            0x80E0
(defconstant $GL_BGRA 32993)
; #define GL_BGRA                           0x80E1
;  blend_color 
(defconstant $GL_CONSTANT_COLOR 32769)
; #define GL_CONSTANT_COLOR                 0x8001
(defconstant $GL_ONE_MINUS_CONSTANT_COLOR 32770)
; #define GL_ONE_MINUS_CONSTANT_COLOR       0x8002
(defconstant $GL_CONSTANT_ALPHA 32771)
; #define GL_CONSTANT_ALPHA                 0x8003
(defconstant $GL_ONE_MINUS_CONSTANT_ALPHA 32772)
; #define GL_ONE_MINUS_CONSTANT_ALPHA       0x8004
(defconstant $GL_BLEND_COLOR 32773)
; #define GL_BLEND_COLOR                    0x8005
;  blend_minmax 
(defconstant $GL_FUNC_ADD 32774)
; #define GL_FUNC_ADD                       0x8006
(defconstant $GL_MIN 32775)
; #define GL_MIN                            0x8007
(defconstant $GL_MAX 32776)
; #define GL_MAX                            0x8008
(defconstant $GL_BLEND_EQUATION 32777)
; #define GL_BLEND_EQUATION                 0x8009
;  blend_subtract 
(defconstant $GL_FUNC_SUBTRACT 32778)
; #define GL_FUNC_SUBTRACT                  0x800A
(defconstant $GL_FUNC_REVERSE_SUBTRACT 32779)
; #define GL_FUNC_REVERSE_SUBTRACT          0x800B
;  color_matrix 
(defconstant $GL_COLOR_MATRIX 32945)
; #define GL_COLOR_MATRIX                   0x80B1
(defconstant $GL_COLOR_MATRIX_STACK_DEPTH 32946)
; #define GL_COLOR_MATRIX_STACK_DEPTH       0x80B2
(defconstant $GL_MAX_COLOR_MATRIX_STACK_DEPTH 32947)
; #define GL_MAX_COLOR_MATRIX_STACK_DEPTH   0x80B3
(defconstant $GL_POST_COLOR_MATRIX_RED_SCALE 32948)
; #define GL_POST_COLOR_MATRIX_RED_SCALE    0x80B4
(defconstant $GL_POST_COLOR_MATRIX_GREEN_SCALE 32949)
; #define GL_POST_COLOR_MATRIX_GREEN_SCALE  0x80B5
(defconstant $GL_POST_COLOR_MATRIX_BLUE_SCALE 32950)
; #define GL_POST_COLOR_MATRIX_BLUE_SCALE   0x80B6
(defconstant $GL_POST_COLOR_MATRIX_ALPHA_SCALE 32951)
; #define GL_POST_COLOR_MATRIX_ALPHA_SCALE  0x80B7
(defconstant $GL_POST_COLOR_MATRIX_RED_BIAS 32952)
; #define GL_POST_COLOR_MATRIX_RED_BIAS     0x80B8
(defconstant $GL_POST_COLOR_MATRIX_GREEN_BIAS 32953)
; #define GL_POST_COLOR_MATRIX_GREEN_BIAS   0x80B9
(defconstant $GL_POST_COLOR_MATRIX_BLUE_BIAS 32954)
; #define GL_POST_COLOR_MATRIX_BLUE_BIAS    0x80BA
(defconstant $GL_POST_COLOR_MATRIX_ALPHA_BIAS 32955)
; #define GL_POST_COLOR_MATRIX_ALPHA_BIAS   0x80BB
;  color_table 
(defconstant $GL_COLOR_TABLE 32976)
; #define GL_COLOR_TABLE                    0x80D0
(defconstant $GL_POST_CONVOLUTION_COLOR_TABLE 32977)
; #define GL_POST_CONVOLUTION_COLOR_TABLE   0x80D1
(defconstant $GL_POST_COLOR_MATRIX_COLOR_TABLE 32978)
; #define GL_POST_COLOR_MATRIX_COLOR_TABLE  0x80D2
(defconstant $GL_PROXY_COLOR_TABLE 32979)
; #define GL_PROXY_COLOR_TABLE              0x80D3
(defconstant $GL_PROXY_POST_CONVOLUTION_COLOR_TABLE 32980)
; #define GL_PROXY_POST_CONVOLUTION_COLOR_TABLE 0x80D4
(defconstant $GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE 32981)
; #define GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE 0x80D5
(defconstant $GL_COLOR_TABLE_SCALE 32982)
; #define GL_COLOR_TABLE_SCALE              0x80D6
(defconstant $GL_COLOR_TABLE_BIAS 32983)
; #define GL_COLOR_TABLE_BIAS               0x80D7
(defconstant $GL_COLOR_TABLE_FORMAT 32984)
; #define GL_COLOR_TABLE_FORMAT             0x80D8
(defconstant $GL_COLOR_TABLE_WIDTH 32985)
; #define GL_COLOR_TABLE_WIDTH              0x80D9
(defconstant $GL_COLOR_TABLE_RED_SIZE 32986)
; #define GL_COLOR_TABLE_RED_SIZE           0x80DA
(defconstant $GL_COLOR_TABLE_GREEN_SIZE 32987)
; #define GL_COLOR_TABLE_GREEN_SIZE         0x80DB
(defconstant $GL_COLOR_TABLE_BLUE_SIZE 32988)
; #define GL_COLOR_TABLE_BLUE_SIZE          0x80DC
(defconstant $GL_COLOR_TABLE_ALPHA_SIZE 32989)
; #define GL_COLOR_TABLE_ALPHA_SIZE         0x80DD
(defconstant $GL_COLOR_TABLE_LUMINANCE_SIZE 32990)
; #define GL_COLOR_TABLE_LUMINANCE_SIZE     0x80DE
(defconstant $GL_COLOR_TABLE_INTENSITY_SIZE 32991)
; #define GL_COLOR_TABLE_INTENSITY_SIZE     0x80DF
;  convolution 
(defconstant $GL_CONVOLUTION_1D 32784)
; #define GL_CONVOLUTION_1D                 0x8010
(defconstant $GL_CONVOLUTION_2D 32785)
; #define GL_CONVOLUTION_2D                 0x8011
(defconstant $GL_SEPARABLE_2D 32786)
; #define GL_SEPARABLE_2D                   0x8012
(defconstant $GL_CONVOLUTION_BORDER_MODE 32787)
; #define GL_CONVOLUTION_BORDER_MODE        0x8013
(defconstant $GL_CONVOLUTION_FILTER_SCALE 32788)
; #define GL_CONVOLUTION_FILTER_SCALE       0x8014
(defconstant $GL_CONVOLUTION_FILTER_BIAS 32789)
; #define GL_CONVOLUTION_FILTER_BIAS        0x8015
(defconstant $GL_REDUCE 32790)
; #define GL_REDUCE                         0x8016
(defconstant $GL_CONVOLUTION_FORMAT 32791)
; #define GL_CONVOLUTION_FORMAT             0x8017
(defconstant $GL_CONVOLUTION_WIDTH 32792)
; #define GL_CONVOLUTION_WIDTH              0x8018
(defconstant $GL_CONVOLUTION_HEIGHT 32793)
; #define GL_CONVOLUTION_HEIGHT             0x8019
(defconstant $GL_MAX_CONVOLUTION_WIDTH 32794)
; #define GL_MAX_CONVOLUTION_WIDTH          0x801A
(defconstant $GL_MAX_CONVOLUTION_HEIGHT 32795)
; #define GL_MAX_CONVOLUTION_HEIGHT         0x801B
(defconstant $GL_POST_CONVOLUTION_RED_SCALE 32796)
; #define GL_POST_CONVOLUTION_RED_SCALE     0x801C
(defconstant $GL_POST_CONVOLUTION_GREEN_SCALE 32797)
; #define GL_POST_CONVOLUTION_GREEN_SCALE   0x801D
(defconstant $GL_POST_CONVOLUTION_BLUE_SCALE 32798)
; #define GL_POST_CONVOLUTION_BLUE_SCALE    0x801E
(defconstant $GL_POST_CONVOLUTION_ALPHA_SCALE 32799)
; #define GL_POST_CONVOLUTION_ALPHA_SCALE   0x801F
(defconstant $GL_POST_CONVOLUTION_RED_BIAS 32800)
; #define GL_POST_CONVOLUTION_RED_BIAS      0x8020
(defconstant $GL_POST_CONVOLUTION_GREEN_BIAS 32801)
; #define GL_POST_CONVOLUTION_GREEN_BIAS    0x8021
(defconstant $GL_POST_CONVOLUTION_BLUE_BIAS 32802)
; #define GL_POST_CONVOLUTION_BLUE_BIAS     0x8022
(defconstant $GL_POST_CONVOLUTION_ALPHA_BIAS 32803)
; #define GL_POST_CONVOLUTION_ALPHA_BIAS    0x8023
(defconstant $GL_CONSTANT_BORDER 33105)
; #define GL_CONSTANT_BORDER                0x8151
(defconstant $GL_REPLICATE_BORDER 33107)
; #define GL_REPLICATE_BORDER               0x8153
(defconstant $GL_CONVOLUTION_BORDER_COLOR 33108)
; #define GL_CONVOLUTION_BORDER_COLOR       0x8154
;  draw_range_elements 
(defconstant $GL_MAX_ELEMENTS_VERTICES 33000)
; #define GL_MAX_ELEMENTS_VERTICES          0x80E8
(defconstant $GL_MAX_ELEMENTS_INDICES 33001)
; #define GL_MAX_ELEMENTS_INDICES           0x80E9
;  histogram 
(defconstant $GL_HISTOGRAM 32804)
; #define GL_HISTOGRAM                      0x8024
(defconstant $GL_PROXY_HISTOGRAM 32805)
; #define GL_PROXY_HISTOGRAM                0x8025
(defconstant $GL_HISTOGRAM_WIDTH 32806)
; #define GL_HISTOGRAM_WIDTH                0x8026
(defconstant $GL_HISTOGRAM_FORMAT 32807)
; #define GL_HISTOGRAM_FORMAT               0x8027
(defconstant $GL_HISTOGRAM_RED_SIZE 32808)
; #define GL_HISTOGRAM_RED_SIZE             0x8028
(defconstant $GL_HISTOGRAM_GREEN_SIZE 32809)
; #define GL_HISTOGRAM_GREEN_SIZE           0x8029
(defconstant $GL_HISTOGRAM_BLUE_SIZE 32810)
; #define GL_HISTOGRAM_BLUE_SIZE            0x802A
(defconstant $GL_HISTOGRAM_ALPHA_SIZE 32811)
; #define GL_HISTOGRAM_ALPHA_SIZE           0x802B
(defconstant $GL_HISTOGRAM_LUMINANCE_SIZE 32812)
; #define GL_HISTOGRAM_LUMINANCE_SIZE       0x802C
(defconstant $GL_HISTOGRAM_SINK 32813)
; #define GL_HISTOGRAM_SINK                 0x802D
(defconstant $GL_MINMAX 32814)
; #define GL_MINMAX                         0x802E
(defconstant $GL_MINMAX_FORMAT 32815)
; #define GL_MINMAX_FORMAT                  0x802F
(defconstant $GL_MINMAX_SINK 32816)
; #define GL_MINMAX_SINK                    0x8030
(defconstant $GL_TABLE_TOO_LARGE 32817)
; #define GL_TABLE_TOO_LARGE                0x8031
;  packed_pixels 
(defconstant $GL_UNSIGNED_BYTE_3_3_2 32818)
; #define GL_UNSIGNED_BYTE_3_3_2            0x8032
(defconstant $GL_UNSIGNED_SHORT_4_4_4_4 32819)
; #define GL_UNSIGNED_SHORT_4_4_4_4         0x8033
(defconstant $GL_UNSIGNED_SHORT_5_5_5_1 32820)
; #define GL_UNSIGNED_SHORT_5_5_5_1         0x8034
(defconstant $GL_UNSIGNED_INT_8_8_8_8 32821)
; #define GL_UNSIGNED_INT_8_8_8_8           0x8035
(defconstant $GL_UNSIGNED_INT_10_10_10_2 32822)
; #define GL_UNSIGNED_INT_10_10_10_2        0x8036
(defconstant $GL_UNSIGNED_BYTE_2_3_3_REV 33634)
; #define GL_UNSIGNED_BYTE_2_3_3_REV        0x8362
(defconstant $GL_UNSIGNED_SHORT_5_6_5 33635)
; #define GL_UNSIGNED_SHORT_5_6_5           0x8363
(defconstant $GL_UNSIGNED_SHORT_5_6_5_REV 33636)
; #define GL_UNSIGNED_SHORT_5_6_5_REV       0x8364
(defconstant $GL_UNSIGNED_SHORT_4_4_4_4_REV 33637)
; #define GL_UNSIGNED_SHORT_4_4_4_4_REV     0x8365
(defconstant $GL_UNSIGNED_SHORT_1_5_5_5_REV 33638)
; #define GL_UNSIGNED_SHORT_1_5_5_5_REV     0x8366
(defconstant $GL_UNSIGNED_INT_8_8_8_8_REV 33639)
; #define GL_UNSIGNED_INT_8_8_8_8_REV       0x8367
(defconstant $GL_UNSIGNED_INT_2_10_10_10_REV 33640)
; #define GL_UNSIGNED_INT_2_10_10_10_REV    0x8368
;  rescale_normal 
(defconstant $GL_RESCALE_NORMAL 32826)
; #define GL_RESCALE_NORMAL                 0x803A
;  separate_specular_color 
(defconstant $GL_LIGHT_MODEL_COLOR_CONTROL 33272)
; #define GL_LIGHT_MODEL_COLOR_CONTROL      0x81F8
(defconstant $GL_SINGLE_COLOR 33273)
; #define GL_SINGLE_COLOR                   0x81F9
(defconstant $GL_SEPARATE_SPECULAR_COLOR 33274)
; #define GL_SEPARATE_SPECULAR_COLOR        0x81FA
;  texture3D 
(defconstant $GL_PACK_SKIP_IMAGES 32875)
; #define GL_PACK_SKIP_IMAGES               0x806B
(defconstant $GL_PACK_IMAGE_HEIGHT 32876)
; #define GL_PACK_IMAGE_HEIGHT              0x806C
(defconstant $GL_UNPACK_SKIP_IMAGES 32877)
; #define GL_UNPACK_SKIP_IMAGES             0x806D
(defconstant $GL_UNPACK_IMAGE_HEIGHT 32878)
; #define GL_UNPACK_IMAGE_HEIGHT            0x806E
(defconstant $GL_TEXTURE_3D 32879)
; #define GL_TEXTURE_3D                     0x806F
(defconstant $GL_PROXY_TEXTURE_3D 32880)
; #define GL_PROXY_TEXTURE_3D               0x8070
(defconstant $GL_TEXTURE_DEPTH 32881)
; #define GL_TEXTURE_DEPTH                  0x8071
(defconstant $GL_TEXTURE_WRAP_R 32882)
; #define GL_TEXTURE_WRAP_R                 0x8072
(defconstant $GL_MAX_3D_TEXTURE_SIZE 32883)
; #define GL_MAX_3D_TEXTURE_SIZE            0x8073
;  texture_edge_clamp 
(defconstant $GL_CLAMP_TO_EDGE 33071)
; #define GL_CLAMP_TO_EDGE                  0x812F
(defconstant $GL_CLAMP_TO_BORDER 33069)
; #define GL_CLAMP_TO_BORDER                0x812D
;  texture_lod 
(defconstant $GL_TEXTURE_MIN_LOD 33082)
; #define GL_TEXTURE_MIN_LOD                0x813A
(defconstant $GL_TEXTURE_MAX_LOD 33083)
; #define GL_TEXTURE_MAX_LOD                0x813B
(defconstant $GL_TEXTURE_BASE_LEVEL 33084)
; #define GL_TEXTURE_BASE_LEVEL             0x813C
(defconstant $GL_TEXTURE_MAX_LEVEL 33085)
; #define GL_TEXTURE_MAX_LEVEL              0x813D
;  GetTarget1_2 
(defconstant $GL_SMOOTH_POINT_SIZE_RANGE 2834)
; #define GL_SMOOTH_POINT_SIZE_RANGE        0x0B12
(defconstant $GL_SMOOTH_POINT_SIZE_GRANULARITY 2835)
; #define GL_SMOOTH_POINT_SIZE_GRANULARITY  0x0B13
(defconstant $GL_SMOOTH_LINE_WIDTH_RANGE 2850)
; #define GL_SMOOTH_LINE_WIDTH_RANGE        0x0B22
(defconstant $GL_SMOOTH_LINE_WIDTH_GRANULARITY 2851)
; #define GL_SMOOTH_LINE_WIDTH_GRANULARITY  0x0B23
(defconstant $GL_ALIASED_POINT_SIZE_RANGE 33901)
; #define GL_ALIASED_POINT_SIZE_RANGE       0x846D
(defconstant $GL_ALIASED_LINE_WIDTH_RANGE 33902)
; #define GL_ALIASED_LINE_WIDTH_RANGE       0x846E
(defconstant $GL_TEXTURE0 33984)
; #define GL_TEXTURE0                       0x84C0
(defconstant $GL_TEXTURE1 33985)
; #define GL_TEXTURE1                       0x84C1
(defconstant $GL_TEXTURE2 33986)
; #define GL_TEXTURE2                       0x84C2
(defconstant $GL_TEXTURE3 33987)
; #define GL_TEXTURE3                       0x84C3
(defconstant $GL_TEXTURE4 33988)
; #define GL_TEXTURE4                       0x84C4
(defconstant $GL_TEXTURE5 33989)
; #define GL_TEXTURE5                       0x84C5
(defconstant $GL_TEXTURE6 33990)
; #define GL_TEXTURE6                       0x84C6
(defconstant $GL_TEXTURE7 33991)
; #define GL_TEXTURE7                       0x84C7
(defconstant $GL_TEXTURE8 33992)
; #define GL_TEXTURE8                       0x84C8
(defconstant $GL_TEXTURE9 33993)
; #define GL_TEXTURE9                       0x84C9
(defconstant $GL_TEXTURE10 33994)
; #define GL_TEXTURE10                      0x84CA
(defconstant $GL_TEXTURE11 33995)
; #define GL_TEXTURE11                      0x84CB
(defconstant $GL_TEXTURE12 33996)
; #define GL_TEXTURE12                      0x84CC
(defconstant $GL_TEXTURE13 33997)
; #define GL_TEXTURE13                      0x84CD
(defconstant $GL_TEXTURE14 33998)
; #define GL_TEXTURE14                      0x84CE
(defconstant $GL_TEXTURE15 33999)
; #define GL_TEXTURE15                      0x84CF
(defconstant $GL_TEXTURE16 34000)
; #define GL_TEXTURE16                      0x84D0
(defconstant $GL_TEXTURE17 34001)
; #define GL_TEXTURE17                      0x84D1
(defconstant $GL_TEXTURE18 34002)
; #define GL_TEXTURE18                      0x84D2
(defconstant $GL_TEXTURE19 34003)
; #define GL_TEXTURE19                      0x84D3
(defconstant $GL_TEXTURE20 34004)
; #define GL_TEXTURE20                      0x84D4
(defconstant $GL_TEXTURE21 34005)
; #define GL_TEXTURE21                      0x84D5
(defconstant $GL_TEXTURE22 34006)
; #define GL_TEXTURE22                      0x84D6
(defconstant $GL_TEXTURE23 34007)
; #define GL_TEXTURE23                      0x84D7
(defconstant $GL_TEXTURE24 34008)
; #define GL_TEXTURE24                      0x84D8
(defconstant $GL_TEXTURE25 34009)
; #define GL_TEXTURE25                      0x84D9
(defconstant $GL_TEXTURE26 34010)
; #define GL_TEXTURE26                      0x84DA
(defconstant $GL_TEXTURE27 34011)
; #define GL_TEXTURE27                      0x84DB
(defconstant $GL_TEXTURE28 34012)
; #define GL_TEXTURE28                      0x84DC
(defconstant $GL_TEXTURE29 34013)
; #define GL_TEXTURE29                      0x84DD
(defconstant $GL_TEXTURE30 34014)
; #define GL_TEXTURE30                      0x84DE
(defconstant $GL_TEXTURE31 34015)
; #define GL_TEXTURE31                      0x84DF
(defconstant $GL_ACTIVE_TEXTURE 34016)
; #define GL_ACTIVE_TEXTURE                 0x84E0
(defconstant $GL_CLIENT_ACTIVE_TEXTURE 34017)
; #define GL_CLIENT_ACTIVE_TEXTURE          0x84E1
(defconstant $GL_MAX_TEXTURE_UNITS 34018)
; #define GL_MAX_TEXTURE_UNITS              0x84E2
(defconstant $GL_COMBINE 34160)
; #define GL_COMBINE                        0x8570
(defconstant $GL_COMBINE_RGB 34161)
; #define GL_COMBINE_RGB                    0x8571
(defconstant $GL_COMBINE_ALPHA 34162)
; #define GL_COMBINE_ALPHA                  0x8572
(defconstant $GL_RGB_SCALE 34163)
; #define GL_RGB_SCALE                      0x8573
(defconstant $GL_ADD_SIGNED 34164)
; #define GL_ADD_SIGNED                     0x8574
(defconstant $GL_INTERPOLATE 34165)
; #define GL_INTERPOLATE                    0x8575
(defconstant $GL_CONSTANT 34166)
; #define GL_CONSTANT                       0x8576
(defconstant $GL_PRIMARY_COLOR 34167)
; #define GL_PRIMARY_COLOR                  0x8577
(defconstant $GL_PREVIOUS 34168)
; #define GL_PREVIOUS                       0x8578
(defconstant $GL_SUBTRACT 34023)
; #define GL_SUBTRACT                       0x84E7
(defconstant $GL_SOURCE0_RGB 34176)
; #define GL_SOURCE0_RGB                    0x8580
(defconstant $GL_SOURCE1_RGB 34177)
; #define GL_SOURCE1_RGB                    0x8581
(defconstant $GL_SOURCE2_RGB 34178)
; #define GL_SOURCE2_RGB                    0x8582
(defconstant $GL_SOURCE3_RGB 34179)
; #define GL_SOURCE3_RGB                    0x8583
(defconstant $GL_SOURCE4_RGB 34180)
; #define GL_SOURCE4_RGB                    0x8584
(defconstant $GL_SOURCE5_RGB 34181)
; #define GL_SOURCE5_RGB                    0x8585
(defconstant $GL_SOURCE6_RGB 34182)
; #define GL_SOURCE6_RGB                    0x8586
(defconstant $GL_SOURCE7_RGB 34183)
; #define GL_SOURCE7_RGB                    0x8587
(defconstant $GL_SOURCE0_ALPHA 34184)
; #define GL_SOURCE0_ALPHA                  0x8588
(defconstant $GL_SOURCE1_ALPHA 34185)
; #define GL_SOURCE1_ALPHA                  0x8589
(defconstant $GL_SOURCE2_ALPHA 34186)
; #define GL_SOURCE2_ALPHA                  0x858A
(defconstant $GL_SOURCE3_ALPHA 34187)
; #define GL_SOURCE3_ALPHA                  0x858B
(defconstant $GL_SOURCE4_ALPHA 34188)
; #define GL_SOURCE4_ALPHA                  0x858C
(defconstant $GL_SOURCE5_ALPHA 34189)
; #define GL_SOURCE5_ALPHA                  0x858D
(defconstant $GL_SOURCE6_ALPHA 34190)
; #define GL_SOURCE6_ALPHA                  0x858E
(defconstant $GL_SOURCE7_ALPHA 34191)
; #define GL_SOURCE7_ALPHA                  0x858F
(defconstant $GL_OPERAND0_RGB 34192)
; #define GL_OPERAND0_RGB                   0x8590
(defconstant $GL_OPERAND1_RGB 34193)
; #define GL_OPERAND1_RGB                   0x8591
(defconstant $GL_OPERAND2_RGB 34194)
; #define GL_OPERAND2_RGB                   0x8592
(defconstant $GL_OPERAND3_RGB 34195)
; #define GL_OPERAND3_RGB                   0x8593
(defconstant $GL_OPERAND4_RGB 34196)
; #define GL_OPERAND4_RGB                   0x8594
(defconstant $GL_OPERAND5_RGB 34197)
; #define GL_OPERAND5_RGB                   0x8595
(defconstant $GL_OPERAND6_RGB 34198)
; #define GL_OPERAND6_RGB                   0x8596
(defconstant $GL_OPERAND7_RGB 34199)
; #define GL_OPERAND7_RGB                   0x8597
(defconstant $GL_OPERAND0_ALPHA 34200)
; #define GL_OPERAND0_ALPHA                 0x8598
(defconstant $GL_OPERAND1_ALPHA 34201)
; #define GL_OPERAND1_ALPHA                 0x8599
(defconstant $GL_OPERAND2_ALPHA 34202)
; #define GL_OPERAND2_ALPHA                 0x859A
(defconstant $GL_OPERAND3_ALPHA 34203)
; #define GL_OPERAND3_ALPHA                 0x859B
(defconstant $GL_OPERAND4_ALPHA 34204)
; #define GL_OPERAND4_ALPHA                 0x859C
(defconstant $GL_OPERAND5_ALPHA 34205)
; #define GL_OPERAND5_ALPHA                 0x859D
(defconstant $GL_OPERAND6_ALPHA 34206)
; #define GL_OPERAND6_ALPHA                 0x859E
(defconstant $GL_OPERAND7_ALPHA 34207)
; #define GL_OPERAND7_ALPHA                 0x859F
(defconstant $GL_DOT3_RGB 34478)
; #define GL_DOT3_RGB                       0x86AE
(defconstant $GL_DOT3_RGBA 34479)
; #define GL_DOT3_RGBA                      0x86AF
(defconstant $GL_TRANSPOSE_MODELVIEW_MATRIX 34019)
; #define GL_TRANSPOSE_MODELVIEW_MATRIX     0x84E3
(defconstant $GL_TRANSPOSE_PROJECTION_MATRIX 34020)
; #define GL_TRANSPOSE_PROJECTION_MATRIX     0x84E4
(defconstant $GL_TRANSPOSE_TEXTURE_MATRIX 34021)
; #define GL_TRANSPOSE_TEXTURE_MATRIX       0x84E5
(defconstant $GL_TRANSPOSE_COLOR_MATRIX 34022)
; #define GL_TRANSPOSE_COLOR_MATRIX         0x84E6
(defconstant $GL_NORMAL_MAP 34065)
; #define GL_NORMAL_MAP                     0x8511
(defconstant $GL_REFLECTION_MAP 34066)
; #define GL_REFLECTION_MAP                 0x8512
(defconstant $GL_TEXTURE_CUBE_MAP 34067)
; #define GL_TEXTURE_CUBE_MAP               0x8513
(defconstant $GL_TEXTURE_BINDING_CUBE_MAP 34068)
; #define GL_TEXTURE_BINDING_CUBE_MAP       0x8514
(defconstant $GL_TEXTURE_CUBE_MAP_POSITIVE_X 34069)
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_X     0x8515
(defconstant $GL_TEXTURE_CUBE_MAP_NEGATIVE_X 34070)
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_X     0x8516
(defconstant $GL_TEXTURE_CUBE_MAP_POSITIVE_Y 34071)
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_Y     0x8517
(defconstant $GL_TEXTURE_CUBE_MAP_NEGATIVE_Y 34072)
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y     0x8518
(defconstant $GL_TEXTURE_CUBE_MAP_POSITIVE_Z 34073)
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_Z     0x8519
(defconstant $GL_TEXTURE_CUBE_MAP_NEGATIVE_Z 34074)
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z     0x851A
(defconstant $GL_PROXY_TEXTURE_CUBE_MAP 34075)
; #define GL_PROXY_TEXTURE_CUBE_MAP         0x851B
(defconstant $GL_MAX_CUBE_MAP_TEXTURE_SIZE 34076)
; #define GL_MAX_CUBE_MAP_TEXTURE_SIZE      0x851C
(defconstant $GL_COMPRESSED_ALPHA 34025)
; #define GL_COMPRESSED_ALPHA               0x84E9
(defconstant $GL_COMPRESSED_LUMINANCE 34026)
; #define GL_COMPRESSED_LUMINANCE           0x84EA
(defconstant $GL_COMPRESSED_LUMINANCE_ALPHA 34027)
; #define GL_COMPRESSED_LUMINANCE_ALPHA     0x84EB
(defconstant $GL_COMPRESSED_INTENSITY 34028)
; #define GL_COMPRESSED_INTENSITY           0x84EC
(defconstant $GL_COMPRESSED_RGB 34029)
; #define GL_COMPRESSED_RGB                 0x84ED
(defconstant $GL_COMPRESSED_RGBA 34030)
; #define GL_COMPRESSED_RGBA                0x84EE
(defconstant $GL_TEXTURE_COMPRESSION_HINT 34031)
; #define GL_TEXTURE_COMPRESSION_HINT       0x84EF
(defconstant $GL_TEXTURE_COMPRESSED_IMAGE_SIZE 34464)
; #define GL_TEXTURE_COMPRESSED_IMAGE_SIZE  0x86A0
(defconstant $GL_TEXTURE_COMPRESSED 34465)
; #define GL_TEXTURE_COMPRESSED             0x86A1
(defconstant $GL_NUM_COMPRESSED_TEXTURE_FORMATS 34466)
; #define GL_NUM_COMPRESSED_TEXTURE_FORMATS 0x86A2
(defconstant $GL_COMPRESSED_TEXTURE_FORMATS 34467)
; #define GL_COMPRESSED_TEXTURE_FORMATS     0x86A3
(defconstant $GL_MULTISAMPLE 32925)
; #define GL_MULTISAMPLE                    0x809D
(defconstant $GL_SAMPLE_ALPHA_TO_COVERAGE 32926)
; #define GL_SAMPLE_ALPHA_TO_COVERAGE       0x809E
(defconstant $GL_SAMPLE_ALPHA_TO_ONE 32927)
; #define GL_SAMPLE_ALPHA_TO_ONE            0x809F
(defconstant $GL_SAMPLE_COVERAGE 32928)
; #define GL_SAMPLE_COVERAGE                0x80A0
(defconstant $GL_SAMPLE_BUFFERS 32936)
; #define GL_SAMPLE_BUFFERS                 0x80A8
(defconstant $GL_SAMPLES 32937)
; #define GL_SAMPLES                        0x80A9
(defconstant $GL_SAMPLE_COVERAGE_VALUE 32938)
; #define GL_SAMPLE_COVERAGE_VALUE          0x80AA
(defconstant $GL_SAMPLE_COVERAGE_INVERT 32939)
; #define GL_SAMPLE_COVERAGE_INVERT         0x80AB
(defconstant $GL_MULTISAMPLE_BIT 536870912)
; #define GL_MULTISAMPLE_BIT                0x20000000
(defconstant $GL_DEPTH_COMPONENT16 33189)
; #define GL_DEPTH_COMPONENT16              0x81A5
(defconstant $GL_DEPTH_COMPONENT24 33190)
; #define GL_DEPTH_COMPONENT24              0x81A6
(defconstant $GL_DEPTH_COMPONENT32 33191)
; #define GL_DEPTH_COMPONENT32              0x81A7
(defconstant $GL_TEXTURE_DEPTH_SIZE 34890)
; #define GL_TEXTURE_DEPTH_SIZE             0x884A
(defconstant $GL_DEPTH_TEXTURE_MODE 34891)
; #define GL_DEPTH_TEXTURE_MODE             0x884B
(defconstant $GL_TEXTURE_COMPARE_MODE 34892)
; #define GL_TEXTURE_COMPARE_MODE           0x884C
(defconstant $GL_TEXTURE_COMPARE_FUNC 34893)
; #define GL_TEXTURE_COMPARE_FUNC           0x884D
(defconstant $GL_COMPARE_R_TO_TEXTURE 34894)
; #define GL_COMPARE_R_TO_TEXTURE           0x884E
(defconstant $GL_FOG_COORDINATE_SOURCE 33872)
; #define GL_FOG_COORDINATE_SOURCE          0x8450
(defconstant $GL_FOG_COORDINATE 33873)
; #define GL_FOG_COORDINATE                 0x8451
(defconstant $GL_FRAGMENT_DEPTH 33874)
; #define GL_FRAGMENT_DEPTH                 0x8452
(defconstant $GL_CURRENT_FOG_COORDINATE 33875)
; #define GL_CURRENT_FOG_COORDINATE         0x8453  
(defconstant $GL_FOG_COORDINATE_ARRAY_TYPE 33876)
; #define GL_FOG_COORDINATE_ARRAY_TYPE      0x8454
(defconstant $GL_FOG_COORDINATE_ARRAY_STRIDE 33877)
; #define GL_FOG_COORDINATE_ARRAY_STRIDE    0x8455
(defconstant $GL_FOG_COORDINATE_ARRAY_POINTER 33878)
; #define GL_FOG_COORDINATE_ARRAY_POINTER   0x8456
(defconstant $GL_FOG_COORDINATE_ARRAY 33879)
; #define GL_FOG_COORDINATE_ARRAY           0x8457
(defconstant $GL_COLOR_SUM 33880)
; #define GL_COLOR_SUM                      0x8458
(defconstant $GL_CURRENT_SECONDARY_COLOR 33881)
; #define GL_CURRENT_SECONDARY_COLOR        0x8459
(defconstant $GL_SECONDARY_COLOR_ARRAY_SIZE 33882)
; #define GL_SECONDARY_COLOR_ARRAY_SIZE     0x845A
(defconstant $GL_SECONDARY_COLOR_ARRAY_TYPE 33883)
; #define GL_SECONDARY_COLOR_ARRAY_TYPE     0x845B
(defconstant $GL_SECONDARY_COLOR_ARRAY_STRIDE 33884)
; #define GL_SECONDARY_COLOR_ARRAY_STRIDE   0x845C
(defconstant $GL_SECONDARY_COLOR_ARRAY_POINTER 33885)
; #define GL_SECONDARY_COLOR_ARRAY_POINTER  0x845D
(defconstant $GL_SECONDARY_COLOR_ARRAY 33886)
; #define GL_SECONDARY_COLOR_ARRAY          0x845E
(defconstant $GL_POINT_SIZE_MIN 33062)
; #define GL_POINT_SIZE_MIN                 0x8126
(defconstant $GL_POINT_SIZE_MAX 33063)
; #define GL_POINT_SIZE_MAX                 0x8127
(defconstant $GL_POINT_FADE_THRESHOLD_SIZE 33064)
; #define GL_POINT_FADE_THRESHOLD_SIZE      0x8128
(defconstant $GL_POINT_DISTANCE_ATTENUATION 33065)
; #define GL_POINT_DISTANCE_ATTENUATION     0x8129
(defconstant $GL_BLEND_DST_RGB 32968)
; #define GL_BLEND_DST_RGB                  0x80C8
(defconstant $GL_BLEND_SRC_RGB 32969)
; #define GL_BLEND_SRC_RGB                  0x80C9
(defconstant $GL_BLEND_DST_ALPHA 32970)
; #define GL_BLEND_DST_ALPHA                0x80CA
(defconstant $GL_BLEND_SRC_ALPHA 32971)
; #define GL_BLEND_SRC_ALPHA                0x80CB
(defconstant $GL_GENERATE_MIPMAP 33169)
; #define GL_GENERATE_MIPMAP                0x8191
(defconstant $GL_GENERATE_MIPMAP_HINT 33170)
; #define GL_GENERATE_MIPMAP_HINT           0x8192
(defconstant $GL_INCR_WRAP 34055)
; #define GL_INCR_WRAP                      0x8507
(defconstant $GL_DECR_WRAP 34056)
; #define GL_DECR_WRAP                      0x8508
(defconstant $GL_MIRRORED_REPEAT 33648)
; #define GL_MIRRORED_REPEAT                0x8370
(defconstant $GL_MAX_TEXTURE_LOD_BIAS 34045)
; #define GL_MAX_TEXTURE_LOD_BIAS           0x84FD
(defconstant $GL_TEXTURE_FILTER_CONTROL 34048)
; #define GL_TEXTURE_FILTER_CONTROL         0x8500
(defconstant $GL_TEXTURE_LOD_BIAS 34049)
; #define GL_TEXTURE_LOD_BIAS               0x8501
; ***********************************************************
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glAccumProcPtr) (GLenum op, GLfloat value);
typedef void (* glAlphaFuncProcPtr) (GLenum func, GLclampf ref);
typedef GLboolean (* glAreTexturesResidentProcPtr) (GLsizei n, const GLuint *textures, GLboolean *residences);
typedef void (* glArrayElementProcPtr) (GLint i);
typedef void (* glBeginProcPtr) (GLenum mode);
typedef void (* glBindTextureProcPtr) (GLenum target, GLuint texture);
typedef void (* glBitmapProcPtr) (GLsizei width, GLsizei height, GLfloat xorig, GLfloat yorig, GLfloat xmove, GLfloat ymove, const GLubyte *bitmap);
typedef void (* glBlendColorProcPtr) (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
typedef void (* glBlendEquationProcPtr) (GLenum mode);
typedef void (* glBlendFuncProcPtr) (GLenum sfactor, GLenum dfactor);
typedef void (* glCallListProcPtr) (GLuint list);
typedef void (* glCallListsProcPtr) (GLsizei n, GLenum type, const GLvoid *lists);
typedef void (* glClearProcPtr) (GLbitfield mask);
typedef void (* glClearAccumProcPtr) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (* glClearColorProcPtr) (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
typedef void (* glClearDepthProcPtr) (GLclampd depth);
typedef void (* glClearIndexProcPtr) (GLfloat c);
typedef void (* glClearStencilProcPtr) (GLint s);
typedef void (* glClipPlaneProcPtr) (GLenum plane, const GLdouble *equation);
typedef void (* glColor3bProcPtr) (GLbyte red, GLbyte green, GLbyte blue);
typedef void (* glColor3bvProcPtr) (const GLbyte *v);
typedef void (* glColor3dProcPtr) (GLdouble red, GLdouble green, GLdouble blue);
typedef void (* glColor3dvProcPtr) (const GLdouble *v);
typedef void (* glColor3fProcPtr) (GLfloat red, GLfloat green, GLfloat blue);
typedef void (* glColor3fvProcPtr) (const GLfloat *v);
typedef void (* glColor3iProcPtr) (GLint red, GLint green, GLint blue);
typedef void (* glColor3ivProcPtr) (const GLint *v);
typedef void (* glColor3sProcPtr) (GLshort red, GLshort green, GLshort blue);
typedef void (* glColor3svProcPtr) (const GLshort *v);
typedef void (* glColor3ubProcPtr) (GLubyte red, GLubyte green, GLubyte blue);
typedef void (* glColor3ubvProcPtr) (const GLubyte *v);
typedef void (* glColor3uiProcPtr) (GLuint red, GLuint green, GLuint blue);
typedef void (* glColor3uivProcPtr) (const GLuint *v);
typedef void (* glColor3usProcPtr) (GLushort red, GLushort green, GLushort blue);
typedef void (* glColor3usvProcPtr) (const GLushort *v);
typedef void (* glColor4bProcPtr) (GLbyte red, GLbyte green, GLbyte blue, GLbyte alpha);
typedef void (* glColor4bvProcPtr) (const GLbyte *v);
typedef void (* glColor4dProcPtr) (GLdouble red, GLdouble green, GLdouble blue, GLdouble alpha);
typedef void (* glColor4dvProcPtr) (const GLdouble *v);
typedef void (* glColor4fProcPtr) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (* glColor4fvProcPtr) (const GLfloat *v);
typedef void (* glColor4iProcPtr) (GLint red, GLint green, GLint blue, GLint alpha);
typedef void (* glColor4ivProcPtr) (const GLint *v);
typedef void (* glColor4sProcPtr) (GLshort red, GLshort green, GLshort blue, GLshort alpha);
typedef void (* glColor4svProcPtr) (const GLshort *v);
typedef void (* glColor4ubProcPtr) (GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha);
typedef void (* glColor4ubvProcPtr) (const GLubyte *v);
typedef void (* glColor4uiProcPtr) (GLuint red, GLuint green, GLuint blue, GLuint alpha);
typedef void (* glColor4uivProcPtr) (const GLuint *v);
typedef void (* glColor4usProcPtr) (GLushort red, GLushort green, GLushort blue, GLushort alpha);
typedef void (* glColor4usvProcPtr) (const GLushort *v);
typedef void (* glColorMaskProcPtr) (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
typedef void (* glColorMaterialProcPtr) (GLenum face, GLenum mode);
typedef void (* glColorPointerProcPtr) (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* glColorSubTableProcPtr) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const GLvoid *data);
typedef void (* glColorTableProcPtr) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *table);
typedef void (* glColorTableParameterfvProcPtr) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* glColorTableParameterivProcPtr) (GLenum target, GLenum pname, const GLint *params);
typedef void (* glConvolutionFilter1DProcPtr) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *image);
typedef void (* glConvolutionFilter2DProcPtr) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *image);
typedef void (* glConvolutionParameterfProcPtr) (GLenum target, GLenum pname, GLfloat params);
typedef void (* glConvolutionParameterfvProcPtr) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* glConvolutionParameteriProcPtr) (GLenum target, GLenum pname, GLint params);
typedef void (* glConvolutionParameterivProcPtr) (GLenum target, GLenum pname, const GLint *params);
typedef void (* glCopyColorSubTableProcPtr) (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);
typedef void (* glCopyColorTableProcPtr) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void (* glCopyConvolutionFilter1DProcPtr) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void (* glCopyConvolutionFilter2DProcPtr) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* glCopyPixelsProcPtr) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum type);
typedef void (* glCopyTexImage1DProcPtr) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void (* glCopyTexImage2DProcPtr) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void (* glCopyTexSubImage1DProcPtr) (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void (* glCopyTexSubImage2DProcPtr) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* glCopyTexSubImage3DProcPtr) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* glCullFaceProcPtr) (GLenum mode);
typedef void (* glDeleteListsProcPtr) (GLuint list, GLsizei range);
typedef void (* glDeleteTexturesProcPtr) (GLsizei n, const GLuint *textures);
typedef void (* glDepthFuncProcPtr) (GLenum func);
typedef void (* glDepthMaskProcPtr) (GLboolean flag);
typedef void (* glDepthRangeProcPtr) (GLclampd zNear, GLclampd zFar);
typedef void (* glDisableProcPtr) (GLenum cap);
typedef void (* glDisableClientStateProcPtr) (GLenum array);
typedef void (* glDrawArraysProcPtr) (GLenum mode, GLint first, GLsizei count);
typedef void (* glDrawBufferProcPtr) (GLenum mode);
typedef void (* glDrawElementsProcPtr) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);
typedef void (* glDrawPixelsProcPtr) (GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glDrawRangeElementsProcPtr) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void (* glEdgeFlagProcPtr) (GLboolean flag);
typedef void (* glEdgeFlagPointerProcPtr) (GLsizei stride, const GLvoid *pointer);
typedef void (* glEdgeFlagvProcPtr) (const GLboolean *flag);
typedef void (* glEnableProcPtr) (GLenum cap);
typedef void (* glEnableClientStateProcPtr) (GLenum array);
typedef void (* glEndProcPtr) (void);
typedef void (* glEndListProcPtr) (void);
typedef void (* glEvalCoord1dProcPtr) (GLdouble u);
typedef void (* glEvalCoord1dvProcPtr) (const GLdouble *u);
typedef void (* glEvalCoord1fProcPtr) (GLfloat u);
typedef void (* glEvalCoord1fvProcPtr) (const GLfloat *u);
typedef void (* glEvalCoord2dProcPtr) (GLdouble u, GLdouble v);
typedef void (* glEvalCoord2dvProcPtr) (const GLdouble *u);
typedef void (* glEvalCoord2fProcPtr) (GLfloat u, GLfloat v);
typedef void (* glEvalCoord2fvProcPtr) (const GLfloat *u);
typedef void (* glEvalMesh1ProcPtr) (GLenum mode, GLint i1, GLint i2);
typedef void (* glEvalMesh2ProcPtr) (GLenum mode, GLint i1, GLint i2, GLint j1, GLint j2);
typedef void (* glEvalPoint1ProcPtr) (GLint i);
typedef void (* glEvalPoint2ProcPtr) (GLint i, GLint j);
typedef void (* glFeedbackBufferProcPtr) (GLsizei size, GLenum type, GLfloat *buffer);
typedef void (* glFinishProcPtr) (void);
typedef void (* glFlushProcPtr) (void);
typedef void (* glFogfProcPtr) (GLenum pname, GLfloat param);
typedef void (* glFogfvProcPtr) (GLenum pname, const GLfloat *params);
typedef void (* glFogiProcPtr) (GLenum pname, GLint param);
typedef void (* glFogivProcPtr) (GLenum pname, const GLint *params);
typedef void (* glFrontFaceProcPtr) (GLenum mode);
typedef void (* glFrustumProcPtr) (GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
typedef GLuint (* glGenListsProcPtr) (GLsizei range);
typedef void (* glGenTexturesProcPtr) (GLsizei n, GLuint *textures);
typedef void (* glGetBooleanvProcPtr) (GLenum pname, GLboolean *params);
typedef void (* glGetClipPlaneProcPtr) (GLenum plane, GLdouble *equation);
typedef void (* glGetColorTableProcPtr) (GLenum target, GLenum format, GLenum type, GLvoid *table);
typedef void (* glGetColorTableParameterfvProcPtr) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* glGetColorTableParameterivProcPtr) (GLenum target, GLenum pname, GLint *params);
typedef void (* glGetConvolutionFilterProcPtr) (GLenum target, GLenum format, GLenum type, GLvoid *image);
typedef void (* glGetConvolutionParameterfvProcPtr) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* glGetConvolutionParameterivProcPtr) (GLenum target, GLenum pname, GLint *params);
typedef void (* glGetDoublevProcPtr) (GLenum pname, GLdouble *params);
typedef GLenum (* glGetErrorProcPtr) (void);
typedef void (* glGetFloatvProcPtr) (GLenum pname, GLfloat *params);
typedef void (* glGetHistogramProcPtr) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid *values);
typedef void (* glGetHistogramParameterfvProcPtr) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* glGetHistogramParameterivProcPtr) (GLenum target, GLenum pname, GLint *params);
typedef void (* glGetIntegervProcPtr) (GLenum pname, GLint *params);
typedef void (* glGetLightfvProcPtr) (GLenum light, GLenum pname, GLfloat *params);
typedef void (* glGetLightivProcPtr) (GLenum light, GLenum pname, GLint *params);
typedef void (* glGetMapdvProcPtr) (GLenum target, GLenum query, GLdouble *v);
typedef void (* glGetMapfvProcPtr) (GLenum target, GLenum query, GLfloat *v);
typedef void (* glGetMapivProcPtr) (GLenum target, GLenum query, GLint *v);
typedef void (* glGetMaterialfvProcPtr) (GLenum face, GLenum pname, GLfloat *params);
typedef void (* glGetMaterialivProcPtr) (GLenum face, GLenum pname, GLint *params);
typedef void (* glGetMinmaxProcPtr) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid *values);
typedef void (* glGetMinmaxParameterfvProcPtr) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* glGetMinmaxParameterivProcPtr) (GLenum target, GLenum pname, GLint *params);
typedef void (* glGetPixelMapfvProcPtr) (GLenum map, GLfloat *values);
typedef void (* glGetPixelMapuivProcPtr) (GLenum map, GLuint *values);
typedef void (* glGetPixelMapusvProcPtr) (GLenum map, GLushort *values);
typedef void (* glGetPointervProcPtr) (GLenum pname, GLvoid* *params);
typedef void (* glGetPolygonStippleProcPtr) (GLubyte *mask);
typedef void (* glGetSeparableFilterProcPtr) (GLenum target, GLenum format, GLenum type, GLvoid *row, GLvoid *column, GLvoid *span);
extern const GLubyte * glGetString (GLenum name);
typedef void (* glGetTexEnvfvProcPtr) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* glGetTexEnvivProcPtr) (GLenum target, GLenum pname, GLint *params);
typedef void (* glGetTexGendvProcPtr) (GLenum coord, GLenum pname, GLdouble *params);
typedef void (* glGetTexGenfvProcPtr) (GLenum coord, GLenum pname, GLfloat *params);
typedef void (* glGetTexGenivProcPtr) (GLenum coord, GLenum pname, GLint *params);
typedef void (* glGetTexImageProcPtr) (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels);
typedef void (* glGetTexLevelParameterfvProcPtr) (GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void (* glGetTexLevelParameterivProcPtr) (GLenum target, GLint level, GLenum pname, GLint *params);
typedef void (* glGetTexParameterfvProcPtr) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* glGetTexParameterivProcPtr) (GLenum target, GLenum pname, GLint *params);
typedef void (* glHintProcPtr) (GLenum target, GLenum mode);
typedef void (* glHistogramProcPtr) (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);
typedef void (* glIndexMaskProcPtr) (GLuint mask);
typedef void (* glIndexPointerProcPtr) (GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* glIndexdProcPtr) (GLdouble c);
typedef void (* glIndexdvProcPtr) (const GLdouble *c);
typedef void (* glIndexfProcPtr) (GLfloat c);
typedef void (* glIndexfvProcPtr) (const GLfloat *c);
typedef void (* glIndexiProcPtr) (GLint c);
typedef void (* glIndexivProcPtr) (const GLint *c);
typedef void (* glIndexsProcPtr) (GLshort c);
typedef void (* glIndexsvProcPtr) (const GLshort *c);
typedef void (* glIndexubProcPtr) (GLubyte c);
typedef void (* glIndexubvProcPtr) (const GLubyte *c);
typedef void (* glInitNamesProcPtr) (void);
typedef void (* glInterleavedArraysProcPtr) (GLenum format, GLsizei stride, const GLvoid *pointer);
typedef GLboolean (* glIsEnabledProcPtr) (GLenum cap);
typedef GLboolean (* glIsListProcPtr) (GLuint list);
typedef GLboolean (* glIsTextureProcPtr) (GLuint texture);
typedef void (* glLightModelfProcPtr) (GLenum pname, GLfloat param);
typedef void (* glLightModelfvProcPtr) (GLenum pname, const GLfloat *params);
typedef void (* glLightModeliProcPtr) (GLenum pname, GLint param);
typedef void (* glLightModelivProcPtr) (GLenum pname, const GLint *params);
typedef void (* glLightfProcPtr) (GLenum light, GLenum pname, GLfloat param);
typedef void (* glLightfvProcPtr) (GLenum light, GLenum pname, const GLfloat *params);
typedef void (* glLightiProcPtr) (GLenum light, GLenum pname, GLint param);
typedef void (* glLightivProcPtr) (GLenum light, GLenum pname, const GLint *params);
typedef void (* glLineStippleProcPtr) (GLint factor, GLushort pattern);
typedef void (* glLineWidthProcPtr) (GLfloat width);
typedef void (* glListBaseProcPtr) (GLuint base);
typedef void (* glLoadIdentityProcPtr) (void);
typedef void (* glLoadMatrixdProcPtr) (const GLdouble *m);
typedef void (* glLoadMatrixfProcPtr) (const GLfloat *m);
typedef void (* glLoadNameProcPtr) (GLuint name);
typedef void (* glLogicOpProcPtr) (GLenum opcode);
typedef void (* glMap1dProcPtr) (GLenum target, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points);
typedef void (* glMap1fProcPtr) (GLenum target, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points);
typedef void (* glMap2dProcPtr) (GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points);
typedef void (* glMap2fProcPtr) (GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points);
typedef void (* glMapGrid1dProcPtr) (GLint un, GLdouble u1, GLdouble u2);
typedef void (* glMapGrid1fProcPtr) (GLint un, GLfloat u1, GLfloat u2);
typedef void (* glMapGrid2dProcPtr) (GLint un, GLdouble u1, GLdouble u2, GLint vn, GLdouble v1, GLdouble v2);
typedef void (* glMapGrid2fProcPtr) (GLint un, GLfloat u1, GLfloat u2, GLint vn, GLfloat v1, GLfloat v2);
typedef void (* glMaterialfProcPtr) (GLenum face, GLenum pname, GLfloat param);
typedef void (* glMaterialfvProcPtr) (GLenum face, GLenum pname, const GLfloat *params);
typedef void (* glMaterialiProcPtr) (GLenum face, GLenum pname, GLint param);
typedef void (* glMaterialivProcPtr) (GLenum face, GLenum pname, const GLint *params);
typedef void (* glMatrixModeProcPtr) (GLenum mode);
typedef void (* glMinmaxProcPtr) (GLenum target, GLenum internalformat, GLboolean sink);
typedef void (* glMultMatrixdProcPtr) (const GLdouble *m);
typedef void (* glMultMatrixfProcPtr) (const GLfloat *m);
typedef void (* glNewListProcPtr) (GLuint list, GLenum mode);
typedef void (* glNormal3bProcPtr) (GLbyte nx, GLbyte ny, GLbyte nz);
typedef void (* glNormal3bvProcPtr) (const GLbyte *v);
typedef void (* glNormal3dProcPtr) (GLdouble nx, GLdouble ny, GLdouble nz);
typedef void (* glNormal3dvProcPtr) (const GLdouble *v);
typedef void (* glNormal3fProcPtr) (GLfloat nx, GLfloat ny, GLfloat nz);
typedef void (* glNormal3fvProcPtr) (const GLfloat *v);
typedef void (* glNormal3iProcPtr) (GLint nx, GLint ny, GLint nz);
typedef void (* glNormal3ivProcPtr) (const GLint *v);
typedef void (* glNormal3sProcPtr) (GLshort nx, GLshort ny, GLshort nz);
typedef void (* glNormal3svProcPtr) (const GLshort *v);
typedef void (* glNormalPointerProcPtr) (GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* glOrthoProcPtr) (GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
typedef void (* glPassThroughProcPtr) (GLfloat token);
typedef void (* glPixelMapfvProcPtr) (GLenum map, GLint mapsize, const GLfloat *values);
typedef void (* glPixelMapuivProcPtr) (GLenum map, GLint mapsize, const GLuint *values);
typedef void (* glPixelMapusvProcPtr) (GLenum map, GLint mapsize, const GLushort *values);
typedef void (* glPixelStorefProcPtr) (GLenum pname, GLfloat param);
typedef void (* glPixelStoreiProcPtr) (GLenum pname, GLint param);
typedef void (* glPixelTransferfProcPtr) (GLenum pname, GLfloat param);
typedef void (* glPixelTransferiProcPtr) (GLenum pname, GLint param);
typedef void (* glPixelZoomProcPtr) (GLfloat xfactor, GLfloat yfactor);
typedef void (* glPointSizeProcPtr) (GLfloat size);
typedef void (* glPolygonModeProcPtr) (GLenum face, GLenum mode);
typedef void (* glPolygonOffsetProcPtr) (GLfloat factor, GLfloat units);
typedef void (* glPolygonStippleProcPtr) (const GLubyte *mask);
typedef void (* glPopAttribProcPtr) (void);
typedef void (* glPopClientAttribProcPtr) (void);
typedef void (* glPopMatrixProcPtr) (void);
typedef void (* glPopNameProcPtr) (void);
typedef void (* glPrioritizeTexturesProcPtr) (GLsizei n, const GLuint *textures, const GLclampf *priorities);
typedef void (* glPushAttribProcPtr) (GLbitfield mask);
typedef void (* glPushClientAttribProcPtr) (GLbitfield mask);
typedef void (* glPushMatrixProcPtr) (void);
typedef void (* glPushNameProcPtr) (GLuint name);
typedef void (* glRasterPos2dProcPtr) (GLdouble x, GLdouble y);
typedef void (* glRasterPos2dvProcPtr) (const GLdouble *v);
typedef void (* glRasterPos2fProcPtr) (GLfloat x, GLfloat y);
typedef void (* glRasterPos2fvProcPtr) (const GLfloat *v);
typedef void (* glRasterPos2iProcPtr) (GLint x, GLint y);
typedef void (* glRasterPos2ivProcPtr) (const GLint *v);
typedef void (* glRasterPos2sProcPtr) (GLshort x, GLshort y);
typedef void (* glRasterPos2svProcPtr) (const GLshort *v);
typedef void (* glRasterPos3dProcPtr) (GLdouble x, GLdouble y, GLdouble z);
typedef void (* glRasterPos3dvProcPtr) (const GLdouble *v);
typedef void (* glRasterPos3fProcPtr) (GLfloat x, GLfloat y, GLfloat z);
typedef void (* glRasterPos3fvProcPtr) (const GLfloat *v);
typedef void (* glRasterPos3iProcPtr) (GLint x, GLint y, GLint z);
typedef void (* glRasterPos3ivProcPtr) (const GLint *v);
typedef void (* glRasterPos3sProcPtr) (GLshort x, GLshort y, GLshort z);
typedef void (* glRasterPos3svProcPtr) (const GLshort *v);
typedef void (* glRasterPos4dProcPtr) (GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glRasterPos4dvProcPtr) (const GLdouble *v);
typedef void (* glRasterPos4fProcPtr) (GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glRasterPos4fvProcPtr) (const GLfloat *v);
typedef void (* glRasterPos4iProcPtr) (GLint x, GLint y, GLint z, GLint w);
typedef void (* glRasterPos4ivProcPtr) (const GLint *v);
typedef void (* glRasterPos4sProcPtr) (GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* glRasterPos4svProcPtr) (const GLshort *v);
typedef void (* glReadBufferProcPtr) (GLenum mode);
typedef void (* glReadPixelsProcPtr) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels);
typedef void (* glRectdProcPtr) (GLdouble x1, GLdouble y1, GLdouble x2, GLdouble y2);
typedef void (* glRectdvProcPtr) (const GLdouble *v1, const GLdouble *v2);
typedef void (* glRectfProcPtr) (GLfloat x1, GLfloat y1, GLfloat x2, GLfloat y2);
typedef void (* glRectfvProcPtr) (const GLfloat *v1, const GLfloat *v2);
typedef void (* glRectiProcPtr) (GLint x1, GLint y1, GLint x2, GLint y2);
typedef void (* glRectivProcPtr) (const GLint *v1, const GLint *v2);
typedef void (* glRectsProcPtr) (GLshort x1, GLshort y1, GLshort x2, GLshort y2);
typedef void (* glRectsvProcPtr) (const GLshort *v1, const GLshort *v2);
typedef GLint (* glRenderModeProcPtr) (GLenum mode);
typedef void (* glResetHistogramProcPtr) (GLenum target);
typedef void (* glResetMinmaxProcPtr) (GLenum target);
typedef void (* glRotatedProcPtr) (GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
typedef void (* glRotatefProcPtr) (GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
typedef void (* glScaledProcPtr) (GLdouble x, GLdouble y, GLdouble z);
typedef void (* glScalefProcPtr) (GLfloat x, GLfloat y, GLfloat z);
typedef void (* glScissorProcPtr) (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* glSelectBufferProcPtr) (GLsizei size, GLuint *buffer);
typedef void (* glSeparableFilter2DProcPtr) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *row, const GLvoid *column);
typedef void (* glShadeModelProcPtr) (GLenum mode);
typedef void (* glStencilFuncProcPtr) (GLenum func, GLint ref, GLuint mask);
typedef void (* glStencilMaskProcPtr) (GLuint mask);
typedef void (* glStencilOpProcPtr) (GLenum fail, GLenum zfail, GLenum zpass);
typedef void (* glTexCoord1dProcPtr) (GLdouble s);
typedef void (* glTexCoord1dvProcPtr) (const GLdouble *v);
typedef void (* glTexCoord1fProcPtr) (GLfloat s);
typedef void (* glTexCoord1fvProcPtr) (const GLfloat *v);
typedef void (* glTexCoord1iProcPtr) (GLint s);
typedef void (* glTexCoord1ivProcPtr) (const GLint *v);
typedef void (* glTexCoord1sProcPtr) (GLshort s);
typedef void (* glTexCoord1svProcPtr) (const GLshort *v);
typedef void (* glTexCoord2dProcPtr) (GLdouble s, GLdouble t);
typedef void (* glTexCoord2dvProcPtr) (const GLdouble *v);
typedef void (* glTexCoord2fProcPtr) (GLfloat s, GLfloat t);
typedef void (* glTexCoord2fvProcPtr) (const GLfloat *v);
typedef void (* glTexCoord2iProcPtr) (GLint s, GLint t);
typedef void (* glTexCoord2ivProcPtr) (const GLint *v);
typedef void (* glTexCoord2sProcPtr) (GLshort s, GLshort t);
typedef void (* glTexCoord2svProcPtr) (const GLshort *v);
typedef void (* glTexCoord3dProcPtr) (GLdouble s, GLdouble t, GLdouble r);
typedef void (* glTexCoord3dvProcPtr) (const GLdouble *v);
typedef void (* glTexCoord3fProcPtr) (GLfloat s, GLfloat t, GLfloat r);
typedef void (* glTexCoord3fvProcPtr) (const GLfloat *v);
typedef void (* glTexCoord3iProcPtr) (GLint s, GLint t, GLint r);
typedef void (* glTexCoord3ivProcPtr) (const GLint *v);
typedef void (* glTexCoord3sProcPtr) (GLshort s, GLshort t, GLshort r);
typedef void (* glTexCoord3svProcPtr) (const GLshort *v);
typedef void (* glTexCoord4dProcPtr) (GLdouble s, GLdouble t, GLdouble r, GLdouble q);
typedef void (* glTexCoord4dvProcPtr) (const GLdouble *v);
typedef void (* glTexCoord4fProcPtr) (GLfloat s, GLfloat t, GLfloat r, GLfloat q);
typedef void (* glTexCoord4fvProcPtr) (const GLfloat *v);
typedef void (* glTexCoord4iProcPtr) (GLint s, GLint t, GLint r, GLint q);
typedef void (* glTexCoord4ivProcPtr) (const GLint *v);
typedef void (* glTexCoord4sProcPtr) (GLshort s, GLshort t, GLshort r, GLshort q);
typedef void (* glTexCoord4svProcPtr) (const GLshort *v);
typedef void (* glTexCoordPointerProcPtr) (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* glTexEnvfProcPtr) (GLenum target, GLenum pname, GLfloat param);
typedef void (* glTexEnvfvProcPtr) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* glTexEnviProcPtr) (GLenum target, GLenum pname, GLint param);
typedef void (* glTexEnvivProcPtr) (GLenum target, GLenum pname, const GLint *params);
typedef void (* glTexGendProcPtr) (GLenum coord, GLenum pname, GLdouble param);
typedef void (* glTexGendvProcPtr) (GLenum coord, GLenum pname, const GLdouble *params);
typedef void (* glTexGenfProcPtr) (GLenum coord, GLenum pname, GLfloat param);
typedef void (* glTexGenfvProcPtr) (GLenum coord, GLenum pname, const GLfloat *params);
typedef void (* glTexGeniProcPtr) (GLenum coord, GLenum pname, GLint param);
typedef void (* glTexGenivProcPtr) (GLenum coord, GLenum pname, const GLint *params);
typedef void (* glTexImage1DProcPtr) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glTexImage2DProcPtr) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glTexImage3DProcPtr) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glTexParameterfProcPtr) (GLenum target, GLenum pname, GLfloat param);
typedef void (* glTexParameterfvProcPtr) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* glTexParameteriProcPtr) (GLenum target, GLenum pname, GLint param);
typedef void (* glTexParameterivProcPtr) (GLenum target, GLenum pname, const GLint *params);
typedef void (* glTexSubImage1DProcPtr) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glTexSubImage2DProcPtr) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glTexSubImage3DProcPtr) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* glTranslatedProcPtr) (GLdouble x, GLdouble y, GLdouble z);
typedef void (* glTranslatefProcPtr) (GLfloat x, GLfloat y, GLfloat z);
typedef void (* glVertex2dProcPtr) (GLdouble x, GLdouble y);
typedef void (* glVertex2dvProcPtr) (const GLdouble *v);
typedef void (* glVertex2fProcPtr) (GLfloat x, GLfloat y);
typedef void (* glVertex2fvProcPtr) (const GLfloat *v);
typedef void (* glVertex2iProcPtr) (GLint x, GLint y);
typedef void (* glVertex2ivProcPtr) (const GLint *v);
typedef void (* glVertex2sProcPtr) (GLshort x, GLshort y);
typedef void (* glVertex2svProcPtr) (const GLshort *v);
typedef void (* glVertex3dProcPtr) (GLdouble x, GLdouble y, GLdouble z);
typedef void (* glVertex3dvProcPtr) (const GLdouble *v);
typedef void (* glVertex3fProcPtr) (GLfloat x, GLfloat y, GLfloat z);
typedef void (* glVertex3fvProcPtr) (const GLfloat *v);
typedef void (* glVertex3iProcPtr) (GLint x, GLint y, GLint z);
typedef void (* glVertex3ivProcPtr) (const GLint *v);
typedef void (* glVertex3sProcPtr) (GLshort x, GLshort y, GLshort z);
typedef void (* glVertex3svProcPtr) (const GLshort *v);
typedef void (* glVertex4dProcPtr) (GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glVertex4dvProcPtr) (const GLdouble *v);
typedef void (* glVertex4fProcPtr) (GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glVertex4fvProcPtr) (const GLfloat *v);
typedef void (* glVertex4iProcPtr) (GLint x, GLint y, GLint z, GLint w);
typedef void (* glVertex4ivProcPtr) (const GLint *v);
typedef void (* glVertex4sProcPtr) (GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* glVertex4svProcPtr) (const GLshort *v);
typedef void (* glVertexPointerProcPtr) (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* glViewportProcPtr) (GLint x, GLint y, GLsizei width, GLsizei height);

typedef void (* glSampleCoverageProcPtr) (GLclampf, GLboolean);
typedef void (* glSamplePassProcPtr) (GLenum);

typedef void (* glLoadTransposeMatrixfProcPtr) (const GLfloat *);
typedef void (* glLoadTransposeMatrixdProcPtr) (const GLdouble *);
typedef void (* glMultTransposeMatrixfProcPtr) (const GLfloat *);
typedef void (* glMultTransposeMatrixdProcPtr) (const GLdouble *);

typedef void (* glCompressedTexImage3DProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, const GLvoid *);
typedef void (* glCompressedTexImage2DProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, const GLvoid *);
typedef void (* glCompressedTexImage1DProcPtr) (GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, const GLvoid *);
typedef void (* glCompressedTexSubImage3DProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, const GLvoid *);
typedef void (* glCompressedTexSubImage2DProcPtr) (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, const GLvoid *);
typedef void (* glCompressedTexSubImage1DProcPtr) (GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, const GLvoid *);
typedef void (* glGetCompressedTexImageProcPtr) (GLenum, GLint, GLvoid *);

typedef void (* glActiveTextureProcPtr) (GLenum);
typedef void (* glClientActiveTextureProcPtr) (GLenum);
typedef void (* glMultiTexCoord1dProcPtr) (GLenum, GLdouble);
typedef void (* glMultiTexCoord1dvProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord1fProcPtr) (GLenum, GLfloat);
typedef void (* glMultiTexCoord1fvProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord1iProcPtr) (GLenum, GLint);
typedef void (* glMultiTexCoord1ivProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord1sProcPtr) (GLenum, GLshort);
typedef void (* glMultiTexCoord1svProcPtr) (GLenum, const GLshort *);
typedef void (* glMultiTexCoord2dProcPtr) (GLenum, GLdouble, GLdouble);
typedef void (* glMultiTexCoord2dvProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord2fProcPtr) (GLenum, GLfloat, GLfloat);
typedef void (* glMultiTexCoord2fvProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord2iProcPtr) (GLenum, GLint, GLint);
typedef void (* glMultiTexCoord2ivProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord2sProcPtr) (GLenum, GLshort, GLshort);
typedef void (* glMultiTexCoord2svProcPtr) (GLenum, const GLshort *);
typedef void (* glMultiTexCoord3dProcPtr) (GLenum, GLdouble, GLdouble, GLdouble);
typedef void (* glMultiTexCoord3dvProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord3fProcPtr) (GLenum, GLfloat, GLfloat, GLfloat);
typedef void (* glMultiTexCoord3fvProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord3iProcPtr) (GLenum, GLint, GLint, GLint);
typedef void (* glMultiTexCoord3ivProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord3sProcPtr) (GLenum, GLshort, GLshort, GLshort);
typedef void (* glMultiTexCoord3svProcPtr) (GLenum, const GLshort *);
typedef void (* glMultiTexCoord4dProcPtr) (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
typedef void (* glMultiTexCoord4dvProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord4fProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glMultiTexCoord4fvProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord4iProcPtr) (GLenum, GLint, GLint, GLint, GLint);
typedef void (* glMultiTexCoord4ivProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord4sProcPtr) (GLenum, GLshort, GLshort, GLshort, GLshort);
typedef void (* glMultiTexCoord4svProcPtr) (GLenum, const GLshort *);

typedef void (* glFogCoordfProcPtr) (GLfloat);
typedef void (* glFogCoordfvProcPtr) (const GLfloat *);  
typedef void (* glFogCoorddProcPtr) (GLdouble);
typedef void (* glFogCoorddvProcPtr) (const GLdouble *);   
typedef void (* glFogCoordPointerProcPtr) (GLenum, GLsizei, const GLvoid *);

typedef void (* glSecondaryColor3bProcPtr) (GLbyte, GLbyte, GLbyte);
typedef void (* glSecondaryColor3bvProcPtr) (const GLbyte *);
typedef void (* glSecondaryColor3dProcPtr) (GLdouble, GLdouble, GLdouble);
typedef void (* glSecondaryColor3dvProcPtr) (const GLdouble *);
typedef void (* glSecondaryColor3fProcPtr) (GLfloat, GLfloat, GLfloat);
typedef void (* glSecondaryColor3fvProcPtr) (const GLfloat *);
typedef void (* glSecondaryColor3iProcPtr) (GLint, GLint, GLint);
typedef void (* glSecondaryColor3ivProcPtr) (const GLint *);
typedef void (* glSecondaryColor3sProcPtr) (GLshort, GLshort, GLshort);
typedef void (* glSecondaryColor3svProcPtr) (const GLshort *);
typedef void (* glSecondaryColor3ubProcPtr) (GLubyte, GLubyte, GLubyte);
typedef void (* glSecondaryColor3ubvProcPtr) (const GLubyte *);
typedef void (* glSecondaryColor3uiProcPtr) (GLuint, GLuint, GLuint);
typedef void (* glSecondaryColor3uivProcPtr) (const GLuint *);
typedef void (* glSecondaryColor3usProcPtr) (GLushort, GLushort, GLushort);
typedef void (* glSecondaryColor3usvProcPtr) (const GLushort *);
typedef void (* glSecondaryColorPointerProcPtr) (GLint, GLenum, GLsizei, const GLvoid *);

typedef void (* glPointParameterfProcPtr) (GLenum pname, GLfloat param); 
typedef void (* glPointParameterfvProcPtr) (GLenum pname, const GLfloat *params);

typedef void (* glBlendFuncSeparateProcPtr) (GLenum, GLenum, GLenum, GLenum);

typedef void (* glMultiDrawArraysProcPtr) (GLenum, const GLint *, const GLsizei *, GLsizei);
typedef void (* glMultiDrawElementsProcPtr) (GLenum, const GLsizei *, GLenum, const GLvoid* *, GLsizei);

typedef void (* glWindowPos2dProcPtr) (GLdouble, GLdouble);
typedef void (* glWindowPos2dvProcPtr) (const GLdouble *);
typedef void (* glWindowPos2fProcPtr) (GLfloat, GLfloat);
typedef void (* glWindowPos2fvProcPtr) (const GLfloat *);
typedef void (* glWindowPos2iProcPtr) (GLint, GLint); 
typedef void (* glWindowPos2ivProcPtr) (const GLint *);
typedef void (* glWindowPos2sProcPtr) (GLshort, GLshort);
typedef void (* glWindowPos2svProcPtr) (const GLshort *);
typedef void (* glWindowPos3dProcPtr) (GLdouble, GLdouble, GLdouble);
typedef void (* glWindowPos3dvProcPtr) (const GLdouble *);
typedef void (* glWindowPos3fProcPtr) (GLfloat, GLfloat, GLfloat);
typedef void (* glWindowPos3fvProcPtr) (const GLfloat *);
typedef void (* glWindowPos3iProcPtr) (GLint, GLint, GLint);
typedef void (* glWindowPos3ivProcPtr) (const GLint *);
typedef void (* glWindowPos3sProcPtr) (GLshort, GLshort, GLshort);
typedef void (* glWindowPos3svProcPtr) (const GLshort *);

|#
 |#

; #else /* GL_GLEXT_FUNCTION_POINTERS */

(deftrap-inline "_glAccum" 
   ((op :UInt32)
    (value :single-float)
   )
   nil
() )

(deftrap-inline "_glAlphaFunc" 
   ((func :UInt32)
    (ref :single-float)
   )
   nil
() )

(deftrap-inline "_glAreTexturesResident" 
   ((n :signed-long)
    (textures (:pointer :GLUINT))
    (residences (:pointer :GLBOOLEAN))
   )
   :UInt8
() )

(deftrap-inline "_glArrayElement" 
   ((i :signed-long)
   )
   nil
() )

(deftrap-inline "_glBegin" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glBindTexture" 
   ((target :UInt32)
    (texture :UInt32)
   )
   nil
() )

(deftrap-inline "_glBitmap" 
   ((width :signed-long)
    (height :signed-long)
    (xorig :single-float)
    (yorig :single-float)
    (xmove :single-float)
    (ymove :single-float)
    (bitmap (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glBlendColor" 
   ((red :single-float)
    (green :single-float)
    (blue :single-float)
    (alpha :single-float)
   )
   nil
() )

(deftrap-inline "_glBlendEquation" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glBlendFunc" 
   ((sfactor :UInt32)
    (dfactor :UInt32)
   )
   nil
() )

(deftrap-inline "_glCallList" 
   ((list :UInt32)
   )
   nil
() )

(deftrap-inline "_glCallLists" 
   ((n :signed-long)
    (type :UInt32)
    (lists (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glClear" 
   ((mask :UInt32)
   )
   nil
() )

(deftrap-inline "_glClearAccum" 
   ((red :single-float)
    (green :single-float)
    (blue :single-float)
    (alpha :single-float)
   )
   nil
() )

(deftrap-inline "_glClearColor" 
   ((red :single-float)
    (green :single-float)
    (blue :single-float)
    (alpha :single-float)
   )
   nil
() )

(deftrap-inline "_glClearDepth" 
   ((depth :double-float)
   )
   nil
() )

(deftrap-inline "_glClearIndex" 
   ((c :single-float)
   )
   nil
() )

(deftrap-inline "_glClearStencil" 
   ((s :signed-long)
   )
   nil
() )

(deftrap-inline "_glClipPlane" 
   ((plane :UInt32)
    (equation (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glColor3b" 
   ((red :SInt8)
    (green :SInt8)
    (blue :SInt8)
   )
   nil
() )

(deftrap-inline "_glColor3bv" 
   ((v (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glColor3d" 
   ((red :double-float)
    (green :double-float)
    (blue :double-float)
   )
   nil
() )

(deftrap-inline "_glColor3dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glColor3f" 
   ((red :single-float)
    (green :single-float)
    (blue :single-float)
   )
   nil
() )

(deftrap-inline "_glColor3fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColor3i" 
   ((red :signed-long)
    (green :signed-long)
    (blue :signed-long)
   )
   nil
() )

(deftrap-inline "_glColor3iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glColor3s" 
   ((red :SInt16)
    (green :SInt16)
    (blue :SInt16)
   )
   nil
() )

(deftrap-inline "_glColor3sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glColor3ub" 
   ((red :UInt8)
    (green :UInt8)
    (blue :UInt8)
   )
   nil
() )

(deftrap-inline "_glColor3ubv" 
   ((v (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glColor3ui" 
   ((red :UInt32)
    (green :UInt32)
    (blue :UInt32)
   )
   nil
() )

(deftrap-inline "_glColor3uiv" 
   ((v (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glColor3us" 
   ((red :UInt16)
    (green :UInt16)
    (blue :UInt16)
   )
   nil
() )

(deftrap-inline "_glColor3usv" 
   ((v (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glColor4b" 
   ((red :SInt8)
    (green :SInt8)
    (blue :SInt8)
    (alpha :SInt8)
   )
   nil
() )

(deftrap-inline "_glColor4bv" 
   ((v (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glColor4d" 
   ((red :double-float)
    (green :double-float)
    (blue :double-float)
    (alpha :double-float)
   )
   nil
() )

(deftrap-inline "_glColor4dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glColor4f" 
   ((red :single-float)
    (green :single-float)
    (blue :single-float)
    (alpha :single-float)
   )
   nil
() )

(deftrap-inline "_glColor4fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColor4i" 
   ((red :signed-long)
    (green :signed-long)
    (blue :signed-long)
    (alpha :signed-long)
   )
   nil
() )

(deftrap-inline "_glColor4iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glColor4s" 
   ((red :SInt16)
    (green :SInt16)
    (blue :SInt16)
    (alpha :SInt16)
   )
   nil
() )

(deftrap-inline "_glColor4sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glColor4ub" 
   ((red :UInt8)
    (green :UInt8)
    (blue :UInt8)
    (alpha :UInt8)
   )
   nil
() )

(deftrap-inline "_glColor4ubv" 
   ((v (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glColor4ui" 
   ((red :UInt32)
    (green :UInt32)
    (blue :UInt32)
    (alpha :UInt32)
   )
   nil
() )

(deftrap-inline "_glColor4uiv" 
   ((v (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glColor4us" 
   ((red :UInt16)
    (green :UInt16)
    (blue :UInt16)
    (alpha :UInt16)
   )
   nil
() )

(deftrap-inline "_glColor4usv" 
   ((v (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glColorMask" 
   ((red :UInt8)
    (green :UInt8)
    (blue :UInt8)
    (alpha :UInt8)
   )
   nil
() )

(deftrap-inline "_glColorMaterial" 
   ((face :UInt32)
    (mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glColorPointer" 
   ((size :signed-long)
    (type :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorSubTable" 
   ((target :UInt32)
    (start :signed-long)
    (count :signed-long)
    (format :UInt32)
    (type :UInt32)
    (data (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorTable" 
   ((target :UInt32)
    (internalformat :UInt32)
    (width :signed-long)
    (format :UInt32)
    (type :UInt32)
    (table (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorTableParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColorTableParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glConvolutionFilter1D" 
   ((target :UInt32)
    (internalformat :UInt32)
    (width :signed-long)
    (format :UInt32)
    (type :UInt32)
    (image (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glConvolutionFilter2D" 
   ((target :UInt32)
    (internalformat :UInt32)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (image (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterf" 
   ((target :UInt32)
    (pname :UInt32)
    (params :single-float)
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glConvolutionParameteri" 
   ((target :UInt32)
    (pname :UInt32)
    (params :signed-long)
   )
   nil
() )

(deftrap-inline "_glConvolutionParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glCopyColorSubTable" 
   ((target :UInt32)
    (start :signed-long)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyColorTable" 
   ((target :UInt32)
    (internalformat :UInt32)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyConvolutionFilter1D" 
   ((target :UInt32)
    (internalformat :UInt32)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyConvolutionFilter2D" 
   ((target :UInt32)
    (internalformat :UInt32)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyPixels" 
   ((x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
    (type :UInt32)
   )
   nil
() )

(deftrap-inline "_glCopyTexImage1D" 
   ((target :UInt32)
    (level :signed-long)
    (internalformat :UInt32)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (border :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexImage2D" 
   ((target :UInt32)
    (level :signed-long)
    (internalformat :UInt32)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
    (border :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage1D" 
   ((target :UInt32)
    (level :signed-long)
    (xoffset :signed-long)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage2D" 
   ((target :UInt32)
    (level :signed-long)
    (xoffset :signed-long)
    (yoffset :signed-long)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage3D" 
   ((target :UInt32)
    (level :signed-long)
    (xoffset :signed-long)
    (yoffset :signed-long)
    (zoffset :signed-long)
    (x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
   )
   nil
() )

(deftrap-inline "_glCullFace" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glDeleteLists" 
   ((list :UInt32)
    (range :signed-long)
   )
   nil
() )

(deftrap-inline "_glDeleteTextures" 
   ((n :signed-long)
    (textures (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glDepthFunc" 
   ((func :UInt32)
   )
   nil
() )

(deftrap-inline "_glDepthMask" 
   ((flag :UInt8)
   )
   nil
() )

(deftrap-inline "_glDepthRange" 
   ((zNear :double-float)
    (zFar :double-float)
   )
   nil
() )

(deftrap-inline "_glDisable" 
   ((cap :UInt32)
   )
   nil
() )

(deftrap-inline "_glDisableClientState" 
   ((array :UInt32)
   )
   nil
() )

(deftrap-inline "_glDrawArrays" 
   ((mode :UInt32)
    (first :signed-long)
    (count :signed-long)
   )
   nil
() )

(deftrap-inline "_glDrawBuffer" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glDrawElements" 
   ((mode :UInt32)
    (count :signed-long)
    (type :UInt32)
    (indices (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glDrawPixels" 
   ((width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glDrawRangeElements" 
   ((mode :UInt32)
    (start :UInt32)
    (end :UInt32)
    (count :signed-long)
    (type :UInt32)
    (indices (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glEdgeFlag" 
   ((flag :UInt8)
   )
   nil
() )

(deftrap-inline "_glEdgeFlagPointer" 
   ((stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glEdgeFlagv" 
   ((flag (:pointer :GLBOOLEAN))
   )
   nil
() )

(deftrap-inline "_glEnable" 
   ((cap :UInt32)
   )
   nil
() )

(deftrap-inline "_glEnableClientState" 
   ((array :UInt32)
   )
   nil
() )

(deftrap-inline "_glEnd" 
   (
   )
   nil
() )

(deftrap-inline "_glEndList" 
   (
   )
   nil
() )

(deftrap-inline "_glEvalCoord1d" 
   ((u :double-float)
   )
   nil
() )

(deftrap-inline "_glEvalCoord1dv" 
   ((u (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glEvalCoord1f" 
   ((u :single-float)
   )
   nil
() )

(deftrap-inline "_glEvalCoord1fv" 
   ((u (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glEvalCoord2d" 
   ((u :double-float)
    (v :double-float)
   )
   nil
() )

(deftrap-inline "_glEvalCoord2dv" 
   ((u (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glEvalCoord2f" 
   ((u :single-float)
    (v :single-float)
   )
   nil
() )

(deftrap-inline "_glEvalCoord2fv" 
   ((u (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glEvalMesh1" 
   ((mode :UInt32)
    (i1 :signed-long)
    (i2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glEvalMesh2" 
   ((mode :UInt32)
    (i1 :signed-long)
    (i2 :signed-long)
    (j1 :signed-long)
    (j2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glEvalPoint1" 
   ((i :signed-long)
   )
   nil
() )

(deftrap-inline "_glEvalPoint2" 
   ((i :signed-long)
    (j :signed-long)
   )
   nil
() )

(deftrap-inline "_glFeedbackBuffer" 
   ((size :signed-long)
    (type :UInt32)
    (buffer (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFinish" 
   (
   )
   nil
() )

(deftrap-inline "_glFlush" 
   (
   )
   nil
() )

(deftrap-inline "_glFogf" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glFogfv" 
   ((pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFogi" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glFogiv" 
   ((pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glFrontFace" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glFrustum" 
   ((left :double-float)
    (right :double-float)
    (bottom :double-float)
    (top :double-float)
    (zNear :double-float)
    (zFar :double-float)
   )
   nil
() )

(deftrap-inline "_glGenLists" 
   ((range :signed-long)
   )
   :UInt32
() )

(deftrap-inline "_glGenTextures" 
   ((n :signed-long)
    (textures (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glGetBooleanv" 
   ((pname :UInt32)
    (params (:pointer :GLBOOLEAN))
   )
   nil
() )

(deftrap-inline "_glGetClipPlane" 
   ((plane :UInt32)
    (equation (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetColorTable" 
   ((target :UInt32)
    (format :UInt32)
    (type :UInt32)
    (table (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionFilter" 
   ((target :UInt32)
    (format :UInt32)
    (type :UInt32)
    (image (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetDoublev" 
   ((pname :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetError" 
   (
   )
   :UInt32
() )

(deftrap-inline "_glGetFloatv" 
   ((pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetHistogram" 
   ((target :UInt32)
    (reset :UInt8)
    (format :UInt32)
    (type :UInt32)
    (values (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetHistogramParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetHistogramParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetIntegerv" 
   ((pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetLightfv" 
   ((light :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetLightiv" 
   ((light :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetMapdv" 
   ((target :UInt32)
    (query :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetMapfv" 
   ((target :UInt32)
    (query :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetMapiv" 
   ((target :UInt32)
    (query :UInt32)
    (v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetMaterialfv" 
   ((face :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetMaterialiv" 
   ((face :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetMinmax" 
   ((target :UInt32)
    (reset :UInt8)
    (format :UInt32)
    (type :UInt32)
    (values (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetPixelMapfv" 
   ((map :UInt32)
    (values (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetPixelMapuiv" 
   ((map :UInt32)
    (values (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glGetPixelMapusv" 
   ((map :UInt32)
    (values (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glGetPointerv" 
   ((pname :UInt32)
    (params (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetPolygonStipple" 
   ((mask (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glGetSeparableFilter" 
   ((target :UInt32)
    (format :UInt32)
    (type :UInt32)
    (row (:pointer :GLVOID))
    (column (:pointer :GLVOID))
    (span (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetString" 
   ((name :UInt32)
   )
   (:pointer :UInt8)
() )

(deftrap-inline "_glGetTexEnvfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetTexEnviv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetTexGendv" 
   ((coord :UInt32)
    (pname :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetTexGenfv" 
   ((coord :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetTexGeniv" 
   ((coord :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetTexImage" 
   ((target :UInt32)
    (level :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetTexLevelParameterfv" 
   ((target :UInt32)
    (level :signed-long)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetTexLevelParameteriv" 
   ((target :UInt32)
    (level :signed-long)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetTexParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetTexParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glHint" 
   ((target :UInt32)
    (mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glHistogram" 
   ((target :UInt32)
    (width :signed-long)
    (internalformat :UInt32)
    (sink :UInt8)
   )
   nil
() )

(deftrap-inline "_glIndexMask" 
   ((mask :UInt32)
   )
   nil
() )

(deftrap-inline "_glIndexPointer" 
   ((type :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glIndexd" 
   ((c :double-float)
   )
   nil
() )

(deftrap-inline "_glIndexdv" 
   ((c (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glIndexf" 
   ((c :single-float)
   )
   nil
() )

(deftrap-inline "_glIndexfv" 
   ((c (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glIndexi" 
   ((c :signed-long)
   )
   nil
() )

(deftrap-inline "_glIndexiv" 
   ((c (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glIndexs" 
   ((c :SInt16)
   )
   nil
() )

(deftrap-inline "_glIndexsv" 
   ((c (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glIndexub" 
   ((c :UInt8)
   )
   nil
() )

(deftrap-inline "_glIndexubv" 
   ((c (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glInitNames" 
   (
   )
   nil
() )

(deftrap-inline "_glInterleavedArrays" 
   ((format :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glIsEnabled" 
   ((cap :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glIsList" 
   ((list :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glIsTexture" 
   ((texture :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glLightModelf" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glLightModelfv" 
   ((pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glLightModeli" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glLightModeliv" 
   ((pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glLightf" 
   ((light :UInt32)
    (pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glLightfv" 
   ((light :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glLighti" 
   ((light :UInt32)
    (pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glLightiv" 
   ((light :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glLineStipple" 
   ((factor :signed-long)
    (pattern :UInt16)
   )
   nil
() )

(deftrap-inline "_glLineWidth" 
   ((width :single-float)
   )
   nil
() )

(deftrap-inline "_glListBase" 
   ((base :UInt32)
   )
   nil
() )

(deftrap-inline "_glLoadIdentity" 
   (
   )
   nil
() )

(deftrap-inline "_glLoadMatrixd" 
   ((m (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glLoadMatrixf" 
   ((m (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glLoadName" 
   ((name :UInt32)
   )
   nil
() )

(deftrap-inline "_glLogicOp" 
   ((opcode :UInt32)
   )
   nil
() )

(deftrap-inline "_glMap1d" 
   ((target :UInt32)
    (u1 :double-float)
    (u2 :double-float)
    (stride :signed-long)
    (order :signed-long)
    (points (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMap1f" 
   ((target :UInt32)
    (u1 :single-float)
    (u2 :single-float)
    (stride :signed-long)
    (order :signed-long)
    (points (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMap2d" 
   ((target :UInt32)
    (u1 :double-float)
    (u2 :double-float)
    (ustride :signed-long)
    (uorder :signed-long)
    (v1 :double-float)
    (v2 :double-float)
    (vstride :signed-long)
    (vorder :signed-long)
    (points (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMap2f" 
   ((target :UInt32)
    (u1 :single-float)
    (u2 :single-float)
    (ustride :signed-long)
    (uorder :signed-long)
    (v1 :single-float)
    (v2 :single-float)
    (vstride :signed-long)
    (vorder :signed-long)
    (points (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMapGrid1d" 
   ((un :signed-long)
    (u1 :double-float)
    (u2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMapGrid1f" 
   ((un :signed-long)
    (u1 :single-float)
    (u2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMapGrid2d" 
   ((un :signed-long)
    (u1 :double-float)
    (u2 :double-float)
    (vn :signed-long)
    (v1 :double-float)
    (v2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMapGrid2f" 
   ((un :signed-long)
    (u1 :single-float)
    (u2 :single-float)
    (vn :signed-long)
    (v1 :single-float)
    (v2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMaterialf" 
   ((face :UInt32)
    (pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glMaterialfv" 
   ((face :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMateriali" 
   ((face :UInt32)
    (pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glMaterialiv" 
   ((face :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMatrixMode" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glMinmax" 
   ((target :UInt32)
    (internalformat :UInt32)
    (sink :UInt8)
   )
   nil
() )

(deftrap-inline "_glMultMatrixd" 
   ((m (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultMatrixf" 
   ((m (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glNewList" 
   ((list :UInt32)
    (mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glNormal3b" 
   ((nx :SInt8)
    (ny :SInt8)
    (nz :SInt8)
   )
   nil
() )

(deftrap-inline "_glNormal3bv" 
   ((v (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glNormal3d" 
   ((nx :double-float)
    (ny :double-float)
    (nz :double-float)
   )
   nil
() )

(deftrap-inline "_glNormal3dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glNormal3f" 
   ((nx :single-float)
    (ny :single-float)
    (nz :single-float)
   )
   nil
() )

(deftrap-inline "_glNormal3fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glNormal3i" 
   ((nx :signed-long)
    (ny :signed-long)
    (nz :signed-long)
   )
   nil
() )

(deftrap-inline "_glNormal3iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glNormal3s" 
   ((nx :SInt16)
    (ny :SInt16)
    (nz :SInt16)
   )
   nil
() )

(deftrap-inline "_glNormal3sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glNormalPointer" 
   ((type :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glOrtho" 
   ((left :double-float)
    (right :double-float)
    (bottom :double-float)
    (top :double-float)
    (zNear :double-float)
    (zFar :double-float)
   )
   nil
() )

(deftrap-inline "_glPassThrough" 
   ((token :single-float)
   )
   nil
() )

(deftrap-inline "_glPixelMapfv" 
   ((map :UInt32)
    (mapsize :signed-long)
    (values (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glPixelMapuiv" 
   ((map :UInt32)
    (mapsize :signed-long)
    (values (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glPixelMapusv" 
   ((map :UInt32)
    (mapsize :signed-long)
    (values (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glPixelStoref" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glPixelStorei" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glPixelTransferf" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glPixelTransferi" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glPixelZoom" 
   ((xfactor :single-float)
    (yfactor :single-float)
   )
   nil
() )

(deftrap-inline "_glPointSize" 
   ((size :single-float)
   )
   nil
() )

(deftrap-inline "_glPolygonMode" 
   ((face :UInt32)
    (mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glPolygonOffset" 
   ((factor :single-float)
    (units :single-float)
   )
   nil
() )

(deftrap-inline "_glPolygonStipple" 
   ((mask (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glPopAttrib" 
   (
   )
   nil
() )

(deftrap-inline "_glPopClientAttrib" 
   (
   )
   nil
() )

(deftrap-inline "_glPopMatrix" 
   (
   )
   nil
() )

(deftrap-inline "_glPopName" 
   (
   )
   nil
() )

(deftrap-inline "_glPrioritizeTextures" 
   ((n :signed-long)
    (textures (:pointer :GLUINT))
    (priorities (:pointer :GLCLAMPF))
   )
   nil
() )

(deftrap-inline "_glPushAttrib" 
   ((mask :UInt32)
   )
   nil
() )

(deftrap-inline "_glPushClientAttrib" 
   ((mask :UInt32)
   )
   nil
() )

(deftrap-inline "_glPushMatrix" 
   (
   )
   nil
() )

(deftrap-inline "_glPushName" 
   ((name :UInt32)
   )
   nil
() )

(deftrap-inline "_glRasterPos2d" 
   ((x :double-float)
    (y :double-float)
   )
   nil
() )

(deftrap-inline "_glRasterPos2dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glRasterPos2f" 
   ((x :single-float)
    (y :single-float)
   )
   nil
() )

(deftrap-inline "_glRasterPos2fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glRasterPos2i" 
   ((x :signed-long)
    (y :signed-long)
   )
   nil
() )

(deftrap-inline "_glRasterPos2iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glRasterPos2s" 
   ((x :SInt16)
    (y :SInt16)
   )
   nil
() )

(deftrap-inline "_glRasterPos2sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glRasterPos3d" 
   ((x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glRasterPos3dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glRasterPos3f" 
   ((x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glRasterPos3fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glRasterPos3i" 
   ((x :signed-long)
    (y :signed-long)
    (z :signed-long)
   )
   nil
() )

(deftrap-inline "_glRasterPos3iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glRasterPos3s" 
   ((x :SInt16)
    (y :SInt16)
    (z :SInt16)
   )
   nil
() )

(deftrap-inline "_glRasterPos3sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glRasterPos4d" 
   ((x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glRasterPos4dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glRasterPos4f" 
   ((x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glRasterPos4fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glRasterPos4i" 
   ((x :signed-long)
    (y :signed-long)
    (z :signed-long)
    (w :signed-long)
   )
   nil
() )

(deftrap-inline "_glRasterPos4iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glRasterPos4s" 
   ((x :SInt16)
    (y :SInt16)
    (z :SInt16)
    (w :SInt16)
   )
   nil
() )

(deftrap-inline "_glRasterPos4sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glReadBuffer" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glReadPixels" 
   ((x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glRectd" 
   ((x1 :double-float)
    (y1 :double-float)
    (x2 :double-float)
    (y2 :double-float)
   )
   nil
() )

(deftrap-inline "_glRectdv" 
   ((v1 (:pointer :GLDOUBLE))
    (v2 (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glRectf" 
   ((x1 :single-float)
    (y1 :single-float)
    (x2 :single-float)
    (y2 :single-float)
   )
   nil
() )

(deftrap-inline "_glRectfv" 
   ((v1 (:pointer :GLFLOAT))
    (v2 (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glRecti" 
   ((x1 :signed-long)
    (y1 :signed-long)
    (x2 :signed-long)
    (y2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glRectiv" 
   ((v1 (:pointer :GLINT))
    (v2 (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glRects" 
   ((x1 :SInt16)
    (y1 :SInt16)
    (x2 :SInt16)
    (y2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glRectsv" 
   ((v1 (:pointer :GLSHORT))
    (v2 (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glRenderMode" 
   ((mode :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_glResetHistogram" 
   ((target :UInt32)
   )
   nil
() )

(deftrap-inline "_glResetMinmax" 
   ((target :UInt32)
   )
   nil
() )

(deftrap-inline "_glRotated" 
   ((angle :double-float)
    (x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glRotatef" 
   ((angle :single-float)
    (x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glScaled" 
   ((x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glScalef" 
   ((x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glScissor" 
   ((x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
   )
   nil
() )

(deftrap-inline "_glSelectBuffer" 
   ((size :signed-long)
    (buffer (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glSeparableFilter2D" 
   ((target :UInt32)
    (internalformat :UInt32)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (row (:pointer :GLVOID))
    (column (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glShadeModel" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glStencilFunc" 
   ((func :UInt32)
    (ref :signed-long)
    (mask :UInt32)
   )
   nil
() )

(deftrap-inline "_glStencilMask" 
   ((mask :UInt32)
   )
   nil
() )

(deftrap-inline "_glStencilOp" 
   ((fail :UInt32)
    (zfail :UInt32)
    (zpass :UInt32)
   )
   nil
() )

(deftrap-inline "_glTexCoord1d" 
   ((s :double-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord1dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glTexCoord1f" 
   ((s :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord1fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord1i" 
   ((s :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexCoord1iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexCoord1s" 
   ((s :SInt16)
   )
   nil
() )

(deftrap-inline "_glTexCoord1sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2d" 
   ((s :double-float)
    (t :double-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glTexCoord2f" 
   ((s :single-float)
    (t :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2i" 
   ((s :signed-long)
    (t :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexCoord2iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2s" 
   ((s :SInt16)
    (t :SInt16)
   )
   nil
() )

(deftrap-inline "_glTexCoord2sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glTexCoord3d" 
   ((s :double-float)
    (t :double-float)
    (r :double-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord3dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glTexCoord3f" 
   ((s :single-float)
    (t :single-float)
    (r :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord3fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord3i" 
   ((s :signed-long)
    (t :signed-long)
    (r :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexCoord3iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexCoord3s" 
   ((s :SInt16)
    (t :SInt16)
    (r :SInt16)
   )
   nil
() )

(deftrap-inline "_glTexCoord3sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glTexCoord4d" 
   ((s :double-float)
    (t :double-float)
    (r :double-float)
    (q :double-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord4dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glTexCoord4f" 
   ((s :single-float)
    (t :single-float)
    (r :single-float)
    (q :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord4fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord4i" 
   ((s :signed-long)
    (t :signed-long)
    (r :signed-long)
    (q :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexCoord4iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexCoord4s" 
   ((s :SInt16)
    (t :SInt16)
    (r :SInt16)
    (q :SInt16)
   )
   nil
() )

(deftrap-inline "_glTexCoord4sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glTexCoordPointer" 
   ((size :signed-long)
    (type :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexEnvf" 
   ((target :UInt32)
    (pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glTexEnvfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexEnvi" 
   ((target :UInt32)
    (pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexEnviv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexGend" 
   ((coord :UInt32)
    (pname :UInt32)
    (param :double-float)
   )
   nil
() )

(deftrap-inline "_glTexGendv" 
   ((coord :UInt32)
    (pname :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glTexGenf" 
   ((coord :UInt32)
    (pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glTexGenfv" 
   ((coord :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexGeni" 
   ((coord :UInt32)
    (pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexGeniv" 
   ((coord :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexImage1D" 
   ((target :UInt32)
    (level :signed-long)
    (internalformat :UInt32)
    (width :signed-long)
    (border :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexImage2D" 
   ((target :UInt32)
    (level :signed-long)
    (internalformat :UInt32)
    (width :signed-long)
    (height :signed-long)
    (border :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexImage3D" 
   ((target :UInt32)
    (level :signed-long)
    (internalformat :UInt32)
    (width :signed-long)
    (height :signed-long)
    (depth :signed-long)
    (border :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexParameterf" 
   ((target :UInt32)
    (pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glTexParameterfv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexParameteri" 
   ((target :UInt32)
    (pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexParameteriv" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTexSubImage1D" 
   ((target :UInt32)
    (level :signed-long)
    (xoffset :signed-long)
    (width :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexSubImage2D" 
   ((target :UInt32)
    (level :signed-long)
    (xoffset :signed-long)
    (yoffset :signed-long)
    (width :signed-long)
    (height :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexSubImage3D" 
   ((target :UInt32)
    (level :signed-long)
    (xoffset :signed-long)
    (yoffset :signed-long)
    (zoffset :signed-long)
    (width :signed-long)
    (height :signed-long)
    (depth :signed-long)
    (format :UInt32)
    (type :UInt32)
    (pixels (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTranslated" 
   ((x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glTranslatef" 
   ((x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glVertex2d" 
   ((x :double-float)
    (y :double-float)
   )
   nil
() )

(deftrap-inline "_glVertex2dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertex2f" 
   ((x :single-float)
    (y :single-float)
   )
   nil
() )

(deftrap-inline "_glVertex2fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertex2i" 
   ((x :signed-long)
    (y :signed-long)
   )
   nil
() )

(deftrap-inline "_glVertex2iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glVertex2s" 
   ((x :SInt16)
    (y :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertex2sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertex3d" 
   ((x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glVertex3dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertex3f" 
   ((x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glVertex3fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertex3i" 
   ((x :signed-long)
    (y :signed-long)
    (z :signed-long)
   )
   nil
() )

(deftrap-inline "_glVertex3iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glVertex3s" 
   ((x :SInt16)
    (y :SInt16)
    (z :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertex3sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertex4d" 
   ((x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glVertex4dv" 
   ((v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertex4f" 
   ((x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glVertex4fv" 
   ((v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertex4i" 
   ((x :signed-long)
    (y :signed-long)
    (z :signed-long)
    (w :signed-long)
   )
   nil
() )

(deftrap-inline "_glVertex4iv" 
   ((v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glVertex4s" 
   ((x :SInt16)
    (y :SInt16)
    (z :SInt16)
    (w :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertex4sv" 
   ((v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexPointer" 
   ((size :signed-long)
    (type :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glViewport" 
   ((x :signed-long)
    (y :signed-long)
    (width :signed-long)
    (height :signed-long)
   )
   nil
() )

(deftrap-inline "_glSampleCoverage" 
   ((ARG2 :single-float)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glSamplePass" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glLoadTransposeMatrixf" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glLoadTransposeMatrixd" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultTransposeMatrixf" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultTransposeMatrixd" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glCompressedTexImage3D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCompressedTexImage2D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCompressedTexImage1D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCompressedTexSubImage3D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCompressedTexSubImage2D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCompressedTexSubImage1D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetCompressedTexImage" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glActiveTexture" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glClientActiveTexture" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1d" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1dv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1f" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1fv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1i" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1iv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1s" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1sv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2d" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2dv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2f" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2fv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2i" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2iv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2s" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2sv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3d" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3dv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3f" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3fv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3i" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3iv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3s" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3sv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4d" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4dv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4f" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4fv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4i" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4iv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4s" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4sv" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glFogCoordf" 
   ((ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glFogCoordfv" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFogCoordd" 
   ((ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glFogCoorddv" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glFogCoordPointer" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3b" 
   ((ARG2 :SInt8)
    (ARG2 :SInt8)
    (ARG2 :SInt8)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3bv" 
   ((ARGH (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3d" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3dv" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3f" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3fv" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3i" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3iv" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3s" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3sv" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3ub" 
   ((ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3ubv" 
   ((ARGH (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3ui" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3uiv" 
   ((ARGH (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3us" 
   ((ARG2 :UInt16)
    (ARG2 :UInt16)
    (ARG2 :UInt16)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3usv" 
   ((ARGH (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColorPointer" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glPointParameterf" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glPointParameterfv" 
   ((pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glBlendFuncSeparate" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glMultiDrawArrays" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
    (ARGH (:pointer :GLSIZEI))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiDrawElements" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSIZEI))
    (ARG2 :UInt32)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glWindowPos2d" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos2dv" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glWindowPos2f" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos2fv" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glWindowPos2i" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glWindowPos2iv" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glWindowPos2s" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glWindowPos2sv" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glWindowPos3d" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos3dv" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glWindowPos3f" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos3fv" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glWindowPos3i" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glWindowPos3iv" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glWindowPos3s" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glWindowPos3sv" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __gl_h_ */


(provide-interface "gl")