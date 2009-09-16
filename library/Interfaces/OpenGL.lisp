(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OpenGL.h"
; at Sunday July 2,2006 7:31:08 pm.
; 
; 	Copyright:	(c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _OPENGL_H
; #define _OPENGL_H

(require-interface "AvailabilityMacros")

(require-interface "OpenGL/CGLCurrent")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** CGL API version.
; 
(defconstant $CGL_VERSION_1_0 1)
; #define CGL_VERSION_1_0  1
(defconstant $CGL_VERSION_1_1 1)
; #define CGL_VERSION_1_1  1
; 
; ** Pixel format functions
; 

(deftrap-inline "_CGLChoosePixelFormat" 
   ((attribs (:pointer :CGLPixelFormatAttribute))
    (pix (:pointer :CGLPIXELFORMATOBJ))
    (npix (:pointer :long))
   )
   :SInt32
() )

(deftrap-inline "_CGLDestroyPixelFormat" 
   ((pix (:pointer :_CGLPixelFormatObject))
   )
   :SInt32
() )

(deftrap-inline "_CGLDescribePixelFormat" 
   ((pix (:pointer :_CGLPixelFormatObject))
    (pix_num :signed-long)
    (attrib :SInt32)
    (value (:pointer :long))
   )
   :SInt32
() )
; 
; ** Renderer information functions
; 

(deftrap-inline "_CGLQueryRendererInfo" 
   ((display_mask :UInt32)
    (rend (:pointer :CGLRENDERERINFOOBJ))
    (nrend (:pointer :long))
   )
   :SInt32
() )

(deftrap-inline "_CGLDestroyRendererInfo" 
   ((rend (:pointer :_CGLRendererInfoObject))
   )
   :SInt32
() )

(deftrap-inline "_CGLDescribeRenderer" 
   ((rend (:pointer :_CGLRendererInfoObject))
    (rend_num :signed-long)
    (prop :SInt32)
    (value (:pointer :long))
   )
   :SInt32
() )
; 
; ** Context functions
; 

(deftrap-inline "_CGLCreateContext" 
   ((pix (:pointer :_CGLPixelFormatObject))
    (share (:pointer :_CGLContextObject))
    (ctx (:pointer :CGLCONTEXTOBJ))
   )
   :SInt32
() )

(deftrap-inline "_CGLDestroyContext" 
   ((ctx (:pointer :_CGLContextObject))
   )
   :SInt32
() )

(deftrap-inline "_CGLCopyContext" 
   ((src (:pointer :_CGLContextObject))
    (dst (:pointer :_CGLContextObject))
    (mask :UInt32)
   )
   :SInt32
() )
; 
; ** PBuffer functions
; 

(deftrap-inline "_CGLCreatePBuffer" 
   ((width :signed-long)
    (height :signed-long)
    (target :UInt32)
    (internalFormat :UInt32)
    (max_level :signed-long)
    (pbuffer (:pointer :CGLPBUFFEROBJ))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGLDestroyPBuffer" 
   ((pbuffer (:pointer :_CGLPBufferObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGLDescribePBuffer" 
   ((obj (:pointer :_CGLPBufferObject))
    (width (:pointer :long))
    (height (:pointer :long))
    (target (:pointer :UInt32))
    (internalFormat (:pointer :UInt32))
    (mipmap (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGLTexImagePBuffer" 
   ((ctx (:pointer :_CGLContextObject))
    (pbuffer (:pointer :_CGLPBufferObject))
    (source :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
; ** Drawable Functions
; 

(deftrap-inline "_CGLSetOffScreen" 
   ((ctx (:pointer :_CGLContextObject))
    (width :signed-long)
    (height :signed-long)
    (rowbytes :signed-long)
    (baseaddr :pointer)
   )
   :SInt32
() )

(deftrap-inline "_CGLGetOffScreen" 
   ((ctx (:pointer :_CGLContextObject))
    (width (:pointer :long))
    (height (:pointer :long))
    (rowbytes (:pointer :long))
    (baseaddr :pointer)
   )
   :SInt32
() )

(deftrap-inline "_CGLSetFullScreen" 
   ((ctx (:pointer :_CGLContextObject))
   )
   :SInt32
() )

(deftrap-inline "_CGLSetPBuffer" 
   ((ctx (:pointer :_CGLContextObject))
    (pbuffer (:pointer :_CGLPBufferObject))
    (face :UInt32)
    (level :signed-long)
    (screen :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGLGetPBuffer" 
   ((ctx (:pointer :_CGLContextObject))
    (pbuffer (:pointer :CGLPBUFFEROBJ))
    (face (:pointer :UInt32))
    (level (:pointer :long))
    (screen (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGLClearDrawable" 
   ((ctx (:pointer :_CGLContextObject))
   )
   :SInt32
() )

(deftrap-inline "_CGLFlushDrawable" 
   ((ctx (:pointer :_CGLContextObject))
   )
   :SInt32
() )
; 
; ** Per context enables and parameters
; 

(deftrap-inline "_CGLEnable" 
   ((ctx (:pointer :_CGLContextObject))
    (pname :SInt32)
   )
   :SInt32
() )

(deftrap-inline "_CGLDisable" 
   ((ctx (:pointer :_CGLContextObject))
    (pname :SInt32)
   )
   :SInt32
() )

(deftrap-inline "_CGLIsEnabled" 
   ((ctx (:pointer :_CGLContextObject))
    (pname :SInt32)
    (enable (:pointer :long))
   )
   :SInt32
() )

(deftrap-inline "_CGLSetParameter" 
   ((ctx (:pointer :_CGLContextObject))
    (pname :SInt32)
    (params (:pointer :long))
   )
   :SInt32
() )

(deftrap-inline "_CGLGetParameter" 
   ((ctx (:pointer :_CGLContextObject))
    (pname :SInt32)
    (params (:pointer :long))
   )
   :SInt32
() )
; 
; ** Virtual screen functions
; 

(deftrap-inline "_CGLSetVirtualScreen" 
   ((ctx (:pointer :_CGLContextObject))
    (screen :signed-long)
   )
   :SInt32
() )

(deftrap-inline "_CGLGetVirtualScreen" 
   ((ctx (:pointer :_CGLContextObject))
    (screen (:pointer :long))
   )
   :SInt32
() )
; 
; ** Global library options
; 

(deftrap-inline "_CGLSetOption" 
   ((pname :SInt32)
    (param :signed-long)
   )
   :SInt32
() )

(deftrap-inline "_CGLGetOption" 
   ((pname :SInt32)
    (param (:pointer :long))
   )
   :SInt32
() )
; 
; ** Version numbers
; 

(deftrap-inline "_CGLGetVersion" 
   ((majorvers (:pointer :long))
    (minorvers (:pointer :long))
   )
   nil
() )
; 
; ** Convert an error code to a string
; 

(deftrap-inline "_CGLErrorString" 
   ((error :SInt32)
   )
   (:pointer :character)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _OPENGL_H */


(provide-interface "OpenGL")