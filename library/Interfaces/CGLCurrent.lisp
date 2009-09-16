(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGLCurrent.h"
; at Sunday July 2,2006 7:27:19 pm.
; 
; 	Copyright:	(c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _CGLCURRENT_H
; #define _CGLCURRENT_H

(require-interface "OpenGL/CGLTypes")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** Current context functions
; 

(deftrap-inline "_CGLSetCurrentContext" 
   ((ctx (:pointer :_CGLContextObject))
   )
   :SInt32
() )

(deftrap-inline "_CGLGetCurrentContext" 
   (
   )
   (:pointer :_CGLContextObject)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _CGLCURRENT_H */


(provide-interface "CGLCurrent")