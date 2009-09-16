(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Accelerate.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;      File:       Accelerate/Accelerate.h
; 
;      Contains:   Master include for all of Accelerate
; 
;      Version:    Accelerate-1
; 
;      Copyright:  ? 2000-2003 by Apple Computer, Inc., all rights reserved.
; 
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
; 
;                      http://developer.apple.com/bugreporter/
; 
; 
; #ifndef __ACCELERATE__
; #define __ACCELERATE__
; #ifndef __VECLIB__

(require-interface "vecLib/vecLib")

; #endif

; #ifndef VIMAGE_H

(require-interface "vImage/vImage")

; #endif


; #endif /* __ACCELERATE__ */


(provide-interface "Accelerate")