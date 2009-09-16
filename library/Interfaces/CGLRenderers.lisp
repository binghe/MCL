(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGLRenderers.h"
; at Sunday July 2,2006 7:27:21 pm.
; 
; 	Copyright:	(c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _CGLRENDERERS_H
; #define _CGLRENDERERS_H
; 
; ** Renderer ID numbers
; 
(defconstant $kCGLRendererGenericID 131584)
; #define kCGLRendererGenericID       0x00020200
(defconstant $kCGLRendererAppleSWID 132608)
; #define kCGLRendererAppleSWID       0x00020600
(defconstant $kCGLRendererATIRage128ID 135168)
; #define kCGLRendererATIRage128ID    0x00021000
(defconstant $kCGLRendererATIRadeonID 135680)
; #define kCGLRendererATIRadeonID     0x00021200
(defconstant $kCGLRendererATIRageProID 136192)
; #define kCGLRendererATIRageProID    0x00021400
(defconstant $kCGLRendererATIRadeon8500ID 136704)
; #define kCGLRendererATIRadeon8500ID 0x00021600
(defconstant $kCGLRendererATIRadeon9700ID 137216)
; #define kCGLRendererATIRadeon9700ID 0x00021800
(defconstant $kCGLRendererGeForce2MXID 139264)
; #define kCGLRendererGeForce2MXID    0x00022000
(defconstant $kCGLRendererGeForce3ID 139776)
; #define kCGLRendererGeForce3ID      0x00022200
(defconstant $kCGLRendererGeForceFXID 140288)
; #define kCGLRendererGeForceFXID     0x00022400
(defconstant $kCGLRendererMesa3DFXID 262144)
; #define kCGLRendererMesa3DFXID      0x00040000

; #endif /* _CGLRENDERERS_H */


(provide-interface "CGLRenderers")