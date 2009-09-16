(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vecLib.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;      File:       vecLib/vecLib.h
;  
;      Contains:   Master include for vecLib framework
;  
;      Version:    vecLib-151~21
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __VECLIB__
; #define __VECLIB__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __VECLIBTYPES__

(require-interface "vecLib/vecLibTypes")

; #endif

; #ifndef __VBASICOPS__

(require-interface "vecLib/vBasicOps")

; #endif

; #ifndef __VBIGNUM__

(require-interface "vecLib/vBigNum")

; #endif

; #ifndef __VECTOROPS__

(require-interface "vecLib/vectorOps")

; #endif

; #ifndef __VFP__

(require-interface "vecLib/vfp")

; #endif

; #ifndef __VDSP__

(require-interface "vecLib/vDSP")

; #endif

; #ifndef __VBLAS__

(require-interface "vecLib/vBLAS")

; #endif

; #ifndef __CLAPACK_H

(require-interface "vecLib/clapack")

; #endif


; #endif /* __VECLIB__ */


(provide-interface "vecLib")