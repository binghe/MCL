(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NavigationServices.h"
; at Sunday July 2,2006 7:25:12 pm.
; 
;      File:       NavigationServices/NavigationServices.h
;  
;      Contains:   Master include for NavigationServices private framework
;  
;      Version:    NavigationServices-97.5~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NAVIGATIONSERVICES__
; #define __NAVIGATIONSERVICES__
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
#endif
|#
 |#
; #ifndef __NAVIGATION__

(require-interface "NavigationServices/Navigation")

; #endif


; #endif /* __NAVIGATIONSERVICES__ */


(provide-interface "NavigationServices")