(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:aglContext.h"
; at Sunday July 2,2006 7:25:33 pm.
; 
;     File:	AGL/aglContext.h
; 
;     Contains:	Data type for internal contexts, for use with internal renderer interface.
; 
;     Version:	Technology:	Mac OS 9
;                 Release:	GM
;  
;      Copyright:  (c) 2000 - 2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _AGLCONTEXT_H
; #define _AGLCONTEXT_H

(require-interface "OpenGL/gliContext")

(require-interface "OpenGL/gliDispatch")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** Opaque declaration for private AGLContext data.
; 

(def-mactype :AGLPrivate (find-mactype '(:pointer :__AGLPrivateRec)))
; 
; ** AGLContext structure.
; 
(defrecord __AGLContextRec
   (rend (:pointer :__GLIContextRec))
   (disp :__GLIFUNCTIONDISPATCHREC)
   (priv (:pointer :__AGLPrivateRec))
)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _AGLCONTEXT_H */


(provide-interface "aglContext")