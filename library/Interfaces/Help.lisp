(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Help.h"
; at Sunday July 2,2006 7:25:17 pm.
; 
;      File:       Help/Help.h
;  
;      Contains:   Master include for Help private framework
;  
;      Version:    Help-27~1003
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HELP__
; #define __HELP__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __APPLEHELP__

(require-interface "Help/AppleHelp")

; #endif


; #endif /* __HELP__ */


(provide-interface "Help")