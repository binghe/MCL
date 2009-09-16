(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HIServices.h"
; at Sunday July 2,2006 7:24:37 pm.
; 
;      File:       HIServices/HIServices.h
;  
;      Contains:   Master include for HIServices framework
;  
;      Version:    HIServices-125.6~1
;  
;      Copyright:  © 2002-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HISERVICES__
; #define __HISERVICES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __ICONS__

(require-interface "HIServices/Icons")

; #endif

; #ifndef __INTERNETCONFIG__

(require-interface "HIServices/InternetConfig")

; #endif

; #ifndef __PROCESSES__

(require-interface "HIServices/Processes")

; #endif

; #ifndef __PASTEBOARD__

(require-interface "HIServices/Pasteboard")

; #endif

; #ifndef __TRANSLATIONSERVICES__

(require-interface "HIServices/TranslationServices")

; #endif

; #ifndef __ACCESSIBILITY__

(require-interface "HIServices/Accessibility")

; #endif


; #endif /* __HISERVICES__ */


(provide-interface "HIServices")