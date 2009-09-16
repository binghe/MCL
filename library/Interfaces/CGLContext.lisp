(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGLContext.h"
; at Sunday July 2,2006 7:27:19 pm.
; 
; 	Copyright:	(c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _CGLCONTEXT_H
; #define _CGLCONTEXT_H

(require-interface "OpenGL/gliContext")

(require-interface "OpenGL/gliDispatch")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** Opaque declaration for private CGLContext data.
; 

(def-mactype :CGLPrivateObj (find-mactype '(:pointer :_CGLPrivateObject)))
; 
; ** CGLContext structure.
; 
(defrecord _CGLContextObject
   (rend (:pointer :__GLIContextRec))
   (disp :__GLIFUNCTIONDISPATCHREC)
   (priv (:pointer :_CGLPrivateObject))
   (stak :pointer)
)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _CGLCONTEXT_H */


(provide-interface "CGLContext")