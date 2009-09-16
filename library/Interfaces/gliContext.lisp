(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:gliContext.h"
; at Sunday July 2,2006 7:25:33 pm.
; 
; 	Copyright:  (c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; #ifndef _GLICONTEXT_H
; #define _GLICONTEXT_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** GL context data type
; 

(def-mactype :GLIContext (find-mactype '(:pointer :__GLIContextRec)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _GLICONTEXT_H */


(provide-interface "gliContext")