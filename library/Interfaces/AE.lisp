(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AE.h"
; at Sunday July 2,2006 7:24:24 pm.
; 
;      File:       AE/AE.h
;  
;      Contains:   Master include for AE private framework
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AE__
; #define __AE__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AEDATAMODEL__

(require-interface "AE/AEDataModel")

; #endif

; #ifndef __APPLEEVENTS__

(require-interface "AE/AppleEvents")

; #endif

; #ifndef __AEPACKOBJECT__

(require-interface "AE/AEPackObject")

; #endif

; #ifndef __AEOBJECTS__

(require-interface "AE/AEObjects")

; #endif

; #ifndef __AEREGISTRY__

(require-interface "AE/AERegistry")

; #endif

; #ifndef __AEUSERTERMTYPES__

(require-interface "AE/AEUserTermTypes")

; #endif

; #ifndef __AEHELPERS__

(require-interface "AE/AEHelpers")

; #endif

; #ifndef __AEMACH__

(require-interface "AE/AEMach")

; #endif


; #endif /* __AE__ */


(provide-interface "AE")