(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecurityHI.h"
; at Sunday July 2,2006 7:25:15 pm.
; 
;      File:       SecurityHI/SecurityHI.h
;  
;      Contains:   Master include for SecurityHI private framework
;  
;      Version:    SecurityHI-90~157
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SECURITYHI__
; #define __SECURITYHI__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __KEYCHAINHI__

(require-interface "SecurityHI/KeychainHI")

; #endif

; #ifndef __URLACCESS__

(require-interface "SecurityHI/URLAccess")

; #endif


; #endif /* __SECURITYHI__ */


(provide-interface "SecurityHI")