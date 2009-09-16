(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:aglRenderers.h"
; at Sunday July 2,2006 7:25:39 pm.
; 
;     File:	AGL/aglRenderers.h
; 
;     Contains:	Constant values for built-in AGL renderers.
; 
;     Version:	Technology:	Mac OS X
;                 Release:	GM
;  
;      Copyright:  (c) 2000-2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _AGLRENDERERS_H
; #define _AGLRENDERERS_H
; 
; ** Renderer ID numbers
; 
(defconstant $AGL_RENDERER_GENERIC_ID 131584)
; #define AGL_RENDERER_GENERIC_ID            0x00020200
(defconstant $AGL_RENDERER_APPLE_SW_ID 132608)
; #define AGL_RENDERER_APPLE_SW_ID           0x00020600
(defconstant $AGL_RENDERER_ATI_RAGE_128_ID 135168)
; #define AGL_RENDERER_ATI_RAGE_128_ID       0x00021000
(defconstant $AGL_RENDERER_ATI_RADEON_ID 135680)
; #define AGL_RENDERER_ATI_RADEON_ID         0x00021200
(defconstant $AGL_RENDERER_ATI_RAGE_PRO_ID 136192)
; #define AGL_RENDERER_ATI_RAGE_PRO_ID       0x00021400
(defconstant $AGL_RENDERER_ATI_RADEON_8500_ID 136704)
; #define AGL_RENDERER_ATI_RADEON_8500_ID    0x00021600
(defconstant $AGL_RENDERER_NVIDIA_GEFORCE_2MX_ID 139264)
; #define AGL_RENDERER_NVIDIA_GEFORCE_2MX_ID 0x00022000 /* also for GeForce 4MX  */
(defconstant $AGL_RENDERER_NVIDIA_GEFORCE_3_ID 139776)
; #define AGL_RENDERER_NVIDIA_GEFORCE_3_ID   0x00022200 /* also for GeForce 4 Ti */
(defconstant $AGL_RENDERER_MESA_3DFX_ID 262144)
; #define AGL_RENDERER_MESA_3DFX_ID          0x00040000
;  depreciated for Mac OS X, use above instead for specific renderer
;  AGL_RENDERER_ATI_ID    
;  AGL_RENDERER_NVIDIA_ID 
;  AGL_RENDERER_FORMAC_ID 
;  AGL_RENDERER_3DFX_ID   

; #endif /* _AGLRENDERERS_H */


(provide-interface "aglRenderers")