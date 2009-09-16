(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGGLContext.h"
; at Sunday July 2,2006 7:24:17 pm.
;  CoreGraphics - CGGLContext.h
;  * Copyright (c) 2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGGLCONTEXT_H_
; #define CGGLCONTEXT_H_

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGContext")

(require-interface "AvailabilityMacros")
;  Create a context from the OpenGL context `glContext'.  `size' specifies
;  * the dimensions of the OpenGL viewport rectangle which the CGContext will
;  * establish by calling glViewport(3G).  If non-NULL, `colorspace' should
;  * be an RGB profile which specifies the destination space when rendering
;  * device-independent colors. 

(deftrap-inline "_CGGLContextCreate" 
   ((glContext :pointer)
    (width :single-float)
    (height :single-float)
    (colorspace (:pointer :CGColorSpace))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGContext)
() )
;  Update the OpenGL viewport associated with the OpenGL context `c' to a
;  * new size.  `size' specifies the dimensions of a new OpenGL viewport
;  * rectangle which the CGContext will establish by calling glViewport(3G).
;  * This function should be called whenever the size of the OpenGL context
;  * changes. 

(deftrap-inline "_CGGLContextUpdateViewportSize" 
   ((c (:pointer :CGContext))
    (width :single-float)
    (height :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

; #endif	/* CGGLCONTEXT_H_ */


(provide-interface "CGGLContext")