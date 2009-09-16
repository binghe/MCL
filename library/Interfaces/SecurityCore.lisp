(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecurityCore.h"
; at Sunday July 2,2006 7:23:37 pm.
; 
;      File:       SecurityCore/SecurityCore.h
;  
;      Contains:   Master include for SecurityCore private framework
;  
;      Version:    SecurityCore-60~117
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SECURITYCORE__
; #define __SECURITYCORE__
; #ifndef __CARBONCORE__
#| #|
#include <CarbonCoreCarbonCore.h>
#endif
|#
 |#
; #ifndef __KEYCHAINCORE__

(require-interface "OSServices/KeychainCore")

; #endif


; #endif /* __SECURITYCORE__ */


(provide-interface "SecurityCore")