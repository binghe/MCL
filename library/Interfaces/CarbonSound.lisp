(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CarbonSound.h"
; at Sunday July 2,2006 7:25:07 pm.
; 
;      File:       CarbonSound/CarbonSound.h
;  
;      Contains:   Master include for CarbonSound private framework
;  
;      Version:    CarbonSound-94~4
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CARBONSOUND__
; #define __CARBONSOUND__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
#endif
|#
 |#
; #ifndef __SOUND__

(require-interface "CarbonSound/Sound")

; #endif


; #endif /* __CARBONSOUND__ */


(provide-interface "CarbonSound")