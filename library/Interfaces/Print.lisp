(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Print.h"
; at Sunday July 2,2006 7:25:12 pm.
; 
;      File:       Print/Print.h
;  
;      Contains:   Printing functions with UI
;  
;      Version:    Printing-158~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PRINT__
; #define __PRINT__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
#endif
|#
 |#
; #ifndef __PMAPPLICATION__

(require-interface "Print/PMApplication")

; #endif


; #endif /* __PRINT__ */


(provide-interface "Print")