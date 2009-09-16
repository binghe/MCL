(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGLTypes.h"
; at Sunday July 2,2006 7:27:19 pm.
; 
; 	Copyright:	(c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _CGLTYPES_H
; #define _CGLTYPES_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** CGL opaque data.
; 

(def-mactype :CGLContextObj (find-mactype '(:pointer :_CGLContextObject)))

(def-mactype :CGLPixelFormatObj (find-mactype '(:pointer :_CGLPixelFormatObject)))

(def-mactype :CGLRendererInfoObj (find-mactype '(:pointer :_CGLRendererInfoObject)))

(def-mactype :CGLPBufferObj (find-mactype '(:pointer :_CGLPBufferObject)))
; 
; ** Attribute names for CGLChoosePixelFormat and CGLDescribePixelFormat.
; 
(def-mactype :_CGLPixelFormatAttribute (find-mactype ':sint32))

(defconstant $kCGLPFAAllRenderers 1)            ;  choose from all available renderers          

(defconstant $kCGLPFADoubleBuffer 5)            ;  choose a double buffered pixel format        

(defconstant $kCGLPFAStereo 6)                  ;  stereo buffering supported                   

(defconstant $kCGLPFAAuxBuffers 7)              ;  number of aux buffers                        

(defconstant $kCGLPFAColorSize 8)               ;  number of color buffer bits                  

(defconstant $kCGLPFAAlphaSize 11)              ;  number of alpha component bits               

(defconstant $kCGLPFADepthSize 12)              ;  number of depth buffer bits                  

(defconstant $kCGLPFAStencilSize 13)            ;  number of stencil buffer bits                

(defconstant $kCGLPFAAccumSize 14)              ;  number of accum buffer bits                  

(defconstant $kCGLPFAMinimumPolicy 51)          ;  never choose smaller buffers than requested  

(defconstant $kCGLPFAMaximumPolicy 52)          ;  choose largest buffers of type requested     

(defconstant $kCGLPFAOffScreen 53)              ;  choose an off-screen capable renderer        

(defconstant $kCGLPFAFullScreen 54)             ;  choose a full-screen capable renderer        

(defconstant $kCGLPFASampleBuffers 55)          ;  number of multi sample buffers               

(defconstant $kCGLPFASamples 56)                ;  number of samples per multi sample buffer    

(defconstant $kCGLPFAAuxDepthStencil 57)        ;  each aux buffer has its own depth stencil    

(defconstant $kCGLPFAColorFloat 58)             ;  color buffers store floating point pixels    

(defconstant $kCGLPFARendererID 70)             ;  request renderer by ID                       

(defconstant $kCGLPFASingleRenderer 71)         ;  choose a single renderer for all screens     

(defconstant $kCGLPFANoRecovery 72)             ;  disable all failure recovery systems         

(defconstant $kCGLPFAAccelerated 73)            ;  choose a hardware accelerated renderer       

(defconstant $kCGLPFAClosestPolicy 74)          ;  choose the closest color buffer to request   

(defconstant $kCGLPFARobust 75)                 ;  renderer does not need failure recovery      

(defconstant $kCGLPFABackingStore 76)           ;  back buffer contents are valid after swap    

(defconstant $kCGLPFAMPSafe 78)                 ;  renderer is multi-processor safe             

(defconstant $kCGLPFAWindow 80)                 ;  can be used to render to an onscreen window  

(defconstant $kCGLPFAMultiScreen 81)            ;  single window can span multiple screens      

(defconstant $kCGLPFACompliant 83)              ;  renderer is opengl compliant                 

(defconstant $kCGLPFADisplayMask 84)            ;  mask limiting supported displays             

(defconstant $kCGLPFAPBuffer 90)                ;  can be used to render to a pbuffer           

(defconstant $kCGLPFAVirtualScreenCount #x80)   ;  number of virtual screens in this format     

(def-mactype :CGLPixelFormatAttribute (find-mactype ':SINT32))
; 
; ** Property names for CGLDescribeRenderer.
; 
(def-mactype :_CGLRendererProperty (find-mactype ':sint32))

(defconstant $kCGLRPOffScreen 53)
(defconstant $kCGLRPFullScreen 54)
(defconstant $kCGLRPRendererID 70)
(defconstant $kCGLRPAccelerated 73)
(defconstant $kCGLRPRobust 75)
(defconstant $kCGLRPBackingStore 76)
(defconstant $kCGLRPMPSafe 78)
(defconstant $kCGLRPWindow 80)
(defconstant $kCGLRPMultiScreen 81)
(defconstant $kCGLRPCompliant 83)
(defconstant $kCGLRPDisplayMask 84)
(defconstant $kCGLRPBufferModes 100)            ;  a bitfield of supported buffer modes          

(defconstant $kCGLRPColorModes 103)             ;  a bitfield of supported color buffer formats  

(defconstant $kCGLRPAccumModes 104)             ;  a bitfield of supported accum buffer formats  

(defconstant $kCGLRPDepthModes 105)             ;  a bitfield of supported depth buffer depths   

(defconstant $kCGLRPStencilModes 106)           ;  a bitfield of supported stencil buffer depths 

(defconstant $kCGLRPMaxAuxBuffers 107)          ;  maximum number of auxilliary buffers          

(defconstant $kCGLRPMaxSampleBuffers 108)       ;  maximum number of sample buffers              

(defconstant $kCGLRPMaxSamples 109)             ;  maximum number of samples                     

(defconstant $kCGLRPVideoMemory 120)            ;  total video memory                            

(defconstant $kCGLRPTextureMemory 121)          ;  video memory useable for texture storage      

(defconstant $kCGLRPRendererCount #x80)         ;  the number of renderers in this renderer info 

(def-mactype :CGLRendererProperty (find-mactype ':SINT32))
; 
; ** Enable names for CGLEnable, CGLDisable, and CGLIsEnabled.
; 
(def-mactype :_CGLContextEnable (find-mactype ':sint32))

(defconstant $kCGLCESwapRectangle #xC9)         ;  Enable or disable the swap rectangle          

(defconstant $kCGLCESwapLimit #xCB)             ;  Enable or disable the swap async limit        

(defconstant $kCGLCERasterization #xDD)         ;  Enable or disable all rasterization           

(defconstant $kCGLCEStateValidation #x12D)      ;  Validate state for multi-screen functionality 

(defconstant $kCGLCEDrawSyncBlueLine #x12E)     ;  Enable or disable drawing of stereo sync blue line 

(def-mactype :CGLContextEnable (find-mactype ':SINT32))
; 
; ** Parameter names for CGLSetParameter and CGLGetParameter.
; 
(def-mactype :_CGLContextParameter (find-mactype ':sint32))

(defconstant $kCGLCPSwapRectangle #xC8)         ;  4 params.  Set or get the swap rectangle {x, y, w, h}  

(defconstant $kCGLCPSwapInterval #xDE)          ;  1 param.   0 -> Don't sync, n -> Sync every n retrace  

(defconstant $kCGLCPClientStorage #xE2)         ;  1 param.   Context specific generic storage            
;   - Used by AGL - 
;   AGL_STATE_VALIDATION     230    
;   AGL_BUFFER_NAME          231    
;   AGL_ORDER_CONTEXT_TO_FRONT  232 
;   AGL_CONTEXT_SURFACE_ID   233    
;   AGL_CONTEXT_DISPLAY_ID   234    

(defconstant $kCGLCPSurfaceOrder #xEB)          ;  1 param.   1 -> Above window, -1 -> Below Window       

(defconstant $kCGLCPSurfaceOpacity #xEC)        ;  1 param.   1 -> Surface is opaque (default), 0 -> non-opaque 
;   - Used by AGL - 
;   AGL_CLIP_REGION          254   
;   AGL_FS_CAPTURE_SINGLE    255   

(def-mactype :CGLContextParameter (find-mactype ':SINT32))
; 
; ** Option names for CGLSetOption and CGLGetOption.
; 
(def-mactype :_CGLGlobalOption (find-mactype ':sint32))

(defconstant $kCGLGOFormatCacheSize #x1F5)      ;  Set the size of the pixel format cache        

(defconstant $kCGLGOClearFormatCache #x1F6)     ;  Reset the pixel format cache if true          

(defconstant $kCGLGORetainRenderers #x1F7)      ;  Whether to retain loaded renderers in memory  

(defconstant $kCGLGOResetLibrary #x1F8)         ;  Do a soft reset of the CGL library if true    

(defconstant $kCGLGOUseErrorHandler #x1F9)      ;  Call the Core Graphics handler on CGL errors  

(def-mactype :CGLGlobalOption (find-mactype ':SINT32))
; 
; ** Error return values from CGLGetError.
; 
(def-mactype :_CGLError (find-mactype ':sint32))

(defconstant $kCGLBadAttribute #x2710)          ;  invalid pixel format attribute  

(defconstant $kCGLBadProperty #x2711)           ;  invalid renderer property       

(defconstant $kCGLBadPixelFormat #x2712)        ;  invalid pixel format            

(defconstant $kCGLBadRendererInfo #x2713)       ;  invalid renderer info           

(defconstant $kCGLBadContext #x2714)            ;  invalid context                 

(defconstant $kCGLBadDrawable #x2715)           ;  invalid drawable                

(defconstant $kCGLBadDisplay #x2716)            ;  invalid graphics device         

(defconstant $kCGLBadState #x2717)              ;  invalid context state           

(defconstant $kCGLBadValue #x2718)              ;  invalid numerical value         

(defconstant $kCGLBadMatch #x2719)              ;  invalid share context           

(defconstant $kCGLBadEnumeration #x271A)        ;  invalid enumerant               

(defconstant $kCGLBadOffScreen #x271B)          ;  invalid offscreen drawable      

(defconstant $kCGLBadFullScreen #x271C)         ;  invalid offscreen drawable      

(defconstant $kCGLBadWindow #x271D)             ;  invalid window                  

(defconstant $kCGLBadAddress #x271E)            ;  invalid pointer                 

(defconstant $kCGLBadCodeModule #x271F)         ;  invalid code module             

(defconstant $kCGLBadAlloc #x2720)              ;  invalid memory allocation       

(defconstant $kCGLBadConnection #x2721)         ;  invalid CoreGraphics connection 

(def-mactype :CGLError (find-mactype ':SINT32))
;  
; ** Buffer modes
; 
(defconstant $kCGLMonoscopicBit 1)
; #define kCGLMonoscopicBit   0x00000001
(defconstant $kCGLStereoscopicBit 2)
; #define kCGLStereoscopicBit 0x00000002
(defconstant $kCGLSingleBufferBit 4)
; #define kCGLSingleBufferBit 0x00000004
(defconstant $kCGLDoubleBufferBit 8)
; #define kCGLDoubleBufferBit 0x00000008
; 
; ** Depth and stencil buffer depths
; 
(defconstant $kCGL0Bit 1)
; #define kCGL0Bit            0x00000001
(defconstant $kCGL1Bit 2)
; #define kCGL1Bit            0x00000002
(defconstant $kCGL2Bit 4)
; #define kCGL2Bit            0x00000004
(defconstant $kCGL3Bit 8)
; #define kCGL3Bit            0x00000008
(defconstant $kCGL4Bit 16)
; #define kCGL4Bit            0x00000010
(defconstant $kCGL5Bit 32)
; #define kCGL5Bit            0x00000020
(defconstant $kCGL6Bit 64)
; #define kCGL6Bit            0x00000040
(defconstant $kCGL8Bit 128)
; #define kCGL8Bit            0x00000080
(defconstant $kCGL10Bit 256)
; #define kCGL10Bit           0x00000100
(defconstant $kCGL12Bit 512)
; #define kCGL12Bit           0x00000200
(defconstant $kCGL16Bit 1024)
; #define kCGL16Bit           0x00000400
(defconstant $kCGL24Bit 2048)
; #define kCGL24Bit           0x00000800
(defconstant $kCGL32Bit 4096)
; #define kCGL32Bit           0x00001000
(defconstant $kCGL48Bit 8192)
; #define kCGL48Bit           0x00002000
(defconstant $kCGL64Bit 16384)
; #define kCGL64Bit           0x00004000
(defconstant $kCGL96Bit 32768)
; #define kCGL96Bit           0x00008000
(defconstant $kCGL128Bit 65536)
; #define kCGL128Bit          0x00010000
; 
; ** Color and accumulation buffer formats.
; 
(defconstant $kCGLRGB444Bit 64)
; #define kCGLRGB444Bit       0x00000040  /* 16 rgb bit/pixel,    R=11:8, G=7:4, B=3:0              */
(defconstant $kCGLARGB4444Bit 128)
; #define kCGLARGB4444Bit     0x00000080  /* 16 argb bit/pixel,   A=15:12, R=11:8, G=7:4, B=3:0     */
(defconstant $kCGLRGB444A8Bit 256)
; #define kCGLRGB444A8Bit     0x00000100  /* 8-16 argb bit/pixel, A=7:0, R=11:8, G=7:4, B=3:0       */
(defconstant $kCGLRGB555Bit 512)
; #define kCGLRGB555Bit       0x00000200  /* 16 rgb bit/pixel,    R=14:10, G=9:5, B=4:0             */
(defconstant $kCGLARGB1555Bit 1024)
; #define kCGLARGB1555Bit     0x00000400  /* 16 argb bit/pixel,   A=15, R=14:10, G=9:5, B=4:0       */
(defconstant $kCGLRGB555A8Bit 2048)
; #define kCGLRGB555A8Bit     0x00000800  /* 8-16 argb bit/pixel, A=7:0, R=14:10, G=9:5, B=4:0      */
(defconstant $kCGLRGB565Bit 4096)
; #define kCGLRGB565Bit       0x00001000  /* 16 rgb bit/pixel,    R=15:11, G=10:5, B=4:0            */
(defconstant $kCGLRGB565A8Bit 8192)
; #define kCGLRGB565A8Bit     0x00002000  /* 8-16 argb bit/pixel, A=7:0, R=15:11, G=10:5, B=4:0     */
(defconstant $kCGLRGB888Bit 16384)
; #define kCGLRGB888Bit       0x00004000  /* 32 rgb bit/pixel,    R=23:16, G=15:8, B=7:0            */
(defconstant $kCGLARGB8888Bit 32768)
; #define kCGLARGB8888Bit     0x00008000  /* 32 argb bit/pixel,   A=31:24, R=23:16, G=15:8, B=7:0   */
(defconstant $kCGLRGB888A8Bit 65536)
; #define kCGLRGB888A8Bit     0x00010000  /* 8-32 argb bit/pixel, A=7:0, R=23:16, G=15:8, B=7:0     */
(defconstant $kCGLRGB101010Bit 131072)
; #define kCGLRGB101010Bit    0x00020000  /* 32 rgb bit/pixel,    R=29:20, G=19:10, B=9:0           */
(defconstant $kCGLARGB2101010Bit 262144)
; #define kCGLARGB2101010Bit  0x00040000  /* 32 argb bit/pixel,   A=31:30  R=29:20, G=19:10, B=9:0  */
(defconstant $kCGLRGB101010_A8Bit 524288)
; #define kCGLRGB101010_A8Bit 0x00080000  /* 8-32 argb bit/pixel, A=7:0  R=29:20, G=19:10, B=9:0    */
(defconstant $kCGLRGB121212Bit 1048576)
; #define kCGLRGB121212Bit    0x00100000  /* 48 rgb bit/pixel,    R=35:24, G=23:12, B=11:0          */
(defconstant $kCGLARGB12121212Bit 2097152)
; #define kCGLARGB12121212Bit 0x00200000  /* 48 argb bit/pixel,   A=47:36, R=35:24, G=23:12, B=11:0 */
(defconstant $kCGLRGB161616Bit 4194304)
; #define kCGLRGB161616Bit    0x00400000  /* 64 rgb bit/pixel,    R=47:32, G=31:16, B=15:0          */
(defconstant $kCGLARGB16161616Bit 8388608)
; #define kCGLARGB16161616Bit 0x00800000  /* 64 argb bit/pixel,   A=63:48, R=47:32, G=31:16, B=15:0 */
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _CGLTYPES_H */


(provide-interface "CGLTypes")