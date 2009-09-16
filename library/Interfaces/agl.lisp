(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:agl.h"
; at Sunday July 2,2006 7:25:32 pm.
; 
;     File:	    AGL/agl.h
; 
;     Contains:	Basic AGL data types, constants and function prototypes.
; 
;     Version:	Technology:	Mac OS X
;                 Release:	GM
;  
;      Copyright:  (c) 2000, 2001, 2002, 2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                  http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _AGL_H
; #define _AGL_H

; #if defined (__MACH__)
#| 
; #import <AvailabilityMacros.h>

; #import <Carbon/Carbon.h>

; #import <OpenGL/gl.h>
 |#

; #else
; #define AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER 
; #define AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER 

(require-interface "Carbon")

(require-interface "gl")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** AGL API version.
; 
(defconstant $AGL_VERSION_2_0 1)
; #define AGL_VERSION_2_0  1
; 
; ** Macintosh device type.
; 

(def-mactype :AGLDevice (find-mactype ':GDHandle))
; 
; ** Macintosh drawable type.
; 

(def-mactype :AGLDrawable (find-mactype ':CGrafPtr))
; 
; ** AGL opaque data.
; 

(def-mactype :AGLRendererInfo (find-mactype '(:pointer :__AGLRendererInfoRec)))

(def-mactype :AGLPixelFormat (find-mactype '(:pointer :__AGLPixelFormatRec)))

(def-mactype :AGLContext (find-mactype '(:pointer :__AGLContextRec)))

(def-mactype :AGLPbuffer (find-mactype '(:pointer :__AGLPBufferRec)))
; **********************************************************************
; 
; ** Attribute names for aglChoosePixelFormat and aglDescribePixelFormat.
; 
(defconstant $AGL_NONE 0)
; #define AGL_NONE                   0
(defconstant $AGL_ALL_RENDERERS 1)
; #define AGL_ALL_RENDERERS          1  /* choose from all available renderers          */
(defconstant $AGL_BUFFER_SIZE 2)
; #define AGL_BUFFER_SIZE            2  /* depth of the index buffer                    */
(defconstant $AGL_LEVEL 3)
; #define AGL_LEVEL                  3  /* level in plane stacking                      */
(defconstant $AGL_RGBA 4)
; #define AGL_RGBA                   4  /* choose an RGBA format                        */
(defconstant $AGL_DOUBLEBUFFER 5)
; #define AGL_DOUBLEBUFFER           5  /* double buffering supported                   */
(defconstant $AGL_STEREO 6)
; #define AGL_STEREO                 6  /* stereo buffering supported                   */
(defconstant $AGL_AUX_BUFFERS 7)
; #define AGL_AUX_BUFFERS            7  /* number of aux buffers                        */
(defconstant $AGL_RED_SIZE 8)
; #define AGL_RED_SIZE               8  /* number of red component bits                 */
(defconstant $AGL_GREEN_SIZE 9)
; #define AGL_GREEN_SIZE             9  /* number of green component bits               */
(defconstant $AGL_BLUE_SIZE 10)
; #define AGL_BLUE_SIZE             10  /* number of blue component bits                */
(defconstant $AGL_ALPHA_SIZE 11)
; #define AGL_ALPHA_SIZE            11  /* number of alpha component bits               */
(defconstant $AGL_DEPTH_SIZE 12)
; #define AGL_DEPTH_SIZE            12  /* number of depth bits                         */
(defconstant $AGL_STENCIL_SIZE 13)
; #define AGL_STENCIL_SIZE          13  /* number of stencil bits                       */
(defconstant $AGL_ACCUM_RED_SIZE 14)
; #define AGL_ACCUM_RED_SIZE        14  /* number of red accum bits                     */
(defconstant $AGL_ACCUM_GREEN_SIZE 15)
; #define AGL_ACCUM_GREEN_SIZE      15  /* number of green accum bits                   */
(defconstant $AGL_ACCUM_BLUE_SIZE 16)
; #define AGL_ACCUM_BLUE_SIZE       16  /* number of blue accum bits                    */
(defconstant $AGL_ACCUM_ALPHA_SIZE 17)
; #define AGL_ACCUM_ALPHA_SIZE      17  /* number of alpha accum bits                   */
; 
; ** Extended attributes
; 
(defconstant $AGL_PIXEL_SIZE 50)
; #define AGL_PIXEL_SIZE            50  /* frame buffer bits per pixel                  */
(defconstant $AGL_MINIMUM_POLICY 51)
; #define AGL_MINIMUM_POLICY        51  /* never choose smaller buffers than requested  */
(defconstant $AGL_MAXIMUM_POLICY 52)
; #define AGL_MAXIMUM_POLICY        52  /* choose largest buffers of type requested     */
(defconstant $AGL_OFFSCREEN 53)
; #define AGL_OFFSCREEN             53  /* choose an off-screen capable renderer        */
(defconstant $AGL_FULLSCREEN 54)
; #define AGL_FULLSCREEN            54  /* choose a full-screen capable renderer        */
(defconstant $AGL_SAMPLE_BUFFERS_ARB 55)
; #define AGL_SAMPLE_BUFFERS_ARB    55  /* number of multi sample buffers               */
(defconstant $AGL_SAMPLES_ARB 56)
; #define AGL_SAMPLES_ARB	          56  /* number of samples per multi sample buffer    */
(defconstant $AGL_AUX_DEPTH_STENCIL 57)
; #define AGL_AUX_DEPTH_STENCIL	  57  /* independent depth and/or stencil buffers for the aux buffer */
;  Renderer management 
(defconstant $AGL_RENDERER_ID 70)
; #define AGL_RENDERER_ID           70  /* request renderer by ID                       */
(defconstant $AGL_SINGLE_RENDERER 71)
; #define AGL_SINGLE_RENDERER       71  /* choose a single renderer for all screens     */
(defconstant $AGL_NO_RECOVERY 72)
; #define AGL_NO_RECOVERY           72  /* disable all failure recovery systems         */
(defconstant $AGL_ACCELERATED 73)
; #define AGL_ACCELERATED           73  /* choose a hardware accelerated renderer       */
(defconstant $AGL_CLOSEST_POLICY 74)
; #define AGL_CLOSEST_POLICY        74  /* choose the closest color buffer to request   */
(defconstant $AGL_ROBUST 75)
; #define AGL_ROBUST                75  /* renderer does not need failure recovery      */
(defconstant $AGL_BACKING_STORE 76)
; #define AGL_BACKING_STORE         76  /* back buffer contents are valid after swap    */
(defconstant $AGL_MP_SAFE 78)
; #define AGL_MP_SAFE               78  /* renderer is multi-processor safe             */
; 
; ** Only for aglDescribePixelFormat
; 
(defconstant $AGL_WINDOW 80)
; #define AGL_WINDOW                80  /* can be used to render to an onscreen window  */
(defconstant $AGL_MULTISCREEN 81)
; #define AGL_MULTISCREEN           81  /* single window can span multiple screens      */
(defconstant $AGL_VIRTUAL_SCREEN 82)
; #define AGL_VIRTUAL_SCREEN        82  /* virtual screen number                        */
(defconstant $AGL_COMPLIANT 83)
; #define AGL_COMPLIANT             83  /* renderer is opengl compliant                 */
; 
; ** Property names for aglDescribeRenderer
; 
;  #define AGL_OFFSCREEN          53 
;  #define AGL_FULLSCREEN         54 
;  #define AGL_RENDERER_ID        70 
;  #define AGL_ACCELERATED        73 
;  #define AGL_ROBUST             75 
;  #define AGL_BACKING_STORE      76 
;  #define AGL_MP_SAFE            78 
;  #define AGL_WINDOW             80 
;  #define AGL_MULTISCREEN        81 
;  #define AGL_COMPLIANT          83 
(defconstant $AGL_BUFFER_MODES 100)
; #define AGL_BUFFER_MODES         100
(defconstant $AGL_MIN_LEVEL 101)
; #define AGL_MIN_LEVEL            101
(defconstant $AGL_MAX_LEVEL 102)
; #define AGL_MAX_LEVEL            102
(defconstant $AGL_COLOR_MODES 103)
; #define AGL_COLOR_MODES          103
(defconstant $AGL_ACCUM_MODES 104)
; #define AGL_ACCUM_MODES          104
(defconstant $AGL_DEPTH_MODES 105)
; #define AGL_DEPTH_MODES          105
(defconstant $AGL_STENCIL_MODES 106)
; #define AGL_STENCIL_MODES        106
(defconstant $AGL_MAX_AUX_BUFFERS 107)
; #define AGL_MAX_AUX_BUFFERS      107
(defconstant $AGL_VIDEO_MEMORY 120)
; #define AGL_VIDEO_MEMORY         120
(defconstant $AGL_TEXTURE_MEMORY 121)
; #define AGL_TEXTURE_MEMORY       121
; 
; ** Integer parameter names
; 
(defconstant $AGL_SWAP_RECT 200)
; #define AGL_SWAP_RECT	         200  /* Enable or set the swap rectangle              */
(defconstant $AGL_BUFFER_RECT 202)
; #define AGL_BUFFER_RECT          202  /* Enable or set the buffer rectangle            */
(defconstant $AGL_SWAP_LIMIT 203)
; #define AGL_SWAP_LIMIT           203  /* Enable or disable the swap async limit        */
(defconstant $AGL_COLORMAP_TRACKING 210)
; #define AGL_COLORMAP_TRACKING    210  /* Enable or disable colormap tracking           */
(defconstant $AGL_COLORMAP_ENTRY 212)
; #define AGL_COLORMAP_ENTRY       212  /* Set a colormap entry to {index, r, g, b}      */
(defconstant $AGL_RASTERIZATION 220)
; #define AGL_RASTERIZATION        220  /* Enable or disable all rasterization           */
(defconstant $AGL_SWAP_INTERVAL 222)
; #define AGL_SWAP_INTERVAL        222  /* 0 -> Don't sync, n -> Sync every n retrace    */
(defconstant $AGL_STATE_VALIDATION 230)
; #define AGL_STATE_VALIDATION     230  /* Validate state for multi-screen functionality */
(defconstant $AGL_BUFFER_NAME 231)
; #define AGL_BUFFER_NAME          231  /* Set the buffer name. Allows for multi ctx to share a buffer */
(defconstant $AGL_ORDER_CONTEXT_TO_FRONT 232)
; #define AGL_ORDER_CONTEXT_TO_FRONT  232  /* Order the current context in front of all the other contexts. */
(defconstant $AGL_CONTEXT_SURFACE_ID 233)
; #define AGL_CONTEXT_SURFACE_ID   233  /* aglGetInteger only - returns the ID of the drawable surface for the context */
(defconstant $AGL_CONTEXT_DISPLAY_ID 234)
; #define AGL_CONTEXT_DISPLAY_ID   234  /* aglGetInteger only - returns the display ID(s) of all displays touched by the context, up to a maximum of 32 displays */
(defconstant $AGL_SURFACE_ORDER 235)
; #define AGL_SURFACE_ORDER        235  /* Position of OpenGL surface relative to window: 1 -> Above window, -1 -> Below Window */
(defconstant $AGL_SURFACE_OPACITY 236)
; #define AGL_SURFACE_OPACITY      236  /* Opacity of OpenGL surface: 1 -> Surface is opaque (default), 0 -> non-opaque */
(defconstant $AGL_CLIP_REGION 254)
; #define AGL_CLIP_REGION          254  /* Enable or set the drawable clipping region */
(defconstant $AGL_FS_CAPTURE_SINGLE 255)
; #define AGL_FS_CAPTURE_SINGLE    255  /* Enable the capture of only a single display for aglFullScreen, normally disabled */
; 
; ** Option names for aglConfigure.
; 
(defconstant $AGL_FORMAT_CACHE_SIZE 501)
; #define AGL_FORMAT_CACHE_SIZE    501  /* Set the size of the pixel format cache        */
(defconstant $AGL_CLEAR_FORMAT_CACHE 502)
; #define AGL_CLEAR_FORMAT_CACHE   502  /* Reset the pixel format cache                  */
(defconstant $AGL_RETAIN_RENDERERS 503)
; #define AGL_RETAIN_RENDERERS     503  /* Whether to retain loaded renderers in memory  */
;  buffer_modes 
(defconstant $AGL_MONOSCOPIC_BIT 1)
; #define AGL_MONOSCOPIC_BIT       0x00000001
(defconstant $AGL_STEREOSCOPIC_BIT 2)
; #define AGL_STEREOSCOPIC_BIT     0x00000002
(defconstant $AGL_SINGLEBUFFER_BIT 4)
; #define AGL_SINGLEBUFFER_BIT     0x00000004
(defconstant $AGL_DOUBLEBUFFER_BIT 8)
; #define AGL_DOUBLEBUFFER_BIT     0x00000008
;  bit depths 
(defconstant $AGL_0_BIT 1)
; #define AGL_0_BIT                0x00000001
(defconstant $AGL_1_BIT 2)
; #define AGL_1_BIT                0x00000002
(defconstant $AGL_2_BIT 4)
; #define AGL_2_BIT                0x00000004
(defconstant $AGL_3_BIT 8)
; #define AGL_3_BIT                0x00000008
(defconstant $AGL_4_BIT 16)
; #define AGL_4_BIT                0x00000010
(defconstant $AGL_5_BIT 32)
; #define AGL_5_BIT                0x00000020
(defconstant $AGL_6_BIT 64)
; #define AGL_6_BIT                0x00000040
(defconstant $AGL_8_BIT 128)
; #define AGL_8_BIT                0x00000080
(defconstant $AGL_10_BIT 256)
; #define AGL_10_BIT               0x00000100
(defconstant $AGL_12_BIT 512)
; #define AGL_12_BIT               0x00000200
(defconstant $AGL_16_BIT 1024)
; #define AGL_16_BIT               0x00000400
(defconstant $AGL_24_BIT 2048)
; #define AGL_24_BIT               0x00000800
(defconstant $AGL_32_BIT 4096)
; #define AGL_32_BIT               0x00001000
(defconstant $AGL_48_BIT 8192)
; #define AGL_48_BIT               0x00002000
(defconstant $AGL_64_BIT 16384)
; #define AGL_64_BIT               0x00004000
(defconstant $AGL_96_BIT 32768)
; #define AGL_96_BIT               0x00008000
(defconstant $AGL_128_BIT 65536)
; #define AGL_128_BIT              0x00010000
;  color modes 
(defconstant $AGL_RGB8_BIT 1)
; #define AGL_RGB8_BIT             0x00000001  /* 8 rgb bit/pixel,     RGB=7:0, inverse colormap         */
(defconstant $AGL_RGB8_A8_BIT 2)
; #define AGL_RGB8_A8_BIT          0x00000002  /* 8-8 argb bit/pixel,  A=7:0, RGB=7:0, inverse colormap  */
(defconstant $AGL_BGR233_BIT 4)
; #define AGL_BGR233_BIT           0x00000004  /* 8 rgb bit/pixel,     B=7:6, G=5:3, R=2:0               */
(defconstant $AGL_BGR233_A8_BIT 8)
; #define AGL_BGR233_A8_BIT        0x00000008  /* 8-8 argb bit/pixel,  A=7:0, B=7:6, G=5:3, R=2:0        */
(defconstant $AGL_RGB332_BIT 16)
; #define AGL_RGB332_BIT           0x00000010  /* 8 rgb bit/pixel,     R=7:5, G=4:2, B=1:0               */
(defconstant $AGL_RGB332_A8_BIT 32)
; #define AGL_RGB332_A8_BIT        0x00000020  /* 8-8 argb bit/pixel,  A=7:0, R=7:5, G=4:2, B=1:0        */
(defconstant $AGL_RGB444_BIT 64)
; #define AGL_RGB444_BIT           0x00000040  /* 16 rgb bit/pixel,    R=11:8, G=7:4, B=3:0              */
(defconstant $AGL_ARGB4444_BIT 128)
; #define AGL_ARGB4444_BIT         0x00000080  /* 16 argb bit/pixel,   A=15:12, R=11:8, G=7:4, B=3:0     */
(defconstant $AGL_RGB444_A8_BIT 256)
; #define AGL_RGB444_A8_BIT        0x00000100  /* 8-16 argb bit/pixel, A=7:0, R=11:8, G=7:4, B=3:0       */
(defconstant $AGL_RGB555_BIT 512)
; #define AGL_RGB555_BIT           0x00000200  /* 16 rgb bit/pixel,    R=14:10, G=9:5, B=4:0             */
(defconstant $AGL_ARGB1555_BIT 1024)
; #define AGL_ARGB1555_BIT         0x00000400  /* 16 argb bit/pixel,   A=15, R=14:10, G=9:5, B=4:0       */
(defconstant $AGL_RGB555_A8_BIT 2048)
; #define AGL_RGB555_A8_BIT        0x00000800  /* 8-16 argb bit/pixel, A=7:0, R=14:10, G=9:5, B=4:0      */
(defconstant $AGL_RGB565_BIT 4096)
; #define AGL_RGB565_BIT           0x00001000  /* 16 rgb bit/pixel,    R=15:11, G=10:5, B=4:0            */
(defconstant $AGL_RGB565_A8_BIT 8192)
; #define AGL_RGB565_A8_BIT        0x00002000  /* 8-16 argb bit/pixel, A=7:0, R=15:11, G=10:5, B=4:0     */
(defconstant $AGL_RGB888_BIT 16384)
; #define AGL_RGB888_BIT           0x00004000  /* 32 rgb bit/pixel,    R=23:16, G=15:8, B=7:0            */
(defconstant $AGL_ARGB8888_BIT 32768)
; #define AGL_ARGB8888_BIT         0x00008000  /* 32 argb bit/pixel,   A=31:24, R=23:16, G=15:8, B=7:0   */
(defconstant $AGL_RGB888_A8_BIT 65536)
; #define AGL_RGB888_A8_BIT        0x00010000  /* 8-32 argb bit/pixel, A=7:0, R=23:16, G=15:8, B=7:0     */
(defconstant $AGL_RGB101010_BIT 131072)
; #define AGL_RGB101010_BIT        0x00020000  /* 32 rgb bit/pixel,    R=29:20, G=19:10, B=9:0           */
(defconstant $AGL_ARGB2101010_BIT 262144)
; #define AGL_ARGB2101010_BIT      0x00040000  /* 32 argb bit/pixel,   A=31:30  R=29:20, G=19:10, B=9:0  */
(defconstant $AGL_RGB101010_A8_BIT 524288)
; #define AGL_RGB101010_A8_BIT     0x00080000  /* 8-32 argb bit/pixel, A=7:0  R=29:20, G=19:10, B=9:0    */
(defconstant $AGL_RGB121212_BIT 1048576)
; #define AGL_RGB121212_BIT        0x00100000  /* 48 rgb bit/pixel,    R=35:24, G=23:12, B=11:0          */
(defconstant $AGL_ARGB12121212_BIT 2097152)
; #define AGL_ARGB12121212_BIT     0x00200000  /* 48 argb bit/pixel,   A=47:36, R=35:24, G=23:12, B=11:0 */
(defconstant $AGL_RGB161616_BIT 4194304)
; #define AGL_RGB161616_BIT        0x00400000  /* 64 rgb bit/pixel,    R=47:32, G=31:16, B=15:0          */
(defconstant $AGL_ARGB16161616_BIT 8388608)
; #define AGL_ARGB16161616_BIT     0x00800000  /* 64 argb bit/pixel,   A=63:48, R=47:32, G=31:16, B=15:0 */
(defconstant $AGL_INDEX8_BIT 536870912)
; #define AGL_INDEX8_BIT           0x20000000  /* 8 bit color look up table                              */
(defconstant $AGL_INDEX16_BIT 1073741824)
; #define AGL_INDEX16_BIT          0x40000000  /* 16 bit color look up table                             */
; 
; ** Error return values from aglGetError.
; 
(defconstant $AGL_NO_ERROR 0)
; #define AGL_NO_ERROR                 0 /* no error                        */
(defconstant $AGL_BAD_ATTRIBUTE 10000)
; #define AGL_BAD_ATTRIBUTE        10000 /* invalid pixel format attribute  */
(defconstant $AGL_BAD_PROPERTY 10001)
; #define AGL_BAD_PROPERTY         10001 /* invalid renderer property       */
(defconstant $AGL_BAD_PIXELFMT 10002)
; #define AGL_BAD_PIXELFMT         10002 /* invalid pixel format            */
(defconstant $AGL_BAD_RENDINFO 10003)
; #define AGL_BAD_RENDINFO         10003 /* invalid renderer info           */
(defconstant $AGL_BAD_CONTEXT 10004)
; #define AGL_BAD_CONTEXT          10004 /* invalid context                 */
(defconstant $AGL_BAD_DRAWABLE 10005)
; #define AGL_BAD_DRAWABLE         10005 /* invalid drawable                */
(defconstant $AGL_BAD_GDEV 10006)
; #define AGL_BAD_GDEV             10006 /* invalid graphics device         */
(defconstant $AGL_BAD_STATE 10007)
; #define AGL_BAD_STATE            10007 /* invalid context state           */
(defconstant $AGL_BAD_VALUE 10008)
; #define AGL_BAD_VALUE            10008 /* invalid numerical value         */
(defconstant $AGL_BAD_MATCH 10009)
; #define AGL_BAD_MATCH            10009 /* invalid share context           */
(defconstant $AGL_BAD_ENUM 10010)
; #define AGL_BAD_ENUM             10010 /* invalid enumerant               */
(defconstant $AGL_BAD_OFFSCREEN 10011)
; #define AGL_BAD_OFFSCREEN        10011 /* invalid offscreen drawable      */
(defconstant $AGL_BAD_FULLSCREEN 10012)
; #define AGL_BAD_FULLSCREEN       10012 /* invalid offscreen drawable      */
(defconstant $AGL_BAD_WINDOW 10013)
; #define AGL_BAD_WINDOW           10013 /* invalid window                  */
(defconstant $AGL_BAD_POINTER 10014)
; #define AGL_BAD_POINTER          10014 /* invalid pointer                 */
(defconstant $AGL_BAD_MODULE 10015)
; #define AGL_BAD_MODULE           10015 /* invalid code module             */
(defconstant $AGL_BAD_ALLOC 10016)
; #define AGL_BAD_ALLOC            10016 /* memory allocation failure       */
; **********************************************************************
; 
; ** Pixel format functions
; 

(deftrap-inline "_aglChoosePixelFormat" 
   ((gdevs (:pointer :AGLDEVICE))
    (ndev :signed-long)
    (attribs (:pointer :GLINT))
   )
   (:pointer :__AGLPixelFormatRec)
() )

(deftrap-inline "_aglDestroyPixelFormat" 
   ((pix (:pointer :__AGLPixelFormatRec))
   )
   nil
() )

(deftrap-inline "_aglNextPixelFormat" 
   ((pix (:pointer :__AGLPixelFormatRec))
   )
   (:pointer :__AGLPixelFormatRec)
() )

(deftrap-inline "_aglDescribePixelFormat" 
   ((pix (:pointer :__AGLPixelFormatRec))
    (attrib :signed-long)
    (value (:pointer :GLINT))
   )
   :UInt8
() )

(deftrap-inline "_aglDevicesOfPixelFormat" 
   ((pix (:pointer :__AGLPixelFormatRec))
    (ndevs (:pointer :GLINT))
   )
   (:pointer (:Handle :GDEVICE))
() )
; 
; ** Renderer information functions
; 

(deftrap-inline "_aglQueryRendererInfo" 
   ((gdevs (:pointer :AGLDEVICE))
    (ndev :signed-long)
   )
   (:pointer :__AGLRendererInfoRec)
() )

(deftrap-inline "_aglDestroyRendererInfo" 
   ((rend (:pointer :__AGLRendererInfoRec))
   )
   nil
() )

(deftrap-inline "_aglNextRendererInfo" 
   ((rend (:pointer :__AGLRendererInfoRec))
   )
   (:pointer :__AGLRendererInfoRec)
() )

(deftrap-inline "_aglDescribeRenderer" 
   ((rend (:pointer :__AGLRendererInfoRec))
    (prop :signed-long)
    (value (:pointer :GLINT))
   )
   :UInt8
() )
; 
; ** Context functions
; 

(deftrap-inline "_aglCreateContext" 
   ((pix (:pointer :__AGLPixelFormatRec))
    (share (:pointer :__AGLContextRec))
   )
   (:pointer :__AGLContextRec)
() )

(deftrap-inline "_aglDestroyContext" 
   ((ctx (:pointer :__AGLContextRec))
   )
   :UInt8
() )

(deftrap-inline "_aglCopyContext" 
   ((src (:pointer :__AGLContextRec))
    (dst (:pointer :__AGLContextRec))
    (mask :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_aglUpdateContext" 
   ((ctx (:pointer :__AGLContextRec))
   )
   :UInt8
() )
; 
; ** Current state functions
; 

(deftrap-inline "_aglSetCurrentContext" 
   ((ctx (:pointer :__AGLContextRec))
   )
   :UInt8
() )

(deftrap-inline "_aglGetCurrentContext" 
   (
   )
   (:pointer :__AGLContextRec)
() )
; 
; ** Drawable Functions
; 

(deftrap-inline "_aglSetDrawable" 
   ((ctx (:pointer :__AGLContextRec))
    (draw (:pointer :OpaqueGrafPtr))
   )
   :UInt8
() )

(deftrap-inline "_aglSetOffScreen" 
   ((ctx (:pointer :__AGLContextRec))
    (width :signed-long)
    (height :signed-long)
    (rowbytes :signed-long)
    (baseaddr (:pointer :GLVOID))
   )
   :UInt8
() )

(deftrap-inline "_aglSetFullScreen" 
   ((ctx (:pointer :__AGLContextRec))
    (width :signed-long)
    (height :signed-long)
    (freq :signed-long)
    (device :signed-long)
   )
   :UInt8
() )

(deftrap-inline "_aglGetDrawable" 
   ((ctx (:pointer :__AGLContextRec))
   )
   (:pointer :OpaqueGrafPtr)
() )
; 
; ** Virtual screen functions
; 

(deftrap-inline "_aglSetVirtualScreen" 
   ((ctx (:pointer :__AGLContextRec))
    (screen :signed-long)
   )
   :UInt8
() )

(deftrap-inline "_aglGetVirtualScreen" 
   ((ctx (:pointer :__AGLContextRec))
   )
   :signed-long
() )
; 
; ** Obtain version numbers
; 

(deftrap-inline "_aglGetVersion" 
   ((major (:pointer :GLINT))
    (minor (:pointer :GLINT))
   )
   nil
() )
; 
; ** Global library options
; 

(deftrap-inline "_aglConfigure" 
   ((pname :UInt32)
    (param :UInt32)
   )
   :UInt8
() )
; 
; ** Swap functions
; 

(deftrap-inline "_aglSwapBuffers" 
   ((ctx (:pointer :__AGLContextRec))
   )
   nil
() )
; 
; ** Per context options
; 

(deftrap-inline "_aglEnable" 
   ((ctx (:pointer :__AGLContextRec))
    (pname :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_aglDisable" 
   ((ctx (:pointer :__AGLContextRec))
    (pname :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_aglIsEnabled" 
   ((ctx (:pointer :__AGLContextRec))
    (pname :UInt32)
   )
   :UInt8
() )

(deftrap-inline "_aglSetInteger" 
   ((ctx (:pointer :__AGLContextRec))
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   :UInt8
() )

(deftrap-inline "_aglGetInteger" 
   ((ctx (:pointer :__AGLContextRec))
    (pname :UInt32)
    (params (:pointer :GLINT))
   )
   :UInt8
() )
; 
; ** Font function
; 

(deftrap-inline "_aglUseFont" 
   ((ctx (:pointer :__AGLContextRec))
    (fontID :signed-long)
    (face :UInt8)
    (size :signed-long)
    (first :signed-long)
    (count :signed-long)
    (base :signed-long)
   )
   :UInt8
() )
; 
; ** Error functions
; 

(deftrap-inline "_aglGetError" 
   (
   )
   :UInt32
() )

(deftrap-inline "_aglErrorString" 
   ((code :UInt32)
   )
   (:pointer :UInt8)
() )
; 
; ** Soft reset function
; 

(deftrap-inline "_aglResetLibrary" 
   (
   )
   nil
() )
; 
; ** Surface texture function
; 

(deftrap-inline "_aglSurfaceTexture" 
   ((context (:pointer :__AGLContextRec))
    (target :UInt32)
    (internalformat :UInt32)
    (surfacecontext (:pointer :__AGLContextRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ** PBuffer functions
; 

(deftrap-inline "_aglCreatePBuffer" 
   ((width :signed-long)
    (height :signed-long)
    (target :UInt32)
    (internalFormat :UInt32)
    (max_level :signed-long)
    (pbuffer (:pointer :AGLPBUFFER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt8
() )

(deftrap-inline "_aglDestroyPBuffer" 
   ((pbuffer (:pointer :__AGLPBufferRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt8
() )

(deftrap-inline "_aglDescribePBuffer" 
   ((pbuffer (:pointer :__AGLPBufferRec))
    (width (:pointer :GLINT))
    (height (:pointer :GLINT))
    (target (:pointer :GLENUM))
    (internalFormat (:pointer :GLENUM))
    (max_level (:pointer :GLINT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt8
() )

(deftrap-inline "_aglTexImagePBuffer" 
   ((ctx (:pointer :__AGLContextRec))
    (pbuffer (:pointer :__AGLPBufferRec))
    (source :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt8
() )
; 
; ** Pbuffer Drawable Functions
; 

(deftrap-inline "_aglSetPBuffer" 
   ((ctx (:pointer :__AGLContextRec))
    (pbuffer (:pointer :__AGLPBufferRec))
    (face :signed-long)
    (level :signed-long)
    (screen :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt8
() )

(deftrap-inline "_aglGetPBuffer" 
   ((ctx (:pointer :__AGLContextRec))
    (pbuffer (:pointer :AGLPBUFFER))
    (face (:pointer :GLINT))
    (level (:pointer :GLINT))
    (screen (:pointer :GLINT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt8
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _AGL_H */


(provide-interface "agl")