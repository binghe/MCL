(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glext.h"
; at Sunday July 2,2006 7:25:34 pm.
; 
; 	Copyright:  (c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef __glext_h_
; #define __glext_h_
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
(defconstant $GL_APPLE_specular_vector 1)
; #define GL_APPLE_specular_vector            1
(defconstant $GL_APPLE_transform_hint 1)
; #define GL_APPLE_transform_hint             1
(defconstant $GL_APPLE_packed_pixels 1)
; #define GL_APPLE_packed_pixels              1
(defconstant $GL_APPLE_client_storage 1)
; #define GL_APPLE_client_storage             1
(defconstant $GL_APPLE_ycbcr_422 1)
; #define GL_APPLE_ycbcr_422                  1
(defconstant $GL_APPLE_texture_range 1)
; #define GL_APPLE_texture_range              1
(defconstant $GL_APPLE_fence 1)
; #define GL_APPLE_fence                      1
(defconstant $GL_APPLE_vertex_array_range 1)
; #define GL_APPLE_vertex_array_range         1
(defconstant $GL_APPLE_vertex_array_object 1)
; #define GL_APPLE_vertex_array_object        1
(defconstant $GL_APPLE_element_array 1)
; #define GL_APPLE_element_array              1
(defconstant $GL_APPLE_vertex_program_evaluators 1)
; #define GL_APPLE_vertex_program_evaluators  1
(defconstant $GL_APPLE_float_pixels 1)
; #define GL_APPLE_float_pixels               1
(defconstant $GL_APPLE_flush_render 1)
; #define GL_APPLE_flush_render               1
(defconstant $GL_APPLE_pixel_buffer 1)
; #define GL_APPLE_pixel_buffer               1
(defconstant $GL_ARB_imaging 1)
; #define GL_ARB_imaging                      1
(defconstant $GL_ARB_transpose_matrix 1)
; #define GL_ARB_transpose_matrix             1
(defconstant $GL_ARB_multitexture 1)
; #define GL_ARB_multitexture                 1
(defconstant $GL_ARB_texture_env_add 1)
; #define GL_ARB_texture_env_add              1
(defconstant $GL_ARB_texture_env_combine 1)
; #define GL_ARB_texture_env_combine          1
(defconstant $GL_ARB_texture_env_dot3 1)
; #define GL_ARB_texture_env_dot3             1
(defconstant $GL_ARB_texture_env_crossbar 1)
; #define GL_ARB_texture_env_crossbar         1
(defconstant $GL_ARB_texture_cube_map 1)
; #define GL_ARB_texture_cube_map             1
(defconstant $GL_ARB_texture_compression 1)
; #define GL_ARB_texture_compression          1
(defconstant $GL_ARB_multisample 1)
; #define GL_ARB_multisample                  1
(defconstant $GL_ARB_texture_border_clamp 1)
; #define GL_ARB_texture_border_clamp         1
(defconstant $GL_ARB_point_parameters 1)
; #define GL_ARB_point_parameters             1
(defconstant $GL_ARB_vertex_program 1)
; #define GL_ARB_vertex_program               1
(defconstant $GL_ARB_fragment_program 1)
; #define GL_ARB_fragment_program             1
(defconstant $GL_ARB_texture_mirrored_repeat 1)
; #define GL_ARB_texture_mirrored_repeat      1
(defconstant $GL_ARB_depth_texture 1)
; #define GL_ARB_depth_texture                1
(defconstant $GL_ARB_shadow 1)
; #define GL_ARB_shadow                       1
(defconstant $GL_ARB_shadow_ambient 1)
; #define GL_ARB_shadow_ambient               1
(defconstant $GL_ARB_vertex_blend 1)
; #define GL_ARB_vertex_blend                 1
(defconstant $GL_ARB_window_pos 1)
; #define GL_ARB_window_pos                   1
(defconstant $GL_EXT_clip_volume_hint 1)
; #define GL_EXT_clip_volume_hint             1
(defconstant $GL_EXT_rescale_normal 1)
; #define GL_EXT_rescale_normal               1
(defconstant $GL_EXT_blend_color 1)
; #define GL_EXT_blend_color                  1
(defconstant $GL_EXT_blend_minmax 1)
; #define GL_EXT_blend_minmax                 1
(defconstant $GL_EXT_blend_subtract 1)
; #define GL_EXT_blend_subtract               1
(defconstant $GL_EXT_compiled_vertex_array 1)
; #define GL_EXT_compiled_vertex_array        1
(defconstant $GL_EXT_texture_lod_bias 1)
; #define GL_EXT_texture_lod_bias             1
(defconstant $GL_EXT_texture_env_add 1)
; #define GL_EXT_texture_env_add              1
(defconstant $GL_EXT_abgr 1)
; #define GL_EXT_abgr                         1
(defconstant $GL_EXT_bgra 1)
; #define GL_EXT_bgra                         1
(defconstant $GL_EXT_texture_filter_anisotropic 1)
; #define GL_EXT_texture_filter_anisotropic   1
(defconstant $GL_EXT_paletted_texture 1)
; #define GL_EXT_paletted_texture             1
(defconstant $GL_EXT_shared_texture_palette 1)
; #define GL_EXT_shared_texture_palette       1
(defconstant $GL_EXT_secondary_color 1)
; #define GL_EXT_secondary_color              1
(defconstant $GL_EXT_separate_specular_color 1)
; #define GL_EXT_separate_specular_color      1
(defconstant $GL_EXT_texture_compression_s3tc 1)
; #define GL_EXT_texture_compression_s3tc     1
(defconstant $GL_EXT_texture_rectangle 1)
; #define GL_EXT_texture_rectangle            1
(defconstant $GL_EXT_fog_coord 1)
; #define GL_EXT_fog_coord                    1
(defconstant $GL_EXT_draw_range_elements 1)
; #define GL_EXT_draw_range_elements          1
(defconstant $GL_EXT_stencil_wrap 1)
; #define GL_EXT_stencil_wrap                 1
(defconstant $GL_EXT_blend_func_separate 1)
; #define GL_EXT_blend_func_separate          1
(defconstant $GL_EXT_multi_draw_arrays 1)
; #define GL_EXT_multi_draw_arrays            1
(defconstant $GL_EXT_shadow_funcs 1)
; #define GL_EXT_shadow_funcs                 1
(defconstant $GL_EXT_stencil_two_side 1)
; #define GL_EXT_stencil_two_side             1
(defconstant $GL_SGI_color_matrix 1)
; #define GL_SGI_color_matrix                 1
(defconstant $GL_SGIS_texture_edge_clamp 1)
; #define GL_SGIS_texture_edge_clamp          1
(defconstant $GL_SGIS_generate_mipmap 1)
; #define GL_SGIS_generate_mipmap             1
(defconstant $GL_SGIS_texture_lod 1)
; #define GL_SGIS_texture_lod                 1
(defconstant $GL_ATI_point_cull_mode 1)
; #define GL_ATI_point_cull_mode              1
(defconstant $GL_ATI_texture_mirror_once 1)
; #define GL_ATI_texture_mirror_once          1
(defconstant $GL_ATI_pn_triangles 1)
; #define GL_ATI_pn_triangles                 1
(defconstant $GL_ATIX_pn_triangles 1)
; #define GL_ATIX_pn_triangles                1
(defconstant $GL_ATI_text_fragment_shader 1)
; #define GL_ATI_text_fragment_shader         1
(defconstant $GL_ATI_blend_equation_separate 1)
; #define GL_ATI_blend_equation_separate      1
(defconstant $GL_ATI_blend_weighted_minmax 1)
; #define GL_ATI_blend_weighted_minmax        1
(defconstant $GL_ATI_texture_env_combine3 1)
; #define GL_ATI_texture_env_combine3         1
(defconstant $GL_ATI_separate_stencil 1)
; #define GL_ATI_separate_stencil             1
(defconstant $GL_ATI_array_rev_comps_in_4_bytes 1)
; #define GL_ATI_array_rev_comps_in_4_bytes   1
(defconstant $GL_NV_point_sprite 1)
; #define GL_NV_point_sprite                  1
(defconstant $GL_NV_register_combiners 1)
; #define GL_NV_register_combiners            1
(defconstant $GL_NV_register_combiners2 1)
; #define GL_NV_register_combiners2           1
(defconstant $GL_NV_blend_square 1)
; #define GL_NV_blend_square                  1
(defconstant $GL_NV_fog_distance 1)
; #define GL_NV_fog_distance                  1
(defconstant $GL_NV_multisample_filter_hint 1)
; #define GL_NV_multisample_filter_hint       1
(defconstant $GL_NV_texgen_reflection 1)
; #define GL_NV_texgen_reflection             1
(defconstant $GL_NV_texture_shader 1)
; #define GL_NV_texture_shader                1
(defconstant $GL_NV_texture_shader2 1)
; #define GL_NV_texture_shader2               1
(defconstant $GL_NV_texture_shader3 1)
; #define GL_NV_texture_shader3               1
(defconstant $GL_NV_depth_clamp 1)
; #define GL_NV_depth_clamp                   1
(defconstant $GL_NV_light_max_exponent 1)
; #define GL_NV_light_max_exponent	    1
(defconstant $GL_IBM_rasterpos_clip 1)
; #define GL_IBM_rasterpos_clip               1
; ***********************************************************
(defconstant $GL_GLEXT_VERSION 7)
; #define GL_GLEXT_VERSION 7

; #if GL_ARB_multitexture
(defconstant $GL_TEXTURE0_ARB 33984)
; #define GL_TEXTURE0_ARB                   0x84C0
(defconstant $GL_TEXTURE1_ARB 33985)
; #define GL_TEXTURE1_ARB                   0x84C1
(defconstant $GL_TEXTURE2_ARB 33986)
; #define GL_TEXTURE2_ARB                   0x84C2
(defconstant $GL_TEXTURE3_ARB 33987)
; #define GL_TEXTURE3_ARB                   0x84C3
(defconstant $GL_TEXTURE4_ARB 33988)
; #define GL_TEXTURE4_ARB                   0x84C4
(defconstant $GL_TEXTURE5_ARB 33989)
; #define GL_TEXTURE5_ARB                   0x84C5
(defconstant $GL_TEXTURE6_ARB 33990)
; #define GL_TEXTURE6_ARB                   0x84C6
(defconstant $GL_TEXTURE7_ARB 33991)
; #define GL_TEXTURE7_ARB                   0x84C7
(defconstant $GL_TEXTURE8_ARB 33992)
; #define GL_TEXTURE8_ARB                   0x84C8
(defconstant $GL_TEXTURE9_ARB 33993)
; #define GL_TEXTURE9_ARB                   0x84C9
(defconstant $GL_TEXTURE10_ARB 33994)
; #define GL_TEXTURE10_ARB                  0x84CA
(defconstant $GL_TEXTURE11_ARB 33995)
; #define GL_TEXTURE11_ARB                  0x84CB
(defconstant $GL_TEXTURE12_ARB 33996)
; #define GL_TEXTURE12_ARB                  0x84CC
(defconstant $GL_TEXTURE13_ARB 33997)
; #define GL_TEXTURE13_ARB                  0x84CD
(defconstant $GL_TEXTURE14_ARB 33998)
; #define GL_TEXTURE14_ARB                  0x84CE
(defconstant $GL_TEXTURE15_ARB 33999)
; #define GL_TEXTURE15_ARB                  0x84CF
(defconstant $GL_TEXTURE16_ARB 34000)
; #define GL_TEXTURE16_ARB                  0x84D0
(defconstant $GL_TEXTURE17_ARB 34001)
; #define GL_TEXTURE17_ARB                  0x84D1
(defconstant $GL_TEXTURE18_ARB 34002)
; #define GL_TEXTURE18_ARB                  0x84D2
(defconstant $GL_TEXTURE19_ARB 34003)
; #define GL_TEXTURE19_ARB                  0x84D3
(defconstant $GL_TEXTURE20_ARB 34004)
; #define GL_TEXTURE20_ARB                  0x84D4
(defconstant $GL_TEXTURE21_ARB 34005)
; #define GL_TEXTURE21_ARB                  0x84D5
(defconstant $GL_TEXTURE22_ARB 34006)
; #define GL_TEXTURE22_ARB                  0x84D6
(defconstant $GL_TEXTURE23_ARB 34007)
; #define GL_TEXTURE23_ARB                  0x84D7
(defconstant $GL_TEXTURE24_ARB 34008)
; #define GL_TEXTURE24_ARB                  0x84D8
(defconstant $GL_TEXTURE25_ARB 34009)
; #define GL_TEXTURE25_ARB                  0x84D9
(defconstant $GL_TEXTURE26_ARB 34010)
; #define GL_TEXTURE26_ARB                  0x84DA
(defconstant $GL_TEXTURE27_ARB 34011)
; #define GL_TEXTURE27_ARB                  0x84DB
(defconstant $GL_TEXTURE28_ARB 34012)
; #define GL_TEXTURE28_ARB                  0x84DC
(defconstant $GL_TEXTURE29_ARB 34013)
; #define GL_TEXTURE29_ARB                  0x84DD
(defconstant $GL_TEXTURE30_ARB 34014)
; #define GL_TEXTURE30_ARB                  0x84DE
(defconstant $GL_TEXTURE31_ARB 34015)
; #define GL_TEXTURE31_ARB                  0x84DF
(defconstant $GL_ACTIVE_TEXTURE_ARB 34016)
; #define GL_ACTIVE_TEXTURE_ARB             0x84E0
(defconstant $GL_CLIENT_ACTIVE_TEXTURE_ARB 34017)
; #define GL_CLIENT_ACTIVE_TEXTURE_ARB      0x84E1
(defconstant $GL_MAX_TEXTURE_UNITS_ARB 34018)
; #define GL_MAX_TEXTURE_UNITS_ARB          0x84E2

; #endif


; #if GL_ARB_transpose_matrix
(defconstant $GL_TRANSPOSE_MODELVIEW_MATRIX_ARB 34019)
; #define GL_TRANSPOSE_MODELVIEW_MATRIX_ARB 0x84E3
(defconstant $GL_TRANSPOSE_PROJECTION_MATRIX_ARB 34020)
; #define GL_TRANSPOSE_PROJECTION_MATRIX_ARB 0x84E4
(defconstant $GL_TRANSPOSE_TEXTURE_MATRIX_ARB 34021)
; #define GL_TRANSPOSE_TEXTURE_MATRIX_ARB   0x84E5
(defconstant $GL_TRANSPOSE_COLOR_MATRIX_ARB 34022)
; #define GL_TRANSPOSE_COLOR_MATRIX_ARB     0x84E6

; #endif


; #if GL_ARB_multisample
(defconstant $GL_MULTISAMPLE_ARB 32925)
; #define GL_MULTISAMPLE_ARB                0x809D
(defconstant $GL_SAMPLE_ALPHA_TO_COVERAGE_ARB 32926)
; #define GL_SAMPLE_ALPHA_TO_COVERAGE_ARB   0x809E
(defconstant $GL_SAMPLE_ALPHA_TO_ONE_ARB 32927)
; #define GL_SAMPLE_ALPHA_TO_ONE_ARB        0x809F
(defconstant $GL_SAMPLE_COVERAGE_ARB 32928)
; #define GL_SAMPLE_COVERAGE_ARB            0x80A0
(defconstant $GL_SAMPLE_BUFFERS_ARB 32936)
; #define GL_SAMPLE_BUFFERS_ARB             0x80A8
(defconstant $GL_SAMPLES_ARB 32937)
; #define GL_SAMPLES_ARB                    0x80A9
(defconstant $GL_SAMPLE_COVERAGE_VALUE_ARB 32938)
; #define GL_SAMPLE_COVERAGE_VALUE_ARB      0x80AA
(defconstant $GL_SAMPLE_COVERAGE_INVERT_ARB 32939)
; #define GL_SAMPLE_COVERAGE_INVERT_ARB     0x80AB
(defconstant $GL_MULTISAMPLE_BIT_ARB 536870912)
; #define GL_MULTISAMPLE_BIT_ARB            0x20000000

; #endif


; #if GL_ARB_texture_cube_map
(defconstant $GL_NORMAL_MAP_ARB 34065)
; #define GL_NORMAL_MAP_ARB                 0x8511
(defconstant $GL_REFLECTION_MAP_ARB 34066)
; #define GL_REFLECTION_MAP_ARB             0x8512
(defconstant $GL_TEXTURE_CUBE_MAP_ARB 34067)
; #define GL_TEXTURE_CUBE_MAP_ARB           0x8513
(defconstant $GL_TEXTURE_BINDING_CUBE_MAP_ARB 34068)
; #define GL_TEXTURE_BINDING_CUBE_MAP_ARB   0x8514
(defconstant $GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB 34069)
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB 0x8515
(defconstant $GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB 34070)
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB 0x8516
(defconstant $GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB 34071)
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB 0x8517
(defconstant $GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB 34072)
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB 0x8518
(defconstant $GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB 34073)
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB 0x8519
(defconstant $GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB 34074)
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB 0x851A
(defconstant $GL_PROXY_TEXTURE_CUBE_MAP_ARB 34075)
; #define GL_PROXY_TEXTURE_CUBE_MAP_ARB     0x851B
(defconstant $GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB 34076)
; #define GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB  0x851C

; #endif


; #if GL_ARB_texture_compression
(defconstant $GL_COMPRESSED_ALPHA_ARB 34025)
; #define GL_COMPRESSED_ALPHA_ARB           0x84E9
(defconstant $GL_COMPRESSED_LUMINANCE_ARB 34026)
; #define GL_COMPRESSED_LUMINANCE_ARB       0x84EA
(defconstant $GL_COMPRESSED_LUMINANCE_ALPHA_ARB 34027)
; #define GL_COMPRESSED_LUMINANCE_ALPHA_ARB 0x84EB
(defconstant $GL_COMPRESSED_INTENSITY_ARB 34028)
; #define GL_COMPRESSED_INTENSITY_ARB       0x84EC
(defconstant $GL_COMPRESSED_RGB_ARB 34029)
; #define GL_COMPRESSED_RGB_ARB             0x84ED
(defconstant $GL_COMPRESSED_RGBA_ARB 34030)
; #define GL_COMPRESSED_RGBA_ARB            0x84EE
(defconstant $GL_TEXTURE_COMPRESSION_HINT_ARB 34031)
; #define GL_TEXTURE_COMPRESSION_HINT_ARB   0x84EF
(defconstant $GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB 34464)
; #define GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB 0x86A0
(defconstant $GL_TEXTURE_COMPRESSED_ARB 34465)
; #define GL_TEXTURE_COMPRESSED_ARB         0x86A1
(defconstant $GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB 34466)
; #define GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB 0x86A2
(defconstant $GL_COMPRESSED_TEXTURE_FORMATS_ARB 34467)
; #define GL_COMPRESSED_TEXTURE_FORMATS_ARB 0x86A3

; #endif


; #if GL_ARB_vertex_blend
(defconstant $GL_MAX_VERTEX_UNITS_ARB 34468)
; #define GL_MAX_VERTEX_UNITS_ARB           0x86A4
(defconstant $GL_ACTIVE_VERTEX_UNITS_ARB 34469)
; #define GL_ACTIVE_VERTEX_UNITS_ARB        0x86A5
(defconstant $GL_WEIGHT_SUM_UNITY_ARB 34470)
; #define GL_WEIGHT_SUM_UNITY_ARB           0x86A6
(defconstant $GL_VERTEX_BLEND_ARB 34471)
; #define GL_VERTEX_BLEND_ARB               0x86A7
(defconstant $GL_CURRENT_WEIGHT_ARB 34472)
; #define GL_CURRENT_WEIGHT_ARB             0x86A8
(defconstant $GL_WEIGHT_ARRAY_TYPE_ARB 34473)
; #define GL_WEIGHT_ARRAY_TYPE_ARB          0x86A9
(defconstant $GL_WEIGHT_ARRAY_STRIDE_ARB 34474)
; #define GL_WEIGHT_ARRAY_STRIDE_ARB        0x86AA
(defconstant $GL_WEIGHT_ARRAY_SIZE_ARB 34475)
; #define GL_WEIGHT_ARRAY_SIZE_ARB          0x86AB
(defconstant $GL_WEIGHT_ARRAY_POINTER_ARB 34476)
; #define GL_WEIGHT_ARRAY_POINTER_ARB       0x86AC
(defconstant $GL_WEIGHT_ARRAY_ARB 34477)
; #define GL_WEIGHT_ARRAY_ARB               0x86AD
(defconstant $GL_MODELVIEW0_ARB 5888)
; #define GL_MODELVIEW0_ARB                 0x1700
(defconstant $GL_MODELVIEW1_ARB 34058)
; #define GL_MODELVIEW1_ARB                 0x850A
(defconstant $GL_MODELVIEW2_ARB 34594)
; #define GL_MODELVIEW2_ARB                 0x8722
(defconstant $GL_MODELVIEW3_ARB 34595)
; #define GL_MODELVIEW3_ARB                 0x8723
(defconstant $GL_MODELVIEW4_ARB 34596)
; #define GL_MODELVIEW4_ARB                 0x8724
(defconstant $GL_MODELVIEW5_ARB 34597)
; #define GL_MODELVIEW5_ARB                 0x8725
(defconstant $GL_MODELVIEW6_ARB 34598)
; #define GL_MODELVIEW6_ARB                 0x8726
(defconstant $GL_MODELVIEW7_ARB 34599)
; #define GL_MODELVIEW7_ARB                 0x8727
(defconstant $GL_MODELVIEW8_ARB 34600)
; #define GL_MODELVIEW8_ARB                 0x8728
(defconstant $GL_MODELVIEW9_ARB 34601)
; #define GL_MODELVIEW9_ARB                 0x8729
(defconstant $GL_MODELVIEW10_ARB 34602)
; #define GL_MODELVIEW10_ARB                0x872A
(defconstant $GL_MODELVIEW11_ARB 34603)
; #define GL_MODELVIEW11_ARB                0x872B
(defconstant $GL_MODELVIEW12_ARB 34604)
; #define GL_MODELVIEW12_ARB                0x872C
(defconstant $GL_MODELVIEW13_ARB 34605)
; #define GL_MODELVIEW13_ARB                0x872D
(defconstant $GL_MODELVIEW14_ARB 34606)
; #define GL_MODELVIEW14_ARB                0x872E
(defconstant $GL_MODELVIEW15_ARB 34607)
; #define GL_MODELVIEW15_ARB                0x872F
(defconstant $GL_MODELVIEW16_ARB 34608)
; #define GL_MODELVIEW16_ARB                0x8730
(defconstant $GL_MODELVIEW17_ARB 34609)
; #define GL_MODELVIEW17_ARB                0x8731
(defconstant $GL_MODELVIEW18_ARB 34610)
; #define GL_MODELVIEW18_ARB                0x8732
(defconstant $GL_MODELVIEW19_ARB 34611)
; #define GL_MODELVIEW19_ARB                0x8733
(defconstant $GL_MODELVIEW20_ARB 34612)
; #define GL_MODELVIEW20_ARB                0x8734
(defconstant $GL_MODELVIEW21_ARB 34613)
; #define GL_MODELVIEW21_ARB                0x8735
(defconstant $GL_MODELVIEW22_ARB 34614)
; #define GL_MODELVIEW22_ARB                0x8736
(defconstant $GL_MODELVIEW23_ARB 34615)
; #define GL_MODELVIEW23_ARB                0x8737
(defconstant $GL_MODELVIEW24_ARB 34616)
; #define GL_MODELVIEW24_ARB                0x8738
(defconstant $GL_MODELVIEW25_ARB 34617)
; #define GL_MODELVIEW25_ARB                0x8739
(defconstant $GL_MODELVIEW26_ARB 34618)
; #define GL_MODELVIEW26_ARB                0x873A
(defconstant $GL_MODELVIEW27_ARB 34619)
; #define GL_MODELVIEW27_ARB                0x873B
(defconstant $GL_MODELVIEW28_ARB 34620)
; #define GL_MODELVIEW28_ARB                0x873C
(defconstant $GL_MODELVIEW29_ARB 34621)
; #define GL_MODELVIEW29_ARB                0x873D
(defconstant $GL_MODELVIEW30_ARB 34622)
; #define GL_MODELVIEW30_ARB                0x873E
(defconstant $GL_MODELVIEW31_ARB 34623)
; #define GL_MODELVIEW31_ARB                0x873F

; #endif


; #if GL_ARB_texture_border_clamp
(defconstant $GL_CLAMP_TO_BORDER_ARB 33069)
; #define GL_CLAMP_TO_BORDER_ARB           0x812D

; #endif


; #if GL_ARB_depth_texture
(defconstant $GL_DEPTH_COMPONENT16_ARB 33189)
; #define GL_DEPTH_COMPONENT16_ARB          0x81A5
(defconstant $GL_DEPTH_COMPONENT24_ARB 33190)
; #define GL_DEPTH_COMPONENT24_ARB          0x81A6
(defconstant $GL_DEPTH_COMPONENT32_ARB 33191)
; #define GL_DEPTH_COMPONENT32_ARB          0x81A7
(defconstant $GL_TEXTURE_DEPTH_SIZE_ARB 34890)
; #define GL_TEXTURE_DEPTH_SIZE_ARB         0x884A
(defconstant $GL_DEPTH_TEXTURE_MODE_ARB 34891)
; #define GL_DEPTH_TEXTURE_MODE_ARB         0x884B

; #endif


; #if GL_ARB_shadow
(defconstant $GL_TEXTURE_COMPARE_MODE_ARB 34892)
; #define GL_TEXTURE_COMPARE_MODE_ARB       0x884C
(defconstant $GL_TEXTURE_COMPARE_FUNC_ARB 34893)
; #define GL_TEXTURE_COMPARE_FUNC_ARB       0x884D
(defconstant $GL_COMPARE_R_TO_TEXTURE_ARB 34894)
; #define GL_COMPARE_R_TO_TEXTURE_ARB       0x884E

; #endif


; #if GL_ARB_shadow_ambient
(defconstant $GL_TEXTURE_COMPARE_FAIL_VALUE_ARB 32959)
; #define GL_TEXTURE_COMPARE_FAIL_VALUE_ARB 0x80BF

; #endif


; #if GL_EXT_abgr
(defconstant $GL_ABGR_EXT 32768)
; #define GL_ABGR_EXT                       0x8000

; #endif


; #if GL_EXT_blend_color
(defconstant $GL_CONSTANT_COLOR_EXT 32769)
; #define GL_CONSTANT_COLOR_EXT             0x8001
(defconstant $GL_ONE_MINUS_CONSTANT_COLOR_EXT 32770)
; #define GL_ONE_MINUS_CONSTANT_COLOR_EXT   0x8002
(defconstant $GL_CONSTANT_ALPHA_EXT 32771)
; #define GL_CONSTANT_ALPHA_EXT             0x8003
(defconstant $GL_ONE_MINUS_CONSTANT_ALPHA_EXT 32772)
; #define GL_ONE_MINUS_CONSTANT_ALPHA_EXT   0x8004
(defconstant $GL_BLEND_COLOR_EXT 32773)
; #define GL_BLEND_COLOR_EXT                0x8005

; #endif


; #if GL_EXT_polygon_offset
(defconstant $GL_POLYGON_OFFSET_EXT 32823)
; #define GL_POLYGON_OFFSET_EXT             0x8037
(defconstant $GL_POLYGON_OFFSET_FACTOR_EXT 32824)
; #define GL_POLYGON_OFFSET_FACTOR_EXT      0x8038
(defconstant $GL_POLYGON_OFFSET_BIAS_EXT 32825)
; #define GL_POLYGON_OFFSET_BIAS_EXT        0x8039

; #endif


; #if GL_EXT_texture
#| 
; #define GL_ALPHA4_EXT                     0x803B
; #define GL_ALPHA8_EXT                     0x803C
; #define GL_ALPHA12_EXT                    0x803D
; #define GL_ALPHA16_EXT                    0x803E
; #define GL_LUMINANCE4_EXT                 0x803F
; #define GL_LUMINANCE8_EXT                 0x8040
; #define GL_LUMINANCE12_EXT                0x8041
; #define GL_LUMINANCE16_EXT                0x8042
; #define GL_LUMINANCE4_ALPHA4_EXT          0x8043
; #define GL_LUMINANCE6_ALPHA2_EXT          0x8044
; #define GL_LUMINANCE8_ALPHA8_EXT          0x8045
; #define GL_LUMINANCE12_ALPHA4_EXT         0x8046
; #define GL_LUMINANCE12_ALPHA12_EXT        0x8047
; #define GL_LUMINANCE16_ALPHA16_EXT        0x8048
; #define GL_INTENSITY_EXT                  0x8049
; #define GL_INTENSITY4_EXT                 0x804A
; #define GL_INTENSITY8_EXT                 0x804B
; #define GL_INTENSITY12_EXT                0x804C
; #define GL_INTENSITY16_EXT                0x804D
; #define GL_RGB2_EXT                       0x804E
; #define GL_RGB4_EXT                       0x804F
; #define GL_RGB5_EXT                       0x8050
; #define GL_RGB8_EXT                       0x8051
; #define GL_RGB10_EXT                      0x8052
; #define GL_RGB12_EXT                      0x8053
; #define GL_RGB16_EXT                      0x8054
; #define GL_RGBA2_EXT                      0x8055
; #define GL_RGBA4_EXT                      0x8056
; #define GL_RGB5_A1_EXT                    0x8057
; #define GL_RGBA8_EXT                      0x8058
; #define GL_RGB10_A2_EXT                   0x8059
; #define GL_RGBA12_EXT                     0x805A
; #define GL_RGBA16_EXT                     0x805B
; #define GL_TEXTURE_RED_SIZE_EXT           0x805C
; #define GL_TEXTURE_GREEN_SIZE_EXT         0x805D
; #define GL_TEXTURE_BLUE_SIZE_EXT          0x805E
; #define GL_TEXTURE_ALPHA_SIZE_EXT         0x805F
; #define GL_TEXTURE_LUMINANCE_SIZE_EXT     0x8060
; #define GL_TEXTURE_INTENSITY_SIZE_EXT     0x8061
; #define GL_REPLACE_EXT                    0x8062
; #define GL_PROXY_TEXTURE_1D_EXT           0x8063
; #define GL_PROXY_TEXTURE_2D_EXT           0x8064
; #define GL_TEXTURE_TOO_LARGE_EXT          0x8065
 |#

; #endif


; #if GL_EXT_texture3D
#| 
; #define GL_PACK_SKIP_IMAGES_EXT           0x806B
; #define GL_PACK_IMAGE_HEIGHT_EXT          0x806C
; #define GL_UNPACK_SKIP_IMAGES_EXT         0x806D
; #define GL_UNPACK_IMAGE_HEIGHT_EXT        0x806E
; #define GL_TEXTURE_3D_EXT                 0x806F
; #define GL_PROXY_TEXTURE_3D_EXT           0x8070
; #define GL_TEXTURE_DEPTH_EXT              0x8071
; #define GL_TEXTURE_WRAP_R_EXT             0x8072
; #define GL_MAX_3D_TEXTURE_SIZE_EXT        0x8073
 |#

; #endif


; #if GL_SGIS_texture_filter4
#| 
; #define GL_FILTER4_SGIS                   0x8146
; #define GL_TEXTURE_FILTER4_SIZE_SGIS      0x8147
 |#

; #endif


; #if GL_EXT_histogram
#| 
; #define GL_HISTOGRAM_EXT                  0x8024
; #define GL_PROXY_HISTOGRAM_EXT            0x8025
; #define GL_HISTOGRAM_WIDTH_EXT            0x8026
; #define GL_HISTOGRAM_FORMAT_EXT           0x8027
; #define GL_HISTOGRAM_RED_SIZE_EXT         0x8028
; #define GL_HISTOGRAM_GREEN_SIZE_EXT       0x8029
; #define GL_HISTOGRAM_BLUE_SIZE_EXT        0x802A
; #define GL_HISTOGRAM_ALPHA_SIZE_EXT       0x802B
; #define GL_HISTOGRAM_LUMINANCE_SIZE_EXT   0x802C
; #define GL_HISTOGRAM_SINK_EXT             0x802D
; #define GL_MINMAX_EXT                     0x802E
; #define GL_MINMAX_FORMAT_EXT              0x802F
; #define GL_MINMAX_SINK_EXT                0x8030
; #define GL_TABLE_TOO_LARGE_EXT            0x8031
 |#

; #endif


; #if GL_EXT_convolution
#| 
; #define GL_CONVOLUTION_1D_EXT             0x8010
; #define GL_CONVOLUTION_2D_EXT             0x8011
; #define GL_SEPARABLE_2D_EXT               0x8012
; #define GL_CONVOLUTION_BORDER_MODE_EXT    0x8013
; #define GL_CONVOLUTION_FILTER_SCALE_EXT   0x8014
; #define GL_CONVOLUTION_FILTER_BIAS_EXT    0x8015
; #define GL_REDUCE_EXT                     0x8016
; #define GL_CONVOLUTION_FORMAT_EXT         0x8017
; #define GL_CONVOLUTION_WIDTH_EXT          0x8018
; #define GL_CONVOLUTION_HEIGHT_EXT         0x8019
; #define GL_MAX_CONVOLUTION_WIDTH_EXT      0x801A
; #define GL_MAX_CONVOLUTION_HEIGHT_EXT     0x801B
; #define GL_POST_CONVOLUTION_RED_SCALE_EXT 0x801C
; #define GL_POST_CONVOLUTION_GREEN_SCALE_EXT 0x801D
; #define GL_POST_CONVOLUTION_BLUE_SCALE_EXT 0x801E
; #define GL_POST_CONVOLUTION_ALPHA_SCALE_EXT 0x801F
; #define GL_POST_CONVOLUTION_RED_BIAS_EXT  0x8020
; #define GL_POST_CONVOLUTION_GREEN_BIAS_EXT 0x8021
; #define GL_POST_CONVOLUTION_BLUE_BIAS_EXT 0x8022
; #define GL_POST_CONVOLUTION_ALPHA_BIAS_EXT 0x8023
 |#

; #endif


; #if GL_SGI_color_matrix
(defconstant $GL_COLOR_MATRIX_SGI 32945)
; #define GL_COLOR_MATRIX_SGI               0x80B1
(defconstant $GL_COLOR_MATRIX_STACK_DEPTH_SGI 32946)
; #define GL_COLOR_MATRIX_STACK_DEPTH_SGI   0x80B2
(defconstant $GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI 32947)
; #define GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI 0x80B3
(defconstant $GL_POST_COLOR_MATRIX_RED_SCALE_SGI 32948)
; #define GL_POST_COLOR_MATRIX_RED_SCALE_SGI 0x80B4
(defconstant $GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI 32949)
; #define GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI 0x80B5
(defconstant $GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI 32950)
; #define GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI 0x80B6
(defconstant $GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI 32951)
; #define GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI 0x80B7
(defconstant $GL_POST_COLOR_MATRIX_RED_BIAS_SGI 32952)
; #define GL_POST_COLOR_MATRIX_RED_BIAS_SGI 0x80B8
(defconstant $GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI 32953)
; #define GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI 0x80B9
(defconstant $GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI 32954)
; #define GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI 0x80BA
(defconstant $GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI 32955)
; #define GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI 0x80BB

; #endif


; #if GL_SGI_color_table
#| 
; #define GL_COLOR_TABLE_SGI                0x80D0
; #define GL_POST_CONVOLUTION_COLOR_TABLE_SGI 0x80D1
; #define GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI 0x80D2
; #define GL_PROXY_COLOR_TABLE_SGI          0x80D3
; #define GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI 0x80D4
; #define GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI 0x80D5
; #define GL_COLOR_TABLE_SCALE_SGI          0x80D6
; #define GL_COLOR_TABLE_BIAS_SGI           0x80D7
; #define GL_COLOR_TABLE_FORMAT_SGI         0x80D8
; #define GL_COLOR_TABLE_WIDTH_SGI          0x80D9
; #define GL_COLOR_TABLE_RED_SIZE_SGI       0x80DA
; #define GL_COLOR_TABLE_GREEN_SIZE_SGI     0x80DB
; #define GL_COLOR_TABLE_BLUE_SIZE_SGI      0x80DC
; #define GL_COLOR_TABLE_ALPHA_SIZE_SGI     0x80DD
; #define GL_COLOR_TABLE_LUMINANCE_SIZE_SGI 0x80DE
; #define GL_COLOR_TABLE_INTENSITY_SIZE_SGI 0x80DF
 |#

; #endif


; #if GL_SGIS_pixel_texture
#| 
; #define GL_PIXEL_TEXTURE_SGIS             0x8353
; #define GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS 0x8354
; #define GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS 0x8355
; #define GL_PIXEL_GROUP_COLOR_SGIS         0x8356
 |#

; #endif


; #if GL_SGIX_pixel_texture
#| 
; #define GL_PIXEL_TEX_GEN_SGIX             0x8139
; #define GL_PIXEL_TEX_GEN_MODE_SGIX        0x832B
 |#

; #endif


; #if GL_SGIS_texture4D
#| 
; #define GL_PACK_SKIP_VOLUMES_SGIS         0x8130
; #define GL_PACK_IMAGE_DEPTH_SGIS          0x8131
; #define GL_UNPACK_SKIP_VOLUMES_SGIS       0x8132
; #define GL_UNPACK_IMAGE_DEPTH_SGIS        0x8133
; #define GL_TEXTURE_4D_SGIS                0x8134
; #define GL_PROXY_TEXTURE_4D_SGIS          0x8135
; #define GL_TEXTURE_4DSIZE_SGIS            0x8136
; #define GL_TEXTURE_WRAP_Q_SGIS            0x8137
; #define GL_MAX_4D_TEXTURE_SIZE_SGIS       0x8138
; #define GL_TEXTURE_4D_BINDING_SGIS        0x814F
 |#

; #endif


; #if GL_SGI_texture_color_table
#| 
; #define GL_TEXTURE_COLOR_TABLE_SGI        0x80BC
; #define GL_PROXY_TEXTURE_COLOR_TABLE_SGI  0x80BD
 |#

; #endif


; #if GL_EXT_cmyka
#| 
; #define GL_CMYK_EXT                       0x800C
; #define GL_CMYKA_EXT                      0x800D
; #define GL_PACK_CMYK_HINT_EXT             0x800E
; #define GL_UNPACK_CMYK_HINT_EXT           0x800F
 |#

; #endif


; #if GL_EXT_texture_object
#| 
; #define GL_TEXTURE_PRIORITY_EXT           0x8066
; #define GL_TEXTURE_RESIDENT_EXT           0x8067
; #define GL_TEXTURE_1D_BINDING_EXT         0x8068
; #define GL_TEXTURE_2D_BINDING_EXT         0x8069
; #define GL_TEXTURE_3D_BINDING_EXT         0x806A
 |#

; #endif


; #if GL_SGIS_detail_texture
#| 
; #define GL_DETAIL_TEXTURE_2D_SGIS         0x8095
; #define GL_DETAIL_TEXTURE_2D_BINDING_SGIS 0x8096
; #define GL_LINEAR_DETAIL_SGIS             0x8097
; #define GL_LINEAR_DETAIL_ALPHA_SGIS       0x8098
; #define GL_LINEAR_DETAIL_COLOR_SGIS       0x8099
; #define GL_DETAIL_TEXTURE_LEVEL_SGIS      0x809A
; #define GL_DETAIL_TEXTURE_MODE_SGIS       0x809B
; #define GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS 0x809C
 |#

; #endif


; #if GL_SGIS_sharpen_texture
#| 
; #define GL_LINEAR_SHARPEN_SGIS            0x80AD
; #define GL_LINEAR_SHARPEN_ALPHA_SGIS      0x80AE
; #define GL_LINEAR_SHARPEN_COLOR_SGIS      0x80AF
; #define GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS 0x80B0
 |#

; #endif


; #if GL_EXT_packed_pixels
#| 
; #define GL_UNSIGNED_BYTE_3_3_2_EXT        0x8032
; #define GL_UNSIGNED_SHORT_4_4_4_4_EXT     0x8033
; #define GL_UNSIGNED_SHORT_5_5_5_1_EXT     0x8034
; #define GL_UNSIGNED_INT_8_8_8_8_EXT       0x8035
; #define GL_UNSIGNED_INT_10_10_10_2_EXT    0x8036
 |#

; #endif


; #if GL_SGIS_texture_lod
(defconstant $GL_TEXTURE_MIN_LOD_SGIS 33082)
; #define GL_TEXTURE_MIN_LOD_SGIS           0x813A
(defconstant $GL_TEXTURE_MAX_LOD_SGIS 33083)
; #define GL_TEXTURE_MAX_LOD_SGIS           0x813B
(defconstant $GL_TEXTURE_BASE_LEVEL_SGIS 33084)
; #define GL_TEXTURE_BASE_LEVEL_SGIS        0x813C
(defconstant $GL_TEXTURE_MAX_LEVEL_SGIS 33085)
; #define GL_TEXTURE_MAX_LEVEL_SGIS         0x813D

; #endif


; #if GL_SGIS_multisample
#| 
; #define GL_MULTISAMPLE_SGIS               0x809D
; #define GL_SAMPLE_ALPHA_TO_MASK_SGIS      0x809E
; #define GL_SAMPLE_ALPHA_TO_ONE_SGIS       0x809F
; #define GL_SAMPLE_MASK_SGIS               0x80A0
; #define GL_1PASS_SGIS                     0x80A1
; #define GL_2PASS_0_SGIS                   0x80A2
; #define GL_2PASS_1_SGIS                   0x80A3
; #define GL_4PASS_0_SGIS                   0x80A4
; #define GL_4PASS_1_SGIS                   0x80A5
; #define GL_4PASS_2_SGIS                   0x80A6
; #define GL_4PASS_3_SGIS                   0x80A7
; #define GL_SAMPLE_BUFFERS_SGIS            0x80A8
; #define GL_SAMPLES_SGIS                   0x80A9
; #define GL_SAMPLE_MASK_VALUE_SGIS         0x80AA
; #define GL_SAMPLE_MASK_INVERT_SGIS        0x80AB
; #define GL_SAMPLE_PATTERN_SGIS            0x80AC
 |#

; #endif


; #if GL_EXT_rescale_normal
(defconstant $GL_RESCALE_NORMAL_EXT 32826)
; #define GL_RESCALE_NORMAL_EXT             0x803A

; #endif


; #if GL_EXT_vertex_array
#| 
; #define GL_VERTEX_ARRAY_EXT               0x8074
; #define GL_NORMAL_ARRAY_EXT               0x8075
; #define GL_COLOR_ARRAY_EXT                0x8076
; #define GL_INDEX_ARRAY_EXT                0x8077
; #define GL_TEXTURE_COORD_ARRAY_EXT        0x8078
; #define GL_EDGE_FLAG_ARRAY_EXT            0x8079
; #define GL_VERTEX_ARRAY_SIZE_EXT          0x807A
; #define GL_VERTEX_ARRAY_TYPE_EXT          0x807B
; #define GL_VERTEX_ARRAY_STRIDE_EXT        0x807C
; #define GL_VERTEX_ARRAY_COUNT_EXT         0x807D
; #define GL_NORMAL_ARRAY_TYPE_EXT          0x807E
; #define GL_NORMAL_ARRAY_STRIDE_EXT        0x807F
; #define GL_NORMAL_ARRAY_COUNT_EXT         0x8080
; #define GL_COLOR_ARRAY_SIZE_EXT           0x8081
; #define GL_COLOR_ARRAY_TYPE_EXT           0x8082
; #define GL_COLOR_ARRAY_STRIDE_EXT         0x8083
; #define GL_COLOR_ARRAY_COUNT_EXT          0x8084
; #define GL_INDEX_ARRAY_TYPE_EXT           0x8085
; #define GL_INDEX_ARRAY_STRIDE_EXT         0x8086
; #define GL_INDEX_ARRAY_COUNT_EXT          0x8087
; #define GL_TEXTURE_COORD_ARRAY_SIZE_EXT   0x8088
; #define GL_TEXTURE_COORD_ARRAY_TYPE_EXT   0x8089
; #define GL_TEXTURE_COORD_ARRAY_STRIDE_EXT 0x808A
; #define GL_TEXTURE_COORD_ARRAY_COUNT_EXT  0x808B
; #define GL_EDGE_FLAG_ARRAY_STRIDE_EXT     0x808C
; #define GL_EDGE_FLAG_ARRAY_COUNT_EXT      0x808D
; #define GL_VERTEX_ARRAY_POINTER_EXT       0x808E
; #define GL_NORMAL_ARRAY_POINTER_EXT       0x808F
; #define GL_COLOR_ARRAY_POINTER_EXT        0x8090
; #define GL_INDEX_ARRAY_POINTER_EXT        0x8091
; #define GL_TEXTURE_COORD_ARRAY_POINTER_EXT 0x8092
; #define GL_EDGE_FLAG_ARRAY_POINTER_EXT    0x8093
 |#

; #endif


; #if GL_SGIS_generate_mipmap
(defconstant $GL_GENERATE_MIPMAP_SGIS 33169)
; #define GL_GENERATE_MIPMAP_SGIS           0x8191
(defconstant $GL_GENERATE_MIPMAP_HINT_SGIS 33170)
; #define GL_GENERATE_MIPMAP_HINT_SGIS      0x8192

; #endif


; #if GL_SGIX_clipmap
#| 
; #define GL_LINEAR_CLIPMAP_LINEAR_SGIX     0x8170
; #define GL_TEXTURE_CLIPMAP_CENTER_SGIX    0x8171
; #define GL_TEXTURE_CLIPMAP_FRAME_SGIX     0x8172
; #define GL_TEXTURE_CLIPMAP_OFFSET_SGIX    0x8173
; #define GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX 0x8174
; #define GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX 0x8175
; #define GL_TEXTURE_CLIPMAP_DEPTH_SGIX     0x8176
; #define GL_MAX_CLIPMAP_DEPTH_SGIX         0x8177
; #define GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX 0x8178
; #define GL_NEAREST_CLIPMAP_NEAREST_SGIX   0x844D
; #define GL_NEAREST_CLIPMAP_LINEAR_SGIX    0x844E
; #define GL_LINEAR_CLIPMAP_NEAREST_SGIX    0x844F
 |#

; #endif


; #if GL_SGIX_shadow
#| 
; #define GL_TEXTURE_COMPARE_SGIX           0x819A
; #define GL_TEXTURE_COMPARE_OPERATOR_SGIX  0x819B
; #define GL_TEXTURE_LEQUAL_R_SGIX          0x819C
; #define GL_TEXTURE_GEQUAL_R_SGIX          0x819D
 |#

; #endif


; #if GL_SGIS_texture_edge_clamp
(defconstant $GL_CLAMP_TO_EDGE_SGIS 33071)
; #define GL_CLAMP_TO_EDGE_SGIS             0x812F

; #endif


; #if GL_SGIS_texture_border_clamp
#| 
; #define GL_CLAMP_TO_BORDER_SGIS           0x812D
 |#

; #endif


; #if GL_EXT_blend_minmax
(defconstant $GL_FUNC_ADD_EXT 32774)
; #define GL_FUNC_ADD_EXT                   0x8006
(defconstant $GL_MIN_EXT 32775)
; #define GL_MIN_EXT                        0x8007
(defconstant $GL_MAX_EXT 32776)
; #define GL_MAX_EXT                        0x8008
(defconstant $GL_BLEND_EQUATION_EXT 32777)
; #define GL_BLEND_EQUATION_EXT             0x8009

; #endif


; #if GL_ATI_blend_weighted_minmax
(defconstant $GL_MIN_WEIGHTED_ATI 34685)
; #define GL_MIN_WEIGHTED_ATI               0x877D
(defconstant $GL_MAX_WEIGHTED_ATI 34686)
; #define GL_MAX_WEIGHTED_ATI               0x877E

; #endif


; #if GL_ATI_texture_env_combine3
(defconstant $GL_MODULATE_ADD_ATI 34628)
; #define GL_MODULATE_ADD_ATI               0x8744
(defconstant $GL_MODULATE_SIGNED_ADD_ATI 34629)
; #define GL_MODULATE_SIGNED_ADD_ATI        0x8745
(defconstant $GL_MODULATE_SUBTRACT_ATI 34630)
; #define GL_MODULATE_SUBTRACT_ATI          0x8746

; #endif


; #if GL_ATI_separate_stencil
(defconstant $GL_STENCIL_BACK_FUNC_ATI 34816)
; #define GL_STENCIL_BACK_FUNC_ATI            0x8800                
(defconstant $GL_STENCIL_BACK_FAIL_ATI 34817)
; #define GL_STENCIL_BACK_FAIL_ATI            0x8801                
(defconstant $GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI 34818)
; #define GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI 0x8802                
(defconstant $GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI 34819)
; #define GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI 0x8803                

; #endif


; #if GL_ATI_array_rev_comps_in_4_bytes
(defconstant $GL_ARRAY_REV_COMPS_IN_4_BYTES_ATI 35196)
; #define GL_ARRAY_REV_COMPS_IN_4_BYTES_ATI 0x897C

; #endif


; #if GL_EXT_blend_subtract
(defconstant $GL_FUNC_SUBTRACT_EXT 32778)
; #define GL_FUNC_SUBTRACT_EXT              0x800A
(defconstant $GL_FUNC_REVERSE_SUBTRACT_EXT 32779)
; #define GL_FUNC_REVERSE_SUBTRACT_EXT      0x800B

; #endif


; #if GL_SGIX_interlace
#| 
; #define GL_INTERLACE_SGIX                 0x8094
 |#

; #endif


; #if GL_SGIX_pixel_tiles
#| 
; #define GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX 0x813E
; #define GL_PIXEL_TILE_CACHE_INCREMENT_SGIX 0x813F
; #define GL_PIXEL_TILE_WIDTH_SGIX          0x8140
; #define GL_PIXEL_TILE_HEIGHT_SGIX         0x8141
; #define GL_PIXEL_TILE_GRID_WIDTH_SGIX     0x8142
; #define GL_PIXEL_TILE_GRID_HEIGHT_SGIX    0x8143
; #define GL_PIXEL_TILE_GRID_DEPTH_SGIX     0x8144
; #define GL_PIXEL_TILE_CACHE_SIZE_SGIX     0x8145
 |#

; #endif


; #if GL_SGIS_texture_select
#| 
; #define GL_DUAL_ALPHA4_SGIS               0x8110
; #define GL_DUAL_ALPHA8_SGIS               0x8111
; #define GL_DUAL_ALPHA12_SGIS              0x8112
; #define GL_DUAL_ALPHA16_SGIS              0x8113
; #define GL_DUAL_LUMINANCE4_SGIS           0x8114
; #define GL_DUAL_LUMINANCE8_SGIS           0x8115
; #define GL_DUAL_LUMINANCE12_SGIS          0x8116
; #define GL_DUAL_LUMINANCE16_SGIS          0x8117
; #define GL_DUAL_INTENSITY4_SGIS           0x8118
; #define GL_DUAL_INTENSITY8_SGIS           0x8119
; #define GL_DUAL_INTENSITY12_SGIS          0x811A
; #define GL_DUAL_INTENSITY16_SGIS          0x811B
; #define GL_DUAL_LUMINANCE_ALPHA4_SGIS     0x811C
; #define GL_DUAL_LUMINANCE_ALPHA8_SGIS     0x811D
; #define GL_QUAD_ALPHA4_SGIS               0x811E
; #define GL_QUAD_ALPHA8_SGIS               0x811F
; #define GL_QUAD_LUMINANCE4_SGIS           0x8120
; #define GL_QUAD_LUMINANCE8_SGIS           0x8121
; #define GL_QUAD_INTENSITY4_SGIS           0x8122
; #define GL_QUAD_INTENSITY8_SGIS           0x8123
; #define GL_DUAL_TEXTURE_SELECT_SGIS       0x8124
; #define GL_QUAD_TEXTURE_SELECT_SGIS       0x8125
 |#

; #endif


; #if GL_SGIX_sprite
#| 
; #define GL_SPRITE_SGIX                    0x8148
; #define GL_SPRITE_MODE_SGIX               0x8149
; #define GL_SPRITE_AXIS_SGIX               0x814A
; #define GL_SPRITE_TRANSLATION_SGIX        0x814B
; #define GL_SPRITE_AXIAL_SGIX              0x814C
; #define GL_SPRITE_OBJECT_ALIGNED_SGIX     0x814D
; #define GL_SPRITE_EYE_ALIGNED_SGIX        0x814E
 |#

; #endif


; #if GL_SGIX_texture_multi_buffer
#| 
; #define GL_TEXTURE_MULTI_BUFFER_HINT_SGIX 0x812E
 |#

; #endif


; #if GL_SGIS_point_parameters
#| 
; #define GL_POINT_SIZE_MIN_EXT             0x8126
; #define GL_POINT_SIZE_MIN_SGIS            0x8126
; #define GL_POINT_SIZE_MAX_EXT             0x8127
; #define GL_POINT_SIZE_MAX_SGIS            0x8127
; #define GL_POINT_FADE_THRESHOLD_SIZE_EXT  0x8128
; #define GL_POINT_FADE_THRESHOLD_SIZE_SGIS 0x8128
; #define GL_DISTANCE_ATTENUATION_EXT       0x8129
; #define GL_DISTANCE_ATTENUATION_SGIS      0x8129
 |#

; #endif


; #if GL_SGIX_instruments
#| 
; #define GL_INSTRUMENT_BUFFER_POINTER_SGIX 0x8180
; #define GL_INSTRUMENT_MEASUREMENTS_SGIX   0x8181
 |#

; #endif


; #if GL_SGIX_texture_scale_bias
#| 
; #define GL_POST_TEXTURE_FILTER_BIAS_SGIX  0x8179
; #define GL_POST_TEXTURE_FILTER_SCALE_SGIX 0x817A
; #define GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX 0x817B
; #define GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX 0x817C
 |#

; #endif


; #if GL_SGIX_framezoom
#| 
; #define GL_FRAMEZOOM_SGIX                 0x818B
; #define GL_FRAMEZOOM_FACTOR_SGIX          0x818C
; #define GL_MAX_FRAMEZOOM_FACTOR_SGIX      0x818D
 |#

; #endif


; #if GL_FfdMaskSGIX
#| 
; #define GL_TEXTURE_DEFORMATION_BIT_SGIX   0x00000001
; #define GL_GEOMETRY_DEFORMATION_BIT_SGIX  0x00000002
 |#

; #endif


; #if GL_SGIX_polynomial_ffd
#| 
; #define GL_GEOMETRY_DEFORMATION_SGIX      0x8194
; #define GL_TEXTURE_DEFORMATION_SGIX       0x8195
; #define GL_DEFORMATIONS_MASK_SGIX         0x8196
; #define GL_MAX_DEFORMATION_ORDER_SGIX     0x8197
 |#

; #endif


; #if GL_SGIX_reference_plane
#| 
; #define GL_REFERENCE_PLANE_SGIX           0x817D
; #define GL_REFERENCE_PLANE_EQUATION_SGIX  0x817E
 |#

; #endif


; #if GL_SGIX_depth_texture
#| 
; #define GL_DEPTH_COMPONENT16_SGIX         0x81A5
; #define GL_DEPTH_COMPONENT24_SGIX         0x81A6
; #define GL_DEPTH_COMPONENT32_SGIX         0x81A7
 |#

; #endif


; #if GL_SGIS_fog_function
#| 
; #define GL_FOG_FUNC_SGIS                  0x812A
; #define GL_FOG_FUNC_POINTS_SGIS           0x812B
; #define GL_MAX_FOG_FUNC_POINTS_SGIS       0x812C
 |#

; #endif


; #if GL_SGIX_fog_offset
#| 
; #define GL_FOG_OFFSET_SGIX                0x8198
; #define GL_FOG_OFFSET_VALUE_SGIX          0x8199
 |#

; #endif


; #if GL_HP_image_transform
#| 
; #define GL_IMAGE_SCALE_X_HP               0x8155
; #define GL_IMAGE_SCALE_Y_HP               0x8156
; #define GL_IMAGE_TRANSLATE_X_HP           0x8157
; #define GL_IMAGE_TRANSLATE_Y_HP           0x8158
; #define GL_IMAGE_ROTATE_ANGLE_HP          0x8159
; #define GL_IMAGE_ROTATE_ORIGIN_X_HP       0x815A
; #define GL_IMAGE_ROTATE_ORIGIN_Y_HP       0x815B
; #define GL_IMAGE_MAG_FILTER_HP            0x815C
; #define GL_IMAGE_MIN_FILTER_HP            0x815D
; #define GL_IMAGE_CUBIC_WEIGHT_HP          0x815E
; #define GL_CUBIC_HP                       0x815F
; #define GL_AVERAGE_HP                     0x8160
; #define GL_IMAGE_TRANSFORM_2D_HP          0x8161
; #define GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP 0x8162
; #define GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP 0x8163
 |#

; #endif


; #if GL_HP_convolution_border_modes
#| 
; #define GL_IGNORE_BORDER_HP               0x8150
; #define GL_CONSTANT_BORDER_HP             0x8151
; #define GL_REPLICATE_BORDER_HP            0x8153
; #define GL_CONVOLUTION_BORDER_COLOR_HP    0x8154
 |#

; #endif


; #if GL_SGIX_texture_add_env
#| 
; #define GL_TEXTURE_ENV_BIAS_SGIX          0x80BE
 |#

; #endif


; #if GL_PGI_vertex_hints
#| 
; #define GL_VERTEX_DATA_HINT_PGI           0x1A22A
; #define GL_VERTEX_CONSISTENT_HINT_PGI     0x1A22B
; #define GL_MATERIAL_SIDE_HINT_PGI         0x1A22C
; #define GL_MAX_VERTEX_HINT_PGI            0x1A22D
; #define GL_COLOR3_BIT_PGI                 0x00010000
; #define GL_COLOR4_BIT_PGI                 0x00020000
; #define GL_EDGEFLAG_BIT_PGI               0x00040000
; #define GL_INDEX_BIT_PGI                  0x00080000
; #define GL_MAT_AMBIENT_BIT_PGI            0x00100000
; #define GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI 0x00200000
; #define GL_MAT_DIFFUSE_BIT_PGI            0x00400000
; #define GL_MAT_EMISSION_BIT_PGI           0x00800000
; #define GL_MAT_COLOR_INDEXES_BIT_PGI      0x01000000
; #define GL_MAT_SHININESS_BIT_PGI          0x02000000
; #define GL_MAT_SPECULAR_BIT_PGI           0x04000000
; #define GL_NORMAL_BIT_PGI                 0x08000000
; #define GL_TEXCOORD1_BIT_PGI              0x10000000
; #define GL_TEXCOORD2_BIT_PGI              0x20000000
; #define GL_TEXCOORD3_BIT_PGI              0x40000000
; #define GL_TEXCOORD4_BIT_PGI              0x80000000
; #define GL_VERTEX23_BIT_PGI               0x00000004
; #define GL_VERTEX4_BIT_PGI                0x00000008
 |#

; #endif


; #if GL_PGI_misc_hints
#| 
; #define GL_PREFER_DOUBLEBUFFER_HINT_PGI   0x1A1F8
; #define GL_CONSERVE_MEMORY_HINT_PGI       0x1A1FD
; #define GL_RECLAIM_MEMORY_HINT_PGI        0x1A1FE
; #define GL_NATIVE_GRAPHICS_HANDLE_PGI     0x1A202
; #define GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI 0x1A203
; #define GL_NATIVE_GRAPHICS_END_HINT_PGI   0x1A204
; #define GL_ALWAYS_FAST_HINT_PGI           0x1A20C
; #define GL_ALWAYS_SOFT_HINT_PGI           0x1A20D
; #define GL_ALLOW_DRAW_OBJ_HINT_PGI        0x1A20E
; #define GL_ALLOW_DRAW_WIN_HINT_PGI        0x1A20F
; #define GL_ALLOW_DRAW_FRG_HINT_PGI        0x1A210
; #define GL_ALLOW_DRAW_MEM_HINT_PGI        0x1A211
; #define GL_STRICT_DEPTHFUNC_HINT_PGI      0x1A216
; #define GL_STRICT_LIGHTING_HINT_PGI       0x1A217
; #define GL_STRICT_SCISSOR_HINT_PGI        0x1A218
; #define GL_FULL_STIPPLE_HINT_PGI          0x1A219
; #define GL_CLIP_NEAR_HINT_PGI             0x1A220
; #define GL_CLIP_FAR_HINT_PGI              0x1A221
; #define GL_WIDE_LINE_HINT_PGI             0x1A222
; #define GL_BACK_NORMALS_HINT_PGI          0x1A223
 |#

; #endif


; #if GL_EXT_paletted_texture
(defconstant $GL_COLOR_INDEX1_EXT 32994)
; #define GL_COLOR_INDEX1_EXT               0x80E2
(defconstant $GL_COLOR_INDEX2_EXT 32995)
; #define GL_COLOR_INDEX2_EXT               0x80E3
(defconstant $GL_COLOR_INDEX4_EXT 32996)
; #define GL_COLOR_INDEX4_EXT               0x80E4
(defconstant $GL_COLOR_INDEX8_EXT 32997)
; #define GL_COLOR_INDEX8_EXT               0x80E5
(defconstant $GL_COLOR_INDEX12_EXT 32998)
; #define GL_COLOR_INDEX12_EXT              0x80E6
(defconstant $GL_COLOR_INDEX16_EXT 32999)
; #define GL_COLOR_INDEX16_EXT              0x80E7
(defconstant $GL_TEXTURE_INDEX_SIZE_EXT 33005)
; #define GL_TEXTURE_INDEX_SIZE_EXT         0x80ED

; #endif


; #if GL_EXT_clip_volume_hint
(defconstant $GL_CLIP_VOLUME_CLIPPING_HINT_EXT 33008)
; #define GL_CLIP_VOLUME_CLIPPING_HINT_EXT  0x80F0

; #endif


; #if GL_SGIX_list_priority
#| 
; #define GL_LIST_PRIORITY_SGIX             0x8182
 |#

; #endif


; #if GL_SGIX_ir_instrument1
#| 
; #define GL_IR_INSTRUMENT1_SGIX            0x817F
 |#

; #endif


; #if GL_SGIX_calligraphic_fragment
#| 
; #define GL_CALLIGRAPHIC_FRAGMENT_SGIX     0x8183
 |#

; #endif


; #if GL_SGIX_texture_lod_bias
#| 
; #define GL_TEXTURE_LOD_BIAS_S_SGIX        0x818E
; #define GL_TEXTURE_LOD_BIAS_T_SGIX        0x818F
; #define GL_TEXTURE_LOD_BIAS_R_SGIX        0x8190
 |#

; #endif


; #if GL_EXT_index_material
#| 
; #define GL_INDEX_MATERIAL_EXT             0x81B8
; #define GL_INDEX_MATERIAL_PARAMETER_EXT   0x81B9
; #define GL_INDEX_MATERIAL_FACE_EXT        0x81BA
 |#

; #endif


; #if GL_EXT_index_func
#| 
; #define GL_INDEX_TEST_EXT                 0x81B5
; #define GL_INDEX_TEST_FUNC_EXT            0x81B6
; #define GL_INDEX_TEST_REF_EXT             0x81B7
 |#

; #endif


; #if GL_EXT_index_array_formats
#| 
; #define GL_IUI_V2F_EXT                    0x81AD
; #define GL_IUI_V3F_EXT                    0x81AE
; #define GL_IUI_N3F_V2F_EXT                0x81AF
; #define GL_IUI_N3F_V3F_EXT                0x81B0
; #define GL_T2F_IUI_V2F_EXT                0x81B1
; #define GL_T2F_IUI_V3F_EXT                0x81B2
; #define GL_T2F_IUI_N3F_V2F_EXT            0x81B3
; #define GL_T2F_IUI_N3F_V3F_EXT            0x81B4
 |#

; #endif


; #if GL_EXT_compiled_vertex_array
(defconstant $GL_ARRAY_ELEMENT_LOCK_FIRST_EXT 33192)
; #define GL_ARRAY_ELEMENT_LOCK_FIRST_EXT   0x81A8
(defconstant $GL_ARRAY_ELEMENT_LOCK_COUNT_EXT 33193)
; #define GL_ARRAY_ELEMENT_LOCK_COUNT_EXT   0x81A9

; #endif


; #if GL_EXT_cull_vertex
#| 
; #define GL_CULL_VERTEX_EXT                0x81AA
; #define GL_CULL_VERTEX_EYE_POSITION_EXT   0x81AB
; #define GL_CULL_VERTEX_OBJECT_POSITION_EXT 0x81AC
 |#

; #endif


; #if GL_SGIX_ycrcb
#| 
; #define GL_YCRCB_422_SGIX                 0x81BB
; #define GL_YCRCB_444_SGIX                 0x81BC
 |#

; #endif


; #if GL_SGIX_fragment_lighting
#| 
; #define GL_FRAGMENT_LIGHTING_SGIX         0x8400
; #define GL_FRAGMENT_COLOR_MATERIAL_SGIX   0x8401
; #define GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX 0x8402
; #define GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX 0x8403
; #define GL_MAX_FRAGMENT_LIGHTS_SGIX       0x8404
; #define GL_MAX_ACTIVE_LIGHTS_SGIX         0x8405
; #define GL_CURRENT_RASTER_NORMAL_SGIX     0x8406
; #define GL_LIGHT_ENV_MODE_SGIX            0x8407
; #define GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX 0x8408
; #define GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX 0x8409
; #define GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX 0x840A
; #define GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX 0x840B
; #define GL_FRAGMENT_LIGHT0_SGIX           0x840C
; #define GL_FRAGMENT_LIGHT1_SGIX           0x840D
; #define GL_FRAGMENT_LIGHT2_SGIX           0x840E
; #define GL_FRAGMENT_LIGHT3_SGIX           0x840F
; #define GL_FRAGMENT_LIGHT4_SGIX           0x8410
; #define GL_FRAGMENT_LIGHT5_SGIX           0x8411
; #define GL_FRAGMENT_LIGHT6_SGIX           0x8412
; #define GL_FRAGMENT_LIGHT7_SGIX           0x8413
 |#

; #endif


; #if GL_IBM_rasterpos_clip
(defconstant $GL_RASTER_POSITION_UNCLIPPED_IBM 103010)
; #define GL_RASTER_POSITION_UNCLIPPED_IBM  0x19262

; #endif


; #if GL_HP_texture_lighting
#| 
; #define GL_TEXTURE_LIGHTING_MODE_HP       0x8167
; #define GL_TEXTURE_POST_SPECULAR_HP       0x8168
; #define GL_TEXTURE_PRE_SPECULAR_HP        0x8169
 |#

; #endif


; #if GL_EXT_draw_range_elements
(defconstant $GL_MAX_ELEMENTS_VERTICES_EXT 33000)
; #define GL_MAX_ELEMENTS_VERTICES_EXT      0x80E8
(defconstant $GL_MAX_ELEMENTS_INDICES_EXT 33001)
; #define GL_MAX_ELEMENTS_INDICES_EXT       0x80E9

; #endif


; #if GL_WIN_phong_shading
#| 
; #define GL_PHONG_WIN                      0x80EA
; #define GL_PHONG_HINT_WIN                 0x80EB
 |#

; #endif


; #if GL_WIN_specular_fog
#| 
; #define GL_FOG_SPECULAR_TEXTURE_WIN       0x80EC
 |#

; #endif


; #if GL_EXT_light_texture
#| 
; #define GL_FRAGMENT_MATERIAL_EXT          0x8349
; #define GL_FRAGMENT_NORMAL_EXT            0x834A
; #define GL_FRAGMENT_COLOR_EXT             0x834C
; #define GL_ATTENUATION_EXT                0x834D
; #define GL_SHADOW_ATTENUATION_EXT         0x834E
; #define GL_TEXTURE_APPLICATION_MODE_EXT   0x834F
; #define GL_TEXTURE_LIGHT_EXT              0x8350
; #define GL_TEXTURE_MATERIAL_FACE_EXT      0x8351
; #define GL_TEXTURE_MATERIAL_PARAMETER_EXT 0x8352
;  reuse GL_FRAGMENT_DEPTH_EXT 
 |#

; #endif


; #if GL_SGIX_blend_alpha_minmax
#| 
; #define GL_ALPHA_MIN_SGIX                 0x8320
; #define GL_ALPHA_MAX_SGIX                 0x8321
 |#

; #endif


; #if GL_EXT_bgra
(defconstant $GL_BGR_EXT 32992)
; #define GL_BGR_EXT                        0x80E0
(defconstant $GL_BGRA_EXT 32993)
; #define GL_BGRA_EXT                       0x80E1

; #endif


; #if GL_SGIX_async
#| 
; #define GL_ASYNC_MARKER_SGIX              0x8329
 |#

; #endif


; #if GL_SGIX_async_pixel
#| 
; #define GL_ASYNC_TEX_IMAGE_SGIX           0x835C
; #define GL_ASYNC_DRAW_PIXELS_SGIX         0x835D
; #define GL_ASYNC_READ_PIXELS_SGIX         0x835E
; #define GL_MAX_ASYNC_TEX_IMAGE_SGIX       0x835F
; #define GL_MAX_ASYNC_DRAW_PIXELS_SGIX     0x8360
; #define GL_MAX_ASYNC_READ_PIXELS_SGIX     0x8361
 |#

; #endif


; #if GL_SGIX_async_histogram
#| 
; #define GL_ASYNC_HISTOGRAM_SGIX           0x832C
; #define GL_MAX_ASYNC_HISTOGRAM_SGIX       0x832D
 |#

; #endif


; #if GL_INTEL_parallel_arrays
#| 
; #define GL_PARALLEL_ARRAYS_INTEL          0x83F4
; #define GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL 0x83F5
; #define GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL 0x83F6
; #define GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL 0x83F7
; #define GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL 0x83F8
 |#

; #endif


; #if GL_HP_occlusion_test
#| 
; #define GL_OCCLUSION_TEST_HP              0x8165
; #define GL_OCCLUSION_TEST_RESULT_HP       0x8166
 |#

; #endif


; #if GL_EXT_pixel_transform
#| 
; #define GL_PIXEL_TRANSFORM_2D_EXT         0x8330
; #define GL_PIXEL_MAG_FILTER_EXT           0x8331
; #define GL_PIXEL_MIN_FILTER_EXT           0x8332
; #define GL_PIXEL_CUBIC_WEIGHT_EXT         0x8333
; #define GL_CUBIC_EXT                      0x8334
; #define GL_AVERAGE_EXT                    0x8335
; #define GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT 0x8336
; #define GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT 0x8337
; #define GL_PIXEL_TRANSFORM_2D_MATRIX_EXT  0x8338
 |#

; #endif


; #if GL_EXT_shared_texture_palette
(defconstant $GL_SHARED_TEXTURE_PALETTE_EXT 33275)
; #define GL_SHARED_TEXTURE_PALETTE_EXT     0x81FB

; #endif


; #if GL_EXT_separate_specular_color
(defconstant $GL_LIGHT_MODEL_COLOR_CONTROL_EXT 33272)
; #define GL_LIGHT_MODEL_COLOR_CONTROL_EXT  0x81F8
(defconstant $GL_SINGLE_COLOR_EXT 33273)
; #define GL_SINGLE_COLOR_EXT               0x81F9
(defconstant $GL_SEPARATE_SPECULAR_COLOR_EXT 33274)
; #define GL_SEPARATE_SPECULAR_COLOR_EXT    0x81FA

; #endif


; #if GL_EXT_secondary_color
(defconstant $GL_COLOR_SUM_EXT 33880)
; #define GL_COLOR_SUM_EXT                  0x8458
(defconstant $GL_CURRENT_SECONDARY_COLOR_EXT 33881)
; #define GL_CURRENT_SECONDARY_COLOR_EXT    0x8459
(defconstant $GL_SECONDARY_COLOR_ARRAY_SIZE_EXT 33882)
; #define GL_SECONDARY_COLOR_ARRAY_SIZE_EXT 0x845A
(defconstant $GL_SECONDARY_COLOR_ARRAY_TYPE_EXT 33883)
; #define GL_SECONDARY_COLOR_ARRAY_TYPE_EXT 0x845B
(defconstant $GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT 33884)
; #define GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT 0x845C
(defconstant $GL_SECONDARY_COLOR_ARRAY_POINTER_EXT 33885)
; #define GL_SECONDARY_COLOR_ARRAY_POINTER_EXT 0x845D
(defconstant $GL_SECONDARY_COLOR_ARRAY_EXT 33886)
; #define GL_SECONDARY_COLOR_ARRAY_EXT      0x845E

; #endif


; #if GL_EXT_texture_perturb_normal
#| 
; #define GL_PERTURB_EXT                    0x85AE
; #define GL_TEXTURE_NORMAL_EXT             0x85AF
 |#

; #endif


; #if GL_EXT_fog_coord
(defconstant $GL_FOG_COORDINATE_SOURCE_EXT 33872)
; #define GL_FOG_COORDINATE_SOURCE_EXT      0x8450
(defconstant $GL_FOG_COORDINATE_EXT 33873)
; #define GL_FOG_COORDINATE_EXT             0x8451
(defconstant $GL_FRAGMENT_DEPTH_EXT 33874)
; #define GL_FRAGMENT_DEPTH_EXT             0x8452
(defconstant $GL_CURRENT_FOG_COORDINATE_EXT 33875)
; #define GL_CURRENT_FOG_COORDINATE_EXT     0x8453
(defconstant $GL_FOG_COORDINATE_ARRAY_TYPE_EXT 33876)
; #define GL_FOG_COORDINATE_ARRAY_TYPE_EXT  0x8454
(defconstant $GL_FOG_COORDINATE_ARRAY_STRIDE_EXT 33877)
; #define GL_FOG_COORDINATE_ARRAY_STRIDE_EXT 0x8455
(defconstant $GL_FOG_COORDINATE_ARRAY_POINTER_EXT 33878)
; #define GL_FOG_COORDINATE_ARRAY_POINTER_EXT 0x8456
(defconstant $GL_FOG_COORDINATE_ARRAY_EXT 33879)
; #define GL_FOG_COORDINATE_ARRAY_EXT       0x8457

; #endif


; #if GL_APPLE_vertex_array_range
(defconstant $GL_VERTEX_ARRAY_RANGE_APPLE 34077)
; #define GL_VERTEX_ARRAY_RANGE_APPLE             0x851D
(defconstant $GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE 34078)
; #define GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE      0x851E
(defconstant $GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_APPLE 34080)
; #define GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_APPLE 0x8520
(defconstant $GL_VERTEX_ARRAY_RANGE_POINTER_APPLE 34081)
; #define GL_VERTEX_ARRAY_RANGE_POINTER_APPLE     0x8521
(defconstant $GL_VERTEX_ARRAY_STORAGE_HINT_APPLE 34079)
; #define GL_VERTEX_ARRAY_STORAGE_HINT_APPLE      0x851F
(defconstant $GL_STORAGE_CLIENT_APPLE 34228)
; #define GL_STORAGE_CLIENT_APPLE                 0x85B4
;  GL_STORAGE_PRIVATE_APPLE           0x85BD 
;  GL_STORAGE_CACHED_APPLE            0x85BE 
;  GL_STORAGE_SHARED_APPLE            0x85BF 

; #endif


; #if GL_APPLE_vertex_array_object
(defconstant $GL_VERTEX_ARRAY_BINDING_APPLE 34229)
; #define GL_VERTEX_ARRAY_BINDING_APPLE      0x85B5

; #endif


; #if GL_APPLE_element_array
(defconstant $GL_ELEMENT_ARRAY_APPLE 35340)
; #define GL_ELEMENT_ARRAY_APPLE             0x8A0C
(defconstant $GL_ELEMENT_ARRAY_TYPE_APPLE 35341)
; #define GL_ELEMENT_ARRAY_TYPE_APPLE        0x8A0D
(defconstant $GL_ELEMENT_ARRAY_POINTER_APPLE 35342)
; #define GL_ELEMENT_ARRAY_POINTER_APPLE     0x8A0E

; #endif


; #if GL_APPLE_fence
(defconstant $GL_DRAW_PIXELS_APPLE 35338)
; #define GL_DRAW_PIXELS_APPLE              0x8A0A
(defconstant $GL_FENCE_APPLE 35339)
; #define GL_FENCE_APPLE             	      0x8A0B

; #endif


; #if GL_REND_screen_coordinates
#| 
; #define GL_SCREEN_COORDINATES_REND        0x8490
; #define GL_INVERTED_SCREEN_W_REND         0x8491
 |#

; #endif


; #if GL_EXT_coordinate_frame
#| 
; #define GL_TANGENT_ARRAY_EXT              0x8439
; #define GL_BINORMAL_ARRAY_EXT             0x843A
; #define GL_CURRENT_TANGENT_EXT            0x843B
; #define GL_CURRENT_BINORMAL_EXT           0x843C
; #define GL_TANGENT_ARRAY_TYPE_EXT         0x843E
; #define GL_TANGENT_ARRAY_STRIDE_EXT       0x843F
; #define GL_BINORMAL_ARRAY_TYPE_EXT        0x8440
; #define GL_BINORMAL_ARRAY_STRIDE_EXT      0x8441
; #define GL_TANGENT_ARRAY_POINTER_EXT      0x8442
; #define GL_BINORMAL_ARRAY_POINTER_EXT     0x8443
; #define GL_MAP1_TANGENT_EXT               0x8444
; #define GL_MAP2_TANGENT_EXT               0x8445
; #define GL_MAP1_BINORMAL_EXT              0x8446
; #define GL_MAP2_BINORMAL_EXT              0x8447
 |#

; #endif


; #if GL_EXT_texture_env_combine
#| 
; #define GL_COMBINE_EXT                    0x8570
; #define GL_COMBINE_RGB_EXT                0x8571
; #define GL_COMBINE_ALPHA_EXT              0x8572
; #define GL_RGB_SCALE_EXT                  0x8573
; #define GL_ADD_SIGNED_EXT                 0x8574
; #define GL_INTERPOLATE_EXT                0x8575
; #define GL_CONSTANT_EXT                   0x8576
; #define GL_PRIMARY_COLOR_EXT              0x8577
; #define GL_PREVIOUS_EXT                   0x8578
; #define GL_SOURCE0_RGB_EXT                0x8580
; #define GL_SOURCE1_RGB_EXT                0x8581
; #define GL_SOURCE2_RGB_EXT                0x8582
; #define GL_SOURCE3_RGB_EXT                0x8583
; #define GL_SOURCE4_RGB_EXT                0x8584
; #define GL_SOURCE5_RGB_EXT                0x8585
; #define GL_SOURCE6_RGB_EXT                0x8586
; #define GL_SOURCE7_RGB_EXT                0x8587
; #define GL_SOURCE0_ALPHA_EXT              0x8588
; #define GL_SOURCE1_ALPHA_EXT              0x8589
; #define GL_SOURCE2_ALPHA_EXT              0x858A
; #define GL_SOURCE3_ALPHA_EXT              0x858B
; #define GL_SOURCE4_ALPHA_EXT              0x858C
; #define GL_SOURCE5_ALPHA_EXT              0x858D
; #define GL_SOURCE6_ALPHA_EXT              0x858E
; #define GL_SOURCE7_ALPHA_EXT              0x858F
; #define GL_OPERAND0_RGB_EXT               0x8590
; #define GL_OPERAND1_RGB_EXT               0x8591
; #define GL_OPERAND2_RGB_EXT               0x8592
; #define GL_OPERAND3_RGB_EXT               0x8593
; #define GL_OPERAND4_RGB_EXT               0x8594
; #define GL_OPERAND5_RGB_EXT               0x8595
; #define GL_OPERAND6_RGB_EXT               0x8596
; #define GL_OPERAND7_RGB_EXT               0x8597
; #define GL_OPERAND0_ALPHA_EXT             0x8598
; #define GL_OPERAND1_ALPHA_EXT             0x8599
; #define GL_OPERAND2_ALPHA_EXT             0x859A
; #define GL_OPERAND3_ALPHA_EXT             0x859B
; #define GL_OPERAND4_ALPHA_EXT             0x859C
; #define GL_OPERAND5_ALPHA_EXT             0x859D
; #define GL_OPERAND6_ALPHA_EXT             0x859E
; #define GL_OPERAND7_ALPHA_EXT             0x859F
 |#

; #endif


; #if GL_ARB_texture_env_combine
(defconstant $GL_COMBINE_ARB 34160)
; #define GL_COMBINE_ARB                    0x8570
(defconstant $GL_COMBINE_RGB_ARB 34161)
; #define GL_COMBINE_RGB_ARB                0x8571
(defconstant $GL_COMBINE_ALPHA_ARB 34162)
; #define GL_COMBINE_ALPHA_ARB              0x8572
(defconstant $GL_RGB_SCALE_ARB 34163)
; #define GL_RGB_SCALE_ARB                  0x8573
(defconstant $GL_ADD_SIGNED_ARB 34164)
; #define GL_ADD_SIGNED_ARB                 0x8574
(defconstant $GL_INTERPOLATE_ARB 34165)
; #define GL_INTERPOLATE_ARB                0x8575
(defconstant $GL_CONSTANT_ARB 34166)
; #define GL_CONSTANT_ARB                   0x8576
(defconstant $GL_PRIMARY_COLOR_ARB 34167)
; #define GL_PRIMARY_COLOR_ARB              0x8577
(defconstant $GL_PREVIOUS_ARB 34168)
; #define GL_PREVIOUS_ARB                   0x8578
(defconstant $GL_SUBTRACT_ARB 34023)
; #define GL_SUBTRACT_ARB                   0x84E7
(defconstant $GL_SOURCE0_RGB_ARB 34176)
; #define GL_SOURCE0_RGB_ARB                0x8580
(defconstant $GL_SOURCE1_RGB_ARB 34177)
; #define GL_SOURCE1_RGB_ARB                0x8581
(defconstant $GL_SOURCE2_RGB_ARB 34178)
; #define GL_SOURCE2_RGB_ARB                0x8582
(defconstant $GL_SOURCE3_RGB_ARB 34179)
; #define GL_SOURCE3_RGB_ARB                0x8583
(defconstant $GL_SOURCE4_RGB_ARB 34180)
; #define GL_SOURCE4_RGB_ARB                0x8584
(defconstant $GL_SOURCE5_RGB_ARB 34181)
; #define GL_SOURCE5_RGB_ARB                0x8585
(defconstant $GL_SOURCE6_RGB_ARB 34182)
; #define GL_SOURCE6_RGB_ARB                0x8586
(defconstant $GL_SOURCE7_RGB_ARB 34183)
; #define GL_SOURCE7_RGB_ARB                0x8587
(defconstant $GL_SOURCE0_ALPHA_ARB 34184)
; #define GL_SOURCE0_ALPHA_ARB              0x8588
(defconstant $GL_SOURCE1_ALPHA_ARB 34185)
; #define GL_SOURCE1_ALPHA_ARB              0x8589
(defconstant $GL_SOURCE2_ALPHA_ARB 34186)
; #define GL_SOURCE2_ALPHA_ARB              0x858A
(defconstant $GL_SOURCE3_ALPHA_ARB 34187)
; #define GL_SOURCE3_ALPHA_ARB              0x858B
(defconstant $GL_SOURCE4_ALPHA_ARB 34188)
; #define GL_SOURCE4_ALPHA_ARB              0x858C
(defconstant $GL_SOURCE5_ALPHA_ARB 34189)
; #define GL_SOURCE5_ALPHA_ARB              0x858D
(defconstant $GL_SOURCE6_ALPHA_ARB 34190)
; #define GL_SOURCE6_ALPHA_ARB              0x858E
(defconstant $GL_SOURCE7_ALPHA_ARB 34191)
; #define GL_SOURCE7_ALPHA_ARB              0x858F
(defconstant $GL_OPERAND0_RGB_ARB 34192)
; #define GL_OPERAND0_RGB_ARB               0x8590
(defconstant $GL_OPERAND1_RGB_ARB 34193)
; #define GL_OPERAND1_RGB_ARB               0x8591
(defconstant $GL_OPERAND2_RGB_ARB 34194)
; #define GL_OPERAND2_RGB_ARB               0x8592
(defconstant $GL_OPERAND3_RGB_ARB 34195)
; #define GL_OPERAND3_RGB_ARB               0x8593
(defconstant $GL_OPERAND4_RGB_ARB 34196)
; #define GL_OPERAND4_RGB_ARB               0x8594
(defconstant $GL_OPERAND5_RGB_ARB 34197)
; #define GL_OPERAND5_RGB_ARB               0x8595
(defconstant $GL_OPERAND6_RGB_ARB 34198)
; #define GL_OPERAND6_RGB_ARB               0x8596
(defconstant $GL_OPERAND7_RGB_ARB 34199)
; #define GL_OPERAND7_RGB_ARB               0x8597
(defconstant $GL_OPERAND0_ALPHA_ARB 34200)
; #define GL_OPERAND0_ALPHA_ARB             0x8598
(defconstant $GL_OPERAND1_ALPHA_ARB 34201)
; #define GL_OPERAND1_ALPHA_ARB             0x8599
(defconstant $GL_OPERAND2_ALPHA_ARB 34202)
; #define GL_OPERAND2_ALPHA_ARB             0x859A
(defconstant $GL_OPERAND3_ALPHA_ARB 34203)
; #define GL_OPERAND3_ALPHA_ARB             0x859B
(defconstant $GL_OPERAND4_ALPHA_ARB 34204)
; #define GL_OPERAND4_ALPHA_ARB             0x859C
(defconstant $GL_OPERAND5_ALPHA_ARB 34205)
; #define GL_OPERAND5_ALPHA_ARB             0x859D
(defconstant $GL_OPERAND6_ALPHA_ARB 34206)
; #define GL_OPERAND6_ALPHA_ARB             0x859E
(defconstant $GL_OPERAND7_ALPHA_ARB 34207)
; #define GL_OPERAND7_ALPHA_ARB             0x859F

; #endif


; #if GL_APPLE_specular_vector
(defconstant $GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE 34224)
; #define GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE 0x85B0

; #endif


; #if GL_APPLE_transform_hint
(defconstant $GL_TRANSFORM_HINT_APPLE 34225)
; #define GL_TRANSFORM_HINT_APPLE           0x85B1

; #endif


; #if GL_APPLE_client_storage
(defconstant $GL_UNPACK_CLIENT_STORAGE_APPLE 34226)
; #define GL_UNPACK_CLIENT_STORAGE_APPLE    0x85B2

; #endif


; #if GL_APPLE_ycbcr_422
(defconstant $GL_YCBCR_422_APPLE 34233)
; #define GL_YCBCR_422_APPLE                 0x85B9
(defconstant $GL_UNSIGNED_SHORT_8_8_APPLE 34234)
; #define GL_UNSIGNED_SHORT_8_8_APPLE        0x85BA
(defconstant $GL_UNSIGNED_SHORT_8_8_REV_APPLE 34235)
; #define GL_UNSIGNED_SHORT_8_8_REV_APPLE    0x85BB

; #endif


; #if GL_APPLE_texture_range
(defconstant $GL_TEXTURE_RANGE_LENGTH_APPLE 34231)
; #define GL_TEXTURE_RANGE_LENGTH_APPLE      0x85B7
(defconstant $GL_TEXTURE_RANGE_POINTER_APPLE 34232)
; #define GL_TEXTURE_RANGE_POINTER_APPLE     0x85B8
(defconstant $GL_TEXTURE_STORAGE_HINT_APPLE 34236)
; #define GL_TEXTURE_STORAGE_HINT_APPLE      0x85BC
(defconstant $GL_TEXTURE_MINIMIZE_STORAGE_APPLE 34230)
; #define GL_TEXTURE_MINIMIZE_STORAGE_APPLE  0x85B6

; #endif


; #if GL_APPLE_vertex_array_range || GL_APPLE_texture_range
(defconstant $GL_STORAGE_PRIVATE_APPLE 34237)
; #define GL_STORAGE_PRIVATE_APPLE           0x85BD
(defconstant $GL_STORAGE_CACHED_APPLE 34238)
; #define GL_STORAGE_CACHED_APPLE            0x85BE
(defconstant $GL_STORAGE_SHARED_APPLE 34239)
; #define GL_STORAGE_SHARED_APPLE            0x85BF

; #endif


; #if GL_APPLE_float_pixels
(defconstant $GL_HALF_APPLE 5131)
; #define GL_HALF_APPLE                      0x140B
(defconstant $GL_COLOR_FLOAT_APPLE 35343)
; #define GL_COLOR_FLOAT_APPLE               0x8A0F
(defconstant $GL_RGBA_FLOAT32_APPLE 34836)
; #define GL_RGBA_FLOAT32_APPLE              0x8814
(defconstant $GL_RGB_FLOAT32_APPLE 34837)
; #define GL_RGB_FLOAT32_APPLE               0x8815
(defconstant $GL_ALPHA_FLOAT32_APPLE 34838)
; #define GL_ALPHA_FLOAT32_APPLE             0x8816
(defconstant $GL_INTENSITY_FLOAT32_APPLE 34839)
; #define GL_INTENSITY_FLOAT32_APPLE         0x8817
(defconstant $GL_LUMINANCE_FLOAT32_APPLE 34840)
; #define GL_LUMINANCE_FLOAT32_APPLE         0x8818
(defconstant $GL_LUMINANCE_ALPHA_FLOAT32_APPLE 34841)
; #define GL_LUMINANCE_ALPHA_FLOAT32_APPLE   0x8819
(defconstant $GL_RGBA_FLOAT16_APPLE 34842)
; #define GL_RGBA_FLOAT16_APPLE              0x881A
(defconstant $GL_RGB_FLOAT16_APPLE 34843)
; #define GL_RGB_FLOAT16_APPLE               0x881B
(defconstant $GL_ALPHA_FLOAT16_APPLE 34844)
; #define GL_ALPHA_FLOAT16_APPLE             0x881C
(defconstant $GL_INTENSITY_FLOAT16_APPLE 34845)
; #define GL_INTENSITY_FLOAT16_APPLE         0x881D
(defconstant $GL_LUMINANCE_FLOAT16_APPLE 34846)
; #define GL_LUMINANCE_FLOAT16_APPLE         0x881E
(defconstant $GL_LUMINANCE_ALPHA_FLOAT16_APPLE 34847)
; #define GL_LUMINANCE_ALPHA_FLOAT16_APPLE   0x881F

; #endif


; #if GL_APPLE_pixel_buffer
(defconstant $GL_MIN_PBUFFER_VIEWPORT_DIMS_APPLE 35344)
; #define GL_MIN_PBUFFER_VIEWPORT_DIMS_APPLE 0x8A10

; #endif


; #if GL_SGIX_fog_scale
#| 
; #define GL_FOG_SCALE_SGIX                 0x81FC
; #define GL_FOG_SCALE_VALUE_SGIX           0x81FD
 |#

; #endif


; #if GL_SUNX_constant_data
#| 
; #define GL_UNPACK_CONSTANT_DATA_SUNX      0x81D5
; #define GL_TEXTURE_CONSTANT_DATA_SUNX     0x81D6
 |#

; #endif


; #if GL_SUN_global_alpha
#| 
; #define GL_GLOBAL_ALPHA_SUN               0x81D9
; #define GL_GLOBAL_ALPHA_FACTOR_SUN        0x81DA
 |#

; #endif


; #if GL_SUN_triangle_list
#| 
; #define GL_RESTART_SUN                    0x01
; #define GL_REPLACE_MIDDLE_SUN             0x02
; #define GL_REPLACE_OLDEST_SUN             0x03
; #define GL_TRIANGLE_LIST_SUN              0x81D7
; #define GL_REPLACEMENT_CODE_SUN           0x81D8
; #define GL_REPLACEMENT_CODE_ARRAY_SUN     0x85C0
; #define GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN 0x85C1
; #define GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN 0x85C2
; #define GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN 0x85C3
; #define GL_R1UI_V3F_SUN                   0x85C4
; #define GL_R1UI_C4UB_V3F_SUN              0x85C5
; #define GL_R1UI_C3F_V3F_SUN               0x85C6
; #define GL_R1UI_N3F_V3F_SUN               0x85C7
; #define GL_R1UI_C4F_N3F_V3F_SUN           0x85C8
; #define GL_R1UI_T2F_V3F_SUN               0x85C9
; #define GL_R1UI_T2F_N3F_V3F_SUN           0x85CA
; #define GL_R1UI_T2F_C4F_N3F_V3F_SUN       0x85CB
 |#

; #endif


; #if GL_EXT_blend_func_separate
(defconstant $GL_BLEND_DST_RGB_EXT 32968)
; #define GL_BLEND_DST_RGB_EXT              0x80C8
(defconstant $GL_BLEND_SRC_RGB_EXT 32969)
; #define GL_BLEND_SRC_RGB_EXT              0x80C9
(defconstant $GL_BLEND_DST_ALPHA_EXT 32970)
; #define GL_BLEND_DST_ALPHA_EXT            0x80CA
(defconstant $GL_BLEND_SRC_ALPHA_EXT 32971)
; #define GL_BLEND_SRC_ALPHA_EXT            0x80CB

; #endif


; #if GL_INGR_color_clamp
#| 
; #define GL_RED_MIN_CLAMP_INGR             0x8560
; #define GL_GREEN_MIN_CLAMP_INGR           0x8561
; #define GL_BLUE_MIN_CLAMP_INGR            0x8562
; #define GL_ALPHA_MIN_CLAMP_INGR           0x8563
; #define GL_RED_MAX_CLAMP_INGR             0x8564
; #define GL_GREEN_MAX_CLAMP_INGR           0x8565
; #define GL_BLUE_MAX_CLAMP_INGR            0x8566
; #define GL_ALPHA_MAX_CLAMP_INGR           0x8567
 |#

; #endif


; #if GL_INGR_interlace_read
#| 
; #define GL_INTERLACE_READ_INGR            0x8568
 |#

; #endif


; #if GL_EXT_stencil_wrap
(defconstant $GL_INCR_WRAP_EXT 34055)
; #define GL_INCR_WRAP_EXT                  0x8507
(defconstant $GL_DECR_WRAP_EXT 34056)
; #define GL_DECR_WRAP_EXT                  0x8508

; #endif


; #if GL_EXT_422_pixels
#| 
; #define GL_422_EXT                        0x80CC
; #define GL_422_REV_EXT                    0x80CD
; #define GL_422_AVERAGE_EXT                0x80CE
; #define GL_422_REV_AVERAGE_EXT            0x80CF
 |#

; #endif


; #if GL_NV_texgen_reflection
(defconstant $GL_NORMAL_MAP_NV 34065)
; #define GL_NORMAL_MAP_NV                  0x8511
(defconstant $GL_REFLECTION_MAP_NV 34066)
; #define GL_REFLECTION_MAP_NV              0x8512

; #endif


; #if GL_EXT_texture_cube_map
#| 
; #define GL_NORMAL_MAP_EXT                 0x8511
; #define GL_REFLECTION_MAP_EXT             0x8512
; #define GL_TEXTURE_CUBE_MAP_EXT           0x8513
; #define GL_TEXTURE_BINDING_CUBE_MAP_EXT   0x8514
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT 0x8515
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT 0x8516
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT 0x8517
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT 0x8518
; #define GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT 0x8519
; #define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT 0x851A
; #define GL_PROXY_TEXTURE_CUBE_MAP_EXT     0x851B
; #define GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT  0x851C
 |#

; #endif


; #if GL_SUN_convolution_border_modes
#| 
; #define GL_WRAP_BORDER_SUN                0x81D4
 |#

; #endif


; #if GL_EXT_texture_lod_bias
(defconstant $GL_MAX_TEXTURE_LOD_BIAS_EXT 34045)
; #define GL_MAX_TEXTURE_LOD_BIAS_EXT       0x84FD
(defconstant $GL_TEXTURE_FILTER_CONTROL_EXT 34048)
; #define GL_TEXTURE_FILTER_CONTROL_EXT     0x8500
(defconstant $GL_TEXTURE_LOD_BIAS_EXT 34049)
; #define GL_TEXTURE_LOD_BIAS_EXT           0x8501

; #endif


; #if GL_EXT_texture_filter_anisotropic
(defconstant $GL_TEXTURE_MAX_ANISOTROPY_EXT 34046)
; #define GL_TEXTURE_MAX_ANISOTROPY_EXT     0x84FE
(defconstant $GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT 34047)
; #define GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT 0x84FF

; #endif


; #if GL_EXT_vertex_weighting
#| 
; #define GL_MODELVIEW0_STACK_DEPTH_EXT     GL_MODELVIEW_STACK_DEPTH
; #define GL_MODELVIEW1_STACK_DEPTH_EXT     0x8502
; #define GL_MODELVIEW0_MATRIX_EXT          GL_MODELVIEW_MATRIX
; #define GL_MODELVIEW_MATRIX1_EXT          0x8506
; #define GL_VERTEX_WEIGHTING_EXT           0x8509
; #define GL_MODELVIEW0_EXT                 GL_MODELVIEW
; #define GL_MODELVIEW1_EXT                 0x850A
; #define GL_CURRENT_VERTEX_WEIGHT_EXT      0x850B
; #define GL_VERTEX_WEIGHT_ARRAY_EXT        0x850C
; #define GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT   0x850D
; #define GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT   0x850E
; #define GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT 0x850F
; #define GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT 0x8510
 |#

; #endif


; #if GL_NV_light_max_exponent
(defconstant $GL_MAX_SHININESS_NV 34052)
; #define GL_MAX_SHININESS_NV               0x8504
(defconstant $GL_MAX_SPOT_EXPONENT_NV 34053)
; #define GL_MAX_SPOT_EXPONENT_NV           0x8505

; #endif


; #if GL_NV_vertex_array_range
#| 
; #define GL_VERTEX_ARRAY_RANGE_NV          0x851D
; #define GL_VERTEX_ARRAY_RANGE_LENGTH_NV   0x851E
; #define GL_VERTEX_ARRAY_RANGE_VALID_NV    0x851F
; #define GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV 0x8520
; #define GL_VERTEX_ARRAY_RANGE_POINTER_NV  0x8521
 |#

; #endif


; #if GL_NV_vertex_array_range2
#| 
; #define GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV 0x8533
 |#

; #endif


; #if GL_NV_register_combiners
(defconstant $GL_REGISTER_COMBINERS_NV 34082)
; #define GL_REGISTER_COMBINERS_NV          0x8522
(defconstant $GL_VARIABLE_A_NV 34083)
; #define GL_VARIABLE_A_NV                  0x8523
(defconstant $GL_VARIABLE_B_NV 34084)
; #define GL_VARIABLE_B_NV                  0x8524
(defconstant $GL_VARIABLE_C_NV 34085)
; #define GL_VARIABLE_C_NV                  0x8525
(defconstant $GL_VARIABLE_D_NV 34086)
; #define GL_VARIABLE_D_NV                  0x8526
(defconstant $GL_VARIABLE_E_NV 34087)
; #define GL_VARIABLE_E_NV                  0x8527
(defconstant $GL_VARIABLE_F_NV 34088)
; #define GL_VARIABLE_F_NV                  0x8528
(defconstant $GL_VARIABLE_G_NV 34089)
; #define GL_VARIABLE_G_NV                  0x8529
(defconstant $GL_CONSTANT_COLOR0_NV 34090)
; #define GL_CONSTANT_COLOR0_NV             0x852A
(defconstant $GL_CONSTANT_COLOR1_NV 34091)
; #define GL_CONSTANT_COLOR1_NV             0x852B
(defconstant $GL_PRIMARY_COLOR_NV 34092)
; #define GL_PRIMARY_COLOR_NV               0x852C
(defconstant $GL_SECONDARY_COLOR_NV 34093)
; #define GL_SECONDARY_COLOR_NV             0x852D
(defconstant $GL_SPARE0_NV 34094)
; #define GL_SPARE0_NV                      0x852E
(defconstant $GL_SPARE1_NV 34095)
; #define GL_SPARE1_NV                      0x852F
(defconstant $GL_DISCARD_NV 34096)
; #define GL_DISCARD_NV                     0x8530
(defconstant $GL_E_TIMES_F_NV 34097)
; #define GL_E_TIMES_F_NV                   0x8531
(defconstant $GL_SPARE0_PLUS_SECONDARY_COLOR_NV 34098)
; #define GL_SPARE0_PLUS_SECONDARY_COLOR_NV 0x8532
(defconstant $GL_UNSIGNED_IDENTITY_NV 34102)
; #define GL_UNSIGNED_IDENTITY_NV           0x8536
(defconstant $GL_UNSIGNED_INVERT_NV 34103)
; #define GL_UNSIGNED_INVERT_NV             0x8537
(defconstant $GL_EXPAND_NORMAL_NV 34104)
; #define GL_EXPAND_NORMAL_NV               0x8538
(defconstant $GL_EXPAND_NEGATE_NV 34105)
; #define GL_EXPAND_NEGATE_NV               0x8539
(defconstant $GL_HALF_BIAS_NORMAL_NV 34106)
; #define GL_HALF_BIAS_NORMAL_NV            0x853A
(defconstant $GL_HALF_BIAS_NEGATE_NV 34107)
; #define GL_HALF_BIAS_NEGATE_NV            0x853B
(defconstant $GL_SIGNED_IDENTITY_NV 34108)
; #define GL_SIGNED_IDENTITY_NV             0x853C
(defconstant $GL_SIGNED_NEGATE_NV 34109)
; #define GL_SIGNED_NEGATE_NV               0x853D
(defconstant $GL_SCALE_BY_TWO_NV 34110)
; #define GL_SCALE_BY_TWO_NV                0x853E
(defconstant $GL_SCALE_BY_FOUR_NV 34111)
; #define GL_SCALE_BY_FOUR_NV               0x853F
(defconstant $GL_SCALE_BY_ONE_HALF_NV 34112)
; #define GL_SCALE_BY_ONE_HALF_NV           0x8540
(defconstant $GL_BIAS_BY_NEGATIVE_ONE_HALF_NV 34113)
; #define GL_BIAS_BY_NEGATIVE_ONE_HALF_NV   0x8541
(defconstant $GL_COMBINER_INPUT_NV 34114)
; #define GL_COMBINER_INPUT_NV              0x8542
(defconstant $GL_COMBINER_MAPPING_NV 34115)
; #define GL_COMBINER_MAPPING_NV            0x8543
(defconstant $GL_COMBINER_COMPONENT_USAGE_NV 34116)
; #define GL_COMBINER_COMPONENT_USAGE_NV    0x8544
(defconstant $GL_COMBINER_AB_DOT_PRODUCT_NV 34117)
; #define GL_COMBINER_AB_DOT_PRODUCT_NV     0x8545
(defconstant $GL_COMBINER_CD_DOT_PRODUCT_NV 34118)
; #define GL_COMBINER_CD_DOT_PRODUCT_NV     0x8546
(defconstant $GL_COMBINER_MUX_SUM_NV 34119)
; #define GL_COMBINER_MUX_SUM_NV            0x8547
(defconstant $GL_COMBINER_SCALE_NV 34120)
; #define GL_COMBINER_SCALE_NV              0x8548
(defconstant $GL_COMBINER_BIAS_NV 34121)
; #define GL_COMBINER_BIAS_NV               0x8549
(defconstant $GL_COMBINER_AB_OUTPUT_NV 34122)
; #define GL_COMBINER_AB_OUTPUT_NV          0x854A
(defconstant $GL_COMBINER_CD_OUTPUT_NV 34123)
; #define GL_COMBINER_CD_OUTPUT_NV          0x854B
(defconstant $GL_COMBINER_SUM_OUTPUT_NV 34124)
; #define GL_COMBINER_SUM_OUTPUT_NV         0x854C
(defconstant $GL_MAX_GENERAL_COMBINERS_NV 34125)
; #define GL_MAX_GENERAL_COMBINERS_NV       0x854D
(defconstant $GL_NUM_GENERAL_COMBINERS_NV 34126)
; #define GL_NUM_GENERAL_COMBINERS_NV       0x854E
(defconstant $GL_COLOR_SUM_CLAMP_NV 34127)
; #define GL_COLOR_SUM_CLAMP_NV             0x854F
(defconstant $GL_COMBINER0_NV 34128)
; #define GL_COMBINER0_NV                   0x8550
(defconstant $GL_COMBINER1_NV 34129)
; #define GL_COMBINER1_NV                   0x8551
(defconstant $GL_COMBINER2_NV 34130)
; #define GL_COMBINER2_NV                   0x8552
(defconstant $GL_COMBINER3_NV 34131)
; #define GL_COMBINER3_NV                   0x8553
(defconstant $GL_COMBINER4_NV 34132)
; #define GL_COMBINER4_NV                   0x8554
(defconstant $GL_COMBINER5_NV 34133)
; #define GL_COMBINER5_NV                   0x8555
(defconstant $GL_COMBINER6_NV 34134)
; #define GL_COMBINER6_NV                   0x8556
(defconstant $GL_COMBINER7_NV 34135)
; #define GL_COMBINER7_NV                   0x8557
;  reuse GL_TEXTURE0_ARB 
;  reuse GL_TEXTURE1_ARB 
;  reuse GL_ZERO 
;  reuse GL_NONE 
;  reuse GL_FOG 

; #endif


; #if GL_ARB_texture_mirrored_repeat
(defconstant $GL_MIRRORED_REPEAT_ARB 33648)
; #define GL_MIRRORED_REPEAT_ARB            0x8370

; #endif


; #if GL_NV_register_combiners2
(defconstant $GL_PER_STAGE_CONSTANTS_NV 34101)
; #define GL_PER_STAGE_CONSTANTS_NV         0x8535

; #endif


; #if GL_NV_fog_distance
(defconstant $GL_FOG_DISTANCE_MODE_NV 34138)
; #define GL_FOG_DISTANCE_MODE_NV           0x855A
(defconstant $GL_EYE_RADIAL_NV 34139)
; #define GL_EYE_RADIAL_NV                  0x855B
(defconstant $GL_EYE_PLANE_ABSOLUTE_NV 34140)
; #define GL_EYE_PLANE_ABSOLUTE_NV          0x855C
;  reuse GL_EYE_PLANE 

; #endif


; #if GL_NV_texgen_emboss
#| 
; #define GL_EMBOSS_LIGHT_NV                0x855D
; #define GL_EMBOSS_CONSTANT_NV             0x855E
; #define GL_EMBOSS_MAP_NV                  0x855F
 |#

; #endif


; #if GL_EXT_texture_compression_s3tc
(defconstant $GL_COMPRESSED_RGB_S3TC_DXT1_EXT 33776)
; #define GL_COMPRESSED_RGB_S3TC_DXT1_EXT   0x83F0
(defconstant $GL_COMPRESSED_RGBA_S3TC_DXT1_EXT 33777)
; #define GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  0x83F1
(defconstant $GL_COMPRESSED_RGBA_S3TC_DXT3_EXT 33778)
; #define GL_COMPRESSED_RGBA_S3TC_DXT3_EXT  0x83F2
(defconstant $GL_COMPRESSED_RGBA_S3TC_DXT5_EXT 33779)
; #define GL_COMPRESSED_RGBA_S3TC_DXT5_EXT  0x83F3

; #endif


; #if GL_EXT_texture_rectangle
(defconstant $GL_TEXTURE_RECTANGLE_EXT 34037)
; #define GL_TEXTURE_RECTANGLE_EXT          0x84F5
(defconstant $GL_TEXTURE_BINDING_RECTANGLE_EXT 34038)
; #define GL_TEXTURE_BINDING_RECTANGLE_EXT  0x84F6
(defconstant $GL_PROXY_TEXTURE_RECTANGLE_EXT 34039)
; #define GL_PROXY_TEXTURE_RECTANGLE_EXT    0x84F7
(defconstant $GL_MAX_RECTANGLE_TEXTURE_SIZE_EXT 34040)
; #define GL_MAX_RECTANGLE_TEXTURE_SIZE_EXT 0x84F8

; #endif


; #if GL_EXT_vertex_shader
#| 
; #define GL_VERTEX_SHADER_EXT              0x8780
; #define GL_VARIANT_VALUE_EXT              0x87E4
; #define GL_VARIANT_DATATYPE_EXT           0x87E5
; #define GL_VARIANT_ARRAY_STRIDE_EXT       0x87E6
; #define GL_VARIANT_ARRAY_TYPE_EXT         0x87E7
; #define GL_VARIANT_ARRAY_EXT              0x87E8
; #define GL_VARIANT_ARRAY_POINTER_EXT      0x87E9
; #define GL_INVARIANT_VALUE_EXT            0x87EA
; #define GL_INVARIANT_DATATYPE_EXT         0x87EB
; #define GL_LOCAL_CONSTANT_VALUE_EXT       0x87EC
; #define GL_LOCAL_CONSTANT_DATATYPE_EXT    0x87Ed
; #define GL_OP_INDEX_EXT                   0x8782
; #define GL_OP_NEGATE_EXT                  0x8783
; #define GL_OP_DOT3_EXT                    0x8784
; #define GL_OP_DOT4_EXT                    0x8785
; #define GL_OP_MUL_EXT                     0x8786
; #define GL_OP_ADD_EXT                     0x8787
; #define GL_OP_MADD_EXT                    0x8788
; #define GL_OP_FRAC_EXT                    0x8789
; #define GL_OP_MAX_EXT                     0x878A
; #define GL_OP_MIN_EXT                     0x878B
; #define GL_OP_SET_GE_EXT                  0x878C
; #define GL_OP_SET_LT_EXT                  0x878D
; #define GL_OP_CLAMP_EXT                   0x878E
; #define GL_OP_FLOOR_EXT                   0x878F
; #define GL_OP_ROUND_EXT                   0x8790
; #define GL_OP_EXP_BASE_2_EXT              0x8791
; #define GL_OP_LOG_BASE_2_EXT              0x8792
; #define GL_OP_POWER_EXT                   0x8793
; #define GL_OP_RECIP_EXT                   0x8794
; #define GL_OP_RECIP_SQRT_EXT              0x8795
; #define GL_OP_SUB_EXT                     0x8796
; #define GL_OP_CROSS_PRODUCT_EXT           0x8797
; #define GL_OP_MULTIPLY_MATRIX_EXT         0x8798
; #define GL_OP_MOV_EXT                     0x8799
; #define GL_OUTPUT_VERTEX_EXT              0x879A
; #define GL_OUTPUT_COLOR0_EXT              0x879B
; #define GL_OUTPUT_COLOR1_EXT              0x879C
; #define GL_OUTPUT_TEXTURE_COORD0_EXT      0x879D
; #define GL_OUTPUT_TEXTURE_COORD1_EXT      0x879E
; #define GL_OUTPUT_TEXTURE_COORD2_EXT      0x879F
; #define GL_OUTPUT_TEXTURE_COORD3_EXT      0x87A0
; #define GL_OUTPUT_TEXTURE_COORD4_EXT      0x87A1
; #define GL_OUTPUT_TEXTURE_COORD5_EXT      0x87A2
; #define GL_OUTPUT_TEXTURE_COORD6_EXT      0x87A3
; #define GL_OUTPUT_TEXTURE_COORD7_EXT      0x87A4
; #define GL_OUTPUT_TEXTURE_COORD8_EXT      0x87A5
; #define GL_OUTPUT_TEXTURE_COORD9_EXT      0x87A6
; #define GL_OUTPUT_TEXTURE_COORD10_EXT     0x87A7
; #define GL_OUTPUT_TEXTURE_COORD11_EXT     0x87A8
; #define GL_OUTPUT_TEXTURE_COORD12_EXT     0x87A9
; #define GL_OUTPUT_TEXTURE_COORD13_EXT     0x87AA
; #define GL_OUTPUT_TEXTURE_COORD14_EXT     0x87AB
; #define GL_OUTPUT_TEXTURE_COORD15_EXT     0x87AC
; #define GL_OUTPUT_TEXTURE_COORD16_EXT     0x87AD
; #define GL_OUTPUT_TEXTURE_COORD17_EXT     0x87AE
; #define GL_OUTPUT_TEXTURE_COORD18_EXT     0x87AF
; #define GL_OUTPUT_TEXTURE_COORD19_EXT     0x87B0
; #define GL_OUTPUT_TEXTURE_COORD20_EXT     0x87B1
; #define GL_OUTPUT_TEXTURE_COORD21_EXT     0x87B2
; #define GL_OUTPUT_TEXTURE_COORD22_EXT     0x87B3
; #define GL_OUTPUT_TEXTURE_COORD23_EXT     0x87B4
; #define GL_OUTPUT_TEXTURE_COORD24_EXT     0x87B5
; #define GL_OUTPUT_TEXTURE_COORD25_EXT     0x87B6
; #define GL_OUTPUT_TEXTURE_COORD26_EXT     0x87B7
; #define GL_OUTPUT_TEXTURE_COORD27_EXT     0x87B8
; #define GL_OUTPUT_TEXTURE_COORD28_EXT     0x87B9
; #define GL_OUTPUT_TEXTURE_COORD29_EXT     0x87BA
; #define GL_OUTPUT_TEXTURE_COORD30_EXT     0x87BB
; #define GL_OUTPUT_TEXTURE_COORD31_EXT     0x87BC
; #define GL_OUTPUT_FOG_EXT                 0x87BD
; #define GL_SCALAR_EXT                     0x87BE
; #define GL_VECTOR_EXT                     0x87BF
; #define GL_MATRIX_EXT                     0x87C0
; #define GL_VARIANT_EXT                    0x87C1
; #define GL_INVARIANT_EXT                  0x87C2
; #define GL_LOCAL_CONSTANT_EXT             0x87C3
; #define GL_LOCAL_EXT                      0x87C4
; #define GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT              0x87C5
; #define GL_MAX_VERTEX_SHADER_VARIANTS_EXT                  0x87C6
; #define GL_MAX_VERTEX_SHADER_INVARIANTS_EXT                0x87C7
; #define GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT           0x87C8
; #define GL_MAX_VERTEX_SHADER_LOCALS_EXT                    0x87C9
; #define GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT    0x87CA
; #define GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT        0x87CB
; #define GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT 0x87CC
; #define GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT      0x87CD
; #define GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT          0x87CE
; #define GL_VERTEX_SHADER_INSTRUCTIONS_EXT                  0x87CF
; #define GL_VERTEX_SHADER_VARIANTS_EXT                      0x87D0
; #define GL_VERTEX_SHADER_INVARIANTS_EXT                    0x87D1
; #define GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT               0x87D2
; #define GL_VERTEX_SHADER_LOCALS_EXT                        0x87D3
; #define GL_VERTEX_SHADER_BINDING_EXT                       0x8781
; #define GL_VERTEX_SHADER_OPTIMIZED_EXT                     0x87D4
; #define GL_X_EXT                          0x87D5
; #define GL_Y_EXT                          0x87D6
; #define GL_Z_EXT                          0x87D7
; #define GL_W_EXT                          0x87D8
; #define GL_NEGATIVE_X_EXT                 0x87D9
; #define GL_NEGATIVE_Y_EXT                 0x87DA
; #define GL_NEGATIVE_Z_EXT                 0x87DB
; #define GL_NEGATIVE_W_EXT                 0x87DC
; #define GL_NEGATIVE_ONE_EXT               0x87DF
; #define GL_NORMALIZED_RANGE_EXT           0x87E0
; #define GL_FULL_RANGE_EXT                 0x87E1
; #define GL_CURRENT_VERTEX_EXT             0x87E2
; #define GL_MVP_MATRIX_EXT                 0x87E3
 |#

; #endif


; #if GL_EXT_fragment_shader
#| 
; #define GL_FRAGMENT_SHADER_EXT            0x8920
; #define GL_REG_0_EXT                      0x8921
; #define GL_REG_1_EXT                      0x8922
; #define GL_REG_2_EXT                      0x8923
; #define GL_REG_3_EXT                      0x8924
; #define GL_REG_4_EXT                      0x8925
; #define GL_REG_5_EXT                      0x8926
; #define GL_REG_6_EXT                      0x8927
; #define GL_REG_7_EXT                      0x8928
; #define GL_REG_8_EXT                      0x8929
; #define GL_REG_9_EXT                      0x892A
; #define GL_REG_10_EXT                     0x892B
; #define GL_REG_11_EXT                     0x892C
; #define GL_REG_12_EXT                     0x892D
; #define GL_REG_13_EXT                     0x892E
; #define GL_REG_14_EXT                     0x892F
; #define GL_REG_15_EXT                     0x8930
; #define GL_REG_16_EXT                     0x8931
; #define GL_REG_17_EXT                     0x8932
; #define GL_REG_18_EXT                     0x8933
; #define GL_REG_19_EXT                     0x8934
; #define GL_REG_20_EXT                     0x8935
; #define GL_REG_21_EXT                     0x8936
; #define GL_REG_22_EXT                     0x8937
; #define GL_REG_23_EXT                     0x8938
; #define GL_REG_24_EXT                     0x8939
; #define GL_REG_25_EXT                     0x893A
; #define GL_REG_26_EXT                     0x893B
; #define GL_REG_27_EXT                     0x893C
; #define GL_REG_28_EXT                     0x893D
; #define GL_REG_29_EXT                     0x893E
; #define GL_REG_30_EXT                     0x893F
; #define GL_REG_31_EXT                     0x8940
; #define GL_CON_0_EXT                      0x8941
; #define GL_CON_1_EXT                      0x8942
; #define GL_CON_2_EXT                      0x8943
; #define GL_CON_3_EXT                      0x8944
; #define GL_CON_4_EXT                      0x8945
; #define GL_CON_5_EXT                      0x8946
; #define GL_CON_6_EXT                      0x8947
; #define GL_CON_7_EXT                      0x8948
; #define GL_CON_8_EXT                      0x8949
; #define GL_CON_9_EXT                      0x894A
; #define GL_CON_10_EXT                     0x894B
; #define GL_CON_11_EXT                     0x894C
; #define GL_CON_12_EXT                     0x894D
; #define GL_CON_13_EXT                     0x894E
; #define GL_CON_14_EXT                     0x894F
; #define GL_CON_15_EXT                     0x8950
; #define GL_CON_16_EXT                     0x8951
; #define GL_CON_17_EXT                     0x8952
; #define GL_CON_18_EXT                     0x8953
; #define GL_CON_19_EXT                     0x8954
; #define GL_CON_20_EXT                     0x8955
; #define GL_CON_21_EXT                     0x8956
; #define GL_CON_22_EXT                     0x8957
; #define GL_CON_23_EXT                     0x8958
; #define GL_CON_24_EXT                     0x8959
; #define GL_CON_25_EXT                     0x895A
; #define GL_CON_26_EXT                     0x895B
; #define GL_CON_27_EXT                     0x895C
; #define GL_CON_28_EXT                     0x895D
; #define GL_CON_29_EXT                     0x895E
; #define GL_CON_30_EXT                     0x895F
; #define GL_CON_31_EXT                     0x8960
; #define GL_MOV_EXT                        0x8961
; #define GL_ADD_EXT                        0x8963
; #define GL_MUL_EXT                        0x8964
; #define GL_SUB_EXT                        0x8965
; #define GL_DOT3_EXT                       0x8966
; #define GL_DOT4_EXT                       0x8967
; #define GL_MAD_EXT                        0x8968
; #define GL_LERP_EXT                       0x8969
; #define GL_CND_EXT                        0x896A
; #define GL_CND0_EXT                       0x896B
; #define GL_DOT2_ADD_EXT                   0x896C
; #define GL_SECONDARY_INTERPOLATOR_EXT     0x896D
; #define GL_NUM_FRAGMENT_REGISTERS_EXT     0x896E
; #define GL_NUM_FRAGMENT_CONSTANTS_EXT     0x896F
; #define GL_NUM_PASSES_EXT                 0x8970
; #define GL_NUM_INSTRUCTIONS_PER_PASS_EXT  0x8971
; #define GL_NUM_INSTRUCTIONS_TOTAL_EXT     0x8972
; #define GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_EXT 0x8973
; #define GL_NUM_LOOPBACK_COMPONENTS_EXT    0x8974
; #define GL_COLOR_ALPHA_PAIRING_EXT        0x8975
; #define GL_SWIZZLE_STR_EXT                0x8976
; #define GL_SWIZZLE_STQ_EXT                0x8977
; #define GL_SWIZZLE_STR_DR_EXT             0x8978
; #define GL_SWIZZLE_STQ_DQ_EXT             0x8979
; #define GL_SWIZZLE_STRQ_EXT               0x897A
; #define GL_SWIZZLE_STRQ_DQ_EXT            0x897B
; #define GL_RED_BIT_EXT                    0x00000001
; #define GL_GREEN_BIT_EXT                  0x00000002
; #define GL_BLUE_BIT_EXT                   0x00000004
; #define GL_2X_BIT_EXT                     0x00000001
; #define GL_4X_BIT_EXT                     0x00000002
; #define GL_8X_BIT_EXT                     0x00000004
; #define GL_HALF_BIT_EXT                   0x00000008
; #define GL_QUARTER_BIT_EXT                0x00000010
; #define GL_EIGHTH_BIT_EXT                 0x00000020
; #define GL_SATURATE_BIT_EXT               0x00000040
; #define GL_COMP_BIT_EXT                   0x00000002
; #define GL_NEGATE_BIT_EXT                 0x00000004
; #define GL_BIAS_BIT_EXT                   0x00000008
 |#

; #endif


; #if GL_IBM_cull_vertex
#| 
; #define GL_CULL_VERTEX_IBM                103050
 |#

; #endif


; #if GL_IBM_vertex_array_lists
#| 
; #define GL_VERTEX_ARRAY_LIST_IBM          103070
; #define GL_NORMAL_ARRAY_LIST_IBM          103071
; #define GL_COLOR_ARRAY_LIST_IBM           103072
; #define GL_INDEX_ARRAY_LIST_IBM           103073
; #define GL_TEXTURE_COORD_ARRAY_LIST_IBM   103074
; #define GL_EDGE_FLAG_ARRAY_LIST_IBM       103075
; #define GL_FOG_COORDINATE_ARRAY_LIST_IBM  103076
; #define GL_SECONDARY_COLOR_ARRAY_LIST_IBM 103077
; #define GL_VERTEX_ARRAY_LIST_STRIDE_IBM   103080
; #define GL_NORMAL_ARRAY_LIST_STRIDE_IBM   103081
; #define GL_COLOR_ARRAY_LIST_STRIDE_IBM    103082
; #define GL_INDEX_ARRAY_LIST_STRIDE_IBM    103083
; #define GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM 103084
; #define GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM 103085
; #define GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM 103086
; #define GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM 103087
 |#

; #endif


; #if GL_SGIX_subsample
#| 
; #define GL_PACK_SUBSAMPLE_RATE_SGIX       0x85A0
; #define GL_UNPACK_SUBSAMPLE_RATE_SGIX     0x85A1
; #define GL_PIXEL_SUBSAMPLE_4444_SGIX      0x85A2
; #define GL_PIXEL_SUBSAMPLE_2424_SGIX      0x85A3
; #define GL_PIXEL_SUBSAMPLE_4242_SGIX      0x85A4
 |#

; #endif


; #if GL_SGIX_ycrcba
#| 
; #define GL_YCRCB_SGIX                     0x8318
; #define GL_YCRCBA_SGIX                    0x8319
 |#

; #endif


; #if GL_SGI_depth_pass_instrument
#| 
; #define GL_DEPTH_PASS_INSTRUMENT_SGIX     0x8310
; #define GL_DEPTH_PASS_INSTRUMENT_COUNTERS_SGIX 0x8311
; #define GL_DEPTH_PASS_INSTRUMENT_MAX_SGIX 0x8312
 |#

; #endif


; #if GL_3DFX_texture_compression_FXT1
#| 
; #define GL_COMPRESSED_RGB_FXT1_3DFX       0x86B0
; #define GL_COMPRESSED_RGBA_FXT1_3DFX      0x86B1
 |#

; #endif


; #if GL_3DFX_multisample
#| 
; #define GL_MULTISAMPLE_3DFX               0x86B2
; #define GL_SAMPLE_BUFFERS_3DFX            0x86B3
; #define GL_SAMPLES_3DFX                   0x86B4
; #define GL_MULTISAMPLE_BIT_3DFX           0x20000000
 |#

; #endif


; #if GL_EXT_multisample
#| 
; #define GL_MULTISAMPLE_EXT                0x809D
; #define GL_SAMPLE_ALPHA_TO_MASK_EXT       0x809E
; #define GL_SAMPLE_ALPHA_TO_ONE_EXT        0x809F
; #define GL_SAMPLE_MASK_EXT                0x80A0
; #define GL_1PASS_EXT                      0x80A1
; #define GL_2PASS_0_EXT                    0x80A2
; #define GL_2PASS_1_EXT                    0x80A3
; #define GL_4PASS_0_EXT                    0x80A4
; #define GL_4PASS_1_EXT                    0x80A5
; #define GL_4PASS_2_EXT                    0x80A6
; #define GL_4PASS_3_EXT                    0x80A7
; #define GL_SAMPLE_BUFFERS_EXT             0x80A8
; #define GL_SAMPLES_EXT                    0x80A9
; #define GL_SAMPLE_MASK_VALUE_EXT          0x80AA
; #define GL_SAMPLE_MASK_INVERT_EXT         0x80AB
; #define GL_SAMPLE_PATTERN_EXT             0x80AC
 |#

; #endif


; #if GL_SGIX_vertex_preclip
#| 
; #define GL_VERTEX_PRECLIP_SGIX            0x83EE
; #define GL_VERTEX_PRECLIP_HINT_SGIX       0x83EF
 |#

; #endif


; #if GL_SGIX_convolution_accuracy
#| 
; #define GL_CONVOLUTION_HINT_SGIX          0x8316
 |#

; #endif


; #if GL_SGIX_resample
#| 
; #define GL_PACK_RESAMPLE_SGIX             0x842C
; #define GL_UNPACK_RESAMPLE_SGIX           0x842D
; #define GL_RESAMPLE_REPLICATE_SGIX        0x842E
; #define GL_RESAMPLE_ZERO_FILL_SGIX        0x842F
; #define GL_RESAMPLE_DECIMATE_SGIX         0x8430
 |#

; #endif


; #if GL_SGIS_point_line_texgen
#| 
; #define GL_EYE_DISTANCE_TO_POINT_SGIS     0x81F0
; #define GL_OBJECT_DISTANCE_TO_POINT_SGIS  0x81F1
; #define GL_EYE_DISTANCE_TO_LINE_SGIS      0x81F2
; #define GL_OBJECT_DISTANCE_TO_LINE_SGIS   0x81F3
; #define GL_EYE_POINT_SGIS                 0x81F4
; #define GL_OBJECT_POINT_SGIS              0x81F5
; #define GL_EYE_LINE_SGIS                  0x81F6
; #define GL_OBJECT_LINE_SGIS               0x81F7
 |#

; #endif


; #if GL_SGIS_texture_color_mask
#| 
; #define GL_TEXTURE_COLOR_WRITEMASK_SGIS   0x81EF
 |#

; #endif


; #if GL_NV_vertex_program
#| 
; #define GL_VERTEX_PROGRAM_NV              0x8620
; #define GL_VERTEX_STATE_PROGRAM_NV        0x8621
; #define GL_ATTRIB_ARRAY_SIZE_NV           0x8623
; #define GL_ATTRIB_ARRAY_STRIDE_NV         0x8624
; #define GL_ATTRIB_ARRAY_TYPE_NV           0x8625
; #define GL_CURRENT_ATTRIB_NV              0x8626
; #define GL_PROGRAM_LENGTH_NV              0x8627
; #define GL_PROGRAM_STRING_NV              0x8628
; #define GL_MODELVIEW_PROJECTION_NV        0x8629
; #define GL_IDENTITY_NV                    0x862A
; #define GL_INVERSE_NV                     0x862B
; #define GL_TRANSPOSE_NV                   0x862C
; #define GL_INVERSE_TRANSPOSE_NV           0x862D
; #define GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV 0x862E
; #define GL_MAX_TRACK_MATRICES_NV          0x862F
; #define GL_MATRIX0_NV                     0x8630
; #define GL_MATRIX1_NV                     0x8631
; #define GL_MATRIX2_NV                     0x8632
; #define GL_MATRIX3_NV                     0x8633
; #define GL_MATRIX4_NV                     0x8634
; #define GL_MATRIX5_NV                     0x8635
; #define GL_MATRIX6_NV                     0x8636
; #define GL_MATRIX7_NV                     0x8637
; #define GL_CURRENT_MATRIX_STACK_DEPTH_NV  0x8640
; #define GL_CURRENT_MATRIX_NV              0x8641
; #define GL_VERTEX_PROGRAM_POINT_SIZE_NV   0x8642
; #define GL_VERTEX_PROGRAM_TWO_SIDE_NV     0x8643
; #define GL_PROGRAM_PARAMETER_NV           0x8644
; #define GL_ATTRIBUTE_ARRAY_POINTER_NV     0x8645
; #define GL_PROGRAM_TARGET_NV              0x8646
; #define GL_PROGRAM_RESIDENT_NV            0x8647
; #define GL_TRACK_MATRIX_NV                0x8648
; #define GL_TRACK_MATRIX_TRANSFORM_NV      0x8649
; #define GL_VERTEX_PROGRAM_BINDING_NV      0x864A
; #define GL_PROGRAM_ERROR_POSITION_NV      0x864B
; #define GL_VERTEX_ATTRIB_ARRAY0_NV        0x8650
; #define GL_VERTEX_ATTRIB_ARRAY1_NV        0x8651
; #define GL_VERTEX_ATTRIB_ARRAY2_NV        0x8652
; #define GL_VERTEX_ATTRIB_ARRAY3_NV        0x8653
; #define GL_VERTEX_ATTRIB_ARRAY4_NV        0x8654
; #define GL_VERTEX_ATTRIB_ARRAY5_NV        0x8655
; #define GL_VERTEX_ATTRIB_ARRAY6_NV        0x8656
; #define GL_VERTEX_ATTRIB_ARRAY7_NV        0x8657
; #define GL_VERTEX_ATTRIB_ARRAY8_NV        0x8658
; #define GL_VERTEX_ATTRIB_ARRAY9_NV        0x8659
; #define GL_VERTEX_ATTRIB_ARRAY10_NV       0x865A
; #define GL_VERTEX_ATTRIB_ARRAY11_NV       0x865B
; #define GL_VERTEX_ATTRIB_ARRAY12_NV       0x865C
; #define GL_VERTEX_ATTRIB_ARRAY13_NV       0x865D
; #define GL_VERTEX_ATTRIB_ARRAY14_NV       0x865E
; #define GL_VERTEX_ATTRIB_ARRAY15_NV       0x865F
; #define GL_MAP1_VERTEX_ATTRIB0_4_NV       0x8660
; #define GL_MAP1_VERTEX_ATTRIB1_4_NV       0x8661
; #define GL_MAP1_VERTEX_ATTRIB2_4_NV       0x8662
; #define GL_MAP1_VERTEX_ATTRIB3_4_NV       0x8663
; #define GL_MAP1_VERTEX_ATTRIB4_4_NV       0x8664
; #define GL_MAP1_VERTEX_ATTRIB5_4_NV       0x8665
; #define GL_MAP1_VERTEX_ATTRIB6_4_NV       0x8666
; #define GL_MAP1_VERTEX_ATTRIB7_4_NV       0x8667
; #define GL_MAP1_VERTEX_ATTRIB8_4_NV       0x8668
; #define GL_MAP1_VERTEX_ATTRIB9_4_NV       0x8669
; #define GL_MAP1_VERTEX_ATTRIB10_4_NV      0x866A
; #define GL_MAP1_VERTEX_ATTRIB11_4_NV      0x866B
; #define GL_MAP1_VERTEX_ATTRIB12_4_NV      0x866C
; #define GL_MAP1_VERTEX_ATTRIB13_4_NV      0x866D
; #define GL_MAP1_VERTEX_ATTRIB14_4_NV      0x866E
; #define GL_MAP1_VERTEX_ATTRIB15_4_NV      0x866F
; #define GL_MAP2_VERTEX_ATTRIB0_4_NV       0x8670
; #define GL_MAP2_VERTEX_ATTRIB1_4_NV       0x8671
; #define GL_MAP2_VERTEX_ATTRIB2_4_NV       0x8672
; #define GL_MAP2_VERTEX_ATTRIB3_4_NV       0x8673
; #define GL_MAP2_VERTEX_ATTRIB4_4_NV       0x8674
; #define GL_MAP2_VERTEX_ATTRIB5_4_NV       0x8675
; #define GL_MAP2_VERTEX_ATTRIB6_4_NV       0x8676
; #define GL_MAP2_VERTEX_ATTRIB7_4_NV       0x8677
; #define GL_MAP2_VERTEX_ATTRIB8_4_NV       0x8678
; #define GL_MAP2_VERTEX_ATTRIB9_4_NV       0x8679
; #define GL_MAP2_VERTEX_ATTRIB10_4_NV      0x867A
; #define GL_MAP2_VERTEX_ATTRIB11_4_NV      0x867B
; #define GL_MAP2_VERTEX_ATTRIB12_4_NV      0x867C
; #define GL_MAP2_VERTEX_ATTRIB13_4_NV      0x867D
; #define GL_MAP2_VERTEX_ATTRIB14_4_NV      0x867E
; #define GL_MAP2_VERTEX_ATTRIB15_4_NV      0x867F
 |#

; #endif


; #if GL_ARB_texture_env_dot3
(defconstant $GL_DOT3_RGB_ARB 34478)
; #define GL_DOT3_RGB_ARB                   0x86AE
(defconstant $GL_DOT3_RGBA_ARB 34479)
; #define GL_DOT3_RGBA_ARB                  0x86AF

; #endif


; #if GL_ARB_point_parameters
(defconstant $GL_POINT_SIZE_MIN_ARB 33062)
; #define GL_POINT_SIZE_MIN_ARB                            0x8126
(defconstant $GL_POINT_SIZE_MAX_ARB 33063)
; #define GL_POINT_SIZE_MAX_ARB                            0x8127
(defconstant $GL_POINT_FADE_THRESHOLD_SIZE_ARB 33064)
; #define GL_POINT_FADE_THRESHOLD_SIZE_ARB                 0x8128
(defconstant $GL_POINT_DISTANCE_ATTENUATION_ARB 33065)
; #define GL_POINT_DISTANCE_ATTENUATION_ARB                0x8129

; #endif


; #if GL_ATI_texture_mirror_once
(defconstant $GL_MIRROR_CLAMP_ATI 34626)
; #define GL_MIRROR_CLAMP_ATI                             0x8742
(defconstant $GL_MIRROR_CLAMP_TO_EDGE_ATI 34627)
; #define GL_MIRROR_CLAMP_TO_EDGE_ATI                     0x8743

; #endif


; #if GL_ATI_pn_triangles
(defconstant $GL_PN_TRIANGLES_ATI 24720)
; #define GL_PN_TRIANGLES_ATI                             0x6090
(defconstant $GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI 24721)
; #define GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI       0x6091
(defconstant $GL_PN_TRIANGLES_POINT_MODE_ATI 24722)
; #define GL_PN_TRIANGLES_POINT_MODE_ATI                  0x6092
(defconstant $GL_PN_TRIANGLES_NORMAL_MODE_ATI 24723)
; #define GL_PN_TRIANGLES_NORMAL_MODE_ATI                 0x6093
(defconstant $GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI 24724)
; #define GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI           0x6094
(defconstant $GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI 24725)
; #define GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI           0x6095
(defconstant $GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI 24726)
; #define GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI            0x6096
(defconstant $GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI 24727)
; #define GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI          0x6097
(defconstant $GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI 24728)
; #define GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI       0x6098

; #endif


; #if GL_ATIX_pn_triangles
(defconstant $GL_PN_TRIANGLES_ATIX 24720)
; #define GL_PN_TRIANGLES_ATIX                            0x6090
(defconstant $GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATIX 24721)
; #define GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATIX      0x6091
(defconstant $GL_PN_TRIANGLES_POINT_MODE_ATIX 24722)
; #define GL_PN_TRIANGLES_POINT_MODE_ATIX                 0x6092
(defconstant $GL_PN_TRIANGLES_NORMAL_MODE_ATIX 24723)
; #define GL_PN_TRIANGLES_NORMAL_MODE_ATIX                0x6093
(defconstant $GL_PN_TRIANGLES_TESSELATION_LEVEL_ATIX 24724)
; #define GL_PN_TRIANGLES_TESSELATION_LEVEL_ATIX          0x6094
(defconstant $GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATIX 24725)
; #define GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATIX          0x6095
(defconstant $GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATIX 24726)
; #define GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATIX           0x6096
(defconstant $GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATIX 24727)
; #define GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATIX         0x6097
(defconstant $GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATIX 24728)
; #define GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATIX      0x6098

; #endif


; #if GL_ATI_text_fragment_shader
(defconstant $GL_TEXT_FRAGMENT_SHADER_ATI 33280)
; #define GL_TEXT_FRAGMENT_SHADER_ATI                     0x8200

; #endif


; #if GL_ATI_blend_equation_separate
(defconstant $GL_ALPHA_BLEND_EQUATION_ATI 34877)
; #define GL_ALPHA_BLEND_EQUATION_ATI                     0x883D

; #endif


; #if GL_ARB_fragment_program
(defconstant $GL_FRAGMENT_PROGRAM_ARB 34820)
; #define GL_FRAGMENT_PROGRAM_ARB                         0x8804
(defconstant $GL_PROGRAM_ALU_INSTRUCTIONS_ARB 34821)
; #define GL_PROGRAM_ALU_INSTRUCTIONS_ARB                 0x8805
(defconstant $GL_PROGRAM_TEX_INSTRUCTIONS_ARB 34822)
; #define GL_PROGRAM_TEX_INSTRUCTIONS_ARB                 0x8806
(defconstant $GL_PROGRAM_TEX_INDIRECTIONS_ARB 34823)
; #define GL_PROGRAM_TEX_INDIRECTIONS_ARB                 0x8807
(defconstant $GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB 34824)
; #define GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB          0x8808
(defconstant $GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB 34825)
; #define GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB          0x8809
(defconstant $GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB 34826)
; #define GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB          0x880A
(defconstant $GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB 34827)
; #define GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB             0x880B
(defconstant $GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB 34828)
; #define GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB             0x880C
(defconstant $GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB 34829)
; #define GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB             0x880D
(defconstant $GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB 34830)
; #define GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB      0x880E
(defconstant $GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB 34831)
; #define GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB      0x880F
(defconstant $GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB 34832)
; #define GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB      0x8810
(defconstant $GL_MAX_TEXTURE_COORDS_ARB 34929)
; #define GL_MAX_TEXTURE_COORDS_ARB                       0x8871
(defconstant $GL_MAX_TEXTURE_IMAGE_UNITS_ARB 34930)
; #define GL_MAX_TEXTURE_IMAGE_UNITS_ARB                  0x8872

; #endif


; #if GL_ARB_vertex_program
(defconstant $GL_VERTEX_PROGRAM_ARB 34336)
; #define GL_VERTEX_PROGRAM_ARB                            0x8620
(defconstant $GL_VERTEX_PROGRAM_POINT_SIZE_ARB 34370)
; #define GL_VERTEX_PROGRAM_POINT_SIZE_ARB                 0x8642
(defconstant $GL_VERTEX_PROGRAM_TWO_SIDE_ARB 34371)
; #define GL_VERTEX_PROGRAM_TWO_SIDE_ARB                   0x8643
(defconstant $GL_PROGRAM_FORMAT_ASCII_ARB 34933)
; #define GL_PROGRAM_FORMAT_ASCII_ARB                      0x8875
(defconstant $GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB 34338)
; #define GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB               0x8622
(defconstant $GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB 34339)
; #define GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB                  0x8623
(defconstant $GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB 34340)
; #define GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB                0x8624
(defconstant $GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB 34341)
; #define GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB                  0x8625
(defconstant $GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB 34922)
; #define GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB            0x886A
(defconstant $GL_CURRENT_VERTEX_ATTRIB_ARB 34342)
; #define GL_CURRENT_VERTEX_ATTRIB_ARB                     0x8626
(defconstant $GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB 34373)
; #define GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB               0x8645
(defconstant $GL_PROGRAM_LENGTH_ARB 34343)
; #define GL_PROGRAM_LENGTH_ARB                            0x8627
(defconstant $GL_PROGRAM_FORMAT_ARB 34934)
; #define GL_PROGRAM_FORMAT_ARB                            0x8876
(defconstant $GL_PROGRAM_NAME_ARB 34423)
; #define GL_PROGRAM_NAME_ARB                              0x8677
(defconstant $GL_PROGRAM_BINDING_ARB 34423)
; #define GL_PROGRAM_BINDING_ARB                           0x8677
(defconstant $GL_PROGRAM_INSTRUCTIONS_ARB 34976)
; #define GL_PROGRAM_INSTRUCTIONS_ARB                      0x88A0
(defconstant $GL_MAX_PROGRAM_INSTRUCTIONS_ARB 34977)
; #define GL_MAX_PROGRAM_INSTRUCTIONS_ARB                  0x88A1
(defconstant $GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB 34978)
; #define GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB               0x88A2
(defconstant $GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB 34979)
; #define GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB           0x88A3
(defconstant $GL_PROGRAM_TEMPORARIES_ARB 34980)
; #define GL_PROGRAM_TEMPORARIES_ARB                       0x88A4
(defconstant $GL_MAX_PROGRAM_TEMPORARIES_ARB 34981)
; #define GL_MAX_PROGRAM_TEMPORARIES_ARB                   0x88A5
(defconstant $GL_PROGRAM_NATIVE_TEMPORARIES_ARB 34982)
; #define GL_PROGRAM_NATIVE_TEMPORARIES_ARB                0x88A6
(defconstant $GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB 34983)
; #define GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB            0x88A7
(defconstant $GL_PROGRAM_PARAMETERS_ARB 34984)
; #define GL_PROGRAM_PARAMETERS_ARB                        0x88A8
(defconstant $GL_MAX_PROGRAM_PARAMETERS_ARB 34985)
; #define GL_MAX_PROGRAM_PARAMETERS_ARB                    0x88A9
(defconstant $GL_PROGRAM_NATIVE_PARAMETERS_ARB 34986)
; #define GL_PROGRAM_NATIVE_PARAMETERS_ARB                 0x88AA
(defconstant $GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB 34987)
; #define GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB             0x88AB
(defconstant $GL_PROGRAM_ATTRIBS_ARB 34988)
; #define GL_PROGRAM_ATTRIBS_ARB                           0x88AC
(defconstant $GL_MAX_PROGRAM_ATTRIBS_ARB 34989)
; #define GL_MAX_PROGRAM_ATTRIBS_ARB                       0x88AD
(defconstant $GL_PROGRAM_NATIVE_ATTRIBS_ARB 34990)
; #define GL_PROGRAM_NATIVE_ATTRIBS_ARB                    0x88AE
(defconstant $GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB 34991)
; #define GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB                0x88AF
(defconstant $GL_PROGRAM_ADDRESS_REGISTERS_ARB 34992)
; #define GL_PROGRAM_ADDRESS_REGISTERS_ARB                 0x88B0
(defconstant $GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB 34993)
; #define GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB             0x88B1
(defconstant $GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB 34994)
; #define GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB          0x88B2
(defconstant $GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB 34995)
; #define GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB      0x88B3
(defconstant $GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB 34996)
; #define GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB              0x88B4
(defconstant $GL_MAX_PROGRAM_ENV_PARAMETERS_ARB 34997)
; #define GL_MAX_PROGRAM_ENV_PARAMETERS_ARB                0x88B5
(defconstant $GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB 34998)
; #define GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB               0x88B6
(defconstant $GL_PROGRAM_STRING_ARB 34344)
; #define GL_PROGRAM_STRING_ARB                            0x8628
(defconstant $GL_PROGRAM_ERROR_POSITION_ARB 34379)
; #define GL_PROGRAM_ERROR_POSITION_ARB                    0x864B
(defconstant $GL_CURRENT_MATRIX_ARB 34369)
; #define GL_CURRENT_MATRIX_ARB                            0x8641
(defconstant $GL_TRANSPOSE_CURRENT_MATRIX_ARB 34999)
; #define GL_TRANSPOSE_CURRENT_MATRIX_ARB                  0x88B7
(defconstant $GL_CURRENT_MATRIX_STACK_DEPTH_ARB 34368)
; #define GL_CURRENT_MATRIX_STACK_DEPTH_ARB                0x8640
(defconstant $GL_MAX_VERTEX_ATTRIBS_ARB 34921)
; #define GL_MAX_VERTEX_ATTRIBS_ARB                        0x8869
(defconstant $GL_MAX_PROGRAM_MATRICES_ARB 34351)
; #define GL_MAX_PROGRAM_MATRICES_ARB                      0x862F
(defconstant $GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB 34350)
; #define GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB            0x862E
(defconstant $GL_PROGRAM_ERROR_STRING_ARB 34932)
; #define GL_PROGRAM_ERROR_STRING_ARB                      0x8874
(defconstant $GL_MATRIX0_ARB 35008)
; #define GL_MATRIX0_ARB                                   0x88C0
(defconstant $GL_MATRIX1_ARB 35009)
; #define GL_MATRIX1_ARB                                   0x88C1
(defconstant $GL_MATRIX2_ARB 35010)
; #define GL_MATRIX2_ARB                                   0x88C2
(defconstant $GL_MATRIX3_ARB 35011)
; #define GL_MATRIX3_ARB                                   0x88C3
(defconstant $GL_MATRIX4_ARB 35012)
; #define GL_MATRIX4_ARB                                   0x88C4
(defconstant $GL_MATRIX5_ARB 35013)
; #define GL_MATRIX5_ARB                                   0x88C5
(defconstant $GL_MATRIX6_ARB 35014)
; #define GL_MATRIX6_ARB                                   0x88C6
(defconstant $GL_MATRIX7_ARB 35015)
; #define GL_MATRIX7_ARB                                   0x88C7
(defconstant $GL_MATRIX8_ARB 35016)
; #define GL_MATRIX8_ARB                                   0x88C8
(defconstant $GL_MATRIX9_ARB 35017)
; #define GL_MATRIX9_ARB                                   0x88C9
(defconstant $GL_MATRIX10_ARB 35018)
; #define GL_MATRIX10_ARB                                  0x88CA
(defconstant $GL_MATRIX11_ARB 35019)
; #define GL_MATRIX11_ARB                                  0x88CB
(defconstant $GL_MATRIX12_ARB 35020)
; #define GL_MATRIX12_ARB                                  0x88CC
(defconstant $GL_MATRIX13_ARB 35021)
; #define GL_MATRIX13_ARB                                  0x88CD
(defconstant $GL_MATRIX14_ARB 35022)
; #define GL_MATRIX14_ARB                                  0x88CE
(defconstant $GL_MATRIX15_ARB 35023)
; #define GL_MATRIX15_ARB                                  0x88CF
(defconstant $GL_MATRIX16_ARB 35024)
; #define GL_MATRIX16_ARB                                  0x88D0
(defconstant $GL_MATRIX17_ARB 35025)
; #define GL_MATRIX17_ARB                                  0x88D1
(defconstant $GL_MATRIX18_ARB 35026)
; #define GL_MATRIX18_ARB                                  0x88D2
(defconstant $GL_MATRIX19_ARB 35027)
; #define GL_MATRIX19_ARB                                  0x88D3
(defconstant $GL_MATRIX20_ARB 35028)
; #define GL_MATRIX20_ARB                                  0x88D4
(defconstant $GL_MATRIX21_ARB 35029)
; #define GL_MATRIX21_ARB                                  0x88D5
(defconstant $GL_MATRIX22_ARB 35030)
; #define GL_MATRIX22_ARB                                  0x88D6
(defconstant $GL_MATRIX23_ARB 35031)
; #define GL_MATRIX23_ARB                                  0x88D7
(defconstant $GL_MATRIX24_ARB 35032)
; #define GL_MATRIX24_ARB                                  0x88D8
(defconstant $GL_MATRIX25_ARB 35033)
; #define GL_MATRIX25_ARB                                  0x88D9
(defconstant $GL_MATRIX26_ARB 35034)
; #define GL_MATRIX26_ARB                                  0x88DA
(defconstant $GL_MATRIX27_ARB 35035)
; #define GL_MATRIX27_ARB                                  0x88DB
(defconstant $GL_MATRIX28_ARB 35036)
; #define GL_MATRIX28_ARB                                  0x88DC
(defconstant $GL_MATRIX29_ARB 35037)
; #define GL_MATRIX29_ARB                                  0x88DD
(defconstant $GL_MATRIX30_ARB 35038)
; #define GL_MATRIX30_ARB                                  0x88DE
(defconstant $GL_MATRIX31_ARB 35039)
; #define GL_MATRIX31_ARB                                  0x88DF
(defconstant $GL_COLOR_SUM_ARB 33880)
; #define GL_COLOR_SUM_ARB                                 0x8458

; #endif


; #if GL_APPLE_vertex_program_evaluators
(defconstant $GL_VERTEX_ATTRIB_MAP1_APPLE 35328)
; #define GL_VERTEX_ATTRIB_MAP1_APPLE                      0x8A00
(defconstant $GL_VERTEX_ATTRIB_MAP2_APPLE 35329)
; #define GL_VERTEX_ATTRIB_MAP2_APPLE                      0x8A01
(defconstant $GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE 35330)
; #define GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE                 0x8A02
(defconstant $GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE 35331)
; #define GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE                0x8A03
(defconstant $GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE 35332)
; #define GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE                0x8A04
(defconstant $GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE 35333)
; #define GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE               0x8A05
(defconstant $GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE 35334)
; #define GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE                 0x8A06
(defconstant $GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE 35335)
; #define GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE                0x8A07
(defconstant $GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE 35336)
; #define GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE                0x8A08
(defconstant $GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE 35337)
; #define GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE               0x8A09

; #endif


; #if GL_NV_texture_shader
(defconstant $GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV 34521)
; #define GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV          0x86D9
(defconstant $GL_UNSIGNED_INT_S8_S8_8_8_NV 34522)
; #define GL_UNSIGNED_INT_S8_S8_8_8_NV                     0x86DA
(defconstant $GL_UNSIGNED_INT_8_8_S8_S8_REV_NV 34523)
; #define GL_UNSIGNED_INT_8_8_S8_S8_REV_NV                 0x86DB
(defconstant $GL_DSDT_MAG_INTENSITY_NV 34524)
; #define GL_DSDT_MAG_INTENSITY_NV                         0x86DC
(defconstant $GL_TEXTURE_SHADER_NV 34526)
; #define GL_TEXTURE_SHADER_NV                             0x86DE
(defconstant $GL_SHADER_OPERATION_NV 34527)
; #define GL_SHADER_OPERATION_NV                           0x86DF
(defconstant $GL_CULL_MODES_NV 34528)
; #define GL_CULL_MODES_NV                                 0x86E0
(defconstant $GL_OFFSET_TEXTURE_MATRIX_NV 34529)
; #define GL_OFFSET_TEXTURE_MATRIX_NV                      0x86E1
(defconstant $GL_OFFSET_TEXTURE_SCALE_NV 34530)
; #define GL_OFFSET_TEXTURE_SCALE_NV                       0x86E2
(defconstant $GL_OFFSET_TEXTURE_BIAS_NV 34531)
; #define GL_OFFSET_TEXTURE_BIAS_NV                        0x86E3
; #define GL_OFFSET_TEXTURE_2D_MATRIX_NV                   GL_OFFSET_TEXTURE_MATRIX_NV
; #define GL_OFFSET_TEXTURE_2D_SCALE_NV                    GL_OFFSET_TEXTURE_SCALE_NV
; #define GL_OFFSET_TEXTURE_2D_BIAS_NV                     GL_OFFSET_TEXTURE_BIAS_NV
(defconstant $GL_PREVIOUS_TEXTURE_INPUT_NV 34532)
; #define GL_PREVIOUS_TEXTURE_INPUT_NV                     0x86E4
(defconstant $GL_CONST_EYE_NV 34533)
; #define GL_CONST_EYE_NV                                  0x86E5
(defconstant $GL_SHADER_CONSISTENT_NV 34525)
; #define GL_SHADER_CONSISTENT_NV                          0x86DD
(defconstant $GL_PASS_THROUGH_NV 34534)
; #define GL_PASS_THROUGH_NV                               0x86E6
(defconstant $GL_CULL_FRAGMENT_NV 34535)
; #define GL_CULL_FRAGMENT_NV                              0x86E7
(defconstant $GL_OFFSET_TEXTURE_2D_NV 34536)
; #define GL_OFFSET_TEXTURE_2D_NV                          0x86E8
(defconstant $GL_OFFSET_TEXTURE_RECTANGLE_NV 34380)
; #define GL_OFFSET_TEXTURE_RECTANGLE_NV                   0x864C
(defconstant $GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV 34381)
; #define GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV             0x864D
(defconstant $GL_DEPENDENT_AR_TEXTURE_2D_NV 34537)
; #define GL_DEPENDENT_AR_TEXTURE_2D_NV                    0x86E9
(defconstant $GL_DEPENDENT_GB_TEXTURE_2D_NV 34538)
; #define GL_DEPENDENT_GB_TEXTURE_2D_NV                    0x86EA
(defconstant $GL_DOT_PRODUCT_NV 34540)
; #define GL_DOT_PRODUCT_NV                                0x86EC
(defconstant $GL_DOT_PRODUCT_DEPTH_REPLACE_NV 34541)
; #define GL_DOT_PRODUCT_DEPTH_REPLACE_NV                  0x86ED
(defconstant $GL_DOT_PRODUCT_TEXTURE_2D_NV 34542)
; #define GL_DOT_PRODUCT_TEXTURE_2D_NV                     0x86EE
(defconstant $GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV 34382)
; #define GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV              0x864E
(defconstant $GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV 34544)
; #define GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV               0x86F0
(defconstant $GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV 34545)
; #define GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV               0x86F1
(defconstant $GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV 34546)
; #define GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV               0x86F2
(defconstant $GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV 34547)
; #define GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV     0x86F3
(defconstant $GL_HILO_NV 34548)
; #define GL_HILO_NV                                       0x86F4
(defconstant $GL_DSDT_NV 34549)
; #define GL_DSDT_NV                                       0x86F5
(defconstant $GL_DSDT_MAG_NV 34550)
; #define GL_DSDT_MAG_NV                                   0x86F6
(defconstant $GL_DSDT_MAG_VIB_NV 34551)
; #define GL_DSDT_MAG_VIB_NV                               0x86F7
(defconstant $GL_HILO16_NV 34552)
; #define GL_HILO16_NV                                     0x86F8
(defconstant $GL_SIGNED_HILO_NV 34553)
; #define GL_SIGNED_HILO_NV                                0x86F9
(defconstant $GL_SIGNED_HILO16_NV 34554)
; #define GL_SIGNED_HILO16_NV                              0x86FA
(defconstant $GL_SIGNED_RGBA_NV 34555)
; #define GL_SIGNED_RGBA_NV                                0x86FB
(defconstant $GL_SIGNED_RGBA8_NV 34556)
; #define GL_SIGNED_RGBA8_NV                               0x86FC
(defconstant $GL_SIGNED_RGB_NV 34558)
; #define GL_SIGNED_RGB_NV                                 0x86FE
(defconstant $GL_SIGNED_RGB8_NV 34559)
; #define GL_SIGNED_RGB8_NV                                0x86FF
(defconstant $GL_SIGNED_LUMINANCE_NV 34561)
; #define GL_SIGNED_LUMINANCE_NV                           0x8701
(defconstant $GL_SIGNED_LUMINANCE8_NV 34562)
; #define GL_SIGNED_LUMINANCE8_NV                          0x8702
(defconstant $GL_SIGNED_LUMINANCE_ALPHA_NV 34563)
; #define GL_SIGNED_LUMINANCE_ALPHA_NV                     0x8703
(defconstant $GL_SIGNED_LUMINANCE8_ALPHA8_NV 34564)
; #define GL_SIGNED_LUMINANCE8_ALPHA8_NV                   0x8704
(defconstant $GL_SIGNED_ALPHA_NV 34565)
; #define GL_SIGNED_ALPHA_NV                               0x8705
(defconstant $GL_SIGNED_ALPHA8_NV 34566)
; #define GL_SIGNED_ALPHA8_NV                              0x8706
(defconstant $GL_SIGNED_INTENSITY_NV 34567)
; #define GL_SIGNED_INTENSITY_NV                           0x8707
(defconstant $GL_SIGNED_INTENSITY8_NV 34568)
; #define GL_SIGNED_INTENSITY8_NV                          0x8708
(defconstant $GL_DSDT8_NV 34569)
; #define GL_DSDT8_NV                                      0x8709
(defconstant $GL_DSDT8_MAG8_NV 34570)
; #define GL_DSDT8_MAG8_NV                                 0x870A
(defconstant $GL_DSDT8_MAG8_INTENSITY8_NV 34571)
; #define GL_DSDT8_MAG8_INTENSITY8_NV                      0x870B
(defconstant $GL_SIGNED_RGB_UNSIGNED_ALPHA_NV 34572)
; #define GL_SIGNED_RGB_UNSIGNED_ALPHA_NV                  0x870C
(defconstant $GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV 34573)
; #define GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV                0x870D
(defconstant $GL_HI_SCALE_NV 34574)
; #define GL_HI_SCALE_NV                                   0x870E
(defconstant $GL_LO_SCALE_NV 34575)
; #define GL_LO_SCALE_NV                                   0x870F
(defconstant $GL_DS_SCALE_NV 34576)
; #define GL_DS_SCALE_NV                                   0x8710
(defconstant $GL_DT_SCALE_NV 34577)
; #define GL_DT_SCALE_NV                                   0x8711
(defconstant $GL_MAGNITUDE_SCALE_NV 34578)
; #define GL_MAGNITUDE_SCALE_NV                            0x8712
(defconstant $GL_VIBRANCE_SCALE_NV 34579)
; #define GL_VIBRANCE_SCALE_NV                             0x8713
(defconstant $GL_HI_BIAS_NV 34580)
; #define GL_HI_BIAS_NV                                    0x8714
(defconstant $GL_LO_BIAS_NV 34581)
; #define GL_LO_BIAS_NV                                    0x8715
(defconstant $GL_DS_BIAS_NV 34582)
; #define GL_DS_BIAS_NV                                    0x8716
(defconstant $GL_DT_BIAS_NV 34583)
; #define GL_DT_BIAS_NV                                    0x8717
(defconstant $GL_MAGNITUDE_BIAS_NV 34584)
; #define GL_MAGNITUDE_BIAS_NV                             0x8718
(defconstant $GL_VIBRANCE_BIAS_NV 34585)
; #define GL_VIBRANCE_BIAS_NV                              0x8719
(defconstant $GL_TEXTURE_BORDER_VALUES_NV 34586)
; #define GL_TEXTURE_BORDER_VALUES_NV                      0x871A
(defconstant $GL_TEXTURE_HI_SIZE_NV 34587)
; #define GL_TEXTURE_HI_SIZE_NV                            0x871B
(defconstant $GL_TEXTURE_LO_SIZE_NV 34588)
; #define GL_TEXTURE_LO_SIZE_NV                            0x871C
(defconstant $GL_TEXTURE_DS_SIZE_NV 34589)
; #define GL_TEXTURE_DS_SIZE_NV                            0x871D
(defconstant $GL_TEXTURE_DT_SIZE_NV 34590)
; #define GL_TEXTURE_DT_SIZE_NV                            0x871E
(defconstant $GL_TEXTURE_MAG_SIZE_NV 34591)
; #define GL_TEXTURE_MAG_SIZE_NV                           0x871F

; #endif


; #if GL_NV_texture_shader2
(defconstant $GL_DOT_PRODUCT_TEXTURE_3D_NV 34543)
; #define GL_DOT_PRODUCT_TEXTURE_3D_NV                     0x86EF

; #endif


; #if GL_NV_texture_shader3
(defconstant $GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV 34896)
; #define GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV               0x8850
(defconstant $GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV 34897)
; #define GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV         0x8851
(defconstant $GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV 34898)
; #define GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV        0x8852
(defconstant $GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV 34899)
; #define GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV  0x8853
(defconstant $GL_OFFSET_HILO_TEXTURE_2D_NV 34900)
; #define GL_OFFSET_HILO_TEXTURE_2D_NV                     0x8854
(defconstant $GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV 34901)
; #define GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV              0x8855
(defconstant $GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV 34902)
; #define GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV          0x8856
(defconstant $GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV 34903)
; #define GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV   0x8857
(defconstant $GL_DEPENDENT_HILO_TEXTURE_2D_NV 34904)
; #define GL_DEPENDENT_HILO_TEXTURE_2D_NV                  0x8858
(defconstant $GL_DEPENDENT_RGB_TEXTURE_3D_NV 34905)
; #define GL_DEPENDENT_RGB_TEXTURE_3D_NV                   0x8859
(defconstant $GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV 34906)
; #define GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV             0x885A
(defconstant $GL_DOT_PRODUCT_PASS_THROUGH_NV 34907)
; #define GL_DOT_PRODUCT_PASS_THROUGH_NV                   0x885B
(defconstant $GL_DOT_PRODUCT_TEXTURE_1D_NV 34908)
; #define GL_DOT_PRODUCT_TEXTURE_1D_NV                     0x885C
(defconstant $GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV 34909)
; #define GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV           0x885D
(defconstant $GL_HILO8_NV 34910)
; #define GL_HILO8_NV                                      0x885E
(defconstant $GL_SIGNED_HILO8_NV 34911)
; #define GL_SIGNED_HILO8_NV                               0x885F
(defconstant $GL_FORCE_BLUE_TO_ONE_NV 34912)
; #define GL_FORCE_BLUE_TO_ONE_NV                          0x8860

; #endif


; #if GL_ATI_point_cull_mode
(defconstant $GL_POINT_CULL_MODE_ATI 24755)
; #define GL_POINT_CULL_MODE_ATI                           0x60B3
(defconstant $GL_POINT_CULL_CENTER_ATI 24756)
; #define GL_POINT_CULL_CENTER_ATI                         0x60B4
(defconstant $GL_POINT_CULL_CLIP_ATI 24757)
; #define GL_POINT_CULL_CLIP_ATI                           0x60B5

; #endif


; #if GL_NV_point_sprite
(defconstant $GL_POINT_SPRITE_NV 34913)
; #define GL_POINT_SPRITE_NV                               0x8861
(defconstant $GL_COORD_REPLACE_NV 34914)
; #define GL_COORD_REPLACE_NV                              0x8862
(defconstant $GL_POINT_SPRITE_R_MODE_NV 34915)
; #define GL_POINT_SPRITE_R_MODE_NV                        0x8863

; #endif


; #if GL_NV_depth_clamp
(defconstant $GL_DEPTH_CLAMP_NV 34383)
; #define GL_DEPTH_CLAMP_NV                                0x864F

; #endif


; #if GL_NV_multisample_filter_hint
(defconstant $GL_MULTISAMPLE_FILTER_HINT_NV 34100)
; #define GL_MULTISAMPLE_FILTER_HINT_NV                    0x8534

; #endif


; #if GL_NV_light_max_exponent
(defconstant $GL_MAX_SHININESS_NV 34052)
; #define GL_MAX_SHININESS_NV				                 0x8504
(defconstant $GL_MAX_SPOT_EXPONENT_NV 34053)
; #define GL_MAX_SPOT_EXPONENT_NV				             0x8505

; #endif


; #if GL_EXT_stencil_two_side
(defconstant $GL_STENCIL_TEST_TWO_SIDE_EXT 35088)
; #define GL_STENCIL_TEST_TWO_SIDE_EXT                     0x8910
(defconstant $GL_ACTIVE_STENCIL_FACE_EXT 35089)
; #define GL_ACTIVE_STENCIL_FACE_EXT                       0x8911

; #endif

; ***********************************************************

; #if GL_VERSION_1_2
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBlendColorProcPtr) (GLclampf, GLclampf, GLclampf, GLclampf);
typedef void (* glBlendEquationProcPtr) (GLenum);
typedef void (* glDrawRangeElementsProcPtr) (GLenum, GLuint, GLuint, GLsizei, GLenum, const GLvoid *);
typedef void (* glColorTableProcPtr) (GLenum, GLenum, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glColorTableParameterfvProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glColorTableParameterivProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glCopyColorTableProcPtr) (GLenum, GLenum, GLint, GLint, GLsizei);
typedef void (* glGetColorTableProcPtr) (GLenum, GLenum, GLenum, GLvoid *);
typedef void (* glGetColorTableParameterfvProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetColorTableParameterivProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glColorSubTableProcPtr) (GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glCopyColorSubTableProcPtr) (GLenum, GLsizei, GLint, GLint, GLsizei);
typedef void (* glConvolutionFilter1DProcPtr) (GLenum, GLenum, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glConvolutionFilter2DProcPtr) (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glConvolutionParameterfProcPtr) (GLenum, GLenum, GLfloat);
typedef void (* glConvolutionParameterfvProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glConvolutionParameteriProcPtr) (GLenum, GLenum, GLint);
typedef void (* glConvolutionParameterivProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glCopyConvolutionFilter1DProcPtr) (GLenum, GLenum, GLint, GLint, GLsizei);
typedef void (* glCopyConvolutionFilter2DProcPtr) (GLenum, GLenum, GLint, GLint, GLsizei, GLsizei);
typedef void (* glGetConvolutionFilterProcPtr) (GLenum, GLenum, GLenum, GLvoid *);
typedef void (* glGetConvolutionParameterfvProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetConvolutionParameterivProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetSeparableFilterProcPtr) (GLenum, GLenum, GLenum, GLvoid *, GLvoid *, GLvoid *);
typedef void (* glSeparableFilter2DProcPtr) (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *, const GLvoid *);
typedef void (* glGetHistogramProcPtr) (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
typedef void (* glGetHistogramParameterfvProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetHistogramParameterivProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetMinmaxProcPtr) (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
typedef void (* glGetMinmaxParameterfvProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetMinmaxParameterivProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glHistogramProcPtr) (GLenum, GLsizei, GLenum, GLboolean);
typedef void (* glMinmaxProcPtr) (GLenum, GLenum, GLboolean);
typedef void (* glResetHistogramProcPtr) (GLenum);
typedef void (* glResetMinmaxProcPtr) (GLenum);
typedef void (* glTexImage3DProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, const GLvoid *);
typedef void (* glTexSubImage3DProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glCopyTexSubImage3DProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
|#
 |#

; #else

(deftrap-inline "_glBlendColor" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glBlendEquation" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glDrawRangeElements" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorTable" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorTableParameterfv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColorTableParameteriv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glCopyColorTable" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glGetColorTable" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameterfv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameteriv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glColorSubTable" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCopyColorSubTable" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glConvolutionFilter1D" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glConvolutionFilter2D" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterf" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterfv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glConvolutionParameteri" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glConvolutionParameteriv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glCopyConvolutionFilter1D" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyConvolutionFilter2D" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glGetConvolutionFilter" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionParameterfv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionParameteriv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetSeparableFilter" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
    (ARGH (:pointer :GLVOID))
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glSeparableFilter2D" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetHistogram" 
   ((ARG2 :UInt32)
    (ARG2 :UInt8)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetHistogramParameterfv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetHistogramParameteriv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetMinmax" 
   ((ARG2 :UInt32)
    (ARG2 :UInt8)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxParameterfv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxParameteriv" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glHistogram" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glMinmax" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glResetHistogram" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glResetMinmax" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glTexImage3D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexSubImage3D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage3D" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_texture_range
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glTextureRangeAPPLEProcPtr) (GLenum target, GLsizei length, const GLvoid *pointer);
typedef void (* glGetTexParameterPointervAPPLEProcPtr) (GLenum target, GLenum pname, GLvoid **params);
|#
 |#

; #else

(deftrap-inline "_glTextureRangeAPPLE" 
   ((target :UInt32)
    (length :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetTexParameterPointervAPPLE" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_multitexture
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glActiveTextureARBProcPtr) (GLenum);
typedef void (* glClientActiveTextureARBProcPtr) (GLenum);
typedef void (* glMultiTexCoord1dARBProcPtr) (GLenum, GLdouble);
typedef void (* glMultiTexCoord1dvARBProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord1fARBProcPtr) (GLenum, GLfloat);
typedef void (* glMultiTexCoord1fvARBProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord1iARBProcPtr) (GLenum, GLint);
typedef void (* glMultiTexCoord1ivARBProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord1sARBProcPtr) (GLenum, GLshort);
typedef void (* glMultiTexCoord1svARBProcPtr) (GLenum, const GLshort *);
typedef void (* glMultiTexCoord2dARBProcPtr) (GLenum, GLdouble, GLdouble);
typedef void (* glMultiTexCoord2dvARBProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord2fARBProcPtr) (GLenum, GLfloat, GLfloat);
typedef void (* glMultiTexCoord2fvARBProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord2iARBProcPtr) (GLenum, GLint, GLint);
typedef void (* glMultiTexCoord2ivARBProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord2sARBProcPtr) (GLenum, GLshort, GLshort);
typedef void (* glMultiTexCoord2svARBProcPtr) (GLenum, const GLshort *);
typedef void (* glMultiTexCoord3dARBProcPtr) (GLenum, GLdouble, GLdouble, GLdouble);
typedef void (* glMultiTexCoord3dvARBProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord3fARBProcPtr) (GLenum, GLfloat, GLfloat, GLfloat);
typedef void (* glMultiTexCoord3fvARBProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord3iARBProcPtr) (GLenum, GLint, GLint, GLint);
typedef void (* glMultiTexCoord3ivARBProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord3sARBProcPtr) (GLenum, GLshort, GLshort, GLshort);
typedef void (* glMultiTexCoord3svARBProcPtr) (GLenum, const GLshort *);
typedef void (* glMultiTexCoord4dARBProcPtr) (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
typedef void (* glMultiTexCoord4dvARBProcPtr) (GLenum, const GLdouble *);
typedef void (* glMultiTexCoord4fARBProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glMultiTexCoord4fvARBProcPtr) (GLenum, const GLfloat *);
typedef void (* glMultiTexCoord4iARBProcPtr) (GLenum, GLint, GLint, GLint, GLint);
typedef void (* glMultiTexCoord4ivARBProcPtr) (GLenum, const GLint *);
typedef void (* glMultiTexCoord4sARBProcPtr) (GLenum, GLshort, GLshort, GLshort, GLshort);
typedef void (* glMultiTexCoord4svARBProcPtr) (GLenum, const GLshort *);
|#
 |#

; #else

(deftrap-inline "_glActiveTextureARB" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glClientActiveTextureARB" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1dARB" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1dvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1fARB" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1fvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1iARB" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1ivARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1sARB" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord1svARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2dARB" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2dvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2fARB" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2fvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2iARB" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2ivARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2sARB" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord2svARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3dARB" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3dvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3fARB" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3fvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3iARB" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3ivARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3sARB" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord3svARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4dARB" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4dvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4fARB" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4fvARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4iARB" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4ivARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4sARB" 
   ((ARG2 :UInt32)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glMultiTexCoord4svARB" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_transpose_matrix
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glLoadTransposeMatrixfARBProcPtr) (const GLfloat *);
typedef void (* glLoadTransposeMatrixdARBProcPtr) (const GLdouble *);
typedef void (* glMultTransposeMatrixfARBProcPtr) (const GLfloat *);
typedef void (* glMultTransposeMatrixdARBProcPtr) (const GLdouble *);
|#
 |#

; #else

(deftrap-inline "_glLoadTransposeMatrixfARB" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glLoadTransposeMatrixdARB" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMultTransposeMatrixfARB" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMultTransposeMatrixdARB" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_multisample
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glSampleCoverageARBProcPtr) (GLclampf, GLboolean);
typedef void (* glSamplePassARBProcPtr) (GLenum);
|#
 |#

; #else

(deftrap-inline "_glSampleCoverageARB" 
   ((ARG2 :single-float)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glSamplePassARB" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_texture_compression
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glCompressedTexImage3DARBProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, const GLvoid *);
typedef void (* glCompressedTexImage2DARBProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, const GLvoid *);
typedef void (* glCompressedTexImage1DARBProcPtr) (GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, const GLvoid *);
typedef void (* glCompressedTexSubImage3DARBProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, const GLvoid *);
typedef void (* glCompressedTexSubImage2DARBProcPtr) (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, const GLvoid *);
typedef void (* glCompressedTexSubImage1DARBProcPtr) (GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, const GLvoid *);
typedef void (* glGetCompressedTexImageARBProcPtr) (GLenum, GLint, GLvoid *);
|#
 |#

; #else

(deftrap-inline "_glCompressedTexImage3DARB" 
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

(deftrap-inline "_glCompressedTexImage2DARB" 
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

(deftrap-inline "_glCompressedTexImage1DARB" 
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

(deftrap-inline "_glCompressedTexSubImage3DARB" 
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

(deftrap-inline "_glCompressedTexSubImage2DARB" 
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

(deftrap-inline "_glCompressedTexSubImage1DARB" 
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

(deftrap-inline "_glGetCompressedTexImageARB" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_vertex_blend
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glWeightbvARBProcPtr) (GLint, const GLbyte *);
typedef void (* glWeightsvARBProcPtr) (GLint, const GLshort *);
typedef void (* glWeightivARBProcPtr) (GLint, const GLint *);
typedef void (* glWeightfvARBProcPtr) (GLint, const GLfloat *);
typedef void (* glWeightdvARBProcPtr) (GLint, const GLdouble *);
typedef void (* glWeightubvARBProcPtr) (GLint, const GLubyte *);
typedef void (* glWeightusvARBProcPtr) (GLint, const GLushort *);
typedef void (* glWeightuivARBProcPtr) (GLint, const GLuint *);
typedef void (* glWeightPointerARBProcPtr) (GLint, GLenum, GLsizei, const GLvoid *);
typedef void (* glVertexBlendARBProcPtr) (GLint);
|#
 |#

; #else

(deftrap-inline "_glWeightbvARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glWeightsvARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glWeightivARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glWeightfvARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glWeightdvARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glWeightubvARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glWeightusvARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glWeightuivARB" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glWeightPointerARB" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glVertexBlendARB" 
   ((ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_blend_color
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBlendColorEXTProcPtr) (GLclampf, GLclampf, GLclampf, GLclampf);
|#
 |#

; #else

(deftrap-inline "_glBlendColorEXT" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_polygon_offset
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glPolygonOffsetEXTProcPtr) (GLfloat, GLfloat);
|#
 |#

; #else

(deftrap-inline "_glPolygonOffsetEXT" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_texture3D
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTexImage3DEXTProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, const GLvoid *);
typedef void (* glTexSubImage3DEXTProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
|#

; #else

(deftrap-inline "_glTexImage3DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexSubImage3DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_texture_filter4
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glGetTexFilterFuncSGISProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glTexFilterFuncSGISProcPtr) (GLenum, GLenum, GLsizei, const GLfloat *);
|#

; #else

(deftrap-inline "_glGetTexFilterFuncSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexFilterFuncSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_subtexture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTexSubImage1DEXTProcPtr) (GLenum, GLint, GLint, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glTexSubImage2DEXTProcPtr) (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
|#

; #else

(deftrap-inline "_glTexSubImage1DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexSubImage2DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_copy_texture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glCopyTexImage1DEXTProcPtr) (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint);
typedef void (* glCopyTexImage2DEXTProcPtr) (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
typedef void (* glCopyTexSubImage1DEXTProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLsizei);
typedef void (* glCopyTexSubImage2DEXTProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
typedef void (* glCopyTexSubImage3DEXTProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
|#

; #else

(deftrap-inline "_glCopyTexImage1DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexImage2DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage1DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage2DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyTexSubImage3DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_histogram
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glGetHistogramEXTProcPtr) (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
typedef void (* glGetHistogramParameterfvEXTProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetHistogramParameterivEXTProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetMinmaxEXTProcPtr) (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
typedef void (* glGetMinmaxParameterfvEXTProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetMinmaxParameterivEXTProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glHistogramEXTProcPtr) (GLenum, GLsizei, GLenum, GLboolean);
typedef void (* glMinmaxEXTProcPtr) (GLenum, GLenum, GLboolean);
typedef void (* glResetHistogramEXTProcPtr) (GLenum);
typedef void (* glResetMinmaxEXTProcPtr) (GLenum);
|#

; #else

(deftrap-inline "_glGetHistogramEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt8)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetHistogramParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetHistogramParameterivEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt8)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetMinmaxParameterivEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glHistogramEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glMinmaxEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glResetHistogramEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glResetMinmaxEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_convolution
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glConvolutionFilter1DEXTProcPtr) (GLenum, GLenum, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glConvolutionFilter2DEXTProcPtr) (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glConvolutionParameterfEXTProcPtr) (GLenum, GLenum, GLfloat);
typedef void (* glConvolutionParameterfvEXTProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glConvolutionParameteriEXTProcPtr) (GLenum, GLenum, GLint);
typedef void (* glConvolutionParameterivEXTProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glCopyConvolutionFilter1DEXTProcPtr) (GLenum, GLenum, GLint, GLint, GLsizei);
typedef void (* glCopyConvolutionFilter2DEXTProcPtr) (GLenum, GLenum, GLint, GLint, GLsizei, GLsizei);
typedef void (* glGetConvolutionFilterEXTProcPtr) (GLenum, GLenum, GLenum, GLvoid *);
typedef void (* glGetConvolutionParameterfvEXTProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetConvolutionParameterivEXTProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetSeparableFilterEXTProcPtr) (GLenum, GLenum, GLenum, GLvoid *, GLvoid *, GLvoid *);
typedef void (* glSeparableFilter2DEXTProcPtr) (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *, const GLvoid *);
|#

; #else

(deftrap-inline "_glConvolutionFilter1DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glConvolutionFilter2DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterfEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glConvolutionParameteriEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glConvolutionParameterivEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glCopyConvolutionFilter1DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCopyConvolutionFilter2DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glGetConvolutionFilterEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetConvolutionParameterivEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetSeparableFilterEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
    (ARGH (:pointer :GLVOID))
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glSeparableFilter2DEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGI_color_table
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glColorTableSGIProcPtr) (GLenum, GLenum, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glColorTableParameterfvSGIProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glColorTableParameterivSGIProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glCopyColorTableSGIProcPtr) (GLenum, GLenum, GLint, GLint, GLsizei);
typedef void (* glGetColorTableSGIProcPtr) (GLenum, GLenum, GLenum, GLvoid *);
typedef void (* glGetColorTableParameterfvSGIProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetColorTableParameterivSGIProcPtr) (GLenum, GLenum, GLint *);
|#

; #else

(deftrap-inline "_glColorTableSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorTableParameterfvSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColorTableParameterivSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glCopyColorTableSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glGetColorTableSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameterfvSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameterivSGI" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_pixel_texture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glPixelTexGenSGIXProcPtr) (GLenum);
|#

; #else

(deftrap-inline "_glPixelTexGenSGIX" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_pixel_texture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glPixelTexGenParameteriSGISProcPtr) (GLenum, GLint);
typedef void (* glPixelTexGenParameterivSGISProcPtr) (GLenum, const GLint *);
typedef void (* glPixelTexGenParameterfSGISProcPtr) (GLenum, GLfloat);
typedef void (* glPixelTexGenParameterfvSGISProcPtr) (GLenum, const GLfloat *);
typedef void (* glGetPixelTexGenParameterivSGISProcPtr) (GLenum, GLint *);
typedef void (* glGetPixelTexGenParameterfvSGISProcPtr) (GLenum, GLfloat *);
|#

; #else

(deftrap-inline "_glPixelTexGenParameteriSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glPixelTexGenParameterivSGIS" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glPixelTexGenParameterfSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glPixelTexGenParameterfvSGIS" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetPixelTexGenParameterivSGIS" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetPixelTexGenParameterfvSGIS" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_texture4D
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTexImage4DSGISProcPtr) (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, const GLvoid *);
typedef void (* glTexSubImage4DSGISProcPtr) (GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
|#

; #else

(deftrap-inline "_glTexImage4DSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexSubImage4DSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_texture_object
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef GLboolean (* glAreTexturesResidentEXTProcPtr) (GLsizei, const GLuint *, GLboolean *);
typedef void (* glBindTextureEXTProcPtr) (GLenum, GLuint);
typedef void (* glDeleteTexturesEXTProcPtr) (GLsizei, const GLuint *);
typedef void (* glGenTexturesEXTProcPtr) (GLsizei, GLuint *);
typedef GLboolean (* glIsTextureEXTProcPtr) (GLuint);
typedef void (* glPrioritizeTexturesEXTProcPtr) (GLsizei, const GLuint *, const GLclampf *);
|#

; #else

(deftrap-inline "_glAreTexturesResidentEXT" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUINT))
    (ARGH (:pointer :GLBOOLEAN))
   )
   :UInt8
() )

(deftrap-inline "_glBindTextureEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glDeleteTexturesEXT" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glGenTexturesEXT" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glIsTextureEXT" 
   ((ARG2 :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glPrioritizeTexturesEXT" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLUINT))
    (ARGH (:pointer :GLCLAMPF))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_detail_texture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glDetailTexFuncSGISProcPtr) (GLenum, GLsizei, const GLfloat *);
typedef void (* glGetDetailTexFuncSGISProcPtr) (GLenum, GLfloat *);
|#

; #else

(deftrap-inline "_glDetailTexFuncSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetDetailTexFuncSGIS" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_sharpen_texture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glSharpenTexFuncSGISProcPtr) (GLenum, GLsizei, const GLfloat *);
typedef void (* glGetSharpenTexFuncSGISProcPtr) (GLenum, GLfloat *);
|#

; #else

(deftrap-inline "_glSharpenTexFuncSGIS" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetSharpenTexFuncSGIS" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_multisample
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glSampleMaskSGISProcPtr) (GLclampf, GLboolean);
typedef void (* glSamplePatternSGISProcPtr) (GLenum);
|#

; #else

(deftrap-inline "_glSampleMaskSGIS" 
   ((ARG2 :single-float)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glSamplePatternSGIS" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_vertex_array
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glArrayElementEXTProcPtr) (GLint);
typedef void (* glColorPointerEXTProcPtr) (GLint, GLenum, GLsizei, GLsizei, const GLvoid *);
typedef void (* glDrawArraysEXTProcPtr) (GLenum, GLint, GLsizei);
typedef void (* glEdgeFlagPointerEXTProcPtr) (GLsizei, GLsizei, const GLvoid *);
typedef void (* glGetPointervEXTProcPtr) (GLenum, GLvoid* *);
typedef void (* glIndexPointerEXTProcPtr) (GLenum, GLsizei, GLsizei, const GLvoid *);
typedef void (* glNormalPointerEXTProcPtr) (GLenum, GLsizei, GLsizei, const GLvoid *);
typedef void (* glTexCoordPointerEXTProcPtr) (GLint, GLenum, GLsizei, GLsizei, const GLvoid *);
typedef void (* glVertexPointerEXTProcPtr) (GLint, GLenum, GLsizei, GLsizei, const GLvoid *);
|#

; #else

(deftrap-inline "_glArrayElementEXT" 
   ((ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glColorPointerEXT" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glDrawArraysEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glEdgeFlagPointerEXT" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetPointervEXT" 
   ((ARG2 :UInt32)
    (* (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glIndexPointerEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glNormalPointerEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexCoordPointerEXT" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glVertexPointerEXT" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_blend_minmax
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBlendEquationEXTProcPtr) (GLenum);
|#
 |#

; #else

(deftrap-inline "_glBlendEquationEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_SGIX_sprite
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glSpriteParameterfSGIXProcPtr) (GLenum, GLfloat);
typedef void (* glSpriteParameterfvSGIXProcPtr) (GLenum, const GLfloat *);
typedef void (* glSpriteParameteriSGIXProcPtr) (GLenum, GLint);
typedef void (* glSpriteParameterivSGIXProcPtr) (GLenum, const GLint *);
|#

; #else

(deftrap-inline "_glSpriteParameterfSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glSpriteParameterfvSGIX" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glSpriteParameteriSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glSpriteParameterivSGIX" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_instruments
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef GLint (* glGetInstrumentsSGIXProcPtr) (void);
typedef void (* glInstrumentsBufferSGIXProcPtr) (GLsizei, GLint *);
typedef GLint (* glPollInstrumentsSGIXProcPtr) (GLint *);
typedef void (* glReadInstrumentsSGIXProcPtr) (GLint);
typedef void (* glStartInstrumentsSGIXProcPtr) (void);
typedef void (* glStopInstrumentsSGIXProcPtr) (GLint);
|#

; #else

(deftrap-inline "_glGetInstrumentsSGIX" 
   (
   )
   :signed-long
() )

(deftrap-inline "_glInstrumentsBufferSGIX" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glPollInstrumentsSGIX" 
   ((ARGH (:pointer :GLINT))
   )
   :signed-long
() )

(deftrap-inline "_glReadInstrumentsSGIX" 
   ((ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glStartInstrumentsSGIX" 
   (
   )
   nil
() )

(deftrap-inline "_glStopInstrumentsSGIX" 
   ((ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_framezoom
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glFrameZoomSGIXProcPtr) (GLint);
|#

; #else

(deftrap-inline "_glFrameZoomSGIX" 
   ((ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_tag_sample_buffer
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTagSampleBufferSGIXProcPtr) (void);
|#

; #else

(deftrap-inline "_glTagSampleBufferSGIX" 
   (
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_polynomial_ffd
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glDeformationMap3dSGIXProcPtr) (GLenum, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, const GLdouble *);
typedef void (* glDeformationMap3fSGIXProcPtr) (GLenum, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, const GLfloat *);
typedef void (* glDeformSGIXProcPtr) (GLbitfield);
typedef void (* glLoadIdentityDeformationMapSGIXProcPtr) (GLbitfield);
|#

; #else

(deftrap-inline "_glDeformationMap3dSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glDeformationMap3fSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glDeformSGIX" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glLoadIdentityDeformationMapSGIX" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_reference_plane
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glReferencePlaneSGIXProcPtr) (const GLdouble *);
|#

; #else

(deftrap-inline "_glReferencePlaneSGIX" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_flush_raster
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glFlushRasterSGIXProcPtr) (void);
|#

; #else

(deftrap-inline "_glFlushRasterSGIX" 
   (
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_fog_function
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glFogFuncSGISProcPtr) (GLsizei, const GLfloat *);
typedef void (* glGetFogFuncSGISProcPtr) (const GLfloat *);
|#

; #else

(deftrap-inline "_glFogFuncSGIS" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetFogFuncSGIS" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_HP_image_transform
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glImageTransformParameteriHPProcPtr) (GLenum, GLenum, GLint);
typedef void (* glImageTransformParameterfHPProcPtr) (GLenum, GLenum, GLfloat);
typedef void (* glImageTransformParameterivHPProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glImageTransformParameterfvHPProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glGetImageTransformParameterivHPProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetImageTransformParameterfvHPProcPtr) (GLenum, GLenum, GLfloat *);
|#

; #else

(deftrap-inline "_glImageTransformParameteriHP" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glImageTransformParameterfHP" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glImageTransformParameterivHP" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glImageTransformParameterfvHP" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetImageTransformParameterivHP" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetImageTransformParameterfvHP" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_color_subtable
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glColorSubTableEXTProcPtr) (GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glCopyColorSubTableEXTProcPtr) (GLenum, GLsizei, GLint, GLint, GLsizei);
|#

; #else

(deftrap-inline "_glColorSubTableEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glCopyColorSubTableEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_PGI_misc_hints
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glHintPGIProcPtr) (GLenum, GLint);
|#

; #else

(deftrap-inline "_glHintPGI" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_paletted_texture
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glColorTableEXTProcPtr) (GLenum, GLenum, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glColorSubTableEXTProcPtr) (GLenum, GLsizei, GLsizei, GLenum, GLenum, const GLvoid *);
typedef void (* glGetColorTableEXTProcPtr) (GLenum, GLenum, GLenum, GLvoid *);
typedef void (* glGetColorTableParameterivEXTProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetColorTableParameterfvEXTProcPtr) (GLenum, GLenum, GLfloat *);
|#
 |#

; #else

(deftrap-inline "_glColorTableEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorSubTableEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetColorTableEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameterivEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetColorTableParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_SGIX_list_priority
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glGetListParameterfvSGIXProcPtr) (GLuint, GLenum, GLfloat *);
typedef void (* glGetListParameterivSGIXProcPtr) (GLuint, GLenum, GLint *);
typedef void (* glListParameterfSGIXProcPtr) (GLuint, GLenum, GLfloat);
typedef void (* glListParameterfvSGIXProcPtr) (GLuint, GLenum, const GLfloat *);
typedef void (* glListParameteriSGIXProcPtr) (GLuint, GLenum, GLint);
typedef void (* glListParameterivSGIXProcPtr) (GLuint, GLenum, const GLint *);
|#

; #else

(deftrap-inline "_glGetListParameterfvSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetListParameterivSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glListParameterfSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glListParameterfvSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glListParameteriSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glListParameterivSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_index_material
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glIndexMaterialEXTProcPtr) (GLenum, GLenum);
|#

; #else

(deftrap-inline "_glIndexMaterialEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_index_func
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glIndexFuncEXTProcPtr) (GLenum, GLclampf);
|#

; #else

(deftrap-inline "_glIndexFuncEXT" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_compiled_vertex_array
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glLockArraysEXTProcPtr) (GLint, GLsizei);
typedef void (* glUnlockArraysEXTProcPtr) (void);
|#
 |#

; #else

(deftrap-inline "_glLockArraysEXT" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glUnlockArraysEXT" 
   (
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_cull_vertex
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glCullParameterdvEXTProcPtr) (GLenum, GLdouble *);
typedef void (* glCullParameterfvEXTProcPtr) (GLenum, GLfloat *);
|#

; #else

(deftrap-inline "_glCullParameterdvEXT" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glCullParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_fragment_lighting
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glFragmentColorMaterialSGIXProcPtr) (GLenum, GLenum);
typedef void (* glFragmentLightfSGIXProcPtr) (GLenum, GLenum, GLfloat);
typedef void (* glFragmentLightfvSGIXProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glFragmentLightiSGIXProcPtr) (GLenum, GLenum, GLint);
typedef void (* glFragmentLightivSGIXProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glFragmentLightModelfSGIXProcPtr) (GLenum, GLfloat);
typedef void (* glFragmentLightModelfvSGIXProcPtr) (GLenum, const GLfloat *);
typedef void (* glFragmentLightModeliSGIXProcPtr) (GLenum, GLint);
typedef void (* glFragmentLightModelivSGIXProcPtr) (GLenum, const GLint *);
typedef void (* glFragmentMaterialfSGIXProcPtr) (GLenum, GLenum, GLfloat);
typedef void (* glFragmentMaterialfvSGIXProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glFragmentMaterialiSGIXProcPtr) (GLenum, GLenum, GLint);
typedef void (* glFragmentMaterialivSGIXProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glGetFragmentLightfvSGIXProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetFragmentLightivSGIXProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glGetFragmentMaterialfvSGIXProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetFragmentMaterialivSGIXProcPtr) (GLenum, GLenum, GLint *);
typedef void (* glLightEnviSGIXProcPtr) (GLenum, GLint);
|#

; #else

(deftrap-inline "_glFragmentColorMaterialSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glFragmentLightfSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glFragmentLightfvSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFragmentLightiSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glFragmentLightivSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glFragmentLightModelfSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glFragmentLightModelfvSGIX" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFragmentLightModeliSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glFragmentLightModelivSGIX" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glFragmentMaterialfSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glFragmentMaterialfvSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFragmentMaterialiSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glFragmentMaterialivSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetFragmentLightfvSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetFragmentLightivSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetFragmentMaterialfvSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetFragmentMaterialivSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glLightEnviSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_draw_range_elements
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glDrawRangeElementsEXTProcPtr) (GLenum, GLuint, GLuint, GLsizei, GLenum, const GLvoid *);
|#
 |#

; #else

(deftrap-inline "_glDrawRangeElementsEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_light_texture
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glApplyTextureEXTProcPtr) (GLenum);
typedef void (* glTextureLightEXTProcPtr) (GLenum);
typedef void (* glTextureMaterialEXTProcPtr) (GLenum, GLenum);
|#

; #else

(deftrap-inline "_glApplyTextureEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glTextureLightEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glTextureMaterialEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_async
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glAsyncMarkerSGIXProcPtr) (GLuint);
typedef GLint (* glFinishAsyncSGIXProcPtr) (GLuint *);
typedef GLint (* glPollAsyncSGIXProcPtr) (GLuint *);
typedef GLuint (* glGenAsyncMarkersSGIXProcPtr) (GLsizei);
typedef void (* glDeleteAsyncMarkersSGIXProcPtr) (GLuint, GLsizei);
typedef GLboolean (* glIsAsyncMarkerSGIXProcPtr) (GLuint);
|#

; #else

(deftrap-inline "_glAsyncMarkerSGIX" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glFinishAsyncSGIX" 
   ((ARGH (:pointer :GLUINT))
   )
   :signed-long
() )

(deftrap-inline "_glPollAsyncSGIX" 
   ((ARGH (:pointer :GLUINT))
   )
   :signed-long
() )

(deftrap-inline "_glGenAsyncMarkersSGIX" 
   ((ARG2 :signed-long)
   )
   :UInt32
() )

(deftrap-inline "_glDeleteAsyncMarkersSGIX" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glIsAsyncMarkerSGIX" 
   ((ARG2 :UInt32)
   )
   :UInt8
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_INTEL_parallel_arrays
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glVertexPointervINTELProcPtr) (GLint, GLenum, const GLvoid* *);
typedef void (* glNormalPointervINTELProcPtr) (GLenum, const GLvoid* *);
typedef void (* glColorPointervINTELProcPtr) (GLint, GLenum, const GLvoid* *);
typedef void (* glTexCoordPointervINTELProcPtr) (GLint, GLenum, const GLvoid* *);
|#

; #else

(deftrap-inline "_glVertexPointervINTEL" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (* (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glNormalPointervINTEL" 
   ((ARG2 :UInt32)
    (* (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glColorPointervINTEL" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (* (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glTexCoordPointervINTEL" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (* (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_pixel_transform
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glPixelTransformParameteriEXTProcPtr) (GLenum, GLenum, GLint);
typedef void (* glPixelTransformParameterfEXTProcPtr) (GLenum, GLenum, GLfloat);
typedef void (* glPixelTransformParameterivEXTProcPtr) (GLenum, GLenum, const GLint *);
typedef void (* glPixelTransformParameterfvEXTProcPtr) (GLenum, GLenum, const GLfloat *);
|#

; #else

(deftrap-inline "_glPixelTransformParameteriEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glPixelTransformParameterfEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glPixelTransformParameterivEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glPixelTransformParameterfvEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_secondary_color
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glSecondaryColor3bEXTProcPtr) (GLbyte, GLbyte, GLbyte);
typedef void (* glSecondaryColor3bvEXTProcPtr) (const GLbyte *);
typedef void (* glSecondaryColor3dEXTProcPtr) (GLdouble, GLdouble, GLdouble);
typedef void (* glSecondaryColor3dvEXTProcPtr) (const GLdouble *);
typedef void (* glSecondaryColor3fEXTProcPtr) (GLfloat, GLfloat, GLfloat);
typedef void (* glSecondaryColor3fvEXTProcPtr) (const GLfloat *);
typedef void (* glSecondaryColor3iEXTProcPtr) (GLint, GLint, GLint);
typedef void (* glSecondaryColor3ivEXTProcPtr) (const GLint *);
typedef void (* glSecondaryColor3sEXTProcPtr) (GLshort, GLshort, GLshort);
typedef void (* glSecondaryColor3svEXTProcPtr) (const GLshort *);
typedef void (* glSecondaryColor3ubEXTProcPtr) (GLubyte, GLubyte, GLubyte);
typedef void (* glSecondaryColor3ubvEXTProcPtr) (const GLubyte *);
typedef void (* glSecondaryColor3uiEXTProcPtr) (GLuint, GLuint, GLuint);
typedef void (* glSecondaryColor3uivEXTProcPtr) (const GLuint *);
typedef void (* glSecondaryColor3usEXTProcPtr) (GLushort, GLushort, GLushort);
typedef void (* glSecondaryColor3usvEXTProcPtr) (const GLushort *);
typedef void (* glSecondaryColorPointerEXTProcPtr) (GLint, GLenum, GLsizei, const GLvoid *);
|#
 |#

; #else

(deftrap-inline "_glSecondaryColor3bEXT" 
   ((ARG2 :SInt8)
    (ARG2 :SInt8)
    (ARG2 :SInt8)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3bvEXT" 
   ((ARGH (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3dEXT" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3dvEXT" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3fEXT" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3fvEXT" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3iEXT" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3ivEXT" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3sEXT" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3svEXT" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3ubEXT" 
   ((ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3ubvEXT" 
   ((ARGH (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3uiEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3uivEXT" 
   ((ARGH (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3usEXT" 
   ((ARG2 :UInt16)
    (ARG2 :UInt16)
    (ARG2 :UInt16)
   )
   nil
() )

(deftrap-inline "_glSecondaryColor3usvEXT" 
   ((ARGH (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glSecondaryColorPointerEXT" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_texture_perturb_normal
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTextureNormalEXTProcPtr) (GLenum);
|#

; #else

(deftrap-inline "_glTextureNormalEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_multi_draw_arrays
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glMultiDrawArraysEXTProcPtr) (GLenum, const GLint *, const GLsizei *, GLsizei);
typedef void (* glMultiDrawElementsEXTProcPtr) (GLenum, const GLsizei *, GLenum, const GLvoid* *, GLsizei);
|#
 |#

; #else

(deftrap-inline "_glMultiDrawArraysEXT" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
    (ARGH (:pointer :GLSIZEI))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiDrawElementsEXT" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLSIZEI))
    (ARG2 :UInt32)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_fog_coord
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glFogCoordfEXTProcPtr) (GLfloat);
typedef void (* glFogCoordfvEXTProcPtr) (const GLfloat *);
typedef void (* glFogCoorddEXTProcPtr) (GLdouble);
typedef void (* glFogCoorddvEXTProcPtr) (const GLdouble *);
typedef void (* glFogCoordPointerEXTProcPtr) (GLenum, GLsizei, const GLvoid *);
|#
 |#

; #else

(deftrap-inline "_glFogCoordfEXT" 
   ((ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glFogCoordfvEXT" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glFogCoorddEXT" 
   ((ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glFogCoorddvEXT" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glFogCoordPointerEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_vertex_array_range
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glVertexArrayRangeAPPLEProcPtr) (GLsizei length, const GLvoid *pointer);
typedef void (* glFlushVertexArrayRangeAPPLEProcPtr) (GLsizei length, const GLvoid *pointer);
typedef void (* glVertexArrayParameteriAPPLEProcPtr) (GLenum pname, GLint param);
|#
 |#

; #else

(deftrap-inline "_glVertexArrayRangeAPPLE" 
   ((length :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glFlushVertexArrayRangeAPPLE" 
   ((length :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glVertexArrayParameteriAPPLE" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_vertex_array_object
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBindVertexArrayAPPLEProcPtr) (GLuint id);
typedef void (* glDeleteVertexArraysAPPLEProcPtr) (GLsizei n, const GLuint *ids);
typedef void (* glGenVertexArraysAPPLEProcPtr) (GLsizei n, GLuint *ids);
typedef GLboolean (* glIsVertexArrayAPPLEProcPtr) (GLuint id);
|#
 |#

; #else

(deftrap-inline "_glBindVertexArrayAPPLE" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glDeleteVertexArraysAPPLE" 
   ((n :signed-long)
    (ids (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glGenVertexArraysAPPLE" 
   ((n :signed-long)
    (ids (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glIsVertexArrayAPPLE" 
   ((id :UInt32)
   )
   :UInt8
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_fence
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glGenFencesAPPLEProcPtr) (GLsizei n, GLuint *fences);
typedef void (* glDeleteFencesAPPLEProcPtr) (GLsizei n, const GLuint *fences);
typedef void (* glSetFenceAPPLEProcPtr) (GLuint fence);
typedef GLboolean (* glIsFenceAPPLEProcPtr) (GLuint fence);
typedef GLboolean (* glTestFenceAPPLEProcPtr) (GLuint fence);
typedef void (* glFinishFenceAPPLEProcPtr) (GLuint fence);
typedef GLboolean (* glTestObjectAPPLEProcPtr) (GLenum object, GLuint name);
typedef void (* glFinishObjectAPPLEProcPtr) (GLenum object, GLuint name);
|#
 |#

; #else

(deftrap-inline "_glGenFencesAPPLE" 
   ((n :signed-long)
    (fences (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glDeleteFencesAPPLE" 
   ((n :signed-long)
    (fences (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glSetFenceAPPLE" 
   ((fence :UInt32)
   )
   nil
() )

(deftrap-inline "_glIsFenceAPPLE" 
   ((fence :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glTestFenceAPPLE" 
   ((fence :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glFinishFenceAPPLE" 
   ((fence :UInt32)
   )
   nil
() )

(deftrap-inline "_glTestObjectAPPLE" 
   ((object :UInt32)
    (name :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glFinishObjectAPPLE" 
   ((object :UInt32)
    (name :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_element_array
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glElementPointerAPPLEProcPtr) (GLenum type, const GLvoid *pointer);
typedef void (* glDrawElementArrayAPPLEProcPtr) (GLenum mode, GLint first, GLsizei count);
typedef void (* glDrawRangeElementArrayAPPLEProcPtr) (GLenum mode, GLuint start, GLuint end, GLint first, GLsizei count);
|#
 |#

; #else

(deftrap-inline "_glElementPointerAPPLE" 
   ((type :UInt32)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glDrawElementArrayAPPLE" 
   ((mode :UInt32)
    (first :signed-long)
    (count :signed-long)
   )
   nil
() )

(deftrap-inline "_glDrawRangeElementArrayAPPLE" 
   ((mode :UInt32)
    (start :UInt32)
    (end :UInt32)
    (first :signed-long)
    (count :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_flush_render
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glFlushRenderAPPLEProcPtr) (void);
typedef void (* glFinishRenderAPPLEProcPtr) (void);
typedef void (* glSwapAPPLEProcPtr) (void);
|#
 |#

; #else

(deftrap-inline "_glFlushRenderAPPLE" 
   (
   )
   nil
() )

(deftrap-inline "_glFinishRenderAPPLE" 
   (
   )
   nil
() )

(deftrap-inline "_glSwapAPPLE" 
   (
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_coordinate_frame
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTangent3bEXTProcPtr) (GLbyte, GLbyte, GLbyte);
typedef void (* glTangent3bvEXTProcPtr) (const GLbyte *);
typedef void (* glTangent3dEXTProcPtr) (GLdouble, GLdouble, GLdouble);
typedef void (* glTangent3dvEXTProcPtr) (const GLdouble *);
typedef void (* glTangent3fEXTProcPtr) (GLfloat, GLfloat, GLfloat);
typedef void (* glTangent3fvEXTProcPtr) (const GLfloat *);
typedef void (* glTangent3iEXTProcPtr) (GLint, GLint, GLint);
typedef void (* glTangent3ivEXTProcPtr) (const GLint *);
typedef void (* glTangent3sEXTProcPtr) (GLshort, GLshort, GLshort);
typedef void (* glTangent3svEXTProcPtr) (const GLshort *);
typedef void (* glBinormal3bEXTProcPtr) (GLbyte, GLbyte, GLbyte);
typedef void (* glBinormal3bvEXTProcPtr) (const GLbyte *);
typedef void (* glBinormal3dEXTProcPtr) (GLdouble, GLdouble, GLdouble);
typedef void (* glBinormal3dvEXTProcPtr) (const GLdouble *);
typedef void (* glBinormal3fEXTProcPtr) (GLfloat, GLfloat, GLfloat);
typedef void (* glBinormal3fvEXTProcPtr) (const GLfloat *);
typedef void (* glBinormal3iEXTProcPtr) (GLint, GLint, GLint);
typedef void (* glBinormal3ivEXTProcPtr) (const GLint *);
typedef void (* glBinormal3sEXTProcPtr) (GLshort, GLshort, GLshort);
typedef void (* glBinormal3svEXTProcPtr) (const GLshort *);
typedef void (* glTangentPointerEXTProcPtr) (GLenum, GLsizei, const GLvoid *);
typedef void (* glBinormalPointerEXTProcPtr) (GLenum, GLsizei, const GLvoid *);
|#

; #else

(deftrap-inline "_glTangent3bEXT" 
   ((ARG2 :SInt8)
    (ARG2 :SInt8)
    (ARG2 :SInt8)
   )
   nil
() )

(deftrap-inline "_glTangent3bvEXT" 
   ((ARGH (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glTangent3dEXT" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glTangent3dvEXT" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glTangent3fEXT" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTangent3fvEXT" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTangent3iEXT" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glTangent3ivEXT" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glTangent3sEXT" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glTangent3svEXT" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glBinormal3bEXT" 
   ((ARG2 :SInt8)
    (ARG2 :SInt8)
    (ARG2 :SInt8)
   )
   nil
() )

(deftrap-inline "_glBinormal3bvEXT" 
   ((ARGH (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glBinormal3dEXT" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glBinormal3dvEXT" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glBinormal3fEXT" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glBinormal3fvEXT" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glBinormal3iEXT" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glBinormal3ivEXT" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glBinormal3sEXT" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glBinormal3svEXT" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glTangentPointerEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glBinormalPointerEXT" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SUNX_constant_data
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glFinishTextureSUNXProcPtr) (void);
|#

; #else

(deftrap-inline "_glFinishTextureSUNX" 
   (
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SUN_global_alpha
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glGlobalAlphaFactorbSUNProcPtr) (GLbyte);
typedef void (* glGlobalAlphaFactorsSUNProcPtr) (GLshort);
typedef void (* glGlobalAlphaFactoriSUNProcPtr) (GLint);
typedef void (* glGlobalAlphaFactorfSUNProcPtr) (GLfloat);
typedef void (* glGlobalAlphaFactordSUNProcPtr) (GLdouble);
typedef void (* glGlobalAlphaFactorubSUNProcPtr) (GLubyte);
typedef void (* glGlobalAlphaFactorusSUNProcPtr) (GLushort);
typedef void (* glGlobalAlphaFactoruiSUNProcPtr) (GLuint);
|#

; #else

(deftrap-inline "_glGlobalAlphaFactorbSUN" 
   ((ARG2 :SInt8)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactorsSUN" 
   ((ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactoriSUN" 
   ((ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactorfSUN" 
   ((ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactordSUN" 
   ((ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactorubSUN" 
   ((ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactorusSUN" 
   ((ARG2 :UInt16)
   )
   nil
() )

(deftrap-inline "_glGlobalAlphaFactoruiSUN" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SUN_triangle_list
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glReplacementCodeuiSUNProcPtr) (GLuint);
typedef void (* glReplacementCodeusSUNProcPtr) (GLushort);
typedef void (* glReplacementCodeubSUNProcPtr) (GLubyte);
typedef void (* glReplacementCodeuivSUNProcPtr) (const GLuint *);
typedef void (* glReplacementCodeusvSUNProcPtr) (const GLushort *);
typedef void (* glReplacementCodeubvSUNProcPtr) (const GLubyte *);
typedef void (* glReplacementCodePointerSUNProcPtr) (GLenum, GLsizei, const GLvoid* *);
|#

; #else

(deftrap-inline "_glReplacementCodeuiSUN" 
   ((ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeusSUN" 
   ((ARG2 :UInt16)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeubSUN" 
   ((ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuivSUN" 
   ((ARGH (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeusvSUN" 
   ((ARGH (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeubvSUN" 
   ((ARGH (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glReplacementCodePointerSUN" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SUN_vertex
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glColor4ubVertex2fSUNProcPtr) (GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat);
typedef void (* glColor4ubVertex2fvSUNProcPtr) (const GLubyte *, const GLfloat *);
typedef void (* glColor4ubVertex3fSUNProcPtr) (GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
typedef void (* glColor4ubVertex3fvSUNProcPtr) (const GLubyte *, const GLfloat *);
typedef void (* glColor3fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glColor3fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *);
typedef void (* glNormal3fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glNormal3fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *);
typedef void (* glColor4fNormal3fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glColor4fNormal3fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glTexCoord2fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord2fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *);
typedef void (* glTexCoord4fVertex4fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord4fVertex4fvSUNProcPtr) (const GLfloat *, const GLfloat *);
typedef void (* glTexCoord2fColor4ubVertex3fSUNProcPtr) (GLfloat, GLfloat, GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord2fColor4ubVertex3fvSUNProcPtr) (const GLfloat *, const GLubyte *, const GLfloat *);
typedef void (* glTexCoord2fColor3fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord2fColor3fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glTexCoord2fNormal3fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord2fNormal3fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glTexCoord2fColor4fNormal3fVertex3fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord2fColor4fNormal3fVertex3fvSUNProcPtr) (const GLfloat *, const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glTexCoord4fColor4fNormal3fVertex4fSUNProcPtr) (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glTexCoord4fColor4fNormal3fVertex4fvSUNProcPtr) (const GLfloat *, const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glReplacementCodeuiVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *);
typedef void (* glReplacementCodeuiColor4ubVertex3fSUNProcPtr) (GLenum, GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiColor4ubVertex3fvSUNProcPtr) (const GLenum *, const GLubyte *, const GLfloat *);
typedef void (* glReplacementCodeuiColor3fVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiColor3fVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *, const GLfloat *);
typedef void (* glReplacementCodeuiNormal3fVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiNormal3fVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *, const GLfloat *);
typedef void (* glReplacementCodeuiColor4fNormal3fVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiColor4fNormal3fVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glReplacementCodeuiTexCoord2fVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiTexCoord2fVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *, const GLfloat *);
typedef void (* glReplacementCodeuiTexCoord2fNormal3fVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *, const GLfloat *, const GLfloat *);
typedef void (* glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUNProcPtr) (GLenum, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
typedef void (* glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUNProcPtr) (const GLenum *, const GLfloat *, const GLfloat *, const GLfloat *, const GLfloat *);
|#

; #else

(deftrap-inline "_glColor4ubVertex2fSUN" 
   ((ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glColor4ubVertex2fvSUN" 
   ((ARGH (:pointer :GLUBYTE))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColor4ubVertex3fSUN" 
   ((ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glColor4ubVertex3fvSUN" 
   ((ARGH (:pointer :GLUBYTE))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColor3fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glColor3fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glNormal3fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glColor4fNormal3fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glColor4fNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord4fVertex4fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord4fVertex4fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2fColor4ubVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2fColor4ubVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLUBYTE))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2fColor3fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2fColor3fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2fNormal3fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2fNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord2fColor4fNormal3fVertex3fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord2fColor4fNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTexCoord4fColor4fNormal3fVertex4fSUN" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glTexCoord4fColor4fNormal3fVertex4fvSUN" 
   ((ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiColor4ubVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiColor4ubVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLUBYTE))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiColor3fVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiColor3fVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiNormal3fVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiColor4fNormal3fVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiColor4fNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiTexCoord2fVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiTexCoord2fVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_blend_func_separate
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBlendFuncSeparateEXTProcPtr) (GLenum, GLenum, GLenum, GLenum);
|#
 |#

; #else

(deftrap-inline "_glBlendFuncSeparateEXT" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_vertex_weighting
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glVertexWeightfEXTProcPtr) (GLfloat);
typedef void (* glVertexWeightfvEXTProcPtr) (const GLfloat *);
typedef void (* glVertexWeightPointerEXTProcPtr) (GLsizei, GLenum, GLsizei, const GLvoid *);
|#

; #else

(deftrap-inline "_glVertexWeightfEXT" 
   ((ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexWeightfvEXT" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexWeightPointerEXT" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_NV_vertex_array_range
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glFlushVertexArrayRangeNVProcPtr) (void);
typedef void (* glVertexArrayRangeNVProcPtr) (GLsizei, const GLvoid *);
|#

; #else

(deftrap-inline "_glFlushVertexArrayRangeNV" 
   (
   )
   nil
() )

(deftrap-inline "_glVertexArrayRangeNV" 
   ((ARG2 :signed-long)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_NV_register_combiners
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glCombinerParameterfvNVProcPtr) (GLenum, const GLfloat *);
typedef void (* glCombinerParameterfNVProcPtr) (GLenum, GLfloat);
typedef void (* glCombinerParameterivNVProcPtr) (GLenum, const GLint *);
typedef void (* glCombinerParameteriNVProcPtr) (GLenum, GLint);
typedef void (* glCombinerInputNVProcPtr) (GLenum, GLenum, GLenum, GLenum, GLenum, GLenum);
typedef void (* glCombinerOutputNVProcPtr) (GLenum, GLenum, GLenum, GLenum, GLenum, GLenum, GLenum, GLboolean, GLboolean, GLboolean);
typedef void (* glFinalCombinerInputNVProcPtr) (GLenum, GLenum, GLenum, GLenum);
typedef void (* glGetCombinerInputParameterfvNVProcPtr) (GLenum, GLenum, GLenum, GLenum, GLfloat *);
typedef void (* glGetCombinerInputParameterivNVProcPtr) (GLenum, GLenum, GLenum, GLenum, GLint *);
typedef void (* glGetCombinerOutputParameterfvNVProcPtr) (GLenum, GLenum, GLenum, GLfloat *);
typedef void (* glGetCombinerOutputParameterivNVProcPtr) (GLenum, GLenum, GLenum, GLint *);
typedef void (* glGetFinalCombinerInputParameterfvNVProcPtr) (GLenum, GLenum, GLfloat *);
typedef void (* glGetFinalCombinerInputParameterivNVProcPtr) (GLenum, GLenum, GLint *);
|#
 |#

; #else

(deftrap-inline "_glCombinerParameterfvNV" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glCombinerParameterfNV" 
   ((ARG2 :UInt32)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glCombinerParameterivNV" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glCombinerParameteriNV" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glCombinerInputNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glCombinerOutputNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glFinalCombinerInputNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glGetCombinerInputParameterfvNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetCombinerInputParameterivNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetCombinerOutputParameterfvNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetCombinerOutputParameterivNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetFinalCombinerInputParameterfvNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetFinalCombinerInputParameterivNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_NV_register_combiners2
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glCombinerStageParameterfvNVProcPtr) (GLenum, GLenum, const GLfloat *);
typedef void (* glGetCombinerStageParameterfvNVProcPtr) (GLenum, GLenum, GLfloat *);
|#
 |#

; #else

(deftrap-inline "_glCombinerStageParameterfvNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetCombinerStageParameterfvNV" 
   ((ARG2 :UInt32)
    (ARG2 :UInt32)
    (ARGH (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_vertex_shader
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glBeginVertexShaderEXTProcPtr) (void);
typedef void (* glEndVertexShaderEXTProcPtr) (void);
typedef void (* glBindVertexShaderEXTProcPtr) (GLuint id);
typedef GLuint (* glGenVertexShadersEXTProcPtr) (GLuint range);
typedef void (* glDeleteVertexShaderEXTProcPtr) (GLuint id);
typedef void (* glShaderOp1EXTProcPtr) (GLenum op, GLuint res, GLuint arg1);
typedef void (* glShaderOp2EXTProcPtr) (GLenum op, GLuint res, GLuint arg1, GLuint arg2);
typedef void (* glShaderOp3EXTProcPtr) (GLenum op, GLuint res, GLuint arg1, GLuint arg2, GLuint arg3);
typedef void (* glSwizzleEXTProcPtr) (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW);
typedef void (* glWriteMaskEXTProcPtr) (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW);
typedef void (* glInsertComponentEXTProcPtr) (GLuint res, GLuint src, GLuint num);
typedef void (* glExtractComponentEXTProcPtr) (GLuint res, GLuint src, GLuint num);
typedef GLuint (* glGenSymbolsEXTProcPtr) (GLenum datatype, GLenum storagetype, GLenum range, GLuint components);
typedef void (* glSetInvariantEXTProcPtr) (GLuint id, GLenum type, GLvoid *addr);
typedef void (* glSetLocalConstantEXTProcPtr) (GLuint id, GLenum type, GLvoid *addr);
typedef void (* glVariantbvEXTProcPtr) (GLuint id, GLbyte *addr);
typedef void (* glVariantdvEXTProcPtr) (GLuint id, GLdouble *addr);
typedef void (* glVariantfvEXTProcPtr) (GLuint id, GLfloat *addr);
typedef void (* glVariantivEXTProcPtr) (GLuint id, GLint *addr);
typedef void (* glVariantsvEXTProcPtr) (GLuint id, GLshort *addr);
typedef void (* glVariantubvEXTProcPtr) (GLuint id, GLubyte *addr);
typedef void (* glVariantuivEXTProcPtr) (GLuint id, GLuint *addr);
typedef void (* glVariantusvEXTProcPtr) (GLuint id, GLushort *addr);
typedef void (* glVariantPointerEXTProcPtr) (GLuint id, GLenum type, GLuint stride, GLvoid *addr);
typedef void (* glEnableVariantClientStateEXTProcPtr) (GLuint id);
typedef void (* glDisableVariantClientStateEXTProcPtr) (GLuint id);
typedef GLuint (* glBindLightParameterEXTProcPtr) (GLenum light, GLenum value);
typedef GLuint (* glBindMaterialParameterEXTProcPtr) (GLenum face, GLenum value);
typedef GLuint (* glBindTexGenParameterEXTProcPtr) (GLenum unit, GLenum coord, GLenum value);
typedef GLuint (* glBindTextureUnitParameterEXTProcPtr) (GLenum unit, GLenum value);
typedef GLuint (* glBindParameterEXTProcPtr) (GLenum value);
typedef GLboolean (* glIsVariantEnabledEXTProcPtr) (GLuint id, GLenum cap);
typedef void (* glGetVariantBooleanvEXTProcPtr) (GLuint id, GLenum value, GLboolean *data);
typedef void (* glGetVariantIntegervEXTProcPtr) (GLuint id, GLenum value, GLint *data);
typedef void (* glGetVariantFloatvEXTProcPtr) (GLuint id, GLenum value, GLfloat *data);
typedef void (* glGetVariantPointervEXTProcPtr) (GLuint id, GLenum value, GLvoid **data);
typedef void (* glGetInvariantBooleanvEXTProcPtr) (GLuint id, GLenum value, GLboolean *data);
typedef void (* glGetInvariantIntegervEXTProcPtr) (GLuint id, GLenum value, GLint *data);
typedef void (* glGetInvariantFloatvEXTProcPtr) (GLuint id, GLenum value, GLfloat *data);
typedef void (* glGetLocalConstantBooleanvEXTProcPtr) (GLuint id, GLenum value, GLboolean *data);
typedef void (* glGetLocalConstantIntegervEXTProcPtr) (GLuint id, GLenum value, GLint *data);
typedef void (* glGetLocalConstantFloatvEXTProcPtr) (GLuint id, GLenum value, GLfloat *data);
|#

; #else

(deftrap-inline "_glBeginVertexShaderEXT" 
   (
   )
   nil
() )

(deftrap-inline "_glEndVertexShaderEXT" 
   (
   )
   nil
() )

(deftrap-inline "_glBindVertexShaderEXT" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glGenVertexShadersEXT" 
   ((range :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glDeleteVertexShaderEXT" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glShaderOp1EXT" 
   ((op :UInt32)
    (res :UInt32)
    (arg1 :UInt32)
   )
   nil
() )

(deftrap-inline "_glShaderOp2EXT" 
   ((op :UInt32)
    (res :UInt32)
    (arg1 :UInt32)
    (arg2 :UInt32)
   )
   nil
() )

(deftrap-inline "_glShaderOp3EXT" 
   ((op :UInt32)
    (res :UInt32)
    (arg1 :UInt32)
    (arg2 :UInt32)
    (arg3 :UInt32)
   )
   nil
() )

(deftrap-inline "_glSwizzleEXT" 
   ((res :UInt32)
    (in :UInt32)
    (outX :UInt32)
    (outY :UInt32)
    (outZ :UInt32)
    (outW :UInt32)
   )
   nil
() )

(deftrap-inline "_glWriteMaskEXT" 
   ((res :UInt32)
    (in :UInt32)
    (outX :UInt32)
    (outY :UInt32)
    (outZ :UInt32)
    (outW :UInt32)
   )
   nil
() )

(deftrap-inline "_glInsertComponentEXT" 
   ((res :UInt32)
    (src :UInt32)
    (num :UInt32)
   )
   nil
() )

(deftrap-inline "_glExtractComponentEXT" 
   ((res :UInt32)
    (src :UInt32)
    (num :UInt32)
   )
   nil
() )

(deftrap-inline "_glGenSymbolsEXT" 
   ((datatype :UInt32)
    (storagetype :UInt32)
    (range :UInt32)
    (components :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glSetInvariantEXT" 
   ((id :UInt32)
    (type :UInt32)
    (addr (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glSetLocalConstantEXT" 
   ((id :UInt32)
    (type :UInt32)
    (addr (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glVariantbvEXT" 
   ((id :UInt32)
    (addr (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glVariantdvEXT" 
   ((id :UInt32)
    (addr (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVariantfvEXT" 
   ((id :UInt32)
    (addr (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVariantivEXT" 
   ((id :UInt32)
    (addr (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glVariantsvEXT" 
   ((id :UInt32)
    (addr (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVariantubvEXT" 
   ((id :UInt32)
    (addr (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glVariantuivEXT" 
   ((id :UInt32)
    (addr (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glVariantusvEXT" 
   ((id :UInt32)
    (addr (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glVariantPointerEXT" 
   ((id :UInt32)
    (type :UInt32)
    (stride :UInt32)
    (addr (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glEnableVariantClientStateEXT" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glDisableVariantClientStateEXT" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glBindLightParameterEXT" 
   ((light :UInt32)
    (value :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glBindMaterialParameterEXT" 
   ((face :UInt32)
    (value :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glBindTexGenParameterEXT" 
   ((unit :UInt32)
    (coord :UInt32)
    (value :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glBindTextureUnitParameterEXT" 
   ((unit :UInt32)
    (value :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glBindParameterEXT" 
   ((value :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glIsVariantEnabledEXT" 
   ((id :UInt32)
    (cap :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glGetVariantBooleanvEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLBOOLEAN))
   )
   nil
() )

(deftrap-inline "_glGetVariantIntegervEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetVariantFloatvEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetVariantPointervEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetInvariantBooleanvEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLBOOLEAN))
   )
   nil
() )

(deftrap-inline "_glGetInvariantIntegervEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetInvariantFloatvEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetLocalConstantBooleanvEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLBOOLEAN))
   )
   nil
() )

(deftrap-inline "_glGetLocalConstantIntegervEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetLocalConstantFloatvEXT" 
   ((id :UInt32)
    (value :UInt32)
    (data (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_fragment_shader
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef GLuint (* glGenFragmentShadersEXTProcPtr) (GLuint range);
typedef void (* glBindFragmentShaderEXTProcPtr) (GLuint id);
typedef void (* glDeleteFragmentShaderEXTProcPtr) (GLuint id);
typedef void (* glBeginFragmentShaderEXTProcPtr) (void);
typedef void (* glEndFragmentShaderEXTProcPtr) (void);
typedef void (* glPassTexCoordEXTProcPtr) (GLuint dst, GLuint coord, GLenum swizzle);
typedef void (* glSampleMapEXTProcPtr) (GLuint dst, GLuint interp, GLenum swizzle);
typedef void (* glColorFragmentOp1EXTProcPtr) (GLenum op, GLuint dst, GLuint dstMask,
                                   GLuint dstMod, GLuint arg1, GLuint arg1Rep,
                                   GLuint arg1Mod);
typedef void (* glColorFragmentOp2EXTProcPtr) (GLenum op, GLuint dst, GLuint dstMask,
                                   GLuint dstMod, GLuint arg1, GLuint arg1Rep,
                                   GLuint arg1Mod, GLuint arg2, GLuint arg2Rep,
                                   GLuint arg2Mod);
typedef void (* glColorFragmentOp3EXTProcPtr) (GLenum op, GLuint dst, GLuint dstMask,
                                   GLuint dstMod, GLuint arg1, GLuint arg1Rep,
                                   GLuint arg1Mod, GLuint arg2, GLuint arg2Rep,
                                   GLuint arg2Mod, GLuint arg3, GLuint arg3Rep,
                                   GLuint arg3Mod);
typedef void (* glAlphaFragmentOp1EXTProcPtr) (GLenum op, GLuint dst, GLuint dstMod,
                                   GLuint arg1, GLuint arg1Rep, GLuint arg1Mod);
typedef void (* glAlphaFragmentOp2EXTProcPtr) (GLenum op, GLuint dst, GLuint dstMod,
                                   GLuint arg1, GLuint arg1Rep, GLuint arg1Mod,
                                   GLuint arg2, GLuint arg2Rep, GLuint arg2Mod);
typedef void (* glAlphaFragmentOp3EXTProcPtr) (GLenum op, GLuint dst, GLuint dstMod,
                                   GLuint arg1, GLuint arg1Rep, GLuint arg1Mod,
                                   GLuint arg2, GLuint arg2Rep, GLuint arg2Mod,
                                   GLuint arg3, GLuint arg3Rep, GLuint arg3Mod);
typedef void (* glSetFragmentShaderConstantEXTProcPtr) (GLuint dst, const GLfloat *value);
|#

; #else

(deftrap-inline "_glGenFragmentShadersEXT" 
   ((range :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_glBindFragmentShaderEXT" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glDeleteFragmentShaderEXT" 
   ((id :UInt32)
   )
   nil
() )

(deftrap-inline "_glBeginFragmentShaderEXT" 
   (
   )
   nil
() )

(deftrap-inline "_glEndFragmentShaderEXT" 
   (
   )
   nil
() )

(deftrap-inline "_glPassTexCoordEXT" 
   ((dst :UInt32)
    (coord :UInt32)
    (swizzle :UInt32)
   )
   nil
() )

(deftrap-inline "_glSampleMapEXT" 
   ((dst :UInt32)
    (interp :UInt32)
    (swizzle :UInt32)
   )
   nil
() )

(deftrap-inline "_glColorFragmentOp1EXT" 
   ((op :UInt32)
    (dst :UInt32)
    (dstMask :UInt32)
    (dstMod :UInt32)
    (arg1 :UInt32)
    (arg1Rep :UInt32)
    (arg1Mod :UInt32)
   )
   nil
() )

(deftrap-inline "_glColorFragmentOp2EXT" 
   ((op :UInt32)
    (dst :UInt32)
    (dstMask :UInt32)
    (dstMod :UInt32)
    (arg1 :UInt32)
    (arg1Rep :UInt32)
    (arg1Mod :UInt32)
    (arg2 :UInt32)
    (arg2Rep :UInt32)
    (arg2Mod :UInt32)
   )
   nil
() )

(deftrap-inline "_glColorFragmentOp3EXT" 
   ((op :UInt32)
    (dst :UInt32)
    (dstMask :UInt32)
    (dstMod :UInt32)
    (arg1 :UInt32)
    (arg1Rep :UInt32)
    (arg1Mod :UInt32)
    (arg2 :UInt32)
    (arg2Rep :UInt32)
    (arg2Mod :UInt32)
    (arg3 :UInt32)
    (arg3Rep :UInt32)
    (arg3Mod :UInt32)
   )
   nil
() )

(deftrap-inline "_glAlphaFragmentOp1EXT" 
   ((op :UInt32)
    (dst :UInt32)
    (dstMod :UInt32)
    (arg1 :UInt32)
    (arg1Rep :UInt32)
    (arg1Mod :UInt32)
   )
   nil
() )

(deftrap-inline "_glAlphaFragmentOp2EXT" 
   ((op :UInt32)
    (dst :UInt32)
    (dstMod :UInt32)
    (arg1 :UInt32)
    (arg1Rep :UInt32)
    (arg1Mod :UInt32)
    (arg2 :UInt32)
    (arg2Rep :UInt32)
    (arg2Mod :UInt32)
   )
   nil
() )

(deftrap-inline "_glAlphaFragmentOp3EXT" 
   ((op :UInt32)
    (dst :UInt32)
    (dstMod :UInt32)
    (arg1 :UInt32)
    (arg1Rep :UInt32)
    (arg1Mod :UInt32)
    (arg2 :UInt32)
    (arg2Rep :UInt32)
    (arg2Mod :UInt32)
    (arg3 :UInt32)
    (arg3Rep :UInt32)
    (arg3Mod :UInt32)
   )
   nil
() )

(deftrap-inline "_glSetFragmentShaderConstantEXT" 
   ((dst :UInt32)
    (value (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_MESA_resize_buffers
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glResizeBuffersMESAProcPtr) (void);
|#

; #else

(deftrap-inline "_glResizeBuffersMESA" 
   (
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_ARB_window_pos
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glWindowPos2dARBProcPtr) (GLdouble, GLdouble);
typedef void (* glWindowPos2dvARBProcPtr) (const GLdouble *);
typedef void (* glWindowPos2fARBProcPtr) (GLfloat, GLfloat);
typedef void (* glWindowPos2fvARBProcPtr) (const GLfloat *);
typedef void (* glWindowPos2iARBProcPtr) (GLint, GLint);
typedef void (* glWindowPos2ivARBProcPtr) (const GLint *);
typedef void (* glWindowPos2sARBProcPtr) (GLshort, GLshort);
typedef void (* glWindowPos2svARBProcPtr) (const GLshort *);
typedef void (* glWindowPos3dARBProcPtr) (GLdouble, GLdouble, GLdouble);
typedef void (* glWindowPos3dvARBProcPtr) (const GLdouble *);
typedef void (* glWindowPos3fARBProcPtr) (GLfloat, GLfloat, GLfloat);
typedef void (* glWindowPos3fvARBProcPtr) (const GLfloat *);
typedef void (* glWindowPos3iARBProcPtr) (GLint, GLint, GLint);
typedef void (* glWindowPos3ivARBProcPtr) (const GLint *);
typedef void (* glWindowPos3sARBProcPtr) (GLshort, GLshort, GLshort);
typedef void (* glWindowPos3svARBProcPtr) (const GLshort *);
|#
 |#

; #else

(deftrap-inline "_glWindowPos2dARB" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos2dvARB" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glWindowPos2fARB" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos2fvARB" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glWindowPos2iARB" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glWindowPos2ivARB" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glWindowPos2sARB" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glWindowPos2svARB" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glWindowPos3dARB" 
   ((ARG2 :double-float)
    (ARG2 :double-float)
    (ARG2 :double-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos3dvARB" 
   ((ARGH (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glWindowPos3fARB" 
   ((ARG2 :single-float)
    (ARG2 :single-float)
    (ARG2 :single-float)
   )
   nil
() )

(deftrap-inline "_glWindowPos3fvARB" 
   ((ARGH (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glWindowPos3iARB" 
   ((ARG2 :signed-long)
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glWindowPos3ivARB" 
   ((ARGH (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glWindowPos3sARB" 
   ((ARG2 :SInt16)
    (ARG2 :SInt16)
    (ARG2 :SInt16)
   )
   nil
() )

(deftrap-inline "_glWindowPos3svARB" 
   ((ARGH (:pointer :GLSHORT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_IBM_multimode_draw_arrays
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glMultiModeDrawArraysIBMProcPtr) (GLenum, const GLint *, const GLsizei *, GLsizei, GLint);
typedef void (* glMultiModeDrawElementsIBMProcPtr) (const GLenum *, const GLsizei *, GLenum, const GLvoid* *, GLsizei, GLint);
|#

; #else

(deftrap-inline "_glMultiModeDrawArraysIBM" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLINT))
    (ARGH (:pointer :GLSIZEI))
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glMultiModeDrawElementsIBM" 
   ((ARGH (:pointer :GLENUM))
    (ARGH (:pointer :GLSIZEI))
    (ARG2 :UInt32)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_IBM_vertex_array_lists
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glColorPointerListIBMProcPtr) (GLint, GLenum, GLint, const GLvoid* *, GLint);
typedef void (* glSecondaryColorPointerListIBMProcPtr) (GLint, GLenum, GLint, const GLvoid* *, GLint);
typedef void (* glEdgeFlagPointerListIBMProcPtr) (GLint, const GLboolean* *, GLint);
typedef void (* glFogCoordPointerListIBMProcPtr) (GLenum, GLint, const GLvoid* *, GLint);
typedef void (* glIndexPointerListIBMProcPtr) (GLenum, GLint, const GLvoid* *, GLint);
typedef void (* glNormalPointerListIBMProcPtr) (GLenum, GLint, const GLvoid* *, GLint);
typedef void (* glTexCoordPointerListIBMProcPtr) (GLint, GLenum, GLint, const GLvoid* *, GLint);
typedef void (* glVertexPointerListIBMProcPtr) (GLint, GLenum, GLint, const GLvoid* *, GLint);
|#

; #else

(deftrap-inline "_glColorPointerListIBM" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glSecondaryColorPointerListIBM" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glEdgeFlagPointerListIBM" 
   ((ARG2 :signed-long)
    (* (:pointer :GLBOOLEAN))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glFogCoordPointerListIBM" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glIndexPointerListIBM" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glNormalPointerListIBM" 
   ((ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glTexCoordPointerListIBM" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_glVertexPointerListIBM" 
   ((ARG2 :signed-long)
    (ARG2 :UInt32)
    (ARG2 :signed-long)
    (* (:pointer :GLVOID))
    (ARG2 :signed-long)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_3DFX_tbuffer
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTbufferMask3DFXProcPtr) (GLuint);
|#

; #else

(deftrap-inline "_glTbufferMask3DFX" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_EXT_multisample
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glSampleMaskEXTProcPtr) (GLclampf, GLboolean);
typedef void (* glSamplePatternEXTProcPtr) (GLenum);
|#

; #else

(deftrap-inline "_glSampleMaskEXT" 
   ((ARG2 :single-float)
    (ARG2 :UInt8)
   )
   nil
() )

(deftrap-inline "_glSamplePatternEXT" 
   ((ARG2 :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIS_texture_color_mask
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glTextureColorMaskSGISProcPtr) (GLboolean, GLboolean, GLboolean, GLboolean);
|#

; #else

(deftrap-inline "_glTextureColorMaskSGIS" 
   ((ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
    (ARG2 :UInt8)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_SGIX_igloo_interface
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glIglooInterfaceSGIXProcPtr) (GLenum, const GLvoid *);
|#

; #else

(deftrap-inline "_glIglooInterfaceSGIX" 
   ((ARG2 :UInt32)
    (ARGH (:pointer :GLVOID))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_NV_vertex_program
#| ; #ifdef GL_GLEXT_FUNCTION_POINTERS
#|
typedef void (* glBindProgramNVProcPtr) (GLenum target, GLuint id);
typedef void (* glDeleteProgramsNVProcPtr) (GLsizei n, const GLuint *ids);
typedef void (* glExecuteProgramNVProcPtr) (GLenum target, GLuint id, const GLfloat *params);
typedef void (* glGenProgramsNVProcPtr) (GLsizei n, GLuint *ids);
typedef GLboolean (* glAreProgramsResidentNVProcPtr) (GLsizei n, const GLuint *ids, GLboolean *residences);
typedef void (* glRequestResidentProgramsNVProcPtr) (GLsizei n, GLuint *ids);
typedef void (* glGetProgramParameterfvNVProcPtr) (GLenum target, GLuint index, GLenum pname, GLfloat *params);
typedef void (* glGetProgramParameterdvNVProcPtr) (GLenum target, GLuint index, GLenum pname, GLdouble *params);
typedef void (* glGetProgramivNVProcPtr) (GLuint id, GLenum pname, GLint *params);
typedef void (* glGetProgramStringNVProcPtr) (GLuint id, GLenum pname, GLubyte *program);
typedef void (* glGetTrackMatrixivNVProcPtr) (GLenum target, GLuint address, GLenum pname, GLint *params);
typedef void (* glGetVertexAttribdvNVProcPtr) (GLuint index, GLenum pname, GLdouble *params);
typedef void (* glGetVertexAttribfvNVProcPtr) (GLuint index, GLenum pname, GLfloat *params);
typedef void (* glGetVertexAttribivNVProcPtr) (GLuint index, GLenum pname, GLint *params);
typedef void (* glGetVertexAttribPointervNVProcPtr) (GLuint index, GLenum pname, GLvoid **pointer);
typedef GLboolean (* glIsProgramNVProcPtr) (GLuint id);
typedef void (* glLoadProgramNVProcPtr) (GLenum target, GLuint id, GLsizei len, const GLubyte *program);
typedef void (* glProgramParameter4fNVProcPtr) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glProgramParameter4dNVProcPtr) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glProgramParameter4dvNVProcPtr) (GLenum target, GLuint index, const GLdouble *params);
typedef void (* glProgramParameter4fvNVProcPtr) (GLenum target, GLuint index, const GLfloat *params);
typedef void (* glProgramParameters4dvNVProcPtr) (GLenum target, GLuint index, GLuint num, const GLdouble *params);
typedef void (* glProgramParameters4fvNVProcPtr) (GLenum target, GLuint index, GLuint num, const GLfloat *params);
typedef void (* glTrackMatrixNVProcPtr) (GLenum target, GLuint address, GLenum matrix, GLenum transform);
typedef void (* glVertexAttribPointerNVProcPtr) (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* glVertexAttrib1sNVProcPtr) (GLuint index, GLshort x);
typedef void (* glVertexAttrib1fNVProcPtr) (GLuint index, GLfloat x);
typedef void (* glVertexAttrib1dNVProcPtr) (GLuint index, GLdouble x);
typedef void (* glVertexAttrib2sNVProcPtr) (GLuint index, GLshort x, GLshort y);
typedef void (* glVertexAttrib2fNVProcPtr) (GLuint index, GLfloat x, GLfloat y);
typedef void (* glVertexAttrib2dNVProcPtr) (GLuint index, GLdouble x, GLdouble y);
typedef void (* glVertexAttrib3sNVProcPtr) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void (* glVertexAttrib3fNVProcPtr) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void (* glVertexAttrib3dNVProcPtr) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void (* glVertexAttrib4sNVProcPtr) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* glVertexAttrib4fNVProcPtr) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glVertexAttrib4dNVProcPtr) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glVertexAttrib4ubNVProcPtr) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void (* glVertexAttrib1svNVProcPtr) (GLuint index, GLshort *v);
typedef void (* glVertexAttrib1fvNVProcPtr) (GLuint index, GLfloat *v);
typedef void (* glVertexAttrib1dvNVProcPtr) (GLuint index, GLdouble *v);
typedef void (* glVertexAttrib2svNVProcPtr) (GLuint index, GLshort *v);
typedef void (* glVertexAttrib2fvNVProcPtr) (GLuint index, GLfloat *v);
typedef void (* glVertexAttrib2dvNVProcPtr) (GLuint index, GLdouble *v);
typedef void (* glVertexAttrib3svNVProcPtr) (GLuint index, GLshort *v);
typedef void (* glVertexAttrib3fvNVProcPtr) (GLuint index, GLfloat *v);
typedef void (* glVertexAttrib3dvNVProcPtr) (GLuint index, GLdouble *v);
typedef void (* glVertexAttrib4svNVProcPtr) (GLuint index, GLshort *v);
typedef void (* glVertexAttrib4fvNVProcPtr) (GLuint index, GLfloat *v);
typedef void (* glVertexAttrib4dvNVProcPtr) (GLuint index, GLdouble *v);
typedef void (* glVertexAttrib4ubvNVProcPtr) (GLuint index, GLubyte *v);
typedef void (* glVertexAttribs1svNVProcPtr) (GLuint index, GLsizei n, GLshort *v);
typedef void (* glVertexAttribs1fvNVProcPtr) (GLuint index, GLsizei n, GLfloat *v);
typedef void (* glVertexAttribs1dvNVProcPtr) (GLuint index, GLsizei n, GLdouble *v);
typedef void (* glVertexAttribs2svNVProcPtr) (GLuint index, GLsizei n, GLshort *v);
typedef void (* glVertexAttribs2fvNVProcPtr) (GLuint index, GLsizei n, GLfloat *v);
typedef void (* glVertexAttribs2dvNVProcPtr) (GLuint index, GLsizei n, GLdouble *v);
typedef void (* glVertexAttribs3svNVProcPtr) (GLuint index, GLsizei n, GLshort *v);
typedef void (* glVertexAttribs3fvNVProcPtr) (GLuint index, GLsizei n, GLfloat *v);
typedef void (* glVertexAttribs3dvNVProcPtr) (GLuint index, GLsizei n, GLdouble *v);
typedef void (* glVertexAttribs4svNVProcPtr) (GLuint index, GLsizei n, GLshort *v);
typedef void (* glVertexAttribs4fvNVProcPtr) (GLuint index, GLsizei n, GLfloat *v);
typedef void (* glVertexAttribs4dvNVProcPtr) (GLuint index, GLsizei n, GLdouble *v);
typedef void (* glVertexAttribs4ubvNVProcPtr) (GLuint index, GLsizei n, GLubyte *v);
|#

; #else

(deftrap-inline "_glBindProgramNV" 
   ((target :UInt32)
    (id :UInt32)
   )
   nil
() )

(deftrap-inline "_glDeleteProgramsNV" 
   ((n :signed-long)
    (ids (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glExecuteProgramNV" 
   ((target :UInt32)
    (id :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGenProgramsNV" 
   ((n :signed-long)
    (ids (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glAreProgramsResidentNV" 
   ((n :signed-long)
    (ids (:pointer :GLUINT))
    (residences (:pointer :GLBOOLEAN))
   )
   :UInt8
() )

(deftrap-inline "_glRequestResidentProgramsNV" 
   ((n :signed-long)
    (ids (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glGetProgramParameterfvNV" 
   ((target :UInt32)
    (index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetProgramParameterdvNV" 
   ((target :UInt32)
    (index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetProgramivNV" 
   ((id :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetProgramStringNV" 
   ((id :UInt32)
    (pname :UInt32)
    (program (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glGetTrackMatrixivNV" 
   ((target :UInt32)
    (address :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribdvNV" 
   ((index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribfvNV" 
   ((index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribivNV" 
   ((index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribPointervNV" 
   ((index :UInt32)
    (pname :UInt32)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glIsProgramNV" 
   ((id :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glLoadProgramNV" 
   ((target :UInt32)
    (id :UInt32)
    (len :signed-long)
    (program (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glProgramParameter4fNV" 
   ((target :UInt32)
    (index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glProgramParameter4dNV" 
   ((target :UInt32)
    (index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glProgramParameter4dvNV" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glProgramParameter4fvNV" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glProgramParameters4dvNV" 
   ((target :UInt32)
    (index :UInt32)
    (num :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glProgramParameters4fvNV" 
   ((target :UInt32)
    (index :UInt32)
    (num :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glTrackMatrixNV" 
   ((target :UInt32)
    (address :UInt32)
    (matrix :UInt32)
    (transform :UInt32)
   )
   nil
() )

(deftrap-inline "_glVertexAttribPointerNV" 
   ((index :UInt32)
    (size :signed-long)
    (type :UInt32)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1sNV" 
   ((index :UInt32)
    (x :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1fNV" 
   ((index :UInt32)
    (x :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1dNV" 
   ((index :UInt32)
    (x :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2sNV" 
   ((index :UInt32)
    (x :SInt16)
    (y :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2fNV" 
   ((index :UInt32)
    (x :single-float)
    (y :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2dNV" 
   ((index :UInt32)
    (x :double-float)
    (y :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3sNV" 
   ((index :UInt32)
    (x :SInt16)
    (y :SInt16)
    (z :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3fNV" 
   ((index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3dNV" 
   ((index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4sNV" 
   ((index :UInt32)
    (x :SInt16)
    (y :SInt16)
    (z :SInt16)
    (w :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4fNV" 
   ((index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4dNV" 
   ((index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4ubNV" 
   ((index :UInt32)
    (x :UInt8)
    (y :UInt8)
    (z :UInt8)
    (w :UInt8)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1svNV" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1fvNV" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1dvNV" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2svNV" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2fvNV" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2dvNV" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3svNV" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3fvNV" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3dvNV" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4svNV" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4fvNV" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4dvNV" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4ubvNV" 
   ((index :UInt32)
    (v (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs1svNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs1fvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs1dvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs2svNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs2fvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs2dvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs3svNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs3fvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs3dvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs4svNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs4fvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs4dvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttribs4ubvNV" 
   ((index :UInt32)
    (n :signed-long)
    (v (:pointer :GLUBYTE))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */

 |#

; #endif


; #if GL_NV_point_sprite
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glPointParameteriNVProcPtr) (GLenum pname, GLint param);
typedef void (* glPointParameterivNVProcPtr) (GLenum pname, const GLint *params);
|#
 |#

; #else

(deftrap-inline "_glPointParameteriNV" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glPointParameterivNV" 
   ((pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ATI_pn_triangles
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glPNTrianglesiATIProcPtr) (GLenum pname, GLint param);
typedef void (* glPNTrianglesfATIProcPtr) (GLenum pname, GLfloat param);
|#
 |#

; #else

(deftrap-inline "_glPNTrianglesiATI" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glPNTrianglesfATI" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ATIX_pn_triangles
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glPNTrianglesiATIXProcPtr) (GLenum pname, GLint param);
typedef void (* glPNTrianglesfATIXProcPtr) (GLenum pname, GLfloat param);
|#
 |#

; #else

(deftrap-inline "_glPNTrianglesiATIX" 
   ((pname :UInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_glPNTrianglesfATIX" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ATI_blend_equation_separate
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBlendEquationSeparateATIProcPtr) (GLenum equationRGB, GLenum equationAlpha);
|#
 |#

; #else

(deftrap-inline "_glBlendEquationSeparateATI" 
   ((equationRGB :UInt32)
    (equationAlpha :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ATI_separate_stencil
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glStencilOpSeparateATIProcPtr) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
typedef void (* glStencilFuncSeparateATIProcPtr) (GLenum frontfunc, GLenum backfunc, GLint ref, GLuint mask);
|#
 |#

; #else

(deftrap-inline "_glStencilOpSeparateATI" 
   ((face :UInt32)
    (sfail :UInt32)
    (dpfail :UInt32)
    (dppass :UInt32)
   )
   nil
() )

(deftrap-inline "_glStencilFuncSeparateATI" 
   ((frontfunc :UInt32)
    (backfunc :UInt32)
    (ref :signed-long)
    (mask :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_point_parameters
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glPointParameterfARBProcPtr) (GLenum pname, GLfloat param);
typedef void (* glPointParameterfvARBProcPtr) (GLenum pname, const GLfloat *params);
|#
 |#

; #else

(deftrap-inline "_glPointParameterfARB" 
   ((pname :UInt32)
    (param :single-float)
   )
   nil
() )

(deftrap-inline "_glPointParameterfvARB" 
   ((pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_ARB_vertex_program
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glBindProgramARBProcPtr) (GLenum target, GLuint program);
typedef void (* glDeleteProgramsARBProcPtr) (GLsizei n, const GLuint *programs);
typedef void (* glGenProgramsARBProcPtr) (GLsizei n, GLuint *programs);
typedef GLboolean (* glIsProgramARBProcPtr) (GLuint program);

typedef void (* glVertexAttrib1sARBProcPtr) (GLuint index, GLshort x);
typedef void (* glVertexAttrib1fARBProcPtr) (GLuint index, GLfloat x);
typedef void (* glVertexAttrib1dARBProcPtr) (GLuint index, GLdouble x);
typedef void (* glVertexAttrib2sARBProcPtr) (GLuint index, GLshort x, GLshort y);
typedef void (* glVertexAttrib2fARBProcPtr) (GLuint index, GLfloat x, GLfloat y);
typedef void (* glVertexAttrib2dARBProcPtr) (GLuint index, GLdouble x, GLdouble y);
typedef void (* glVertexAttrib3sARBProcPtr) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void (* glVertexAttrib3fARBProcPtr) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void (* glVertexAttrib3dARBProcPtr) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void (* glVertexAttrib4sARBProcPtr) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* glVertexAttrib4fARBProcPtr) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glVertexAttrib4dARBProcPtr) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glVertexAttrib4NubARBProcPtr) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void (* glVertexAttrib1svARBProcPtr) (GLuint index, const GLshort *v);
typedef void (* glVertexAttrib1fvARBProcPtr) (GLuint index, const GLfloat *v);
typedef void (* glVertexAttrib1dvARBProcPtr) (GLuint index, const GLdouble *v);
typedef void (* glVertexAttrib2svARBProcPtr) (GLuint index, const GLshort *v);
typedef void (* glVertexAttrib2fvARBProcPtr) (GLuint index, const GLfloat *v);
typedef void (* glVertexAttrib2dvARBProcPtr) (GLuint index, const GLdouble *v);
typedef void (* glVertexAttrib3svARBProcPtr) (GLuint index, const GLshort *v);
typedef void (* glVertexAttrib3fvARBProcPtr) (GLuint index, const GLfloat *v);
typedef void (* glVertexAttrib3dvARBProcPtr) (GLuint index, const GLdouble *v);
typedef void (* glVertexAttrib4bvARBProcPtr) (GLuint index, const GLbyte *v);
typedef void (* glVertexAttrib4svARBProcPtr) (GLuint index, const GLshort *v);
typedef void (* glVertexAttrib4ivARBProcPtr) (GLuint index, const GLint *v);
typedef void (* glVertexAttrib4ubvARBProcPtr) (GLuint index, const GLubyte *v);
typedef void (* glVertexAttrib4usvARBProcPtr) (GLuint index, const GLushort *v);
typedef void (* glVertexAttrib4uivARBProcPtr) (GLuint index, const GLuint *v);
typedef void (* glVertexAttrib4fvARBProcPtr) (GLuint index, const GLfloat *v);
typedef void (* glVertexAttrib4dvARBProcPtr) (GLuint index, const GLdouble *v);
typedef void (* glVertexAttrib4NbvARBProcPtr) (GLuint index, const GLbyte *v);
typedef void (* glVertexAttrib4NsvARBProcPtr) (GLuint index, const GLshort *v);
typedef void (* glVertexAttrib4NivARBProcPtr) (GLuint index, const GLint *v);
typedef void (* glVertexAttrib4NubvARBProcPtr) (GLuint index, const GLubyte *v);
typedef void (* glVertexAttrib4NusvARBProcPtr) (GLuint index, const GLushort *v);
typedef void (* glVertexAttrib4NuivARBProcPtr) (GLuint index, const GLuint *v);

typedef void (* glVertexAttribPointerARBProcPtr) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);

typedef void (* glEnableVertexAttribArrayARBProcPtr) (GLuint index);
typedef void (* glDisableVertexAttribArrayARBProcPtr) (GLuint index);

typedef void (* glGetVertexAttribdvARBProcPtr) (GLuint index, GLenum pname, GLdouble *params);
typedef void (* glGetVertexAttribfvARBProcPtr) (GLuint index, GLenum pname, GLfloat *params);
typedef void (* glGetVertexAttribivARBProcPtr) (GLuint index, GLenum pname, GLint *params);
typedef void (* glGetVertexAttribPointervARBProcPtr) (GLuint index, GLenum pname, GLvoid **pointer);

typedef void (* glProgramEnvParameter4dARBProcPtr) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glProgramEnvParameter4dvARBProcPtr) (GLenum target, GLuint index, const GLdouble *params);
typedef void (* glProgramEnvParameter4fARBProcPtr) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glProgramEnvParameter4fvARBProcPtr) (GLenum target, GLuint index, const GLfloat *params);
typedef void (* glProgramLocalParameter4dARBProcPtr) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* glProgramLocalParameter4dvARBProcPtr) (GLenum target, GLuint index, const GLdouble *params);
typedef void (* glProgramLocalParameter4fARBProcPtr) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* glProgramLocalParameter4fvARBProcPtr) (GLenum target, GLuint index, const GLfloat *params);

typedef void (* glGetProgramEnvParameterdvARBProcPtr) (GLenum target, GLuint index, GLdouble *params);
typedef void (* glGetProgramEnvParameterfvARBProcPtr) (GLenum target, GLuint index, GLfloat *params);
typedef void (* glGetProgramLocalParameterdvARBProcPtr) (GLenum target, GLuint index, GLdouble *params);
typedef void (* glGetProgramLocalParameterfvARBProcPtr) (GLenum target, GLuint index, GLfloat *params);

typedef void (* glProgramStringARBProcPtr) (GLenum target, GLenum format, GLsizei len, const GLvoid *string); 
typedef void (* glGetProgramStringARBProcPtr) (GLenum target, GLenum pname, GLvoid *string);

typedef void (* glGetProgramivARBProcPtr) (GLenum target, GLenum pname, GLint *params);
|#
 |#

; #else

(deftrap-inline "_glBindProgramARB" 
   ((target :UInt32)
    (program :UInt32)
   )
   nil
() )

(deftrap-inline "_glDeleteProgramsARB" 
   ((n :signed-long)
    (programs (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glGenProgramsARB" 
   ((n :signed-long)
    (programs (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glIsProgramARB" 
   ((program :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glVertexAttrib1sARB" 
   ((index :UInt32)
    (x :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1fARB" 
   ((index :UInt32)
    (x :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1dARB" 
   ((index :UInt32)
    (x :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2sARB" 
   ((index :UInt32)
    (x :SInt16)
    (y :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2fARB" 
   ((index :UInt32)
    (x :single-float)
    (y :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2dARB" 
   ((index :UInt32)
    (x :double-float)
    (y :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3sARB" 
   ((index :UInt32)
    (x :SInt16)
    (y :SInt16)
    (z :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3fARB" 
   ((index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3dARB" 
   ((index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4sARB" 
   ((index :UInt32)
    (x :SInt16)
    (y :SInt16)
    (z :SInt16)
    (w :SInt16)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4fARB" 
   ((index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4dARB" 
   ((index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NubARB" 
   ((index :UInt32)
    (x :UInt8)
    (y :UInt8)
    (z :UInt8)
    (w :UInt8)
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1svARB" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1fvARB" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib1dvARB" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2svARB" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2fvARB" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib2dvARB" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3svARB" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3fvARB" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib3dvARB" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4bvARB" 
   ((index :UInt32)
    (v (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4svARB" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4ivARB" 
   ((index :UInt32)
    (v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4ubvARB" 
   ((index :UInt32)
    (v (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4usvARB" 
   ((index :UInt32)
    (v (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4uivARB" 
   ((index :UInt32)
    (v (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4fvARB" 
   ((index :UInt32)
    (v (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4dvARB" 
   ((index :UInt32)
    (v (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NbvARB" 
   ((index :UInt32)
    (v (:pointer :GLBYTE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NsvARB" 
   ((index :UInt32)
    (v (:pointer :GLSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NivARB" 
   ((index :UInt32)
    (v (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NubvARB" 
   ((index :UInt32)
    (v (:pointer :GLUBYTE))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NusvARB" 
   ((index :UInt32)
    (v (:pointer :GLUSHORT))
   )
   nil
() )

(deftrap-inline "_glVertexAttrib4NuivARB" 
   ((index :UInt32)
    (v (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_glVertexAttribPointerARB" 
   ((index :UInt32)
    (size :signed-long)
    (type :UInt32)
    (normalized :UInt8)
    (stride :signed-long)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glEnableVertexAttribArrayARB" 
   ((index :UInt32)
   )
   nil
() )

(deftrap-inline "_glDisableVertexAttribArrayARB" 
   ((index :UInt32)
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribdvARB" 
   ((index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribfvARB" 
   ((index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribivARB" 
   ((index :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_glGetVertexAttribPointervARB" 
   ((index :UInt32)
    (pname :UInt32)
    (pointer (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glProgramEnvParameter4dARB" 
   ((target :UInt32)
    (index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glProgramEnvParameter4dvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glProgramEnvParameter4fARB" 
   ((target :UInt32)
    (index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glProgramEnvParameter4fvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glProgramLocalParameter4dARB" 
   ((target :UInt32)
    (index :UInt32)
    (x :double-float)
    (y :double-float)
    (z :double-float)
    (w :double-float)
   )
   nil
() )

(deftrap-inline "_glProgramLocalParameter4dvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glProgramLocalParameter4fARB" 
   ((target :UInt32)
    (index :UInt32)
    (x :single-float)
    (y :single-float)
    (z :single-float)
    (w :single-float)
   )
   nil
() )

(deftrap-inline "_glProgramLocalParameter4fvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetProgramEnvParameterdvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetProgramEnvParameterfvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glGetProgramLocalParameterdvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glGetProgramLocalParameterfvARB" 
   ((target :UInt32)
    (index :UInt32)
    (params (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glProgramStringARB" 
   ((target :UInt32)
    (format :UInt32)
    (len :signed-long)
    (string (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetProgramStringARB" 
   ((target :UInt32)
    (pname :UInt32)
    (string (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glGetProgramivARB" 
   ((target :UInt32)
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_APPLE_vertex_program_evaluators
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glEnableVertexAttribAPPLEProcPtr) (GLuint index, GLenum pname);
typedef void (* glDisableVertexAttribAPPLEProcPtr) (GLuint index, GLenum pname);
typedef GLboolean (* glIsVertexAttribEnabledAPPLEProcPtr) (GLuint index, GLenum pname);
typedef void (* glMapVertexAttrib1dAPPLEProcPtr) (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points);
typedef void (* glMapVertexAttrib1fAPPLEProcPtr) (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points);
typedef void (* glMapVertexAttrib2dAPPLEProcPtr) (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points);
typedef void (* glMapVertexAttrib2fAPPLEProcPtr) (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points);
|#
 |#

; #else

(deftrap-inline "_glEnableVertexAttribAPPLE" 
   ((index :UInt32)
    (pname :UInt32)
   )
   nil
() )

(deftrap-inline "_glDisableVertexAttribAPPLE" 
   ((index :UInt32)
    (pname :UInt32)
   )
   nil
() )

(deftrap-inline "_glIsVertexAttribEnabledAPPLE" 
   ((index :UInt32)
    (pname :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_glMapVertexAttrib1dAPPLE" 
   ((index :UInt32)
    (size :UInt32)
    (u1 :double-float)
    (u2 :double-float)
    (stride :signed-long)
    (order :signed-long)
    (points (:pointer :GLDOUBLE))
   )
   nil
() )

(deftrap-inline "_glMapVertexAttrib1fAPPLE" 
   ((index :UInt32)
    (size :UInt32)
    (u1 :single-float)
    (u2 :single-float)
    (stride :signed-long)
    (order :signed-long)
    (points (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_glMapVertexAttrib2dAPPLE" 
   ((index :UInt32)
    (size :UInt32)
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

(deftrap-inline "_glMapVertexAttrib2fAPPLE" 
   ((index :UInt32)
    (size :UInt32)
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

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif


; #if GL_EXT_stencil_two_side
; #ifdef GL_GLEXT_FUNCTION_POINTERS
#| #|
typedef void (* glActiveStencilFaceEXTProcPtr) (GLenum face);
|#
 |#

; #else

(deftrap-inline "_glActiveStencilFaceEXT" 
   ((face :UInt32)
   )
   nil
() )

; #endif /* GL_GLEXT_FUNCTION_POINTERS */


; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "glext")